resource "aws_imagebuilder_infrastructure_configuration" "parallelcluster-golden-ami-infra-config" {
  name                  = "parallelcluster-golden-ami-infra-config"
  instance_profile_name = aws_iam_instance_profile.ec2-image-builder-instance-profile.name
  instance_types        = ["t3.small"]
  subnet_id                     = "subnet-0d5099e9dd031ddd5"
  security_group_ids            = ["sg-023d8873eb82c1cd3"]

  terminate_instance_on_failure = true
}