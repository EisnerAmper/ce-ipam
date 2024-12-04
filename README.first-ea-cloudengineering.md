# How we've deployed this.

1. Use the provided container:

      ```bash
      make # builds the container

      make run/azure-management # start up our container with the tools we need and docker socket enabled
      ```

2. Create resource group and two user managed identities
  * id-ipam\<ui \| engine\>-\<environment\>-\<location\>
  
    Examples:
    | environment | function | id |
    | ----------- | -------- | -- |
    | nonprod | ui | id-ipamui-dev-eus2 |
    | nonprod | engine | id-ipamengine-dev-eus2 |
    | prod | ui | id-ipamui-prod-eus2 |
    | prod | engine | id-ipamengine-prod-eus2 |

3. After creating the managed identies, we map the permissions for the management group:

      ```powershell
      New-AzRoleAssignment -ObjectId "0710c7fd-b3ec-470e-9dc3-bce4a93d138f" -RoleDefinitionName Reader -Scope /providers/Microsoft.Management/managementGroups/EA-SANDBOX
      ```