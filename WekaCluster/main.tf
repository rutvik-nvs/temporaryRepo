provider "aws" {
  region = "us-east-1"
  profile = "mskcc"
}

terraform {
  backend "s3" {
    bucket        = "mskcc-terraform-state-parallel-cluster"
    key           = "state/terraform-2.tfstate"
    region        = "us-east-1"
    profile       = "mskcc"
    use_lockfile  = true
  }
}

module "weka_deployment" {
  # Weka Info
  weka_version = "4.4.10.202"
  get_weka_io_token = "Id6jQT4wbDJ7m2ts"
  source = "weka/weka/aws"
  version = "1.0.23"

  # Basic Cluster Info
  prefix = "weka"
  cluster_name = "msktest1"
  cluster_size = 6

  # Cluster Instances Info
  ami_id = "ami-0908096f52ece5a76"
  data_services_instance_type = "m6i.xlarge"
  instance_type = "i3en.2xlarge"

  # Requirement 1: Existing Key Pair
  key_pair_name = "weka-key"

  # Requirement 2: Existing IAM Role
  # instance_iam_profile_arn = "arn:aws:iam::832028463133:instance-profile/EC2-Custom-SSM-Role"

  # Network Configuration
  subnet_ids = ["subnet-0d5099e9dd031ddd5"]
  alb_allow_https_cidrs = ["0.0.0.0/0"]
  alb_additional_subnet_id = "subnet-04e6e50e343415abb"

  assign_public_ip = false
  allow_ssh_cidrs = ["0.0.0.0/0"]
  allow_weka_api_cidrs = ["0.0.0.0/0"]
  set_dedicated_fe_container = false
  protection_level = 2
  create_nat_gateway = false
  tiering_enable_obs_integration = true
  tiering_obs_name = "msktest1-default"
  tiering_enable_ssd_percent = 20
  tiering_obs_iam_bucket_prefix = "msktest"
  clients_number = 1
  clients_use_dpdk = true
  client_instance_type = "c5.2xlarge"
  client_frontend_cores = 1
  data_services_number = 2
  secretmanager_use_vpc_endpoint = true
  secretmanager_create_vpc_endpoint = false
  create_alb = true
}
output "weka_deployment_output" {
  value = module.weka_deployment
}