## Cutover Plan (Azure DMS)

1) Validate source permissions and prerequisites
2) Create target PostgreSQL Flexible Server (networking, parameters, users)
3) Configure DMS project and run migration
4) Monitor progress and lag/throughput
5) Freeze writes for cutover window
6) Run validation checks
7) Switch application connection strings to Azure target
8) Monitor errors/latency and confirm completion
