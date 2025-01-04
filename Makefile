MISSING_ARGS = $(shell for x in '$(AWS_PROFILE)' '$(COUNTRY)' '$(ENVIRONMENT)' ; \
	do [ \"$$x\" = \"\" ] && echo 1 ; done)
ENV_VARS = AWS_PROFILE=$(AWS_PROFILE)
FLAGS = -chdir=./infra
OPTIONS = -var-file=../env/$(COUNTRY)/$(ENVIRONMENT).tfvars

define terraform_cmd
	$(eval $@_ACTION = $(1))
	$(eval $@_ENV_VARS = $(2))
	$(eval $@_FLAGS = $(3))
	$(eval $@_OPTIONS = $(4))
	@echo "Run terraform ${$@_FLAGS} ${$@_ACTION} ${$@_OPTIONS}"
	${$@_ENV_VARS} terraform ${$@_FLAGS} ${$@_ACTION} ${$@_OPTIONS}
endef

.PHONY: help
help: ## Prints this help
	@echo "Usage:"
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: check-args
check-args:
	@echo $(MISSING_ARGS)
ifneq ($(MISSING_ARGS),)
	$(error Missing one or more required argument(s): AWS_PROFILE, COUNTRY, ENVIRONMENT)
endif

.PHONY: init
init: check-args ## Init states
	$(eval OPTIONS = -backend-config=../env/$(COUNTRY)/$(ENVIRONMENT).backend.tfvars)
ifeq (${UPGRADE},true)
	$(eval OPTIONS += -reconfigure)
endif
	@$(call terraform_cmd, init, $(ENV_VARS), $(FLAGS), $(OPTIONS))

.PHONY: plan
plan: check-args ## Plan resources
	@$(call terraform_cmd, plan, $(ENV_VARS), $(FLAGS), $(OPTIONS))

.PHONY: output
output: check-args ## Show output
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
