resource "kubernetes_deployment" "exporter" {

    metadata {

        name      = var.name
        namespace = var.namespace

        labels = {

            app = var.name

        }

    }

    spec {

        selector {

            match_labels = {

                app = var.name

            }

        }

        template {

            metadata {

                labels = {

                    app = var.name

                }

            }

            spec {

                security_context {

                    run_as_non_root = true
                    run_as_group    = 10000
                    run_as_user     = 10000

                }

                container {

                    name  = "exporter"
                    image = "quay.io/prometheuscommunity/elasticsearch-exporter:latest"

                    command = [

                        "/bin/elasticsearch_exporter",
                        "--es.uri=${ var.elasticsearch_host }",
                        "--es.ssl-skip-verify",
                        "--es.all"

                    ]

                    port {

                        name           = "exporter"
                        container_port = 9114
                        protocol       = "TCP"

                    }

                    security_context {

                        read_only_root_filesystem = true

                        capabilities {

                            drop = [

                                "SETPCAP",
                                "MKNOD",
                                "AUDIT_WRITE",
                                "CHOWN",
                                "NET_RAW",
                                "DAC_OVERRIDE",
                                "FOWNER",
                                "FSETID",
                                "KILL",
                                "SETGID",
                                "SETUID",
                                "NET_BIND_SERVICE",
                                "SYS_CHROOT",
                                "SETFCAP"

                            ]

                        }

                    }
                    resources {

                        requests = {

                            cpu    = "25m"
                            memory = "64Mi"

                        }

                        limits = {

                            cpu    = "100m"
                            memory = "128Mi"

                        }

                    }

                    readiness_probe {

                        initial_delay_seconds = 10
                        timeout_seconds       = 10

                        http_get {

                            path = "/healthz"
                            port = 9114

                        }

                    }

                    liveness_probe {

                        initial_delay_seconds = 10
                        timeout_seconds       = 10

                        http_get {

                            path = "/healthz"
                            port = 9114

                        }

                    }

                }

            }

        }

    }

}
