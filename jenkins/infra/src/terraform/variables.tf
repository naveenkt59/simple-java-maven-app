
data "terraform_remote_state" "opa_ingestionapi" {
  backend = "s3"

    config {
      bucket = "java-bucket-devops"
      key    = ".terraform/terraform.tfstate"
      region = "eu-central-1"
      encrypt = true
         }
}


data "template_file" "user_data_api" {
  template = "${file("files/user_data.tpl")}"
}