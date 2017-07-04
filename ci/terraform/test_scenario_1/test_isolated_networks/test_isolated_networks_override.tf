resource "cloudstack_egress_firewall" "isonet01" {
  network_id = "${cloudstack_network.isonet01.id}"

  rule {
    cidr_list = ["0.0.0.0/0"]
    protocol = "tcp"
    ports = [8080]
  }
  rule {
    cidr_list = ["0.0.0.0/0"]
    protocol = "icmp"
  }
}

resource "cloudstack_egress_firewall" "isonet02" {
  network_id = "${cloudstack_network.isonet02.id}"

  rule {
    cidr_list = ["0.0.0.0/0"]
    protocol = "tcp"
    ports = [8080]
  }
  rule {
    cidr_list = ["0.0.0.0/0"]
    protocol = "icmp"
  }
}

resource "cloudstack_egress_firewall" "isonet03" {
  network_id = "${cloudstack_network.isonet03.id}"

  rule {
    cidr_list = ["0.0.0.0/0"]
    protocol = "tcp"
    ports = [8080]
  }
  rule {
    cidr_list = ["0.0.0.0/0"]
    protocol = "icmp"
  }
}

resource "cloudstack_egress_firewall" "isonet04" {
  network_id = "${cloudstack_network.isonet04.id}"

  rule {
    cidr_list = ["0.0.0.0/0"]
    protocol = "tcp"
    ports = [8080]
  }
  rule {
    cidr_list = ["0.0.0.0/0"]
    protocol = "icmp"
  }
}

