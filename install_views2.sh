#!/usr/bin/env bash

# Stop on error
set -e
echo "Started installing views."
echo "Initalising conda for this shell"
eval "$(conda shell.bash hook)"

echo "Updating conda"
conda update --all --yes
echo "Removing existing views2 env"
conda remove --name views2 --all --yes
echo "Creating env from env_static.yaml"
# @TODO: Change back to env_static.yaml asap when we have working "builds" for linux
conda env create -f /content/drive/My\ Drive/OpenViEWS2/misc/environment.yaml
echo "Activating env"
source activate views2
echo "Running pip install --editable . to install the views package"
pip install --editable /content/drive/My\ Drive/OpenViEWS2

echo "Creating storage directory here"
mkdir -p ./storage

# Copy the default config file to default config dir ~/.views2/
if [ ! -f /content/drive/My\ Drive/OpenViEWS2/config.yaml ];
    then
        echo "No current ./config.yaml found, copying the defaults"
        cp /content/drive/My\ Drive/OpenViEWS2/misc/defaults.yaml /content/drive/My\ Drive/OpenViEWS2/config.yaml
    else
        echo "./config.yaml already exists, not changing it"
fi

echo "Great success, you can now do \" conda activate views2 \" in your shell and get started."
