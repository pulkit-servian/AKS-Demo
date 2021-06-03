# ##Below defines the kubernetes deployment manifest for the demo application with the replicas and sku defined
resource "kubernetes_deployment" "demoapp" {
  metadata {
    name = "demoapp"
    labels = {
      app = "demoapp"
    }
  }

  spec {
    replicas = 4

    selector {
      match_labels = {
        app = "demoapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "demoapp"
        }
      }

      spec {
        container {
          image = "haroondogar/techchallengeapp:1.0"
          name  = "servian-to-do"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }

      }
    }
  }
  wait_for_rollout = false
}
#The Loadbalancer manifest below exposes the webapp pods externally
resource "kubernetes_service" "svc" {
  metadata {
    name = "svc"
  }
  spec {
    selector = {
      app = "demoapp"
    }
    port {
      port = 80
    }
    type = "LoadBalancer"
  }
}
#Below is the code to configure a horizontal pod autoscaler to scale based on cpu utilization
resource "kubernetes_horizontal_pod_autoscaler" "hpa" {
  metadata {
    name = "demoapp"
  }

  spec {
    max_replicas = 10
    min_replicas = 4

    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = "demoapp"
    }
    target_cpu_utilization_percentage = 10
  }
}
