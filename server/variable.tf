/**
 * Create by : Benja kuneepong
 * Date : Wed, Aug  7, 2024 10:45:12 AM
 * Purpose : ประกาศตัวแปลเริิ่มต้นเพื่อไปใช้ในไฟล์​ var ของแต่ละ environment
 */

variable "compartment_ocid" { default = "" }
variable "region" { default = "ap-singapore-1" }
variable "user_ocid" { default = ""}
variable "fingerprint" { default = ""}
variable "tenancy_ocid" { default = ""}
variable "vcn_cidr" { default = "10.0.0.0/24"}
variable "ssh_public_key" {
  type =  string
  default = ""
}
variable "private_key_path" { default = "C:\\Users\\benjakun\\.oci\\oci_api_key.pem"}

variable "AD" { default = "1"}

variable "image_operating_system" {
  default = "Oracle Linux"
}
variable "image_operating_system_version" {
  default = "8"
}
// Compute Shape
variable "instance_shape" {
  description = "Instance Shape"
  default = "VM.Standard2.1"
}

variable "webservice_ports" {
  default = ["80", "443"]
}

variable "bastion_ports" {
  default = ["22"]
}

variable "VCN-CIDR" {
  default = "10.0.0.0/16"
}


