# creates EC2 instance for the ELRR xAPI Gateway Component

resource "aws_instance" "elrr_xapi_gateway" {
  key_name      = aws_key_pair.elrr_public_kp.key_name
  ami           = "ami-0b9064170e32bde34"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_xapi_gateway_subnet.id

  tags = {
    Name = "elrr_xapi_gateway"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_xapi_gw_sg.id
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

  user_data = file("user_data/elrr_xapi_gateway.txt")
}

resource "aws_network_interface" "elrr_xapi_gw_network_interface" {
  subnet_id   = aws_subnet.elrr_xapi_gateway_subnet.id

  tags = {
    Name = "elrr_xapi_gw_network_interface"
  }
}

resource "aws_eip" "elrr_xapi_gw_eip" {
  instance = aws_instance.elrr_xapi_gateway.id
  vpc      = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.elrr_xapi_gateway.id
  allocation_id = aws_eip.elrr_xapi_gw_eip.id
}
