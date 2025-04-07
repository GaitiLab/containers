options(repos = "https://CRAN.R-project.org")

message("Install packages with pak...")
pak::pkg_install(c("GaitiLab/GaitiLabUtils", "mojaveazure/seurat-disk"))

message("Finished!")
