options(repos = "https://CRAN.R-project.org")

# # 1). Install 'pak' (fast package installer)
# message("Installing 'pak'...")
# install.packages("pak")

# 2). Install 'scrnaseq-cellcomm'
message("Installing 'GaitiLabUtils'...")
pak::pkg_install("GaitiLab/GaitiLabUtils")

message("Finished!")
