resource "aws_iam_role" "ssm_managed_ec2_role" {
  name = "ssm_managed_ec2_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": ["ec2.amazonaws.com"]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ssm_managed_policy_attachment" {
  role = aws_iam_role.ssm_managed_ec2_role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_managed_ec2_profile" {
  name = "ssm_managed_ec2_profile"
  role = aws_iam_role.ssm_managed_ec2_role.name
}