#!/usr/bin/env bash
#SBATCH -J build_apptainer_image
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=John.Doe@mail.ca
#SBATCH --partition=all
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=02:00:00
#SBATCH --output=slurm_out/%x_%A.out
#SBATCH --error=slurm_out/%x_%A.out

# Adaptable SLURM script for building images from .tar files (Docker). 
# Assuming that the PWD contains your .tar file and is also the destination

# TODO change your email in the SBATCH above

# TODO fill out
image_name="giotto"

module load apptainer 

export APPTAINER_CACHEDIR=$PWD/cache
export APPTAINER_TMPDIR=$PWD/tmp
mkdir -p $APPTAINER_CACHEDIR
mkdir -p $APPTAINER_TMPDIR

apptainer build ${image_name}.sif docker-archive:${image_name}.tar

# Clean up
rm -rf $APPTAINER_CACHEDIR
rm -rf $APPTAINER_TMPDIR