FROM joank23/seurat:5.1.0

ARG MAMBA_DOCKERFILE_ACTIVATE=1

RUN R -e "pak::pkg_install('dmcable/spacexr')"
