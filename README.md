
# 🚀 Terraform + Flask App Deployment on AWS

This project demonstrates how to deploy a simple Python Flask web application on an AWS EC2 instance using **Terraform** with **provisioners**.

The app automatically installs dependencies, uploads a Python file, and runs the Flask server on port 80 using Terraform's `remote-exec`.

---

## 📦 Features

- Full AWS infrastructure provisioning:
  - VPC, Subnet, Internet Gateway, Route Table, Security Group
  - EC2 instance using SSH key pair
- Flask app automatically deployed and started on EC2
- Remote provisioners to copy and execute app
- Remote state storage in S3

---

## 📁 File Structure

```
.
├── main.tf           # Main infrastructure configuration
├── variables.tf      # Input variables
├── provider.tf       # AWS provider definition
├── backend.tf        # S3 remote state configuration
├── output.tf         # Outputs (e.g. EC2 IP)
├── app.py            # Flask app to deploy
├── .gitignore        # Ignored files (state, keys, logs)
└── README.md         # Project documentation
```

---

## 🔧 Prerequisites

- AWS CLI configured
- SSH key pair generated (`~/.ssh/id_rsa`, `~/.ssh/id_rsa.pub`)
- S3 bucket created for storing Terraform state
- Terraform installed

---

## 🚀 Getting Started

```bash
terraform init
terraform plan
terraform apply
```

Once complete, open your browser and go to:

```
http://<EC2_PUBLIC_IP>
```

---

## 💡 Learning Outcome

Through this project I learned how to:

- Automate cloud infrastructure with Terraform
- Use provisioners (`file`, `remote-exec`) effectively
- Deploy and manage a Python app without manual steps

---

## 📌 License

This project is for educational purposes and open to all learners.

---

## 📎 Tags

#Terraform #AWS #Flask #Python #DevOps #IaC #Cloud #AbhishekVeeramalla
