# App (Flask)

A minimal API used to prove:
- Docker build and runtime
- ECS Fargate deployment
- Health checks (`/health`)
- Optional database connectivity check on `/` and `/ready`

Endpoints:
- `/health` returns 200 always
- `/ready` returns 200 only if the service can connect to RDS (otherwise 503)
