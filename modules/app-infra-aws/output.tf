
output "k8s-master" {
    value = ["${aws_instance.ec2_1.*.public_ip}"]
}