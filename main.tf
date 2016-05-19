provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

resource "aws_security_group" "fw-demo" {
    name = "fw-demo"

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

    # outbound internet access
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "20mn-demo-01" {   
    key_name = "${var.aws_key_name}"
    instance_type = "m4.xlarge"
    ami = "${lookup(var.aws_amis, var.aws_region)}"
    security_groups = ["${aws_security_group.fw-demo.name}"]
    
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
            "sh /tmp/docker-install.sh",
            "sh /tmp/docker-compose.sh"
        ]
    }
}
