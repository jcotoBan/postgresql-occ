#!/bin/bash

set -e

readonly owner="${1}"
readonly repo="${2}"
readonly date=$(date '+%Y-%m-%d_%H%M%S')

runner_token () {
    registration_token=$(curl -sX POST -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer ${gh_token}"\
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/repos/${owner}/${repo}/actions/runners/registration-token | jq -r .token)
}

create_runner () {
    # create self-hosted runner linode from stackscript
    linode_id=$(curl -sH "Content-Type: application/json" \
        -H "Authorization: Bearer ${linode_token}" \
        -X POST -d '{
        "swap_size": 512,
        "image": "linode/ubuntu22.04",
        "root_pass": "'"${root_password}"'",
        "stackscript_id": 1244472,
        "stackscript_data": {
            "repository": "'"${repo}"'",
            "gh_password": "'"${registration_token}"'"
        },
        "authorized_keys": [
            "ssh-rsa AAAA_valid_public_ssh_key_123456785== user@their-computer"
        ],
        "booted": true,
        "private_ip": true,
        "label": "'"${repo}_${date}_jcc"'",
        "type": "g6-standard-4",
        "region": "us-southeast"
        }' \
        https://api.linode.com/v4/linode/instances | jq -r .id)

        #Save the instance name

        curl -L \
        -X POST \
        -H "Accept: application/vnd.github+json" \
        -H "Authorization: Bearer ${gh_token}" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        https://api.github.com/repos/OWNER/REPO/actions/variables \
        -d '{"name":"RUNNER_NAME","value":"'"${repo}_${date}_jcc"'"}'
}

wait_for_it () {
    # wait for linode to be ready status triggering next workflow
    while true; do
        linode_status=$(curl -sH "Authorization: Bearer ${linode_token}" https://api.linode.com/v4/linode/instances/${linode_id} | jq -r .status)
        echo "linode still creating"
        sleep 2
        if [[ ${linode_status} == "running" ]]; then
            echo "linode is ready"
            break
        fi
    done
}

# main
runner_token
create_runner
wait_for_it

