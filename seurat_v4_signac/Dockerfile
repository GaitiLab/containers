FROM joank23/seurat:4.4.0

USER root

# Update, install required packages, and clean up in one RUN statement
RUN apt-get update && \
    apt-get install -y --no-install-recommends --fix-missing libbz2-dev liblzma-dev && \
    rm -rf /var/lib/apt/lists/*

USER $MAMBA_USER
ARG MAMBA_DOCKERFILE_ACTIVATE=1

RUN R --slave --no-restore --no-save -e "options(repos=c(CRAN='https://cloud.r-project.org')); setRepositories(ind=1:3); install.packages('Signac', dependencies = TRUE)"



