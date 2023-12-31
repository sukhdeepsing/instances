variable "region" {
  default = "us-west-2"
}
variable "profile" {
  default = "student.1"
}
variable "webserver_prefix" {
  default = "student.1-webserver-vm"
}

variable "loadbalancer_prefix" {
  default = "student.1-loadbalancer-vm"
}
variable "web_docker_host_prefix" {
  default = "student.1-docker-vm"
}
variable "lb_docker_host_prefix" {
  default = "student.1-docker-vm"
}
variable "jenkins_master_prefix" {
      default = "student.1-jenkins-vm"
}


