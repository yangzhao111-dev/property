


make plan AWS_PROFILE=ipe-rootdeployer COUNTRY=us ENVIRONMENT=stage
ifeg($(VPC TGW),true)
    FLAGS =-chdir=./transit-gateway
    OPTIONS = -var-file=../env/transit-gateway.tfvars  -lock=false
    BACKEND_CONFIG =../env/transit-gateway.backend.tfvars
else
    FLAGS =-chdir=./infra
    OPTIONS = -var-file=../env/$(COUNTRY)/$(ENVIRONMENT).tfvars -lock=false 
    BACKEND_CONFIG =../env/$(COUNTRY)/$(ENVIRONMENT).backend.tfvars
endif
