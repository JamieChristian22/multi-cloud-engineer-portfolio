variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
  default     = "cloud-portfolio"
}

variable "replicas" {
  description = "Number of replicas"
  type        = number
  default     = 2
}

variable "container_image" {
  description = "Docker image"
  type        = string
  default     = "cloud-insurance-app:1.0"
}
