output "namespace" {
  value = kubernetes_namespace.cloud_portfolio.metadata[0].name
}

output "deployment_name" {
  value = kubernetes_deployment.cloud_insurance_app.metadata[0].name
}

output "service_name" {
  value = kubernetes_service.cloud_insurance_service.metadata[0].name
}
