FROM joank23/seurat:4.4.0 AS base

FROM base AS build

USER root

# Update, install required packages, and clean up in one RUN statement
RUN apt-get update && \
    apt-get install -y --no-install-recommends libcairo2-dev libnetcdf-dev gcc-multilib curl libcurl4-openssl-dev && \
    rm -rf /var/lib/apt/lists/*

USER $MAMBA_USER

# Copy the necessary files
COPY --chown=$MAMBA_USER:$MAMBA_USER install.R /tmp/install.R
ARG MAMBA_DOCKERFILE_ACTIVATE=1

# Run the R script
RUN Rscript /tmp/install.R && \
    rm /tmp/install.R
