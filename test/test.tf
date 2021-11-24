variable "cluster_name" {}

#
# Retrieve authentication for kubernetes from aws.
#
provider "aws" {

    region = "us-east-1"

}

#
# Get kubernetes cluster info.
#
data "aws_eks_cluster" "cluster" {

    name = var.cluster_name

}

#
# Retrieve authentication for kubernetes from aws.
#
data "aws_eks_cluster_auth" "cluster" {

    name = var.cluster_name

}

provider "kubernetes" {

    host  = data.aws_eks_cluster.cluster.endpoint
    token = data.aws_eks_cluster_auth.cluster.token

    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[ 0 ].data)

}

module "test" {

    source = "../"

    name               = "elasticsearch-exporter"
    namespace          = "monitoring"
    elasticsearch_host = "https://user:pass@cluster-1-es-http.default.svc.cluster.local:9200"

}
