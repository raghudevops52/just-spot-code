#!/bin/bash

echo "Note: Everytime we run this script creates a new server"

rm -rf .terraform terraform*

terraform init
terraform apply -auto-approve
