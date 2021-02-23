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

variable "EC2_VAR" {
  type = map(string)

  default = {
    AMI = "ami-0fc970315c2d38f01"
    INSTANCE_TYPE = "t2.micro"
  }
}

#**************************************S3*******************************************

variable "BUCKET_NAME" {
    default="container-webapp-bucket"
}


