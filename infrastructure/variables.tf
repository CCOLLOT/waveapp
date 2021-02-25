#************************************GLOBAL******************************************

variable "PROJECT_NAME"{
    type = string
    default = "webapp-formation"

}
variable "AWS_REGION"{
    type = string
    default = "eu-west-1"
}

variable "ENVIRONMENT"{
    type = string
    default = "dev"
}

#**************************************VPC*******************************************
variable "VPC_CIDR_BLOCK" {
    type = string
    default = "10.0.0.0/16"
}

variable "SUBNET_VAR" {
    type= map(string) 
    default = {
        AVAILABILITY_ZONE="eu-west-1a"
        CIDR_BLOCK="10.0.0.0/24"
    }
}

#**************************************EC2*******************************************
data "aws_ami" "amazon-linux-2" {
 most_recent = true
 owners=["amazon"]
filter {
   name   = "owner-alias"
   values = ["amazon"]
 }


 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}

variable "EC2_VAR" {
  type = map(string)

  default = {
    INSTANCE_TYPE = "t2.micro"
  }
}

#**************************************S3*******************************************

variable "BUCKET_NAME" {
    default="container-webapp-bucket"
}


