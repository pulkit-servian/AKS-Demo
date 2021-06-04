# # ##Below defines the kubernetes deployment manifest for the demo application with the replicas and sku defined
# resource "kubernetes_deployment" "servian-demo" {
#   metadata {
#     name = "servian-demo"
#     labels = {
#       app = "servian-demo"
#     }
#   }

#   spec {
#     replicas = 4

#     selector {
#       match_labels = {
#         app = "servian-demo"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "servian-demo"
#         }
#       }

#       spec {
#         container {
#           image = "nginxdemos/hello"
#           name  = "nginx"

#           resources {
#             limits = {
#               cpu    = "0.5"
#               memory = "512Mi"
#             }
#             requests = {
#               cpu    = "250m"
#               memory = "50Mi"
#             }
#           }
#         }

#       }
#     }
#   }
#   wait_for_rollout = false
# }
# #The Loadbalancer manifest below exposes the webapp pods externally
# resource "kubernetes_service" "svc" {
#   metadata {
#     name = "svc"
#   }
#   spec {
#     selector = {
#       app = "servian-demo"
#     }
#     port {
#       port = 80
#     }
#     type = "LoadBalancer"
#   }
# }
# #Below is the code to configure a horizontal pod autoscaler to scale based on cpu utilization
# resource "kubernetes_horizontal_pod_autoscaler" "hpa" {
#   metadata {
#     name = "servian-demo"
#   }

#   spec {
#     max_replicas = 10
#     min_replicas = 4

#     scale_target_ref {
#       api_version = "apps/v1"
#       kind        = "Deployment"
#       name        = "servian-demo"
#     }
#     target_cpu_utilization_percentage = 10
#   }
# }
