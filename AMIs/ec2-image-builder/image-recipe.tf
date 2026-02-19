resource "aws_imagebuilder_image_recipe" "parallelcluster-golden-ami-cpu" {
  name         = "parallelcluster-golden-ami-cpu"
  version      = "1.0.0"
  parent_image = "arn:aws:imagebuilder:${var.aws_region}:aws:image/red-hat-enterprise-linux-8-x86/x.x.x"

  # Step 1: Prepare the environment
  component {
    component_arn = aws_imagebuilder_component.install_ansible.arn
  }
  # Step 2: The "Worker" - Passing the S3 Zip URL as a parameter
  component {
    component_arn = aws_imagebuilder_component.run_playbook.arn
    
    parameter {
      name  = "PlaybookS3Url"
      value = "s3://${aws_s3_object.ansible_playbook_zip.bucket}/${aws_s3_object.ansible_playbook_zip.key}"
    }
    parameter {
      name = "LvmScriptS3Url"
      value = "s3://${aws_s3_object.lvm_script.bucket}/${aws_s3_object.lvm_script.key}"
    }
  }
  # Step 3: Sanitize and Slim down the AMI
  component {
    component_arn = aws_imagebuilder_component.cleanup.arn
  }
  # Testing: Validate the AMI works as expected
  component {
    component_arn = aws_imagebuilder_component.test_golden_ami.arn
  }

  block_device_mapping {
    device_name = "/dev/sda1"
    ebs {
      volume_size           = 64
      volume_type           = "gp3"
      delete_on_termination = true
    }
  }
  block_device_mapping {
    device_name = "/dev/sdb"
    ebs {
      volume_size           = 136
      volume_type           = "gp3"
      delete_on_termination = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_imagebuilder_image_recipe" "parallelcluster-golden-ami-gpu" {
  name         = "parallelcluster-golden-ami-gpu"
  version      = "1.0.0"
  parent_image = "arn:aws:imagebuilder:${var.aws_region}:aws:image/red-hat-enterprise-linux-8-x86/x.x.x"

  # Step 1: Prepare the environment
  component {
    component_arn = aws_imagebuilder_component.install_ansible.arn
  }
  # Step 2: The "Worker" - Passing the S3 Zip URL as a parameter
  component {
    component_arn = aws_imagebuilder_component.run_playbook.arn
    
    parameter {
      name  = "PlaybookS3Url"
      value = "s3://${aws_s3_object.ansible_playbook_zip.bucket}/${aws_s3_object.ansible_playbook_zip.key}"
    }
    parameter {
      name = "LvmScriptS3Url"
      value = "s3://${aws_s3_object.lvm_script.bucket}/${aws_s3_object.lvm_script.key}"
    }
  }
  # Step 3: Sanitize and Slim down the AMI
  component {
    component_arn = aws_imagebuilder_component.cleanup.arn
  }
  # Testing: Validate the AMI works as expected
  component {
    component_arn = aws_imagebuilder_component.test_golden_ami.arn
  }

  block_device_mapping {
    device_name = "/dev/sda1"
    ebs {
      volume_size           = 64
      volume_type           = "gp3"
      delete_on_termination = true
    }
  }
  block_device_mapping {
    device_name = "/dev/sdb"
    ebs {
      volume_size           = 136
      volume_type           = "gp3"
      delete_on_termination = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_imagebuilder_image_recipe" "parallelcluster-golden-ami-weka" {
  name         = "parallelcluster-golden-ami-weka"
  version      = "1.0.0"
  parent_image = "arn:aws:imagebuilder:${var.aws_region}:aws:image/red-hat-enterprise-linux-8-x86/x.x.x"

  # Step 1: Prepare the environment
  component {
    component_arn = aws_imagebuilder_component.install_ansible.arn
  }
  # Step 2: The "Worker" - Passing the S3 Zip URL as a parameter
  component {
    component_arn = aws_imagebuilder_component.run_playbook.arn
    
    parameter {
      name  = "PlaybookS3Url"
      value = "s3://${aws_s3_object.ansible_playbook_zip.bucket}/${aws_s3_object.ansible_playbook_zip.key}"
    }
    parameter {
      name = "LvmScriptS3Url"
      value = "s3://${aws_s3_object.lvm_script.bucket}/${aws_s3_object.lvm_script.key}"
    }
  }
  # component {
  #   component_arn = aws_imagebuilder_component.install_weka.arn
  # }
  # Step 3: Sanitize and Slim down the AMI
  component {
    component_arn = aws_imagebuilder_component.cleanup.arn
  }
  # Testing: Validate the AMI works as expected
  component {
    component_arn = aws_imagebuilder_component.test_golden_ami.arn
  }

  block_device_mapping {
    device_name = "/dev/sda1"
    ebs {
      volume_size           = 64
      volume_type           = "gp3"
      delete_on_termination = true
    }
  }
  block_device_mapping {
    device_name = "/dev/sdb"
    ebs {
      volume_size           = 136
      volume_type           = "gp3"
      delete_on_termination = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
