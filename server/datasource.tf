
//Get a list of supported images based on shape , operating_system and operating_system_version provided

data "oci_core_images" "compute_images" {
    compartment_id = var.compartment_ocid
    operating_system = var.image_operating_system
    operating_system_version = var.image_operating_system_version
    shape = var.instance_shape
}

# output "available_images" {
#   value = data.oci_core_images.compute_images.images
# }
//ocid1.image.oc1.ap-singapore-1.aaaaaaaavyyyaj6ydfj66xverrze5z2ldauzutzcxucvzqk6frgnoc66uzwa