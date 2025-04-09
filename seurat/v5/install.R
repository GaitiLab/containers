options(repos = "https://CRAN.R-project.org")

message("Install packages with pak...")
pak::pkg_install(c("GaitiLab/GaitiLabUtils", "mojaveazure/seurat-disk", "satijalab/seurat-wrappers", "jmw86069/colorjam@fe1658de43da284e2d40c3f049fe9334caec4f19"))

message("Finished!")
