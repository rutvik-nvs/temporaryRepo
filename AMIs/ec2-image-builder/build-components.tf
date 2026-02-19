# 1. Install Ansible Component
resource "aws_imagebuilder_component" "install_ansible" {
  name     = "install-ansible"
  platform = "Linux"
  version  = var.ansible_component_version

  data = file("${path.module}/components/install-ansible.yaml")

  lifecycle {
    create_before_destroy = true
  }
}

# 2. Run Playbook Component (With Parameter)
resource "aws_imagebuilder_component" "run_playbook" {
  name     = "run-ansible-playbook"
  platform = "Linux"
  version  = var.ansible_component_version

  data = file("${path.module}/components/run-playbook.yaml")

  lifecycle {
    create_before_destroy = true
  }
}

# 2. Run Playbook Component (With Parameter)
resource "aws_imagebuilder_component" "install_weka" {
  name     = "install-weka"
  platform = "Linux"
  version  = var.ansible_component_version

  data = file("${path.module}/components/install-weka.yaml")

  lifecycle {
    create_before_destroy = true
  }
}

# 3. Cleanup Ansible Component
resource "aws_imagebuilder_component" "cleanup" {
  name     = "cleanup"
  platform = "Linux"
  version  = var.ansible_component_version

  data = file("${path.module}/components/cleanup.yaml")

  lifecycle {
    create_before_destroy = true
  }
}
