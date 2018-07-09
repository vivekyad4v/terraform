data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2_role" {
  name               = "${var.orgname}_${var.environ}_role"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.instance_assume_role_policy.json}"
}

resource "aws_iam_policy" "ec2_policy" {
  name        = "${var.orgname}_${var.environ}_policy"
  description = "${var.orgname}_${var.environ}_policy"
  policy      = "${file("./iam-policies/s3-bucket-access.json")}"
}

resource "aws_iam_policy_attachment" "ec2_attach" {
  name       = "${var.orgname}_${var.environ}_attach"
  roles      = ["${aws_iam_role.ec2_role.name}"]
  policy_arn = "${aws_iam_policy.ec2_policy.arn}"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name  = "${var.orgname}_${var.environ}_role"
  role = "${aws_iam_role.ec2_role.name}"
}

