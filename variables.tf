#
# All personal variables
#
variable "aws_access_key" {
    description = "Access key for aws api"
    type = "string"
}

variable "aws_secret_key" {
    description = "Secret key for aws api"
    type = "string"
}

variable "aws_key_name" {
    description = "Key pair name to access instance through ssh"
    type = "string"
}

variable "local_key_path" {
    description = "Path to local ssh private key"
    type = "string"
}

#
# All common variables
#
variable "aws_region" {
    description = "Region where instances are created (Ireland)"
    type = "string"
    default = "eu-west-1"
}

variable "aws_ami" {
    description = "List of availables ami"
    type = "map"
    default = {
        eu-west-1 = "ami-2d80115e"
    }
}

variable "aws_snapshot_datastore" {
    description = "List of Snapshot id wich contains all databases"
    type = "map"
    default = {
        eu-west-1 = "snap-d7c6b5fd"
    }
}

variable "aws_instance_type" {
    description = "Amazon EC2 instance type"
    type = "string"
    default = "m4.xlarge"
}

variable "aws_databases_volume_id" {
    description = "Id of the volume wich contains all databases"
    type = "string"
    default = "vol-e9ee202c"
}
