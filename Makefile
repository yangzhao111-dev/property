MISSING_ARGS = $(shell for x in '$(AWS_PROFILE)' '$(COUNTRY)' '$(ENVIRONMENT)' ; \
	do [ \"$$x\" = \"\" ] && echo 1 ; done)
MISSING_ARGS_TGW = $(shell for x in '$(AWS_PROFILE)' ; \
	do [ \"$$x\" = \"\" ] && echo 1 ; done)

ENV_VARS = AWS_PROFILE=$(AWS_PROFILE)
ifeq ($(VPC_TGW),true)
	FLAGS = -chdir=./transit-gateway
	OPTIONS = -var-file=../env/transit-gateway.tfvars -lock=false
	BACKEND_CONFIG = ../env/transit-gateway.backend.tfvars
else
	FLAGS = -chdir=./infra
	OPTIONS = -var-file=../env/$(COUNTRY)/$(ENVIRONMENT).tfvars -lock=false
	BACKEND_CONFIG = ../env/$(COUNTRY)/$(ENVIRONMENT).backend.tfvars
endif

define terraform_cmd
	$(eval $@_ACTION = $(1))
	$(eval $@_ENV_VARS = $(2))
	$(eval $@_FLAGS = $(3))
	$(eval $@_OPTIONS = $(4))
	@echo "Run terraform ${$@_FLAGS} ${$@_ACTION} ${$@_OPTIONS}"
	${$@_ENV_VARS} terraform ${$@_FLAGS} ${$@_ACTION} ${$@_OPTIONS}
endef

HELP_FMT="  \033[36m%-20s\033[0m %s\n"

.PHONY: help
help: ## Prints this help
	@echo "Usage:"
	@echo "  make <COMMAND> [VARIABLE...]"
	@echo
	@echo "Examples:"
	@echo "  make init AWS_PROFILE=profile-name COUNTRY=us ENVIRONMENT=dev"
	@echo
	@echo "Commands:"
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf $(HELP_FMT), $$1, $$2}'
	@echo
	@echo "Variables:"
	@printf $(HELP_FMT) "AWS_PROFILE" "AWS profile name, required"
	@printf $(HELP_FMT) "COUNTRY" "Country: [us, au]"
	@printf $(HELP_FMT) "" "  required when plan, apply, output, destroy"
	@printf $(HELP_FMT) "ENVIRONMENT" "Environment name: [dev, stage, prod]"
	@printf $(HELP_FMT) "" "  required when plan, apply, output, destroy"
	@printf $(HELP_FMT) "VPC_TGW" "Setup the VPC transit gateways when this value is true, optional"
	@printf $(HELP_FMT) "UPGRADE" "Reconfigure the local states when this value is true"
	@printf $(HELP_FMT) "" "  optional for init"
	@printf $(HELP_FMT) "APPROVE" "Auto approve when this value is true"
	@printf $(HELP_FMT) "" "  optional for apply"

.PHONY: check-args
check-args:
ifeq ($(VPC_TGW),true)
ifneq ($(MISSING_ARGS_TGW),)
	$(error Missing required argument: AWS_PROFILE)
endif
else
ifneq ($(MISSING_ARGS),)
	$(error Missing one or more required argument(s): AWS_PROFILE, COUNTRY, ENVIRONMENT)
endif
endif

.PHONY: init
init: check-args ## Init states, use UPGRADE=true for reconfigure
	$(eval OPTIONS = -backend-config=$(BACKEND_CONFIG))
ifeq (${UPGRADE},true)
	$(eval OPTIONS += -reconfigure)
endif
	@$(call terraform_cmd, init, $(ENV_VARS), $(FLAGS), $(OPTIONS))

.PHONY: plan
plan: check-args ## Plan resources
	@$(call terraform_cmd, plan, $(ENV_VARS), $(FLAGS), $(OPTIONS))

.PHONY: output
output: check-args ## Show outputs
	@$(call terraform_cmd, output, $(ENV_VARS), $(FLAGS))

.PHONY: apply
apply: check-args ## Apply resources, use APPROVE=true for auto approve
ifeq (${APPROVE},true)
	$(eval OPTIONS += -auto-approve)
endif
	@$(call terraform_cmd, apply, $(ENV_VARS), $(FLAGS), $(OPTIONS))

.PHONY: destroy

destroy: check-args ## Destroy resources
	@$(call terraform_cmd, destroy, $(ENV_VARS), $(FLAGS), $(OPTIONS))
