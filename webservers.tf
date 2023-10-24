resource "aws_key_pair" "keypair" {
    key_name        = "fromterraform"
    public_key      = file("/home/ubuntu/root/.ssh/id_rsa.pub")

}


resource "aws_instance" "webserver" {
    ami = "ami-08e5424edfe926b43"
    associate_public_ip_address = "true"
    instance_type = "t2.micro"
    key_name = aws_key_pair.keypair.key_name
    subnet_id = aws_subnet.webserver.id
    vpc_security_group_ids = [aws_security_group.websg.id]

    tags = {
      Name= "Webserver-1"
    }

    depends_on = [ 
        aws_key_pair.keypair
     ]


    connection {
      type = "ssh"
      user = var.username
      private_key = file("/home/ubuntu/root/.ssh/id_rsa")
      host = self.public_ip
      
    }

    provisioner "remote-exec" {
      inline = [ 
        "#!/bin/bash",
        "sudo apt update",
        "sudo apt install nginx -y"                                    
       ]
      
    }
    
        
  
}

