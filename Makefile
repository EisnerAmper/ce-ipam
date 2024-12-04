INSTALL_DIR ?= /app
IMAGE_NAME ?= ce-cicd-utils
IMAGE_REPO ?= ghcr.io/eisneramper
GITHUB_RUN_ID ?= local
IMAGE_TAG ?= local
IMAGE ?= ${IMAGE_REPO}/${IMAGE_NAME}:${IMAGE_TAG}
CONTAINER_HOSTNAME := $(shell basename ${PWD})
LINT_FAIL_UNDER ?= 9
CACHE_FROM ?= ghcr.io/eisneramper/ce-cicd-utils:11937268670-b55f9f3

all: github-env-setup build/azure-management

github-env-setup:
	@echo "INSTALL_DIR=${INSTALL_DIR}"
	@echo "IMAGE_NAME=${IMAGE_NAME}"
	@echo "IMAGE_REPO=${IMAGE_REPO}"
	@echo "IMAGE_TAG=${IMAGE_TAG}"
	@echo "REGISTRY=${IMAGE_REPO}/${IMAGE_NAME}"
	@echo "IMAGE=${IMAGE}"
	@echo "CACHE_FROM=${CACHE_FROM}"

# --cache-from ${CACHE_FROM}
build/azure-management:
	echo "using INSTALL_DIR: ${INSTALL_DIR}"
	docker build -t ${IMAGE} --build-arg INSTALL_DIR=${INSTALL_DIR} -f Dockerfile.devops .

build/c7n:
	docker build -t utils/c7n --build-arg INSTALL_DIR=$$PWD -f c7n.Dockerfile.devops .

push/azure-management:
	echo "pushing image: ${IMAGE}"
	docker push ${IMAGE}

run/azure-management:
	@touch -f $$HOME/.gitconfig
	docker run --rm -it \
	-v /var/run/docker.sock:/var/run/docker.sock:rw \
	-v $$PWD:$$PWD \
	-v $$HOME/.azure:/root/.azure:rw \
	-v $$HOME/.gitconfig:/root/.gitconfig:rw \
	-v $$HOME/.ssh:/root/.ssh:rw \
	-e ARM_TENANT_ID="${ARM_TENANT_ID}" \
	--workdir $$PWD \
	${IMAGE}

az-login:
	@az login --service-principal \
			--username ${ARM_CLIENT_ID} \
			--password ${ARM_CLIENT_SECRET} \
			--tenant ${ARM_TENANT_ID} \
			--allow-no-subscriptions > .login_info

init-azure-module/%: az-login
	az account set --subscription ${ARM_SUBSCRIPTION_ID}
	echo "bootstrapping module: $* in environment: ${ENVIRONMENT}"
	bash -c "cd ./infrastructure/terraform/$* \
		&& terraform init -backend-config="storage_account_name=${TERRAFORM_STATE_STORAGE_ACCOUNT}" \
               -backend-config="container_name=${TERRAFORM_STATE_CONTAINER_NAME}" \
               -backend-config="key=$*/terraform.tfstate" \
			   -backend-config="use_azuread_auth=false" \
			   -backend-config="resource_group_name=${ARM_RESOURCE_GROUP}" \
               -backend=true \
               -get=true \
               -input=false"

plan/%: az-login
	az account set --subscription ${ARM_SUBSCRIPTION_ID}
	bash -c "cd ./infrastructure/terraform/$* \
		&& terraform plan"

test/%: az-login
	@echo $*
