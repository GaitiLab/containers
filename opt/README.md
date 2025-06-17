# Run OPT (Off-target Probe Tracker)

For more information on the tool, please see:

* [GitHub repo](https://github.com/JEFworks-Lab/off-target-probe-tracker)
* [Pre-print](https://www.biorxiv.org/content/10.1101/2025.03.31.646342v1)

## How to run OPT

A [Jupyter Notebook](https://github.com/JEFworks-Lab/off-target-probe-tracker/blob/main/example.ipynb) is provided on GitHub, but see below for default use or use `run_opt.sh`.

```sh

# In case H4H is used, load apptainer
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

```

## Formatting FASTA files

OPT requires a specific format in version: https://github.com/JEFworks-Lab/off-target-probe-tracker/commit/4d4d8b6cc2c79e41e36467789ff4908317fb6577

`>gene_id|gene_name|accession`

'accession' seems to be just a unique identifier
See ref https://www.10xgenomics.com/support/software/xenium-panel-designer/latest/tutorials/xenium-panel-design-concepts-terms#seq-coord, which states:

"In Xenium panel designs, the FASTA file contains the panel probe sequences in FASTA format, as represented on the probes and reverse-complement to the targeted transcript in FASTA format. The sequence ID consists of the transcript ID, gene name, and a unique identifying string, e.g. ENSG00000134440|NARS|1f419e5.""

However FASTA files downloaded from the 10x Genomics website ([pre-designed panels v1](https://www.10xgenomics.com/support/software/xenium-panel-designer/latest/tutorials/pre-designed-xenium-v1) or [Xenium prime 5K panels](https://www.10xgenomics.com/support/software/xenium-panel-designer/latest/tutorials/pre-designed-xenium-prime-5k)) come in a different format, i.e. `{GENE SYMBOL} ({ENSEMBL ID}) | {CODEWORD} | {INDEX}`

Following script generated with ChatGPT converts this into: `>{ENSEMBL ID}|{GENE SYMBOL}|{CODEWORD}_{INDEX}` with `{CODEWORD}_{INDEX}` representing the unique identifier. Alternatively use `format_fasta.sh`.

```sh
# filename without extension
input_fasta_excl_ext=""
# Extension (.fasta or .fa)
ext=".fa"

echo "Input file=${input_fasta_excl_ext}..."
echo "Extension=${ext}..."

echo "Start reformatting..."

awk '/^>/ {
    match($0, /^>([^ ]+) \(([^)]+)\) \| ([^|]+) \| (.+)$/, arr)
    if (arr[1] && arr[2] && arr[3] && arr[4]) {
        print ">" arr[2] "|" arr[1] "|" arr[3] "_" arr[4]
    } else {
        print $0
    }
    next
} 1' ${input_fasta_excl_ext}${ext} > ${input_fasta_excl_ext}_reformatted${ext}

echo "Finished reformatting!"

```

## Building image from scratch

When building the image from scratch, first clone the [GitHub repo](https://github.com/JEFworks-Lab/off-target-probe-tracker). Then follow instructions as outlined in the global `README.md`