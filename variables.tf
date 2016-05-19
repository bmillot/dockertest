variable "aws_access_key" {
    description = "Access key for aws api"
    type = "string"
}

variable "aws_secret_key" {
    description = "Secret key for aws api"
    type = "string"
}

variable "aws_region" {
    description = "Region where instances are created (Ireland)"
    type = "string"
    default = "eu-west-1"
}

variable "aws_amis" {
    description = "List of availables ami"
    type = "map"
    default = {
        eu-west-1 = "ami-f95ef58a"
    }
}

variable "aws_key_name" {
    description = "Key pair name to access instance through ssh"
    type = "string"
}

variable "local_key_path" {
    description = "Path to local ssh private key"
    type = "string"
}
