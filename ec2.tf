data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "ubuntu" {
  for_each = {
    docker = {
      name = "docker"
      type = "t2.micro"

    }
    prometheus = {
      name = "prometheus"
      type = "t2.micro"
    }
  }
  ami           = data.aws_ami.ubuntu.id
  instance_type = lookup(each.value, "type", null)
  key_name      = aws_key_pair.my-key.id

  tags = {
    Name = "${each.key}"
  }
}

resource "aws_key_pair" "my-key" {
  key_name   = "my-key"
  public_key = file("./my-key.pub")
}