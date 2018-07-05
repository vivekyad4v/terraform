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
  name               = "${var.environ}_neworg_role"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.instance_assume_role_policy.json}"
}

resource "aws_iam_policy" "ec2_s3_policy" {
  name        = "${var.environ}_neworg_policy"
  description = "${var.environ}_neworg_policy"
  policy      = "${file("./iam-policies/s3-bucket-access.json")}"
}

resource "aws_iam_policy_attachment" "ec2_attach" {
  name       = "${var.environ}_neworg_attach"
  roles      = ["${aws_iam_role.ec2_role.name}"]
  policy_arn = "${aws_iam_policy.ec2_s3_policy.arn}"
}

resource "aws_iam_instance_profile" "ec2_s3_profile" {
  name  = "${var.environ}_neworg_ec2_profile"
  role = "${aws_iam_role.ec2_role.name}"
}

