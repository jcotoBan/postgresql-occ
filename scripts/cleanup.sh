#!/bin/bash

./config.sh remove --token $REGISTRATION_TOKEN

# linode-cli linodes list --json | jq '.[] | select (.label | startswith("kubeslice"))' | jq '.id' | xargs -I {} linode-cli linodes delete {}
