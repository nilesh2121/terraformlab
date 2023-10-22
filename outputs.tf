output "webserver_public_ip" {
    description = "Web server public ip"
    value = format("http://%s", aws_instance.webserver.public_ip)
}