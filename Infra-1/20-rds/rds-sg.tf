# Security Group for Bastion Host
module "rds_mysql_sg" {
  source = "git::https://github.com/vaheedgit26/Infra-1.0.git//modules/sg"

  vpc_id         = data.terraform_remote_state.vpc.outputs.vpc_id
  sg_name        = local.sg_name
  sg_description = "Mysql RDS Instance Security Group"

  common_tags    = local.common_tags
}

# bastion (public_subnet) ---> mysql (database_subnet)
resource "aws_security_group_rule" "mysql_bastion" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = data.terraform_remote_state.bastion.outputs.bastion_sg_id
  security_group_id        = module.rds_mysql_sg.sg_id

  # depends_on = [module.bastion_sg]
}

# EKS cluster  --->  mysql (database_subnet)
resource "aws_security_group_rule" "mysql_backend" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = data.terraform_remote_state.eks.outputs.cluster_security_group_id
  security_group_id        = module.rds_mysql_sg.sg_id

  # depends_on = [module.backend_sg]
}
