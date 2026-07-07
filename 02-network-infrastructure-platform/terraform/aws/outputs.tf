output "vpc_id" { value = module.aws_network.vpc_id }
output "public_subnet_ids" { value = module.aws_network.public_subnet_ids }
output "private_subnet_ids" { value = module.aws_network.private_subnet_ids }
output "network_security_group_id" { value = module.aws_network.security_group_id }
