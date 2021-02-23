#************************************GLOBAL******************************************

PROJECT_NAME="webapp-formation"
AWS_REGION="eu-west-1"

#**************************************VPC*******************************************
VPC_CIDR_BLOCK = "10.0.0.0/16"

SUBNET_VAR={
        AVAILABILITY_ZONE="eu-west-1a"
        CIDR_BLOCK="10.0.0.0/24"
    }
    
#**************************************EC2*******************************************

EC2_VAR = {
    AMI = "ami-0fc970315c2d38f01"
    INSTANCE_TYPE = "t2.micro"
    AVAILABILITY_ZONE="eu-west-1"
  }


#**************************************S3*******************************************
BUCKET_NAME="container-webapp-bucket"
