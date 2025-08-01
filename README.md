# Terraform Talos PVE

This is a simple project that deploys a Talos Cluster across 3 single node Proxmox servers. This was a test and probably going to change the whole process. Talos image being used contains `qemu-guest-agent` and `iscsi-tools`.

Deployment instructions:

1. Git clone the repo.

    ```bash
    git clone
    ```

2. Generate `terraform.tfvars` based on `variables.tf`.

3. Generate `locals.tf` based on the following example.

    ```terraform
    locals {
      prox1_ip       = <prox1_ip>
      prox1_password = var.prox_default_password
      prox2_ip       = <prox2_ip>
      prox2_password = var.prox_default_password
      prox3_ip       = <prox3_ip>
      prox3_password = var.prox_default_password
    }
    ```

4. Generate `backend.tf` if needed. This is an example using MinIO S3 as backend.

    ```terraform
    terraform {
      backend "s3" {
        endpoints = {
          s3 = "http://<minio-ip>:9000"
        }
        bucket                      = "terraform-state"
        key                         = "talos-pve.tfstate"
        region                      = "main" # Region validation will be skipped
        skip_credentials_validation = true   # Skip AWS related checks and validations
        skip_requesting_account_id  = true
        skip_metadata_api_check     = true
        skip_region_validation      = true
        use_path_style              = true 
    
        access_key = <minio_access_key>
        secret_key = <minio_secret_key>
      }
    }
    ```

5. Initialize project.

    ```bash
    terraform init
    ```

6. Apply changes.

    ```bash
    terraform apply
    ```
