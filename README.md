# infra

## Init Terraform

> * This only needs to be run once
> * Use `aws configure --profile ipe-init` to set up AWS ak/sk

```shell
AWS_PROFILE=ipe-init terraform.exe init -chdir=init
AWS_PROFILE=ipe-init terraform.exe plan -chdir=init
AWS_PROFILE=ipe-init terraform.exe apply -chdir=init
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

### output

```shell
make output AWS_PROFILE=ipe-rootdeployer COUNTRY=us ENVIRONMENT=stage
```

### destroy

```shell
make destroy AWS_PROFILE=ipe-rootdeployer COUNTRY=us ENVIRONMENT=stage
```

## Transit Gateway cross account peer

> Perform Transit Gateway deployment after multiple VPC deployments is complete

```shell
# init
make init AWS_PROFILE=ipe-rootdeployer VPC_TGW=true
# plan
make plan AWS_PROFILE=ipe-rootdeployer VPC_TGW=true
# apply
make apply AWS_PROFILE=ipe-rootdeployer VPC_TGW=true
# output
make output AWS_PROFILE=ipe-rootdeployer VPC_TGW=true
# destroy
make destroy AWS_PROFILE=ipe-rootdeployer VPC_TGW=true
```
