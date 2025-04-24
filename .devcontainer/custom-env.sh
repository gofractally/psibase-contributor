#!/bin/bash

ENV_FILE=".devcontainer/.env"

case "$(uname -s)" in
    Darwin)
        printf "MAC_GW_IP=192.168.65.1\n" > "$ENV_FILE"
        ;;
    *)
        echo "Custom gateway IP env variable only needed on docker for mac"
        exit 0
        ;;
esac

# On docker for mac, it appears that the gateway ip is always `192.168.65.1`.
# 
# From what I've found, I think Docker Desktop for Mac hard-codes this address inside its vpnkit layer every time it starts the 
#   linux vm in which it runs the containers.
# So whenever the host makes a request to the container, the vpnkit's NAT rewrites the source of the request at the VM boundary to match that 
#   hard-coded gateway IP of 192.168.65.1.

# I can't find this documented officially, but after a lot of digging I see many different sources that seem to confirm this.
# e.g.:
# 
# * https://forums.docker.com/t/services-that-need-to-know-source-ip-host-networking-only/141884
#   ```
#   Using a client to connect in, though, I find the IP address of that client is not the IP of the host on my real network, but a different 
#   and specific IP (192.168.65.1) for every connection.
#   ```
#
# * https://forums.docker.com/t/host-docker-internal-not-resolving-correctly/137980
#   ```
#   You can tell from the container's logs, that 192.168.65.254 is being provided as the IP address of host.docker.internal. But when the 
#   host machine is actually trying to access the container, it is being reported as 192.168.65.1
#   This happens on 4.23 and 4.24. If I rollback to 4.22, everything works
#   ```
#
# And this has been manually confirmed to be consistent on three different mac machines by running an instance of psinode, and checking the logs 
#  in the container after making a request to it from the host.
