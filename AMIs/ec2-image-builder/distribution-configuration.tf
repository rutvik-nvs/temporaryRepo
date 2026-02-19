resource "aws_imagebuilder_distribution_configuration" "parallelcluster-golden-ami-dist-config-cpu" {
  name = "parallelcluster-golden-ami-dist-config-cpu"

  distribution {
    region = var.aws_region
    ami_distribution_configuration {
      name = "parallelcluster-golden-ami-cpu-{{ imagebuilder:buildDate }}"
    }
  }
}

resource "aws_imagebuilder_distribution_configuration" "parallelcluster-golden-ami-dist-config-gpu" {
  name = "parallelcluster-golden-ami-dist-config-gpu"

  distribution {
    region = var.aws_region
    ami_distribution_configuration {
      name = "parallelcluster-golden-ami-gpu-{{ imagebuilder:buildDate }}"
    }
  }
}

resource "aws_imagebuilder_distribution_configuration" "parallelcluster-golden-ami-dist-config-weka" {
  name = "parallelcluster-golden-ami-dist-config-weka"

  distribution {
    region = var.aws_region
    ami_distribution_configuration {
      name = "parallelcluster-golden-ami-weka-{{ imagebuilder:buildDate }}"
    }
  }
}
