# 1. Zip the local playbook directory
data "archive_file" "ansible_playbook" {
  type        = "zip"
  source_dir  = "${path.module}/ansible"
  output_path = "${path.module}/files/ansible_playbook.zip"
}

# 2. Create S3 bucket and upload the zipped playbook and LVM script
resource "aws_s3_bucket" "mskcc-parallelcluster-golden-ami" {
  bucket = "mskcc-parallelcluster-golden-ami" # Ensure this is globally unique
}

# 3a. Upload to S3 (Key name includes the hash for uniqueness)
resource "aws_s3_object" "ansible_playbook_zip" {
  bucket = aws_s3_bucket.mskcc-parallelcluster-golden-ami.id
  key    = "build-artifacts/ansible-playbook-${data.archive_file.ansible_playbook.output_md5}.zip"
  source = data.archive_file.ansible_playbook.output_path
}

# 3b. Upload to S3
# source_hash triggers an update when the file content changes
resource "aws_s3_object" "lvm_script" {
  bucket = aws_s3_bucket.mskcc-parallelcluster-golden-ami.id
  key    = "build-artifacts/lvm-script.sh"
  source = "${path.module}/lvm-script.sh"
  source_hash = filemd5("${path.module}/lvm-script.sh")
}
