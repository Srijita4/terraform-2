resource "aws_vpc" "lu_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "LUIT VPC"
    }
    enable_dns_hostnames = true
    enable_dns_support = true
  }
  resource "aws_subnet" "database_subnet_1" {
    vpc_id            = aws_vpc.lu_vpc.id
    cidr_block        = "10.0.3.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "Database 1"
    }
  }
  resource "aws_subnet" "database_subnet_2" {
    vpc_id            = aws_vpc.lu_vpc.id
    cidr_block        = "10.0.4.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name = "Database-2b"
    }
  }
  resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.lu_vpc.id
    tags = {
      Name = "LU-IGW"
    }
  }
  resource "aws_route_table" "web_rt" {
    vpc_id = aws_vpc.lu_vpc.id
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name = "RT for Subnet"
    }
  }
  resource "aws_route_table_association" "first" {
    subnet_id      = aws_subnet.database_subnet_1.id
    route_table_id = aws_route_table.web_rt.id
  }
  resource "aws_route_table_association" "second" {
    subnet_id      = aws_subnet.database_subnet_2.id
    route_table_id = aws_route_table.web_rt.id
  }
  resource "aws_security_group" "db" {
    name   = "db"
    vpc_id = aws_vpc.lu_vpc.id
    ingress {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    egress{
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name = "DB SG"
    }
  }
  resource "aws_db_instance" "RDS" {
    identifier = "mydb"
    allocated_storage    = 20
    storage_type = "gp2"
    engine               = "mysql"
    engine_version       = "5.7"
    instance_class       = "db.t3.micro"
    multi_az             = false
    username             = "admin123"
    password             = "password123"
    skip_final_snapshot  = true
    db_subnet_group_name = aws_db_subnet_group.rds_group.name
    port = 3306
    publicly_accessible = true
    vpc_security_group_ids = [aws_security_group.db.id]
    tags = {
      Name = "RDS database"
    }
  }
  resource "aws_db_subnet_group" "rds_group" {
    name       = "subnet group"
    subnet_ids = [aws_subnet.database_subnet_1.id, aws_subnet.database_subnet_2.id]
    tags = {
      Name = "RDS subnet group"
    }
}
