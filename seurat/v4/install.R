options(repos = "https://CRAN.R-project.org")

message("Install packages with pak...")

pak::pkg_install(
    c(
        "GaitiLab/GaitiLabUtils",
        "mojaveazure/seurat-disk",
        "jmw86069/colorjam@fe1658de43da284e2d40c3f049fe9334caec4f19",
        "cellgeni/schard",
        # Force v4 - https://satijalab.org/seurat/articles/install_v5.html#install-seurat-v4
        "satijalab/seurat@v4.4.0",
        "satijalab/seurat-object@v4.1.4"
    ),
    upgrade = FALSE
)

message("Finished!")
