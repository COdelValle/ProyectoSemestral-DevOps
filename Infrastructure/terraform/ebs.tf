resource "kubernetes_storage_class" "ebs_sc" {
  metadata {
    name = "ebs-gp3"
  }
  storage_provisioner = "://aws.com"
  volume_binding_mode = "WaitForFirstConsumer"
  parameters = {
    type = "gp3"
  }
}