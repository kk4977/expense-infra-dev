resource "aws_key_pair" "vpn" {
  key_name   = "vpn"
  # we can paste the public key directly like this
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDAA9QII8gxiJrn+vndpJ1wQeN+Hkzd8+GNX16oQifKfsYhyJ5DIfmkOdNNr8J5a9djC46AeKlCmkSPDQZBRldI5S5WZPeqJLpqQcNpHMT3O3WKmeqYhbuTZnExbxz/FnDeoHVBxQTU6tZjDF+30Y/zELZV/Vse6P1eG88l0csoPWstVP8UuG0g7/UTMBk7UNzIdwfMFGgbh2gnaVLc7qMjGnc56t1tFrgtqBUIqibq/Gq14fk4kFN6CrynzrUQKMNiFPoxwSkW8cgW9L4g7lW3RS13U3buNEg15aKQtxnVdEeNaribHwrZOv4Vb35TeI4MLYj6xAub6D7yiimnVOw8qKARl7BqpWVM0EhvCLXvS1kRdGwiQ9qzAaTqGGChVoskRs0jLNk4LbFjmpKt8JvDvTJz091xDiffBZ/YOmwPfa/LvtJxMdGBRXICmQ4cNrZEejGZO7qRJuiGtu9NhKUBLu7AmmVVpv3w1b20jLqSou1ebSkRiPofdw4hRHFRfY8= user@SK"
  # public_key = file("~/.ssh/openvpn.pub")
  # ~ means windows home directory
}


module "vpn" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  key_name = aws_key_pair.vpn.key_name
  name = "${var.project_name}-${var.environment}-vpn"

  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
  # convert StringList to list and get first element
  subnet_id = local.public_subnet_ids
  ami = data.aws_ami.ami_info.id
  
  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-vpn"
    }
  )
}