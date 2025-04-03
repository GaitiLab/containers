FROM mambaorg/micromamba:ubuntu22.04 AS base

FROM base AS build

# Trying: https://github.com/BayraktarLab/cell2location/issues/348#issuecomment-1950080723

USER $MAMBA_USER

# Copy the necessary files
COPY --chown=$MAMBA_USER:$MAMBA_USER env.yaml /tmp/env.yaml

# Install dependencies using micromamba and clean up
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes

ARG MAMBA_DOCKERFILE_ACTIVATE=1

RUN pip uninstall -y jax jaxlib && \
    micromamba install -y -c conda-forge jaxlib jax numpy=2.1 squidpy && \
    micromamba clean --all --yes && \
    rm /tmp/env.yaml

FROM base 

USER $MAMBA_USER

ARG MAMBA_DOCKERFILE_ACTIVATE=1  

# Copy the installed environment and R packages from the build stage to ensure R and Python are available
COPY --from=build /opt/conda /opt/conda