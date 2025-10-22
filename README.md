# 🌐 Terraform Deploy to Azure

This project demonstrates **automated deployment of a static website to Microsoft Azure** using **Terraform** and **GitHub Actions**.

It provisions:
- An **Azure Resource Group**
- An **Azure Storage Account** (configured for static website hosting)
- Uploads your local `index.html` and `styles.css` files to the Azure storage account  
and outputs the public **website URL** automatically after deployment.

---

## CI/CD (GitHub Actions)

[![Build APK](https://github.com/HansrajS1/terraform-mini-project/actions/workflows/deploy.yml/badge.svg)](https://github.com/HansrajS1/terraform-mini-project/actions/workflows/deploy.yml)


## 🚀 Project Overview

The GitHub Actions workflow (`.github/workflows/terraform.yml`) runs Terraform commands to automatically:
1. Initialize Terraform  
2. Validate configuration  
3. Plan changes  
4. Apply and deploy resources to Azure  

Once completed, your website is hosted live on Azure!

---

## 🧩 Project Structure

```
.
├── index.html
├── styles.css
├── main.tf
├── variables.tf
└── .github/
    └── workflows/
        └── terraform.yml
```

---

## 💡 Prerequisites

Before deploying, ensure you have:
- An **Azure account**
- A **Service Principal** created for Terraform authentication  
- The following **GitHub Secrets** configured in your repository:

| Secret Name | Description |
|--------------|-------------|
| `ARM_CLIENT_ID` | Azure Service Principal client ID |
| `ARM_CLIENT_SECRET` | Azure Service Principal client secret |
| `ARM_SUBSCRIPTION_ID` | Your Azure subscription ID |
| `ARM_TENANT_ID` | Your Azure tenant ID |

---

## ⚙️ GitHub Actions Workflow

The workflow file: `.github/workflows/terraform.yml`

```yaml
name: Terraform Deploy to Azure
on:
  push:
    branches:
      - main

jobs:
  terraform:
    name: Apply Terraform
    runs-on: ubuntu-latest

    env:
      ARM_CLIENT_ID: ${{ secrets.ARM_CLIENT_ID }}
      ARM_CLIENT_SECRET: ${{ secrets.ARM_CLIENT_SECRET }}
      ARM_SUBSCRIPTION_ID: ${{ secrets.ARM_SUBSCRIPTION_ID }}
      ARM_TENANT_ID: ${{ secrets.ARM_TENANT_ID }}

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: 1.8.0

      - name: Terraform Init
        run: terraform init

      - name: Terraform Validate
        run: terraform validate

      - name: Terraform Plan
        run: terraform plan

      - name: Terraform Apply
        run: terraform apply -auto-approve
```

---

## 🧱 Terraform Configuration Overview

The Terraform configuration (`main.tf`) includes:

- **Resource Group Creation**
- **Storage Account for Static Website**
- **Blob Upload of HTML and CSS**
- **Website URL Output**

Example output after apply:
```
Apply complete! Resources: 5 added, 0 changed, 0 destroyed.
Outputs:
website_url = "https://webapp3b97158bab25ded3.z29.web.core.windows.net/"
```

---

## 🌍 Accessing Your Website

Once the GitHub Action completes:
1. Go to your **GitHub Actions > Terraform Deploy to Azure** workflow run.
2. Check the **Terraform Apply** step output.
3. Copy the **website_url** value — that’s your live hosted site! 🎉

---

## 👨‍💻 Authors

**By:**  
- Hansraj  
- Somnath Ghosh  

---

## 📄 License

This project is licensed under the **MIT License** — free to use and modify.

---

## 🧠 Summary

✅ Automated Terraform workflow  
✅ Azure static website hosting  
✅ CI/CD with GitHub Actions  
✅ Outputs live website link automatically  
