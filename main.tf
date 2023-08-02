data "terraform_remote_state" "network_details" {
  backend = "s3"
  config = {
    bucket = "student.1-sukhdeep-bucket"
    key = "student.1-network-state"
    region = "us-west-2"
  }
}
resource "aws_instance" "my_vm" {
  ami = "ami-0c65adc9a5c1b5d7c"
  subnet_id = data.terraform_remote_state.network_details.outputs.my_subnet
  instance_type = "t3.micro"
  tags = {
     Name = "student.1-vm1"
  }
}

