resource "aws_codebuild_project" "build" {
  name          = "${local.app_name}-build"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = data.aws_caller_identity.current.account_id
      type  = "PLAINTEXT"
    }

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.aws_region
      type  = "PLAINTEXT"
    }

    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = "php-app-repo"
      type  = "PLAINTEXT"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }
}
