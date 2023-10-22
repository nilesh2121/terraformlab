resource "aws_vpc" "mumbai" {
    cidr_block = var.network_cidr

    tags = {
      "Name" = "mumbai-vpc"
    }
  
}

resource "aws_subnet" "webserver" {
    vpc_id = aws_vpc.mumbai.id
    cidr_block = "192.168.0.0/24"
    availability_zone = "ap-south-1a"

    tags = {
      Name = "webserver"
    }

    depends_on = [ 
        aws_vpc.mumbai
     ]



}


resource "aws_internet_gateway" "mumgw" {
    vpc_id = aws_vpc.mumbai.id

    tags = {
      Name = "mumbai-igw"

    }

    depends_on = [ 
        aws_vpc.mumbai,
        aws_subnet.webserver
     ]


}

resource "aws_security_group" "websg" {
    vpc_id = aws_vpc.mumbai.id
    description = "created by terraform"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
        
    }

    tags = {
      Name = "Web Security Group"
    }

    depends_on = [ 
        aws_vpc.mumbai 
        ]

}

resource "aws_route_table" "publicrt" {
    vpc_id = aws_vpc.mumbai.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.mumgw.id
    }

    tags = {
      Name = "Public RT"
    }

    depends_on = [ 
        aws_internet_gateway.mumgw
     ]
  
}

resource "aws_route_table_association" "webrtassociation" {
    subnet_id = aws_subnet.webserver.id
    route_table_id = aws_route_table.publicrt.id

    depends_on = [ 
        aws_route_table.publicrt
     ]


}

