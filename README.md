### Description
Terraform module to deploy Velocloud Edges in AWS

### Usage Example
```
module "velo1" {
  source        = "git::https://github.com/fkhademi/terraform-aws-velo-edge-module.git"

  name		          = "edge1"
  vpc_id	          = "vpc-05f81363c2a863c73"
  private_subnet_id	= "subnet-123456abcdef12345"
  public_subnet_id	= "subnet-abcdef12345689123"
  ssh_key	          = var.ssh_key
}
```

### Variables
The following variables are required:

key | value
:--- | :---
name | AWS resource name
vpc_id | VPC ID to deploy resources
private_subnet_id | Private Subnet ID for SDWAN Edge LAN Interface
public_subnet_id | Public Subnet ID for SDWAN Edge WAN Interface
ssh_key | Public key to be used

The following variables are optional:

key | default | value 
:---|:---|:---
instance_size | c4.large | The size of the EC2 instance

### Outputs
This module will return the following outputs:

key | description
:---|:---
private_ip | Private IP and attributes of the LAN interface
public_ip | Public IP and attributes of the WAN interface
instance | EC2 instance and it's attributes