output "vpc01-tier01-vm01" {
  value = "${cloudstack_ipaddress.vpc01-tier01.ip_address}:2201"
}

output "vpc01-tier02-vm01" {
  value = "${cloudstack_ipaddress.vpc01-tier02.ip_address}:2201"
}

output "vpc01-tier02-vm02" {
  value = "${cloudstack_ipaddress.vpc01-tier02.ip_address}:2202"
}

output "vpc02-tier01-vm01" {
  value = "${cloudstack_ipaddress.vpc02-tier01.ip_address}:2201"
}

output "vpc03-tier01-vm01" {
  value = "${cloudstack_ipaddress.vpc03-tier01.ip_address}:2201"
}

output "vpc04-tier01-vm01" {
  value = "${cloudstack_ipaddress.vpc04-tier01.ip_address}:2201"
}
