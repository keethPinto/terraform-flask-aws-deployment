resource "aws_key_pair" "deployer" {
  key_name   = var.key_name              # Replace with your desired key name
  public_key = file(var.public_key_path) # Replace with the path to your public key file
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "main"
  }
}
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.sub1_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}
resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
resource "aws_route_table_association" "rtb_sub" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.rtb.id
}
resource "aws_security_group" "flask-sg" {
  name   = "flask-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "flask-sg"
  }
}
resource "aws_instance" "flask-server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.flask-sg.id]
  key_name               = aws_key_pair.deployer.key_name

  tags = {
    Name = "flask-Server"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"              # Replace with the appropriate username for your EC2 instance
    private_key = file("~/.ssh/id_rsa") # Replace with the path to your private key
    host        = self.public_ip
  }
  # File provisioner to copy a file from local to the remote EC2 instance
  provisioner "file" {
    source      = "app.py"              # Replace with the path to your local file
    destination = "/home/ubuntu/app.py" # Replace with the path on the remote instance
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y", # Update package lists (for ubuntu)
      "sudo apt install -y python3-pip",
      "cd /home/ubuntu",
      "sudo apt install -y python3-flask", # package installation
      "nohup sudo python3 app.py > /home/ubuntu/output.log 2>&1 & sleep 5", # executing the app
      "echo 'Flask app setup complete. Check /home/ubuntu/output.log'"
    ]
  }
}
