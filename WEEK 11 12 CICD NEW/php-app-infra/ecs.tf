resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${local.app_name}-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "ecs-tasks.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_cluster" "cluster" {
  name = "${local.app_name}-cluster"
}

resource "aws_ecs_task_definition" "task" {
  family                   = "${local.app_name}-task"
  requires_compatibilities = ["EC2"]
  network_mode             = "awsvpc"
  cpu                      = "128"
  memory                   = "256"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "php-app"
      image = "${aws_ecr_repository.app.repository_url}:latest"
      portMappings = [{
        containerPort = 80
      }]
      environment = [
        {
          name  = "DB_HOST"
          value = aws_db_instance.main.endpoint
        },
        {
          name  = "DB_NAME"
          value = aws_db_instance.main.db_name
        },
        {
          name  = "DB_USER"
          value = aws_db_instance.main.username
        },
        {
          name  = "DB_PASS"
          value = aws_db_instance.main.password
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/${local.app_name}"
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "service" {
  name            = "${local.app_name}-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 1
  launch_type     = "EC2"

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 50
  health_check_grace_period_seconds  = 300

  load_balancer {
    target_group_arn = aws_lb_target_group.app_tg.arn
    container_name   = "php-app"
    container_port   = 80
  }

  network_configuration {
    subnets         = data.aws_subnets.all.ids
    security_groups = [data.aws_security_group.ec2_sg.id]
  }

  depends_on = [aws_lb_listener.app]
}
