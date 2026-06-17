resource "aws_eks_cluster" "eks" {
  name     = "${var.project_name}-cluster"
  role_arn = data.aws_iam_role.labrole.arn

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    subnet_ids = [
      aws_subnet.subnet-1.id,
      aws_subnet.subnet-2.id
    ]
    security_group_ids = [aws_security_group.main.id]
  }     
  
  depends_on = [aws_cloudwatch_log_group.eks_logs]
}

#resource "aws_eks_addon" "ebs_csi" {
#  cluster_name             = aws_eks_cluster.eks.name
#  addon_name               = "aws-ebs-csi-driver"
#  service_account_role_arn = data.aws_iam_role.labrole.arn
#}

resource "aws_eks_node_group" "workers" {
  cluster_name = aws_eks_cluster.eks.name
  node_group_name = "workers"
  node_role_arn = data.aws_iam_role.labrole.arn
  subnet_ids = [aws_subnet.subnet-1.id,
                aws_subnet.subnet-2.id]
  scaling_config {
    desired_size = 2
    max_size = 2
    min_size = 1
  }
  instance_types = ["t3.small"]
  capacity_type = "ON_DEMAND"
}