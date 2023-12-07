#!/bin/bash

# StackScript that runs on instance provisioned by the
# ghrunner.sh script. This does the basic configuration
# to install GitHub actions dependencies and configure
# it to be the self-hosted runner for the specified
# repository. This is the StackScript saved onto a the
# Linode CI/CD account, and the StackScript ID provided
# to the create_runner() function in ghrunner.sh.

# DO NOT confuse this with ss.sh, which is the StackScript
# that initiates execution of the Ansible playbook for the
# Marketplace app/cluster.


# <UDF name="repository" label="Github repository" />
# <UDF name="owner" label="Github repo owner" />
# <UDF name="gh_password" label="Github token" />
# <UDF name="runner_label" label="Github runner label" />


setup () {
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get -yq upgrade
}

install () {
    mkdir actions-runner && cd actions-runner
    curl -o actions-runner-linux-x64-2.300.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.300.2/actions-runner-linux-x64-2.300.2.tar.gz
    echo "ed5bf2799c1ef7b2dd607df66e6b676dff8c44fb359c6fedc9ebf7db53339f0c  actions-runner-linux-x64-2.300.2.tar.gz" | shasum -a 256 -c
    tar xzf ./actions-runner-linux-x64-2.300.2.tar.gz
}

run () {
    ./bin/installdependencies.sh
    RUNNER_ALLOW_RUNASROOT="1" ./config.sh --url https://github.com/${OWNER}/${REPOSITORY} --token ${GH_PASSWORD} --labels ${RUNNER_LABEL}   #Change accordingly
    RUNNER_ALLOW_RUNASROOT="1" ./run.sh
}

# main
setup
install
run