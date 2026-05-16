# Automation Scripts

## Scripts Included

| Script | Purpose |
|---|---|
| `deploy.sh` | Deploys the Azure enterprise cloud environment using Azure CLI |
| `validate.sh` | Validates resource group, App Service, Storage, VNet, NSG, Key Vault, and alerts |
| `upload-project-file.sh` | Uploads a local file into the private `project-files` blob container |
| `cleanup.sh` | Deletes the full resource group after testing |

## Usage

```bash
chmod +x scripts/*.sh
az login
./scripts/deploy.sh
./scripts/validate.sh
```

## Cleanup

```bash
./scripts/cleanup.sh
```

The cleanup script requires typing `DELETE` before deletion.
