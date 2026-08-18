#!/bin/bash

# Script to download and build pySCENIC Singularity images
module load singularity/3.11
module load java/18

# Build pySCENIC CLI version Singularity image
singularity build aertslab-pyscenic-0.12.1.sif docker://aertslab/pyscenic:0.12.1

# Build pySCENIC CLI version + ipython kernel + scanpy Singularity image
singularity build aertslab-pyscenic-scanpy-0.12.1-1.9.1.sif docker://aertslab/pyscenic_scanpy:0.12.1_1.9.1