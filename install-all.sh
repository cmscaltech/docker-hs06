#!/bin/sh

# Install Bare metal all required packages
sh baremetal/install.sh


# Install all what is required for docker
sh docker/install.sh

# Install all what is required for hepscore
sh hepscore/install.sh
