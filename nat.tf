resource "aws_instance" "nat" {
  ami                         = var.ec2_ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public[0].id
  associate_public_ip_address = true
  key_name                    = var.key_name
  source_dest_check           = false
  vpc_security_group_ids      = [aws_security_group.nat.id]

  user_data = <<-EOF
    #!/bin/bash
    exec > >(tee /var/log/user-data.log|logger -t user-data) 2>&1
    export DEBIAN_FRONTEND=noninteractive

    # Enable IP forwarding
    echo 1 > /proc/sys/net/ipv4/ip_forward
    sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf || echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
    sysctl -p

    # Install iptables-persistent
    apt-get update
    apt-get install -y iptables-persistent

    # Determine interface
    IFACE=$(ip -o -4 route show to default | awk '{print $5}')
    echo "Using interface $IFACE for NAT" >> /var/log/user-data.log

    # Configure NAT
    iptables -t nat -A POSTROUTING -o $IFACE -s ${var.vpc_cidr} -j MASQUERADE
    netfilter-persistent save

    # Log configuration
    iptables -t nat -L -v >> /var/log/user-data.log
  EOF

  tags = {
    Name              = "nat-instance"
    common-course-tag = var.common_course_tag
  }
}

resource "aws_eip" "nat_eip" {
  instance = aws_instance.nat.id
}

resource "aws_route_table" "private" {
  count  = length(var.private_subnets)
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "private-rt-${var.azs[count.index]}"
  }
}
resource "aws_route" "private_nat" {
  count                  = length(var.private_subnets)
  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  instance_id            = aws_instance.nat.id
}
resource "aws_route_table_association" "private_assoc" {
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
