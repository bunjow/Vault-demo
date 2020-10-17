module "vault_cluster" {
  source = "github.com/hashicorp/terraform-aws-vault//modules/vault-cluster?ref=v0.0.1"

  ami_id = "ami-0a03201be248ccd30"
  # Configure and start Vault during boot.
  user_data = <<-EOF
              #!/bin/bash
              /opt/vault/bin/run-vault --tls-cert-file /opt/vault/tls/vault.crt.pem --tls-key-file /opt/vault/tls/vault.key.pem
              EOF

  # Add tag to each node in the cluster with value set to var.cluster_name
  cluster_tag_key   = "Name"

  # Optionally add extra tags to each node in the cluster
  cluster_extra_tags = [
    {
      key = "Environment"
      value = "Dev"
      propagate_at_launch = true
    },
    {
      key = "Department"
      value = "Ops"
      propagate_at_launch = true
    }
  ]

  # ... See variables.tf for the other parameters you must define for the vault-cluster module
}

variable "cluster_name" {
  default  = "vault-demo"
}

variable "ami_id" {
  default  = "ami-0a03201be248ccd30"
}

variable "instance_type" {
  default  = "t2.micro"
}

variable "vpc_id" {
  default  = "vpc-96526aec"
}

variable "allowed_inbound_cidr_blocks" {
  description = "A list of CIDR-formatted IP address ranges from which the EC2 Instances will allow connections to Vault"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "allowed_inbound_security_group_ids" {
  description = "A list of security group IDs that will be allowed to connect to Vault"
  type        = list(string)
  default     = []
}

variable "allowed_inbound_security_group_count" {
  description = "The number of entries in var.allowed_inbound_security_group_ids. Ideally, this value could be computed dynamically, but we pass this variable to a Terraform resource's 'count' property and Terraform requires that 'count' be computed with literals or data sources only."
  default   = "2"
}

variable "user_data" {
  description = "A User Data script to execute while the server is booting. We recommend passing in a bash script that executes the run-vault script, which should have been installed in the AMI by the install-vault module."
}

variable "cluster_size" {
  description = "The number of nodes to have in the cluster. We strongly recommend setting this to 3 or 5."
  default  = "3"
}

