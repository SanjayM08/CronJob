provider "aws" {
  region     = "us-east-2"
  access_key = "xxxxxxxx"
  secret_key = "xxxxxxxx"
}

resource "aws_instance" "CRONTAB" {
  ami           = "ami-05fb0b8c1424f266b"
  instance_type = "t2.micro"
  key_name      = "non"

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y docker.io
              apt-get install -y git
              git clone https://github.com/SanjayM08/CronJob.git
              cd CronJob
              cd crontab
              docker build . -t sanjaym08/cronjob
              docker run -d -p 80:80 sanjaym08/cronjob	
              EOF

  tags = {
    Name = "CRONTAB"
  }
}

output "public_ip" {
  value = aws_instance.CRONTAB.public_ip
}
