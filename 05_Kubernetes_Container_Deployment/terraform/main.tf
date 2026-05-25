resource "kubernetes_namespace" "cloud_portfolio" {
  metadata {
    name = "cloud-portfolio"
  }
}

resource "kubernetes_deployment" "cloud_insurance_app" {
  metadata {
    name      = "cloud-insurance-app"
    namespace = kubernetes_namespace.cloud_portfolio.metadata[0].name

    labels = {
      app = "cloud-insurance-app"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "cloud-insurance-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "cloud-insurance-app"
        }
      }

      spec {
        container {
          image = "cloud-insurance-app:1.0"
          name  = "cloud-insurance-app"

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "cloud_insurance_service" {
  metadata {
    name      = "cloud-insurance-service"
    namespace = kubernetes_namespace.cloud_portfolio.metadata[0].name
  }

  spec {
    selector = {
      app = "cloud-insurance-app"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}
