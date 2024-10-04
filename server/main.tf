# /**
#  * Create by : Benja kuneepong
#  * Date : Wed, Aug  7, 2024 10:45:12 AM
#  * Purpose : ประกาศว่าใช้ terraform version อะไรสำหรับ provider
#  */

terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "~> 6.12.0"
    }
  }
}



  provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}
  


