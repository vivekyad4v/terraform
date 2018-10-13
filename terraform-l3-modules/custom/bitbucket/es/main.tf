##########
# Create service linked role before proceeding 
# $ aws iam create-service-linked-role --aws-service-name es.amazonaws.com     # Need to integrate with ES.TF
#########

resource "aws_iam_service_linked_role" "es" {
  aws_service_name = "es.amazonaws.com"
}

data "aws_iam_policy_document" "es_management_access" {
  statement {
    actions = [
      "es:*",
    ]

    resources = [
      "${aws_elasticsearch_domain.es.arn}",
      "${aws_elasticsearch_domain.es.arn}/*",
    ]

    principals {
      type = "AWS"

      identifiers = ["${distinct(compact(var.management_iam_roles))}"]
    }
  }
}

resource "aws_elasticsearch_domain" "es" {
  domain_name           = "${var.project}-${var.env}"
  elasticsearch_version = "${var.es_version}"

  cluster_config {
    instance_type            = "${var.instance_type}"
    instance_count           = "${var.instance_count}"
    zone_awareness_enabled   = "${var.es_zone_awareness}"
  }
  ebs_options {
    ebs_enabled = "${var.ebs_volume_size > 0 ? true : false}"
    volume_size = "${var.ebs_volume_size}"
  }
  vpc_options = ["${var.vpc_options}"]

  tags = "${merge(map("Name", format("%s-%s", var.project, var.env)), var.default_tags)}"
}

resource "aws_elasticsearch_domain_policy" "es_management_access" {
  domain_name     = "${var.project}-${var.env}"
  access_policies = "${data.aws_iam_policy_document.es_management_access.json}"
}

