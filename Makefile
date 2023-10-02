default:
	terraform init
	terraform apply -auto-approve
	terraform state rm aws_ami_from_instance
	terraform destroy -auto-approve