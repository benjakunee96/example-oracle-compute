resource "oci_core_instance" "example_instance" {
  availability_domain = "khXC:AP-SINGAPORE-1-AD-1"
  compartment_id      = var.compartment_ocid
  shape               = var.instance_shape

  create_vnic_details {
    subnet_id       = oci_core_subnet.test_subnet.id
    assign_public_ip = true

    nsg_ids = [oci_core_network_security_group.ssh_network_security_group.id, oci_core_network_security_group.WebSecurityGroup.id]  # Attach NSG
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }

  source_details {
    source_type = "image"
    source_id   = "ocid1.image.oc1.ap-singapore-1.aaaaaaaavyyyaj6ydfj66xverrze5z2ldauzutzcxucvzqk6frgnoc66uzwa"
    boot_volume_size_in_gbs = 50
  }

  display_name = "example_instance"
}
