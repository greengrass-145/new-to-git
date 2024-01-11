#ECS Cluster
resource "aws_ecs_cluster" "cluster" {
  name = local.cluster_name

#   lifecycle {
#     create_before_destroy = true
#   }
}

data "aws_iam_policy_document" "ecs_instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_instance_role" {
  name               = "ecs-instance-role-${local.cluster_name}"
  assume_role_policy = data.aws_iam_policy_document.ecs_instance_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role_policy" {
  count = var.use_AmazonEC2ContainerServiceforEC2Role_policy ? 1 : 0

  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ecsInstanceRole-${local.cluster_name}"
  path = "/"
  role = aws_iam_role.ecs_instance_role.name
}