# Same-account, same-region peering is auto-accepted, so no separate
# accepter resource is required.
resource "aws_vpc_peering_connection" "this" {
  vpc_id      = var.requester_vpc_id
  peer_vpc_id = var.accepter_vpc_id
  auto_accept = true

  tags = merge(var.tags, { Name = var.name })
}

# Allow private DNS resolution across the peering link in both directions.
resource "aws_vpc_peering_connection_options" "this" {
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  accepter {
    allow_remote_vpc_dns_resolution = true
  }
}

# Routes from the hub side to the spoke CIDR.
resource "aws_route" "requester" {
  for_each                  = toset(var.requester_route_table_ids)
  route_table_id            = each.value
  destination_cidr_block    = var.accepter_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

# Routes from the spoke side back to the hub CIDR.
resource "aws_route" "accepter" {
  for_each                  = toset(var.accepter_route_table_ids)
  route_table_id            = each.value
  destination_cidr_block    = var.requester_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}
