resource "aws_imagebuilder_image_pipeline" "parallelcluster-golden-ami-gpu" {
  name                             = "parallelcluster-golden-ami-gpu"
  image_recipe_arn                 = aws_imagebuilder_image_recipe.parallelcluster-golden-ami-gpu.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.parallelcluster-golden-ami-infra-config.arn
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.parallelcluster-golden-ami-dist-config-gpu.arn
  enhanced_image_metadata_enabled  = false

  status = "ENABLED"
}
