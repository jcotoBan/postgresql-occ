#!/bin/bash

# linode-cli linodes list --json | jq '.[] | select (.label | startswith("kubeslice"))' | jq '.id' | xargs -I {} linode-cli linodes delete {}

remove_runner () {
    registration_token=$(curl -sX POST -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer ${gh_token}"\
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/repos/${owner}/${repo}/actions/runners/registration-token | jq -r .token)

    ./config.sh remove --token $registration_token
}

remove_runner()


