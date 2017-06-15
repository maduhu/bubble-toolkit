
resource "cloudstack_vpc" "vpc01" {
    count           = "1"
    name            = "vpc01"
    cidr            = "10.1.0.0/16"
    vpc_offering    = "${var.vpcofferings["redundant"]}"
    zone            = "${var.zone}"
}

// Tier 01
//
resource "cloudstack_network" "vpc01-tier01" {
  count = "1"
  name = "vpc01-tier01"
  cidr = "10.1.1.0/24"
  gateway = "10.1.1.1"
  network_offering = "${var.network_offerings["vpc_isolatednetworks"]}"
  zone = "${var.zone}"
  vpc_id = "${cloudstack_vpc.vpc01.id}"
  acl_id = "${var.default_allow_acl_id}"
}
resource "cloudstack_ipaddress" "vpc01-tier01" {
  count = "1"
  vpc_id = "${cloudstack_vpc.vpc01.id}"
}

resource "cloudstack_instance" "vpc01-tier01-vm01" {
  count = "1"
  name = "vpc01-tier01-vm01"
  display_name = "vpc01-tier01-vm01"
  ip_address = "10.1.1.11"
  network_id = "${cloudstack_network.vpc01-tier01.id}"
  expunge = true
  service_offering = "${var.instance_offering}"
  template = "${var.instance_template}"
  zone = "${var.zone}"
}
resource "cloudstack_port_forward" "vpc01-tier01-vm01" {
    count                  = "1"
    ip_address_id          = "${cloudstack_ipaddress.vpc01-tier01.id}"
    forward {
        protocol           = "tcp"
        private_port       = 22
        public_port        = 2201
        virtual_machine_id = "${cloudstack_instance.vpc01-tier01-vm01.id}"
        vm_guest_ip        = "${cloudstack_instance.vpc01-tier01-vm01.ip_address}"
    }
}


// Tier 02
//
resource "cloudstack_network" "vpc01-tier02" {
  count = "1"
  name = "vpc01-tier02"
  cidr = "10.1.2.0/24"
  gateway = "10.1.2.1"
  network_offering = "DefaultIsolatedNetworkOfferingForVpcNetworks"
  zone = "${var.zone}"
  vpc_id = "${cloudstack_vpc.vpc01.id}"
  acl_id = "${var.default_allow_acl_id}"
}
resource "cloudstack_ipaddress" "vpc01-tier02" {
  count = "1"
  vpc_id = "${cloudstack_vpc.vpc01.id}"
}

resource "cloudstack_instance" "vpc01-tier02-vm01" {
  count = "1"
  name = "vpc01-tier02-vm01"
  display_name = "vpc01-tier02-vm01"
  ip_address = "10.1.2.11"
  network_id = "${cloudstack_network.vpc01-tier02.id}"
  expunge = true
  service_offering = "${var.instance_offering}"
  template = "${var.instance_template}"
  zone = "${var.zone}"
}
resource "cloudstack_port_forward" "vpc01-tier02-vm01" {
    count                  = "1"
    ip_address_id          = "${cloudstack_ipaddress.vpc01-tier02.id}"
    forward {
        protocol           = "tcp"
        private_port       = 22
        public_port        = 2201
        virtual_machine_id = "${cloudstack_instance.vpc01-tier02-vm01.id}"
        vm_guest_ip        = "${cloudstack_instance.vpc01-tier02-vm01.ip_address}"
    }
}

resource "cloudstack_instance" "vpc01-tier02-vm02" {
  count = "1"
  name = "vpc01-tier02-vm02"
  display_name = "vpc01-tier02-vm02"
  ip_address = "10.1.2.12"
  network_id = "${cloudstack_network.vpc01-tier02.id}"
  expunge = true
  service_offering = "${var.instance_offering}"
  template = "${var.instance_template}"
  zone = "${var.zone}"
}
resource "cloudstack_port_forward" "vpc01-tier02-vm02" {
    count                  = "1"
    ip_address_id          = "${cloudstack_ipaddress.vpc01-tier02.id}"
    forward {
        protocol           = "tcp"
        private_port       = 22
        public_port        = 2202
        virtual_machine_id = "${cloudstack_instance.vpc01-tier02-vm02.id}"
        vm_guest_ip        = "${cloudstack_instance.vpc01-tier02-vm02.ip_address}"
    }
}
