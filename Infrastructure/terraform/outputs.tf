output "cluster_name" {
  value = aws_eks_cluster.eks.name
}
output "cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}
output "despacho_backend_ecr_url" {
  value = aws_ecr_repository.despacho-backend.repository_url
}
output "ventas_backend_ecr_url" {
  value = aws_ecr_repository.ventas-backend.repository_url
}
output "frontend_ecr_url" {
  value = aws_ecr_repository.frontend.repository_url
}