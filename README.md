# OpenTofu Migration example

This project aims to show how it is possible to to migrate from Terraform to OpenTofu with simple examples.

## Prerequisites

### Environment configuration

We use the latest available versions to be as representative as possible:
- Terraform v1.8.2
- OpenTofu v1.7.0

### Infrastructure provider

We use AWS, but obviously you can use any infrastructure provider you want. 

### Backend

Backends are stored in a S3 bucket.

## The Terraform stack

The sample stack only provision a VPC on AWS, storing the state in the S3 bucket.

![tf bucket](./images/tf-backend.png)
![tf vpc](./images/tf-vpc.png)

## Migration to OpenTofu

> According to [the migration documentation](https://opentofu.org/docs/intro/migration/terraform-1.8/), it is recommended to migrate to OpenTofu 1.7.0 when using Terraform 1.8.x, before upgrading in a latest version if exists. 

Check the version of Terraform, this documentation only works with 1.8.2:

```bash
$ terraform version

Terraform v1.8.2
on darwin_amd64
+ provider registry.terraform.io/hashicorp/aws v5.47.0
```

Ensure there is no pending changes on your project:

```bash
$ terraform plan

aws_vpc.vpc: Refreshing state... [id=vpc-022ccb793f294a27a]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
```

Backup the tfstate file if you work on a real infrastructure.

Initialize OpenTofu:

```bash
$ tofu init

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/aws versions matching "~> 5.0"...
- Installing hashicorp/aws v5.48.0...
- Installed hashicorp/aws v5.48.0 (signed, key ID 0C0AF313E5FD9F80)

Providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://opentofu.org/docs/cli/plugins/signing/

OpenTofu has made some changes to the provider dependency selections recorded
in the .terraform.lock.hcl file. Review those changes and commit them to your
version control system if they represent changes you intended to make.

OpenTofu has been successfully initialized!

You may now begin working with OpenTofu. Try running "tofu plan" to see
any changes that are required for your infrastructure. All OpenTofu commands
should now work.

If you ever set or change modules or backend configuration for OpenTofu,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

Check there is no pending changes:

```bash
$ tofu plan

aws_vpc.vpc: Refreshing state... [id=vpc-022ccb793f294a27a]

No changes. Your infrastructure matches the configuration.

OpenTofu has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
```
