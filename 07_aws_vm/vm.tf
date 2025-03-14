resource "aws_key_pair" "key" {
  key_name   = "giopellizzoni-key"
  public_key = file("~/.ssh/aws-key.pub")
}

resource "aws_instance" "vm" {
  ami                         = "ami-0cb91c7de36eed2cb"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = data.terraform_remote_state.vpc.outputs.subnet_id
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.security_group_id]
  associate_public_ip_address = true

  tags = {
    Name = "giopellizzoni-vm"
  }
}
