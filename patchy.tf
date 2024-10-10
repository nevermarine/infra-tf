resource "mikrotik_dns_record" "patchy" {
  name    = "patchy.home"
  address = "10.0.0.3"
}

resource "mikrotik_dns_record" "nas" {
  name    = "nas.home"
  address = "10.0.0.3"
}
