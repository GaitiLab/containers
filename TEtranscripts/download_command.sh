#!/bin/bash

# At the time creating the image, the latest version is 2.2.3. This is the version on H4H.
# Pull the TEtranscripts Singularity container image from Docker Hub
singularity pull tetranscripts.sif docker://mhammelllab/tetranscripts:latest