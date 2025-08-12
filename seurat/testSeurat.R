# install specific package so that Seurat / SeuratObject won't be upgraded to v5
pak::pkg_install("satijalab/seurat-data@v0.2.1")
SeuratData::InstallData("pbmc3k")

c("Seurat", "SeuratObject", "Matrix", "MASS") |>
    purrr::map(\(x) {
        print(paste("pkg:", x, "version:", packageVersion(x)))
    })

data(pbmc3k)

# Test standard flow
standard_workflow <- function(obj) {
    obj <- Seurat::NormalizeData(obj)
    obj <- Seurat::FindVariableFeatures(obj)
    obj <- Seurat::ScaleData(obj)
    obj <- Seurat::RunPCA(obj, features = Seurat::VariableFeatures(obj))
    obj <- Seurat::RunUMAP(obj, features = Seurat::VariableFeatures(obj))
    obj <- Seurat::FindNeighbors(obj, dims = 1:10)
    obj <- Seurat::FindClusters(obj)
    return(obj)
}

obj <- pbmc3k
# is out-of-the-box v3.1.4 (only works with Seurat/SeuratObject v4)
obj_version <- SeuratObject::Version(obj)

# Seurat object v5 / Seurat v5 only works with updated object
if (
    (compareVersion(as.character(obj_version), "5") > 0) &&
        compareVersion(packageVersion("SeuratObject"), "5")
) {
    obj |> standard_workflow()
}
# Updates based on Seurat/SeuratObject version
updated_obj <- Seurat::UpdateSeuratObject(obj)

obj_version <- SeuratObject::Version(updated_obj)
compareVersion(as.character(obj_version), "5")

updated_obj |> standard_workflow()
