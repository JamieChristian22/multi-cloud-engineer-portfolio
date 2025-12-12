# Multi-Cloud Serverless Contact API (AWS • Azure • GCP)

This project exposes a simple `Contact` API that can run on **AWS Lambda**,
**Azure Functions**, or **GCP Cloud Functions** using the same core business logic.

## Features

- `GET /contacts` – list all contacts
- `POST /contacts` – create a new contact
- `GET /health` – basic health check
- In-memory storage (for demo) via a shared repository module
- Provider-specific handler wrappers:
  - `aws_lambda_handler.py`
  - `azure_function_handler.py`
  - `gcp_function_handler.py`

## Tech Stack

- Python 3.x
- AWS Lambda + API Gateway
- Azure Functions (HTTP trigger)
- Google Cloud Functions (HTTP)
- JSON over HTTP

## How It Works

- Core domain logic (Contact model + repository) lives in:
  - `src/models.py`
  - `src/repository.py`
- Each cloud handler:
  - Parses the incoming request into a simple dict
  - Calls `handle_request(method, path, body)`
  - Translates the response back into the provider's response format

## Running Locally (Simple Test)

```bash
cd project1-multicloud-serverless-api
python -m src.aws_lambda_handler
```

## High-Level Deployment Notes

- **AWS**
  - Package `src` as a Lambda function.
  - Set handler: `src.aws_lambda_handler.lambda_handler`
  - Attach to API Gateway with routes `/contacts` and `/health`.

- **Azure**
  - Create a Python HTTP-trigger Function.
  - Use `src.azure_function_handler.main` as the entrypoint.
  - Configure route template: `contacts` and `health`.

- **GCP**
  - Deploy a Python HTTP Cloud Function.
  - Use `src.gcp_function_handler.main` as the entrypoint.
  - Map routes based on the request path.
