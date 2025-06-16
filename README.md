# Infrastructure with Terraform and AWS

This repo holds Terraform code to set up AWS resources:
- S3 bucket for Terraform state (with DynamoDB locking)
- IAM OIDC provider and IAM Role for GitHub Actions
- Attachments of necessary AWS-managed policies (EC2, S3, VPC, etc.)

---

## Prerequisites

1. **AWS account** with permission to create S3, DynamoDB, IAM providers/roles.
2. **AWS CLI** configured locally (`aws sts get-caller-identity` should show the target account).
3. **Terraform ≥1.6.0** installed.

---

## Quick Local Setup

1. **Clone and enter repo**:
   ```bash
   git clone rsschool-devops-course-tasks.git
   cd rsschool-devops-course-tasks
