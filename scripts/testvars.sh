#!/bin/bash

# Put the test UDF variables for the Marketplace app/cluster
# here. When GitHub Action executes the ss.sh script, the
# UDF variables will have values for the script to run as
# it would being invoked from the Cloud Manager or API.

# Example:
#
export token_password="${linode_token}"
export cluster_name="test_postgres_cluster"
export sudo_username="testuser"
export add_ssh_keys="yes"
export cluster_size="3"

