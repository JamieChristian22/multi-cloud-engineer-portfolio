# Useful KQL Queries (Container Apps / Log Analytics)

## Recent application logs
ContainerAppConsoleLogs_CL
| sort by TimeGenerated desc
| take 50

## Errors (simple keyword search)
ContainerAppConsoleLogs_CL
| where Log_s contains "error" or Log_s contains "ERROR"
| sort by TimeGenerated desc
| take 50
