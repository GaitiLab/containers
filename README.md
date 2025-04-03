# containers

Docker & Singularity/Apptainer images for convenience. These containers can also be found on:
-  [DockerHub](https://hub.docker.com/repositories/joank23).
- Internally on the HPC group directory `ref/singularity_images`

## Available images

| Docker image     | Description                                                                                                                                                                                                                                                         | Reference                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | Repository                                                                                                                                                          |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| cell2location    | Cell type deconvolution tool for Spatial Transcriptomics                                                                                                                                                                                                            | Kleshchevnikov, V., Shmatko, A., Dann, E. et al. Cell2location maps fine-grained cell types in spatial transcriptomics. Nat Biotechnol 40, 661–671 (2022). <https://doi.org/10.1038/s41587-021-01139-4>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | [GitHub](https://github.com/BayraktarLab/cell2location)                                                                                                             |
| Giotto           | Toolbox for Spatial Transcriptomics. Micromamba-based image with R-version **4.4.1**. Also contains `pak`, `GaitiLab/GaitiLabUtils` and `radian`                                                                                                                    | Dries, R., Zhu, Q., Dong, R. et al. Giotto: a toolbox for integrative analysis and visualization of spatial expression data. Genome Biol 22, 78 (2021). <https://doi.org/10.1186/s13059-021-02286-2>; Dong, R., Yuan, GC. SpatialDWLS: accurate deconvolution of spatial transcriptomic data. Genome Biol 22, 145 (2021). <https://doi.org/10.1186/s13059-021-02362-7>                                                                                                                                                                                                                                                                                                                                               | [GitHub](https://drieslab.github.io/Giotto_website/)                                                                                                                |
| RCTD             | Tool for cell type annotation of Spatial Transcriptomics. Image builds on the `Seurat_v5` image (v5.1.0).                                                                                                                                                           | Cable, D.M., Murray, E., Zou, L.S. et al. Robust decomposition of cell type mixtures in spatial transcriptomics. Nat Biotechnol 40, 517–526 (2022). <https://doi.org/10.1038/s41587-021-00830-w>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | [GitHub](https://github.com/dmcable/spacexr)                                                                                                                        |
| Seurat_v4        | Micromamba-based image with R version **4.3.3**, `Seurat` **v4.4.0** & `GaitiLab/GaitiLabUtils`. Commonly used packages are also installed: `pak`, `tidyverse`, `data.table`, `stringr`. For convenience when working interactively, `radian` is installed as well. | Hao, Y., Hao, S., Andersen-Nissen, E., Mauck, W. M., Zheng, S., Butler, A., Lee, M. J., Wilk, A. J., Darby, C., Zager, M., Hoffman, P., Stoeckius, M., Papalexi, E., Mimitou, E. P., Jain, J., Srivastava, A., Stuart, T., Fleming, L. M., Yeung, B., … Satija, R. (2021). Integrated analysis of multimodal single-cell data. Cell, 184(13), 3573-3587.e29. <https://doi.org/10.1016/j.cell.2021.04.048>                                                                                                                                                                                                                                                                                                            | [Seurat](https://satijalab.org/seurat/)                                                                                                                             |
| seurat_v5        | Micromamba-based image with R version **4.3.3**, `Seurat` **v5.1.0** & `GaitiLab/GaitiLabUtils`. Commonly used packages are also installed: `pak`, `tidyverse`, `data.table`, `stringr`. For convenience when working interactively, `radian` is installed as well. | Hao, Y., Stuart, T., Kowalski, M.H. et al. Dictionary learning for integrative, multimodal and scalable single-cell analysis. Nat Biotechnol 42, 293–304 (2024). <https://doi.org/10.1038/s41587-023-01767-y>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | [Seurat](https://satijalab.org/seurat/)                                                                                                                             |
| cell2cell        | Image used in the Nextflow pipeline `GaitiLab/scrnaseq-cellcomm-pipeline` to run cell2cell. Image is based on Python **3.10.8**                                                                                                                                     | Armingol E, Ghaddar A, Joshi CJ, Baghdassarian H, Shamie I, et al. (2022) Inferring a spatial code of cell-cell interactions across a whole animal body. PLOS Computational Biology 18(11): e1010715. [https://doi.org/10.1371/journal.pcbi.1010715](https://doi.org/10.1371/journal.pcbi.1010715)                                                                                                                                                                                                                                                                                                                                                                                                                   | [GitHub](https://github.com/earmingol/cell2cell)                                                                                                                    |
| cellphonedb      | Image used in the Nextflow pipeline `GaitiLab/scrnaseq-cellcomm-pipeline` to run `CellPhoneDB v5`. Image is based on Python **3.8.18**                                                                                                                              | Garcia-Alonso, L., Lorenzi, V., Mazzeo, C. I. et al. Single-cell roadmap of human gonadal development. Nature 607, 540–547 (2022). [https://doi.org/10.1038/s41586-022-04918-4](https://doi.org/10.1038/s41586-022-04918-4)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | [GitHub](https://github.com/ventolab/CellphoneDB)                                                                                                                   |
| scrnaseqcellcomm | Image used in the Nextflow pipeline `GaitiLab/scrnaseq-cellcomm-pipeline` to run all Rscripts, incl. `CellChat` (v2.1.2)& `LIANA` (v0.1.14). The image installs R-version `4.2.2`, Seurat `4.4.0` and `GaitiLab/GaitiLabUtils`                                      | Jin, S., Plikus, M. V., & Nie, Q. (2023). CellChat for systematic analysis of cell-cell communication from single-cell and spatially resolved transcriptomics (p. 2023.11.05.565674). bioRxiv. [https://doi.org/10.1101/2023.11.05.565674](https://doi.org/10.1101/2023.11.05.565674);  Dimitrov, D., Türei, D., Garrido-Rodriguez M., Burmedi P. L., Nagai, J. S., Boys, C., Flores, R. O. R., Kim, H., Szalai, B., Costa, I. G., Valdeolivas, A., Dugourd, A. and Saez-Rodriguez, J. Comparison of methods and resources for cell-cell communication inference from single-cell RNA-Seq data. Nat Commun 13, 3224 (2022). [https://doi.org/10.1038/s41467-022-30755-0](https://doi.org/10.1038/s41467-022-30755-0) | [CellChat v2](https://github.com/jinworks/CellChat), [LIANA](https://github.com/saezlab/liana/), [scrnaseq-cellcomm](https://github.com/GaitiLab/scrnaseq-cellcomm) |
| cytotrace2       | Based on the `joank23/seurat:4.4.0` image. Contains the R-based version of cytoTRACE2.                                                                                                                                                                              | Kang M, Armenteros JJA, Gulati GS, Gleyzer R, Avagyan S, Brown EL, Zhang W, Usmani A, Earland N, Wu Z, Zou J, Fields RC, Chen DY, Chaudhuri AA, Newman AM. Mapping single-cell developmental potential in health and disease with interpretable deep learning. bioRxiv Preprint. 2024 Mar 21:2024.03.19.585637. doi: 10.1101/2024.03.19.585637. PMID: 38562882; PMCID: PMC10983880.                                                                                                                                                                                                                                                                                                                                  | [GitHub](https://github.com/digitalcytometry/cytotrace2)                                                                                                            |

## How to use

### H4H

- Build image 

1. Save Docker image as '.tar'
```sh 
docker save <docker-image> > <docker-image>.tar
```
2. Move tar file to H4H
3. Build Apptainer/Singularity image
```sh
module load apptainer 
apptainer build <image>.sif docker-archive:<image>.tar
```

- Running a container interactively

```sh
module load apptainer 
apptainer run <image>.sif <command>
```

### Local

#### Docker

- Build image

```sh
# platform, e.g. linux/amd64, linux/arm64
docker buildx build -t <name> . --platform <your-platform>
```

- Running a container interactively.

```sh
# platform, e.g. linux/amd64 linux/arm64
docker run -it --rm --platform <your-platform> <docker-image> <command>
```

#### Apptainer

- Build image from DockerHub (https://hub.docker.com/repositories/joank23)

```sh
apptainer build <image>.sif docker://<docker-hub-image>
```

- Running a container interactively

```sh
apptainer run <image>.sif <command>
```
