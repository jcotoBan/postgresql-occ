#!/bin/bash

./config.sh remove --token ARTQV33IFNB3OYL6BP5DKKLFLO3RS

# linode-cli linodes list --json | jq '.[] | select (.label | startswith("kubeslice"))' | jq '.id' | xargs -I {} linode-cli linodes delete {}
