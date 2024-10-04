

resource "oci_core_vcn" "test_vcn" {
  cidr_block     = var.vcn_cidr
  compartment_id = var.compartment_ocid
  dns_label      = "testvcn"
}


resource "oci_core_internet_gateway" "test_ig" {
  compartment_id = var.compartment_ocid
  display_name   = "tfClusterInternetGateway"
  vcn_id         = oci_core_vcn.test_vcn.id
}

resource "oci_core_route_table" "test_route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.test_vcn.id
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.test_ig.id
  }
}

resource "oci_core_subnet" "test_subnet" {
  cidr_block     = var.vcn_cidr
  compartment_id = var.compartment_ocid
  dns_label      = "testsubnet"
  route_table_id = oci_core_route_table.test_route_table.id
  security_list_ids = [oci_core_security_list.WebSecurityList.id , oci_core_security_list.SSHSecurityList.id]
  vcn_id = oci_core_vcn.test_vcn.id
}

# SSH NSG
resource "oci_core_network_security_group" "ssh_network_security_group" {
  compartment_id = var.compartment_ocid
  display_name   = "sshSecurityGroup"
  vcn_id         = oci_core_vcn.test_vcn.id
}

# Web NSG
resource "oci_core_network_security_group" "WebSecurityGroup" {
  compartment_id = var.compartment_ocid
  display_name   = "WebSecurityGroup"
  vcn_id         = oci_core_vcn.test_vcn.id
}

# Security List for HTTP/HTTPS in VCN
resource "oci_core_security_list" "WebSecurityList" {
 compartment_id = var.compartment_ocid
  display_name   = "WebSecurityList"
  vcn_id         = oci_core_vcn.test_vcn.id

  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"
  }

  dynamic "ingress_security_rules" {
    for_each = var.webservice_ports
    content {
      protocol = "6"
      source   = "0.0.0.0/0"
      tcp_options {
        max = ingress_security_rules.value
        min = ingress_security_rules.value
      }
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.vcn_cidr
  }
}

# Security List for SSH in VCN
resource "oci_core_security_list" "SSHSecurityList" {
  compartment_id = var.compartment_ocid
  display_name   = "SSHSecurityList"
  vcn_id         = oci_core_vcn.test_vcn.id

  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"
  }

  dynamic "ingress_security_rules" {
    for_each = var.bastion_ports
    content {
      protocol = "6"
      source   = "0.0.0.0/0"
      tcp_options {
        max = ingress_security_rules.value
        min = ingress_security_rules.value
      }
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.vcn_cidr
  }
}
