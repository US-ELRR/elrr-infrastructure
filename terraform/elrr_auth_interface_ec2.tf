# creates EC2 instance for the ELRR auth

resource "aws_instance" "elrr_auth" {
  key_name      = aws_key_pair.elrr_public_kp.key_name
  ami           = "ami-0747bdcabd34c712a"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_auth_subnet.id

  tags = {
    Name = "var.auth_ec2"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_auth_sg.id
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("key")
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 30
  }

  user_data = "user_data/elrr_auth_interface.txt"
}

resource "aws_network_interface" "elrr_auth_interface" {
  subnet_id   = aws_subnet.elrr_auth_subnet.id

  tags = {
    Name = "elrr_auth_interface"
  }
}
