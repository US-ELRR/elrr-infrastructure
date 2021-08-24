# creates EC2 instance for the ELRR Local Staging Component

resource "aws_instance" "elrr_datasim" {
  key_name      = aws_key_pair.elrr_public.key_name
  ami           = "ami-0b9064170e32bde34"
  instance_type = "t2.small"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_public_subnet_2.id

  tags = {
    Name = "elrr_datasim"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_datasim_sg.id
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("key")
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 20
  }

  user_data = file("user_data/elrr_datasim.txt")
}

resource "aws_network_interface" "elrr_datasim_interface" {
  subnet_id   = aws_subnet.elrr_public_subnet_2.id

  tags = {
    Name = "elrr_datasim_interface"
  }
}
