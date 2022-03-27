# Deploys a RabbitMQ server to the Kubernetes cluster.

resource "kubernetes_deployment" "rabbit" {
  metadata {
    name = "rabbit"

    labels = {
      pod = "rabbit"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        pod = "rabbit"
      }
    }

    template {
      metadata {
        labels = {
          pod = "rabbit"
        }
      }

      spec {
        container {
          image = "rabbitmq:3.8.5-management"
          name  = "rabbit"

          port {
            container_port = 5672
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "rabbit" {
    metadata {
        name = "rabbit"
    }

    spec {
        selector = {
            pod = kubernetes_deployment.rabbit.metadata[0].labels.pod
        }   

        port {
            port        = 5672
        }
    }
}

resource "kubernetes_service" "rabbit_dashboard" {
    metadata {
        name = "rabbit-dashboard"
    }

    spec {
        selector = {
            pod = kubernetes_deployment.rabbit.metadata[0].labels.pod
        }   

        port {
            port        = 15672
        }

        type             = "LoadBalancer"
    }
}

