# Non Production Landing Zone


## Setup Variables

The Non Production Landing zone has your remote state in a storage account, to configure the local environment you need to configure the environment variable with the storage account key to access the terraform state.

```powershell

$Env:TF_VAR_non_prod_remotestate_storagekey = "[NON PRODUCTION REMOTE STATE STORAGE KEY]";

```