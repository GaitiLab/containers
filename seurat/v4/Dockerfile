FROM mambaorg/micromamba:ubuntu22.04 AS base

FROM base AS build

USER root

# Update, install required packages, and clean up in one RUN statement
RUN apt-get update && \
    apt-get install -y --no-install-recommends libcairo2-dev libhdf5-dev libxml2-dev && \
    rm -rf /var/lib/apt/lists/*

USER $MAMBA_USER

# Copy the necessary files
COPY --chown=$MAMBA_USER:$MAMBA_USER env.yaml /tmp/env.yaml
COPY --chown=$MAMBA_USER:$MAMBA_USER install.R /tmp/install.R

# Install dependencies using micromamba and clean up
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes

ARG MAMBA_DOCKERFILE_ACTIVATE=1

# Run the R script
RUN Rscript /tmp/install.R && \
    rm /tmp/install.R /tmp/env.yaml

