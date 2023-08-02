data "terraform_remote_state" "network_details" {
  backend = "s3"
  config = {
    bucket = "student.1-sukhdeep-bucket"
    key = "student.1-network-state"
    region = "us-west-2"
  }
}

