#!/bin/bash

# The actual Marketplace app/cluster setup stackscript.
# Example from postgresql-occ
# ----------

# set -e
# trap "cleanup $? $LINENO" EXIT

## Deployment Variables
# <UDF name="token_password" label="Your Linode API token" />
# <UDF name="cluster_name" label="Domain Name" example="linode.com" />
# <UDF name="sudo_username" label="The limited sudo user to be created in the cluster" />
# <UDF name="add_ssh_keys" label="Add Account SSH Keys to All Nodes?" oneof="yes,no"  default="yes" />
# <UDF name="cluster_size" label="PostgeSQL cluster size" default="3" oneof="3" />

# ...