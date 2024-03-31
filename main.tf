provider "aws" {
  region = var.aws_region
}

resource "aws_ecs_cluster" "medusa_cluster" {
  name = var.cluster_name
}

data "aws_iam_role" "medusa_role" {
  name = "medusa-execution-role"  # Assuming this is the existing IAM role name
}

resource "aws_ecs_task_definition" "medusa_task" {
  execution_role_arn = data.aws_iam_role.medusa_role.arn
  family             = var.task_family
  network_mode       = "awsvpc"
  cpu                = var.task_cpu
  memory             = var.task_memory
  requires_compatibilities = ["FARGATE"]

  container_definitions = jsonencode([
    {
      "name": "medusa-container",
      "image": var.container_image,
      "cpu": var.container_cpu,
      "memory": var.container_memory,
      "essential": true,
      "portMappings": [
        {
          "containerPort": var.container_port,
          "hostPort": var.host_port, 
          "protocol": "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "medusa_service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.medusa_cluster.id
  task_definition = aws_ecs_task_definition.medusa_task.arn
  desired_count   = var.desired_count

  network_configuration {
    subnets         = var.subnets
    security_groups = var.security_groups
    assign_public_ip = var.assign_public_ip
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cloudwatch_log_group" "ecs_logs" {
  name = "/ecs/${var.cluster_name}/${var.service_name}"
}

resource "aws_cloudwatch_log_stream" "ecs_log_stream" {
  name           = "${aws_ecs_service.medusa_service.name}/${aws_ecs_service.medusa_service.name}"
  log_group_name = aws_cloudwatch_log_group.ecs_logs.name
}
