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
  name               = "${var.environ}_${var.orgname}_role"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.instance_assume_role_policy.json}"
}

resource "aws_iam_policy" "ec2_s3_policy" {
  name        = "${var.environ}_${var.orgname}_policy"
  description = "${var.environ}_${var.orgname}_policy"
  policy      = "${file("./iam-policies/s3-bucket-access.json")}"
}

resource "aws_iam_policy_attachment" "ec2_attach" {
  name       = "${var.environ}_${var.orgname}_attach"
  roles      = ["${aws_iam_role.ec2_role.name}"]
  policy_arn = "${aws_iam_policy.ec2_s3_policy.arn}"
}

resource "aws_iam_instance_profile" "ec2_s3_profile" {
  name  = "${var.environ}_${var.orgname}_ec2_profile"
  role = "${aws_iam_role.ec2_role.name}"
}

