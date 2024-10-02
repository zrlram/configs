import boto3

def create_ec2_instance(ec2_resource, key_name):
    # Create a new EC2 instance
    instances = ec2_resource.create_instances(
        ImageId='ami-0abcdef1234567890',  # Replace with a valid AMI ID for us-west-2
        MinCount=1,
        MaxCount=1,
        InstanceType='t2.micro',
        KeyName=key_name,
        TagSpecifications=[
            {
                'ResourceType': 'instance',
                'Tags': [
                    {
                        'Key': 'Name',
                        'Value': 'QuickInstance'
                    }
                ]
            }
        ]
    )

    for instance in instances:
        print(f'Created instance with ID: {instance.id}')

if __name__ == "__main__":
    region = 'us-west-2'
    key_name = 'jcran-dev-key'

    ec2_resource = boto3.resource('ec2', region_name=region)

    # Create EC2 instance
    create_ec2_instance(ec2_resource, key_name)

