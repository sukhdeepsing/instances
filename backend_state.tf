terraform {
  backend "s3" {
     bucket = "student.1-sukhdeep-bucket"
     key = "student.1-instance-state"
     region = "us-west-2"
   }
}

