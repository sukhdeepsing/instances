data "terraform_remote_state" "network_details" {
  backend = "s3"
  config = {
    bucket = "student.1-sukhdeep-bucket"
    key = "student.1-network-state"
    region = var.region
  }
}

module "webserver" {
  source = "./modules/linux_node"
  ami = "ami-0c65adc9a5c1b5d7c"
  instance_count = "0"
  instance_type = "t3.micro" 
  key_name  = data.terraform_remote_state.network_details.outputs.my_aws_key
  subnet_id = data.terraform_remote_state.network_details.outputs.my_subnet
  vpc_security_group_ids = data.terraform_remote_state.network_details.outputs.security_group_id_array
   tags = {
      " Name" = "var.webserver_prefix"
  }
           install_package = "webservers"
           playbook_name = "install-apache.yaml"
}
module "loadbalancer" {
  source = "./modules/linux_node"
  ami = "ami-0c65adc9a5c1b5d7c"
  instance_count = "0"
  instance_type = "t3.micro"
  key_name  = data.terraform_remote_state.network_details.outputs.my_aws_key
  subnet_id = data.terraform_remote_state.network_details.outputs.my_subnet
  vpc_security_group_ids = data.terraform_remote_state.network_details.outputs.security_group_id_array
   tags = {
        Name = "var.loadbalancer_prefix"
}  
        install_package = "loadbalancer"
        playbook_name = "install-ha-proxy.yaml"
        depends_on = [module.webserver]

}
module "web_docker_host" {
  source = "./modules/linux_node"
  instance_count = "1"
  ami = "ami-0c65adc9a5c1b5d7c"
  instance_type = "t3.micro"
  key_name = data.terraform_remote_state.network_details.outputs.my_aws_key
  subnet_id = data.terraform_remote_state.network_details.outputs.my_subnet
  vpc_security_group_ids =     data.terraform_remote_state.network_details.outputs.security_group_id_array
  tags = {
      Name = var.web_docker_host_prefix
       }
 install_package = "dockerhost"
 playbook_name = "install-docker.yaml"
    }

