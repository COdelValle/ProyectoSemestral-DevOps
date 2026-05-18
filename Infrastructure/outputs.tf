output "despacho_backend_ecr" {
  value = aws_ecr_repository.despacho-backend.repository_url
}

output "ventas_backend_ecr" {
  value = aws_ecr_repository.ventas-backend.repository_url
}

output "frontend_ecr" {
  value = aws_ecr_repository.frontend.repository_url
}

output "mysql_private_ip" {
  value = aws_instance.db.private_ip
}