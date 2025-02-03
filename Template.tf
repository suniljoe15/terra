variable "html_content" {
  description = "list of contents into index.html"
  type        = list(string)
  default     = ["server 1", "server 2", "server 3"]
}

resource "aws_launch_template" "web-template" {
  name = "Terraform-Template"

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 20
    }
  }

  disable_api_stop        = false
  disable_api_termination = false

  image_id = "ami-0f26813c8d83a7f9f"

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t2.micro"

  key_name = aws_key_pair.web-keypair.key_name

  monitoring {
    enabled = true
  }

  # network_interfaces {
  #   associate_public_ip_address = true
  # }

  vpc_security_group_ids = [aws_security_group.web-sg.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Terraform-Template"
    }
  }

  user_data = base64encode(<<-EOF
    
    Install-WindowsFeature -name Web-Server -IncludeManagementTools
    $htmlContent = ${jsonencode(var.html_content)}
    $htmlPath = "C:\\inetpub\\wwwroot\\index.html"
    Set-Content -Path $htmlPath -Value $htmlContent
    foreach ($content in $htmlContent) {
        Add-Content -Path $htmlPath -Value $content
    }
    $newHostname = "IIS-WebServer"
    Rename-Computer -NewName $newHostname -Force -PassThru
    Restart-Computer -Force
    
  EOF
  )
}
