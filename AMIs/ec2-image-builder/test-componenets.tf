# 1. Test Component
resource "aws_imagebuilder_component" "test_golden_ami" {
  name     = "test-golden-ami"
  platform = "Linux"
  version  = var.ansible_component_version

  data = file("${path.module}/components/test.yaml")

  lifecycle {
    create_before_destroy = true
  }
}