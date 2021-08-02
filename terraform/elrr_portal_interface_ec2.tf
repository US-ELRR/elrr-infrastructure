# creates EC2 instance for the ELRR portal

resource "aws_instance" "elrr_portal" {
  key_name      = aws_key_pair.elrr_public_kp.key_name
  ami           = "ami-0b9064170e32bde34"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_auth_subnet.id

  tags = {
    Name = "elrr_portal"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_portal_sg.id
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

  user_data = file("user_data/elrr_portal_interface.txt")
}

resource "aws_network_interface" "elrr_portal_interface" {
  subnet_id   = aws_subnet.elrr_portal_subnet.id

  tags = {
    Name = "elrr_portal_interface"
  }
}
