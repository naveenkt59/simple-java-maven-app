
variable "use_remote_state" {
  type    = bool
  default = true
}




data "terraform_remote_state" "opa_ingestionapi" {
  workspace = "DEV"
  backend = "s3"

    config =  {
      bucket = "java-bucket-devops"
      key    = ".terraform/terraform.tfstate"
      region = "eu-central-1"
      encrypt = true
         }
}


data "template_file" "user_data_api" {
  template = "${file("files/user_data.tpl")}"
}


variable "allowed_ports" {
  type        = list
  description = "List of allowed ingress ports"
  default     = [
        "22",
        "8080"
      ]
}

variable "create_default_security_group" {
  description = "Create default Security Group with only Egress traffic allowed"
  default     = "true"
}
