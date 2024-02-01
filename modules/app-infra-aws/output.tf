
output "frontend-nodes" {
    value = ["${aws_instance.ec2_frontend.*.public_ip}"]
}


output "backend-nodes" {
    value = ["${aws_instance.ec2_backendend.*.public_ip}"]
}