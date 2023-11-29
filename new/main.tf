
resource "aws_security_group" "terra-sg-01" {
  name = "terra-sg-today-01"
  description = "today class"
  vpc_id = ""
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "test"
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }

  egress{
    cidr_blocks = ["0.0.0.0/0"]
    description = "test"
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }

}

resource "aws_instance" "ec2_test-01" {
  ami = "ami-074dc0a6f6c764218"
  instance_type = var.instance_type
  subnet_id = "subnet-00d2838782fa3ecee"
  vpc_security_group_ids = var.security_group #["sg-075d9dc319f0a8390"]
  tags = {
    Name = "CICD-123"
  }
}


resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket-157673692367"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
    depends_on = [
    aws_instance.ec2_test-01
  ]
}