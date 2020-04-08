

resource "aws_iam_role" "ec2_apijobs_instance_role" {
  name               = "DEV_ec2_apijobs_instance_role"
  assume_role_policy = file("assumerolepolicy.json")
}


resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = "${aws_iam_role.ec2_apijobs_instance_role.name}"
  policy_arn = "arn:aws:iam::883089186918:policy/test_policy"
}

resource "aws_iam_instance_profile" "ec2_apijobs_instance_profile" {
  name  = "DEV_ec2_apijobs_instance_profile"
  role = "${aws_iam_role.ec2_apijobs_instance_role.name}"
}

resource "aws_instance" "instance" {
  count                       = "1"
  ami                         =  "ami-0ec1ba09723e5bfac"
  instance_type               = "t2.micro"
  key_name                    = "ec2_devops"
  iam_instance_profile        = "${aws_iam_instance_profile.ec2_apijobs_instance_profile.name}"
  subnet_id                   = "subnet-06b736809c3ec3989"
  disable_api_termination     = "false"
  ebs_optimized               = "false"
  associate_public_ip_address = "true"
  user_data                   = "${data.template_file.user_data_api.rendered}"
 vpc_security_group_ids = [ "${aws_security_group.sg-opa-apijobs.id}"]


  tags =  {
         Name = "java_app"
         Environment = "dev"
         
  }

  lifecycle {
    ignore_changes = [key_name, user_data]
  }
 timeouts {
    create = "10m"
    delete = "30m"
  }
}
