#!/bin/bash

# set -e

# readonly owner="${1}"
# readonly repo="${2}"
# readonly date=$(date '+%Y-%m-%d_%H%M%S')

#  remove_runner () {
#     mkdir actions-runner && cd actions-runner
#     curl -o actions-runner-linux-x64-2.300.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.300.2/actions-runner-linux-x64-2.300.2.tar.gz
#     echo "ed5bf2799c1ef7b2dd607df66e6b676dff8c44fb359c6fedc9ebf7db53339f0c  actions-runner-linux-x64-2.300.2.tar.gz" | shasum -a 256 -c
#     tar xzf ./actions-runner-linux-x64-2.300.2.tar.gz

#     registration_token=$(curl -sX POST -H "Accept: application/vnd.github+json" \
#     -H "Authorization: Bearer ${gh_token}"\
#     -H "X-GitHub-Api-Version: 2022-11-28" \
#     https://api.github.com/repos/${owner}/${repo}/actions/runners/registration-token | jq -r .token)
#     RUNNER_ALLOW_RUNASROOT="1" ./config.sh remove --token $registration_token
# }

# remove_runner