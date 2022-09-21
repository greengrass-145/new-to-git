#ECS TAsk defenition Sample
resource "aws_ecs_task_definition" "taskdefenition" {
  family = "service"
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
  container_definitions = jsonencode([
    {
      name      = "test-1"
      image     = "service-first"
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
    
  ])

  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}
