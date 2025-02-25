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

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > ip_address.txt"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/aws-key")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo subnet_id: ${data.terraform_remote_state.vpc.outputs.subnet_id} >> /tmp/network_info.log",
      "echo security_group_id: ${data.terraform_remote_state.vpc.outputs.security_group_id} >> /tmp/network_info.log",
    ]
  }

  provisioner "file" {
    source      = "teste.txt"
    destination = "/tmp/exemplo.txt"
  }

  provisioner "file" {
    content     = "ami used: ${self.ami}"
    destination = "/tmp/ami.txt"
  }

  tags = {
    Name = "giopellizzoni-vm"
  }
}


