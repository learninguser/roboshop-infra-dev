output "mongodb_private_ip" {
  value = module.mongodb.private_ip
}

output "redis_private_ip" {
  value = module.redis.private_ip
}

output "mysql_private_ip" {
  value = module.mysql.private_ip
}

output "rabbitmq_private_ip" {
  value = module.rabbitmq.private_ip
}