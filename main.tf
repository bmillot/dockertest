provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

resource "aws_security_group" "cd_security_group" {
    name = "20mn-cd-firewall"
    description = "This security group was generated by the continuous delivery for validation/demo instances"

    tags {
        Name = "20mn-demo"
    }

    # SSH access from anywhere
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # HTTPS access from anywhere
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # HTTP access from anywhere
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Etna access from anywhere
    ingress {
        from_port = 8081
        to_port = 8081
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Mary access from anywhere
    ingress {
        from_port = 8082
        to_port = 8082
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Elasticsearch access from anywhere
    ingress {
        from_port = 9200
        to_port = 9200
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # outbound internet access
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "20mn_demo" {
    key_name = "${var.aws_key_name}"
    instance_type = "${var.aws_instance_type}"
    ami = "${lookup(var.aws_ami, var.aws_region)}"
    security_groups = ["${aws_security_group.cd_security_group.name}"]

    tags {
        Name = "20mn-demo"
    }

    ebs_block_device {
        device_name = "/dev/sdf"
        snapshot_id = "${lookup(var.aws_snapshot_datastore, var.aws_region)}"
        volume_type = "gp2"
        volume_size = "4"
        delete_on_termination = "true"
    }

    connection {
        type = "ssh"
        user = "ubuntu"
        private_key = "${file(var.local_key_path)}"
    }

    provisioner "file" {
        source = "./provisionning/"
        destination = "/tmp/"
    }

    provisioner "remote-exec" {
        inline = [
            "sh /tmp/provision.sh"
        ]
    }
}
