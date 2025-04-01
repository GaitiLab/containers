FROM mambaorg/micromamba:ubuntu22.04 AS base 

# Stage 1: Install python environment for Giotto
FROM base AS pyenv

USER root

# Update, install required packages, and clean up in one RUN statement
RUN apt-get update && \
    apt-get install -y --no-install-recommends libcairo2-dev && \
    rm -rf /var/lib/apt/lists/*

USER $MAMBA_USER

# Copy the necessary files
COPY --chown=$MAMBA_USER:$MAMBA_USER env.yaml /tmp/env.yaml

# Install dependencies using micromamba and clean up
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes

ARG MAMBA_DOCKERFILE_ACTIVATE=1

# Stage 2: Install Giotto
FROM base AS giottosuite

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends libfontconfig1-dev && \
    rm -rf /var/lib/apt/lists/*

USER $MAMBA_USER

ARG MAMBA_DOCKERFILE_ACTIVATE=1  

# Copy the installed environment and R packages from the build stage to ensure R and Python are available
COPY --from=pyenv /opt/conda /opt/conda

RUN R -e "pak::pkg_install('drieslab/Giotto')"

# Stage 3: 
FROM base AS build

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends libharfbuzz-dev \
    libfribidi-dev \
    cmake \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    pkgconf && \
    rm -rf /var/lib/apt/lists/*

USER $MAMBA_USER
ARG MAMBA_DOCKERFILE_ACTIVATE=1  

COPY --chown=$MAMBA_USER:$MAMBA_USER install.R /tmp/install.R

# Copy the installed environment and R packages from the build stage to ensure R and Python are available
COPY --from=giottosuite /opt/conda /opt/conda

RUN Rscript /tmp/install.R && \
    rm /tmp/install.R

FROM base
COPY --from=build /opt/conda /opt/conda
ARG MAMBA_DOCKERFILE_ACTIVATE=1  
