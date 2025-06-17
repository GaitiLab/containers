#!/usr/bin/env bash

# OPT requires a specific format in version: https://github.com/JEFworks-Lab/off-target-probe-tracker/commit/4d4d8b6cc2c79e41e36467789ff4908317fb6577

# >gene_id|gene_name|accession

# 'accession' seems to be just a unique identifier
# See ref https://www.10xgenomics.com/support/software/xenium-panel-designer/latest/tutorials/xenium-panel-design-concepts-terms#seq-coord, which states:
# "In Xenium panel designs, the FASTA file contains the panel probe sequences in FASTA format, 
# as represented on the probes and reverse-complement to the targeted transcript in FASTA format. 
# The sequence ID consists of the transcript ID, gene name, and a unique identifying string, e.g. ENSG00000134440|NARS|1f419e5.""

# However FASTA files downloaded from the 10x Genomics website come in a different format, i.e. 
# {GENE SYMBOL} ({ENSEMBL ID}) | {CODEWORD} | {INDEX}
# Following script generated with ChatGPT converts this into: >{ENSEMBL ID}|{GENE SYMBOL}|{CODEWORD}_{INDEX} 
# with {CODEWORD}_{INDEX} representing the unique identifier

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