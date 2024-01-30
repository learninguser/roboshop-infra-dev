locals{
    name = "${var.project_name}-${var.environment}"
    public_subnet_id = element(split(",", data.aws_ssm_parameter.public_subnet_ids.value), 0)
    current_time = formatdate("YYYY-MM-DD-hh-mm", timestamp())
}