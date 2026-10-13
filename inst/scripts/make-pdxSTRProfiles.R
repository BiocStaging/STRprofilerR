# Builds data/pdxSTRProfiles.rda from inst/extdata/main_database.csv.
#
# Run from the root of the package source after any change to the CSV, the
# STRProfiles class, or ingest, with the current source loaded:
#
#   Rscript -e 'pkgload::load_all(); source("inst/scripts/make-pdxSTRProfiles.R")'
#
# tests/testthat/test-data.R fails if the saved object and a fresh read of the
# CSV disagree.
#
# Source: STR profiles of patient-derived models from The Jackson Laboratory
# PDX program (https://tumor.informatics.jax.org/mtbwi/pdxSearch.do) and the
# NCI Patient-Derived Models Repository (https://pdmr.cancer.gov/), compiled as
# the default database of the strprofiler Python package. See
# inst/scripts/README.md.

library(STRprofilerR)

src <- file.path("inst", "extdata", "main_database.csv")
stopifnot(file.exists(src), dir.exists("data"))

# Center and Passage are routed to sampleData() by the default metadataCols.
pdxSTRProfiles <- readSTRProfiles(src)

# Record the file name, not this machine's path to it. The application shows it
# as the name of the loaded database.
pdxSTRProfiles@provenance$files <- basename(src)

save(pdxSTRProfiles, file = file.path("data", "pdxSTRProfiles.rda"), compress = "xz")
