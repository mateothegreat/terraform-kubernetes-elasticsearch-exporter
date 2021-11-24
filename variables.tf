variable "name" {

    type        = string
    description = "exporter deployment name"

}

variable "namespace" {

    type        = string
    description = "exporter deployment namespace"

}

variable "elasticsearch_host" {

    type        = string
    description = "elasticsearch hostname using a full url (i.e.: https://user:pass@cluster-1-es:9200)"

}
