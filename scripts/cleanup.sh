#!/bin/bash

set -e

readonly owner="${1}"
readonly repo="${2}"
readonly date=$(date '+%Y-%m-%d_%H%M%S')


# linode-cli linodes list --json | jq '.[] | select (.label | startswith("kubeslice"))' | jq '.id' | xargs -I {} linode-cli linodes delete {}

 remove_runner () {

    runner_id=$(curl -L -s \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer ${gh_token}" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/repos/${owner}/${repo}/actions/runners | jq '.runners[0].id')

    curl -L \
    -X DELETE \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer ${gh_token}" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/repos/${owner}/${repo}/actions/runners/${runner_id}
}

clean_instances() {

    if [ -n "$runner_name" ]; then
        curl -s -H "Authorization: Bearer ${TOKEN_PASSWORD}" \
        https://api.linode.com/v4/linode/instances \
        | jq --arg runner_name "${runner_name}" '.data[] | select (.label | startswith($runner_name))' | jq '.id' \
        | xargs -I {} curl -H "Authorization: Bearer ${TOKEN_PASSWORD}" \
            -X DELETE \
            https://api.linode.com/v4/linode/instances/{}
    else
        echo "Be careful, runner name is empty"
    fi

    curl -L \
    -X DELETE \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer ${gh_token}" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/repos/${owner}/${repo}/actions/variables/RUNNER_NAME

}

remove_runner
clean_instances