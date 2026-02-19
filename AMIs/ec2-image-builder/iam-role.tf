# 1. Create the IAM role
resource "aws_iam_role" "ec2-image-builder" {
  name = "ec2-image-builder"

  # The "Trust Relationship" allowing an entity to use the role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

# 2. Attach required policies to the role
resource "aws_iam_role_policy_attachment" "ec2-image-builder-policy-attachments" {
  for_each = toset([
    "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilder",
    "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  ])

  role       = aws_iam_role.ec2-image-builder.name
  policy_arn = each.value
}

# 3. Create the Instance Profile
resource "aws_iam_instance_profile" "ec2-image-builder-instance-profile" {
  name = "ec2-image-builder-instance-profile"
  role = aws_iam_role.ec2-image-builder.name
}
