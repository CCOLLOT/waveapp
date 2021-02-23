import boto3
import os
import logging
from botocore.exceptions import ClientError
logging.basicConfig(filename='webapp-formation.log',format='[%(asctime)s] %(levelname)s: %(message)s', datefmt='%m/%d/%Y %I:%M:%S %p', level=logging.DEBUG)
BUCKET_NAME=os.environ.get("BUCKET_NAME")

def upload_file(file_name, bucket_name=BUCKET_NAME):
    """
    Function to upload a file to an S3 bucket
    :param file_name: File to upload
    :param bucket: Bucket to upload to
    :param object_name: S3 object name. If not specified then file_name is used
    :return: True if file was uploaded, else False
    """
    object_name = file_name
    s3_client = boto3.client('s3')
    try:
        s3_client.upload_file(file_name, bucket_name, object_name)
    except ClientError as e:
        logging.error(e)
        print(e)
        return False
    logging.info(f"Successfully uploaded the file {file_name} to the bucket {bucket_name}")
    return True