#!/usr/bin/env bash
#SBATCH -J build_apptainer_image
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=Joan.Kant@uhn.ca
#SBATCH --partition=himem
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=02:00:00
#SBATCH --output=slurm_out/%x_%A.out
#SBATCH --error=slurm_out/%x_%A.out

# Adaptable SLURM script for building images from .tar files (Docker). 
# Assuming that the PWD contains your .tar file and is also the destination

# TODO change your email in the SBATCH above

# TODO fill out
image_name="opt"
image_src="/cluster/projects/gaitigroup/Users/Joan/containers/opt/${image_name}.tar"
image_dest="/cluster/projects/gaitigroup/ref/singularity_images/${image_name}_dev.sif"

module load apptainer 

export APPTAINER_CACHEDIR=$PWD/cache_${image_name}
export APPTAINER_TMPDIR=$PWD/tmp_${image_name}
mkdir -p $APPTAINER_CACHEDIR
mkdir -p $APPTAINER_TMPDIR

apptainer build ${image_dest} docker-archive:${image_src}

# Clean up
rm -rf $APPTAINER_CACHEDIR
rm -rf $APPTAINER_TMPDIR