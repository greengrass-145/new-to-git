# ECS Service with loadbalancer
resource "aws_ecs_service" "ecs_service" {
  name = "demo-auto-ecsservice"
  cluster = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.taskdefenition.arn
  desired_count = 1
  launch_type = "EC2"
  #platform_version = "1.4.0"

  lifecycle {
    ignore_changes = [
      desired_count]
  }

  # network_configuration {
  #   subnets = [
  #     var.subnet1,var.subnet2
  #   #   var.ecs_subnet_b.id,
  #   #   var.ecs_subnet_c.id
  #   ]
  #   security_groups = [
  #     aws_security_group.main.id]
  #   #assign_public_ip = true
  # }

  load_balancer {
    target_group_arn = aws_lb_target_group.ALB.arn
    container_name = "test-1"
    container_port = 80
  }
}