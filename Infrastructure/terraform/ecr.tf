resource "aws_ecr_repository" "despacho-backend" {
  name         = "${var.project_name}-despacho-backend"
  image_scanning_configuration {
    scan_on_push = true
  }
  force_delete = true
  tags = {
    Name = "${var.project_name}-despacho-backend"
  }
}

resource "aws_ecr_repository" "ventas-backend" {
  name         = "${var.project_name}-ventas-backend"
  image_scanning_configuration {
    scan_on_push = true
  }
  force_delete = true
  tags = {
    Name = "${var.project_name}-ventas-backend"
  }
}

resource "aws_ecr_repository" "frontend" {
  name         = "${var.project_name}-frontend"
  image_scanning_configuration {
    scan_on_push = true
  }
  force_delete = true
  tags = {
    Name = "${var.project_name}-frontend"
  }
}