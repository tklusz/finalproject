/*
  Variable explanation for security groups.

  Ingress and Outgress.

  i_f_p = ingress_from_ports
  i_t_p = ingress_to_ports
  i_p   = ingress_protocols
  i_c   = ingress_cidr

  All items are supplied as a list.
  i_f_p  should be a list of all "ingress from" ports.
  i_t_p  should be a list of all corresponding "ingress to" ports.
  i_p    should be a list of protocols corresponding to the port pair above.
  i_c    should be a list of CIDR blocks corresponding to i_f_p, i_t_p and i_p.

  Two traditional ingress rules with translation to this formatting:

  Traditional rule 1:

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = 0.0.0.0/0
  }

  Traditional rule 2:

  ingress {
    from_port = 80
    to_port = 80
    protocol = tcp"
    cidr_blocks = 0.0.0.0/0
  }

  Translation of both the above into module format:

  ingress_from_ports = [443, 80]
  ingress_to_ports   = [443, 80]
  ingress_protocols  = ["tcp", "tcp"]
  ingress_cidrs      = [["0.0.0.0/0"], ["0.0.0.0/0"]]

  Egress behaves the same way.

*/
