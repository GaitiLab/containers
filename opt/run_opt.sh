#!/usr/bin/env bash
#SBATCH -J run_opt_tracker
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=Joan.Kant@uhn.ca
#SBATCH --partition=himem
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=00:30:00
#SBATCH --output=slurm_out/%x_%A.out
#SBATCH --error=slurm_out/%x_%A.out

# TODO change email
# TODO change paths accordingly

module load apptainer

# ---- Use of your own probes
# Starts with /mnt for mounting
# probes="/mnt/probes/xenium_human_5k_gene_expression_panel_probe_sequences_revB_reformatted.fa"

# Output directory created in PWD by OPT
output_dir="xenium_5k_panel/chess"

# ---- Refs packages with OPT 
# Data files from GitHub repo (https://github.com/JEFworks-Lab/off-target-probe-tracker)
# and stored in shared folder on H4H

# In case of testing, an example of a FASTA file with probes was provided
# probes="/mnt/data/probes/xenium_human_breast_gene_expression_panel_probe_sequences.fasta"

refs_dir="/cluster/projects/gaitigroup/ref/opt_refs/"

# All directories below are paths based on path after mounting, i.e. starting with mnt
gene_synonyms="/mnt/gene_synonyms.csv"

# # (1) Gencode
# annotation_file="/mnt/gencode/gencode.v47.basic.annotation.fmted.gff"
# target_fasta="/mnt/gencode/gencode.v47.basic.annotation.fmted.fa"

# # (2) chess
# annotation_file="/mnt/chess/chess3.1.3.GRCh38.primary.gff"
# target_fasta="/mnt/chess/chess3.1.3.GRCh38.primary.gf"

# # (3) Refseq
# annotation_file="/mnt/refseq/refseq.v110.noAlt.noFix.renamed.gff"
# target_fasta="/mnt/refseq/refseq.v110.noAlt.noFix.filtered.fa"


# Shared apptainer image on H4H
apptainer_img="/cluster/projects/gaitigroup/ref/singularity_images/opt.sif"

# By default runs 
apptainer run --bind ${refs_dir}:/mnt ${apptainer_img} opt \
    -o ${output_dir}/ \
    -p 10 all \
    -q ${probes} \
    -a ${annotation_file} \
    -t ${target_fasta} \
    -s ${gene_synonyms}
