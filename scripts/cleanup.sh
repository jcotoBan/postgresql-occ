#!/bin/bash

set -e

readonly owner="${1}"
readonly repo="${2}"
readonly date=$(date '+%Y-%m-%d_%H%M%S')

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

remove_runner