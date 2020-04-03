# Makefile to kickoff terraform.
# ####################################################
#
STATEBUCKET = java-bucket-devops
STATEKEY = .terraform/terraform.tfstate
STATEREGION = eu-central-1

# # Before we start test that we have the mandatory executables available
	EXECUTABLES = git
	K := $(foreach exec,$(EXECUTABLES),\
		$(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH, consider sudo yum install $(exec)")))


.PHONY: plan

first-run:
	@echo "initialize remote state file"
	@echo $(WORKSPACE) $(JOB_NAME)
	sudo terraform init -backend-config="bucket=$(STATEBUCKET)" -backend-config="key=$(STATEKEY)"  -backend-config="region=$(STATEREGION)"


init:
	@echo "initialize remote state file"
	sudo terraform init --force-copy -backend-config="bucket=$(STATEBUCKET)" -backend-config="key=$(STATEKEY)" -backend-config="region=$(STATEREGION)"

validate: init
	@echo "running terraform validate
	sudo terraform validate -no-color 

plan: validate
	@echo "running terraform plan"
	sudo terraform plan -no-color 

apply: plan
	@echo "running terraform apply"
	sudo terraform apply -auto-approve -no-color

plan-destroy: validate
	@echo "running terraform plan -destroy"
	sudo terraform plan -destroy -no-color  

destroy: init
	@echo "running terraform destroy"
	sudo terraform destroy -force -no-color