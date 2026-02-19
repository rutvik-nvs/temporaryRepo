# 1. Custom Build Workflow
resource "aws_imagebuilder_workflow" "build_workflow" {
  name             = "custom-build-workflow"
  version          = "1.0.0"
  type             = "BUILD"
  description      = "Custom workflow to build and inventory the image"

  data = file("${path.module}/workflows/build.yaml")
}

# 2. Custom Test Workflow
resource "aws_imagebuilder_workflow" "test_workflow" {
  name             = "custom-test-workflow"
  version          = "1.0.0"
  type             = "TEST"
  description      = "Custom workflow to scan and test the image"

  data = file("${path.module}/workflows/test.yaml")
}
