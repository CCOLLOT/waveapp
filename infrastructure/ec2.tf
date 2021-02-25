resource "aws_instance" "container_webapp_instance" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = var.EC2_VAR.INSTANCE_TYPE
  iam_instance_profile   = aws_iam_instance_profile.container_webapp_instance_profile.name
  user_data              = templatefile("startup.sh", { BUCKET_NAME = var.BUCKET_NAME })
  subnet_id              = aws_subnet.container_webapp_subnet.id
  vpc_security_group_ids = [aws_security_group.container_webapp_sg.id]
  tags = {
    Project = var.PROJECT_NAME
    Name    = format("%s-ec2", var.PROJECT_NAME)
    Env     = var.ENVIRONMENT
  }
}

resource "aws_iam_instance_profile" "container_webapp_instance_profile" {
  name = "ContainerWebappInstanceProfile"
  role = aws_iam_role.container_webapp_instance_role.name

}

resource "aws_iam_role" "container_webapp_instance_role" {
  name                  = "ContainerWebappInstanceRole"
  path                  = "/"
  force_detach_policies = true
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : "ec2.amazonaws.com"
          },
          "Effect" : "Allow",
          "Sid" : ""
        }
      ]
    }
  )
  tags = {
    Project = var.PROJECT_NAME
    Name    = format("%s-role", var.PROJECT_NAME)
    Env     = var.ENVIRONMENT
  }
}

resource "aws_iam_role_policy" "container_webapp_s3_policy" {
  name = "container_webapp_policy"
  role = aws_iam_role.container_webapp_instance_role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:ListBucket"
        ],
        "Resource" : [
          aws_s3_bucket.container_webapp_bucket.arn
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:DeleteObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject"
        ],
        "Resource" : [
          format("%s/*", aws_s3_bucket.container_webapp_bucket.arn)
        ]
      }
    ]
  })
}
output "EC2_PUBLIC_DNS" {
  value = aws_instance.container_webapp_instance.public_dns
  }
output "EC2_PUBLIC_IP" {
  value = aws_instance.container_webapp_instance.public_ip
  }