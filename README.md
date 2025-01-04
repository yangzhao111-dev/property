# infra

## Init Terraform

> * This only needs to be run once
> * Use `aws configure --profile ipe-init` to set up AWS ak/sk

```shell
AWS_PROFILE=ipe-init terraform.exe -chdir=init init
AWS_PROFILE=ipe-init terraform.exe -chdir=init plan
AWS_PROFILE=ipe-init terraform.exe -chdir=init apply
```
> Generate the AWS ak/sk of the deploy user(`ipe-rootdeployer`) after the apply

## Run Terraform

> * For local running, use `aws configure --profile ipe-rootdeployer` to set up AWS ak/sk

### init

```shell
make init AWS_PROFILE=ipe-rootdeployer COUNTRY=us ENVIRONMENT=stage
```

### plan

```shell
make plan AWS_PROFILE=ipe-rootdeployer COUNTRY=us ENVIRONMENT=stage
```

### apply

```shell
make apply AWS_PROFILE=ipe-rootdeployer COUNTRY=us ENVIRONMENT=stage
# Auto approve
# make apply AWS_PROFILE=ipe-rootdeployer COUNTRY=us ENVIRONMENT=stage APPROVE=true
```

### destroy

```shell
make destroy AWS_PROFILE=ipe-rootdeployer COUNTRY=us ENVIRONMENT=stage
```
