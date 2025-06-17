FROM mambaorg/micromamba:ubuntu22.04 AS base

FROM base AS build

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

USER $MAMBA_USER

# Copy the necessary files
COPY --chown=$MAMBA_USER:$MAMBA_USER env.yaml /tmp/env.yaml
# Copy the cloned github repo (when building from scratch, easiest to first clone the repo)
COPY --chown=$MAMBA_USER:$MAMBA_USER off-target-probe-tracker /tmp/off-target-probe-tracker


# Install dependencies using micromamba and clean up
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes

ARG MAMBA_DOCKERFILE_ACTIVATE=1

# Install from cloned github repo (when building from scratch, easiest to first clone the repo)
RUN cd /tmp/off-target-probe-tracker && \
    pip install --no-cache-dir . && \
    # Clean up pip cache just in case (pip caches in ~/.cache/pip)
    rm -rf ~/.cache/pip && \
    # Remove the source code to save space
    cd /tmp && rm -rf off-target-probe-tracker