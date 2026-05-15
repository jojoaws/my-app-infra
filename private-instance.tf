resource "aws_instance" "private_instance" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  subnet_id = aws_subnet.private_subnet_1.id

  vpc_security_group_ids = [
    aws_security_group.private_instance_sg.id
  ]

  key_name = var.key_pair_name

  associate_public_ip_address = false

  tags = {
    Name = "private-instance"
  }
}
