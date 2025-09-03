tphardening@tphardening-virtual-machine:~/terraform$ cat outputs.tf
output "bucket_name" {
  value = aws_s3_bucket.logs_bucket.bucket
}

output "ec2_public_ip" {
  value = aws_instance.web.public_ip
}

output "alb_dns_name" {
  value = aws_lb.web_alb.dns_name
}
