resource "kubernetes_service" "exporter" {

    metadata {

        name      = var.name
        namespace = var.namespace

    }

    spec {

        selector = {

            app = var.name

        }

        port {

            port        = 9114
            target_port = 9114
            protocol    = "TCP"

        }

    }

}
