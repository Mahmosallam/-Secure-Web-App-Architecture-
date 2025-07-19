
<img width="782" height="467" alt="image" src="https://github.com/user-attachments/assets/b3cda761-3ce8-4d6d-a2f2-dcc888c6e31a" />


# 🌐 Secure Web Application on AWS with Reverse Proxy and Private Backend

## 📘 Overview

This project demonstrates how to build a **secure and modular web architecture** on AWS using **Terraform**.  
It consists of two main parts:

- **Public EC2 instances** acting as **NGINX reverse proxies**.
- **Private EC2 instances** running a **Flask backend app**, accessible only through the internal **Application Load Balancer (ALB)**.

The goal is to **separate the public interface** from the secure backend, ensuring **traffic passes only through controlled paths** (via NGINX + ALB).

---

## 📁 Folder Structure (Modules & Files)
## 📁 Project Structure

```
secure-webapp-terraform/
│
├── README.md                     -> Project documentation
├── install_backend.sh            -> Shell script to setup backend EC2 instances
├── install_nginx.sh              -> Shell script to setup NGINX on reverse proxy EC2 instances
├── variables.tf                  -> Global input variables
├── outputs.tf                    -> Global output variables (IP addresses, DNS, etc.)
├── main.tf                       -> Root Terraform configuration that ties all modules
│
│
├── modules/
│   │
│   ├── vpc/
│   │   ├── main.tf               -> Creates the main VPC
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │
│   ├── subnets/
│   │   └── main.tf               -> Defines public and private subnets
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │
│   ├── route_tables/
│   │   ├── main.tf               -> Configures route tables and their associations
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │
│   ├── nat_igw/
│   │   └── main.tf               -> Creates NAT Gateway and Internet Gateway
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │
│   │
│   ├── security_group/
│   │   └── main.tf               -> Defines security groups for EC2, ALB, etc.
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │
│   ├── ec2_backend/
│   │   ├── main.tf               -> Launches two private EC2 backend instances
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── install_backend.sh    -> Backend setup script (copied remotely)
│   │
│   ├── ec2_proxy/
│   │   ├── main.tf               -> Launches two public EC2 instances as reverse proxies
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── install_nginx.sh      -> NGINX setup script (copied remotely)
│   │
│   ├── alb_internal/
│   │   ├── main.tf               -> Internal ALB for backend traffic
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── alb_public/               -> Optional: Public ALB if needed
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
```


---

## ⚙️ Features

- ✅ Public EC2 reverse proxies with NGINX.
- ✅ Private EC2s running a secure backend Flask app.
- ✅ Internal Application Load Balancer (ALB) in private subnet.
- ✅ Modular Terraform structure for clean and scalable infrastructure.
- ✅ NGINX auto-provisioned and configured using `remote-exec`.
- ✅ Bastion-style SSH tunneling from public proxy EC2s to backend EC2s.

---

## 🧰 Technologies Used

- **Terraform v1.6+**
- **AWS EC2, ALB, VPC, Subnets, NAT, IGW**
- **Amazon Linux 2023**
- **NGINX** (reverse proxy)
- **apache in backend ec2s

---

## 🚀 How to Deploy

> 📝 Make sure you have your AWS credentials configured and a key pair before starting.

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/secure-webapp-terraform.git
   cd secure-webapp-terraform
   
2. Initialize Terraform:
   ```bash
   terraform init


3. Review and apply
   ```bash
   terraform apply


💡 Architecture Overview

User
 │
 ▼
[NGINX Reverce Proxy EC2] (Public Subnet)
 │
 ▼
[Internal ALB] (Private Subnet)
 │
 ▼
[Backend EC2 Instances] 


<img width="1702" height="752" alt="Screenshot 2025-07-19 075322" src="https://github.com/user-attachments/assets/48ce0e7b-ce07-4cfb-89bc-1d4049472e81" />



📌 Notes
This setup is fully modular and ready for enhancement (e.g., adding RDS, auto scaling, monitoring, etc).

You can secure the ALB even further using NACLs or security group tightening.

Don't forget to clean up after testing:
```bash
terraform destroy
