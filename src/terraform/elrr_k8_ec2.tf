# creates EC2 instance for kubernetes master

resource "aws_instance" "elrr_k8_master" {
  key_name      = aws_key_pair.elrr_public.key_name
  ami           = "ami-0b9064170e32bde34"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_public_subnet_1.id

  tags = {
    Name = "elrr_k8_master"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_k8_sg.id
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

  user_data  = file("user_data/elrr_k8.txt")

}

resource "aws_network_interface" "elrr_k8_master_interface" {
  subnet_id   = aws_subnet.elrr_public_subnet_1.id

  tags = {
    Name = "elrr_k8_master_interface"
  }
}

# creates EC2 instance for kubernetes node 1

resource "aws_instance" "elrr_k8_node1" {
  key_name      = aws_key_pair.elrr_public.key_name
  ami           = "ami-0b9064170e32bde34"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_public_subnet_1.id

  tags = {
    Name = "elrr_k8_node1"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_k8_sg.id
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

  user_data  = file("user_data/elrr_k8.txt")

}

resource "aws_network_interface" "elrr_k8_node1_interface" {
  subnet_id   = aws_subnet.elrr_public_subnet_1.id

  tags = {
    Name = "elrr_k8_node1_interface"
  }
}

# creates EC2 instance for kubernetes node 2

resource "aws_instance" "elrr_k8_node2" {
  key_name      = aws_key_pair.elrr_public.key_name
  ami           = "ami-0b9064170e32bde34"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_public_subnet_1.id

  tags = {
    Name = "elrr_k8_node2"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_k8_sg.id
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

  user_data  = file("user_data/elrr_k8.txt")

}

resource "aws_network_interface" "elrr_k8_node2_interface" {
  subnet_id   = aws_subnet.elrr_public_subnet_1.id

  tags = {
    Name = "elrr_k8_node2_interface"
  }
}

# creates EC2 instance for kubenetes node3

resource "aws_instance" "elrr_k8_node3" {
  key_name      = aws_key_pair.elrr_public.key_name
  ami           = "ami-0b9064170e32bde34"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_public_subnet_1.id

  tags = {
    Name = "elrr_k8_node3"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_k8_sg.id
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

  user_data  = file("user_data/elrr_k8.txt")

}

resource "aws_network_interface" "elrr_k8_node3_interface" {
  subnet_id   = aws_subnet.elrr_public_subnet_1.id

  tags = {
    Name = "elrr_k8_node3_interface"
  }
}

resource "aws_eip" "elrr_k8_master_eip" {
  instance = aws_instance.elrr_k8_master.id
  vpc      = true
}

resource "aws_eip_association" "eip_assoc_k8" {
  instance_id   = aws_instance.elrr_k8_master.id
  allocation_id = aws_eip.elrr_k8_master_eip.id
}
