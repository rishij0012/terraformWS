provider "aws" {
    profile = "terraform"
    region = "us-east-1"
}

resource  "aws_instance" "os1"{
    ami = "ami-0d5eff06f840b45e9"
    instance_type = "t2.micro"
    tags =  {
                Name = "testing terraform"
            }
}

output "instance_id" {
    value = aws_instance.os1.id
}

output "instance_AZ" {
    value = aws_instance.os1.availability_zone
}

resource "aws_ebs_volume" "ebsVolume" {
  size              = 10
  availability_zone = aws_instance.os1.availability_zone
  tags = {
    Name = "test_terraform"
  }
}

output "ebs_id" {
    value = aws_ebs_volume.ebsVolume.id
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebsVolume.id
  instance_id = aws_instance.os1.id
}

output "checking-attachment"{
    value = aws_volume_attachment.ebs_att
}