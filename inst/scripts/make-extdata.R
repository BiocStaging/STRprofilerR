# Fetches the example files in inst/extdata that come from the strprofiler
# Python package (https://github.com/j-andrews7/STRprofiler, MIT license),
# pinned to its 0.5.1 release, which STRprofilerR is checked against.
#
# Run from the root of the package source:
#
#   Rscript inst/scripts/make-extdata.R
#
# The only change made to these files is line-ending normalisation by git
# (see .gitattributes). What each file holds, and its source, is described in
# inst/scripts/README.md. inst/extdata/clastr_response.json is made by
# inst/scripts/make-clastr-response.R instead.

base <- "https://raw.githubusercontent.com/j-andrews7/STRprofiler/v0.5.1/"

# Path in the strprofiler repository, named by the file written to inst/extdata.
files <- c(
    ExampleSTR.xlsx = "tests/ExampleSTR.xlsx",
    ExampleSTR_database.csv = "tests/ExampleSTR_database.csv",
    ExampleSTR_long.csv = "tests/ExampleSTR_long.csv",
    ExampleSTR_long_1samp.csv = "tests/ExampleSTR_long_1samp.csv",
    Example_app_database.csv = "tests/Example_app_database.csv",
    Example_clastr_input.csv = "tests/Example_clastr_input.csv",
    SampleMap_exp.csv = "tests/SampleMap_exp.csv",
    Example_Batch_File.csv = "strprofiler/shiny_app/www/Example_Batch_File.csv",
    Example_Custom_Database.csv = "strprofiler/shiny_app/www/Example_Custom_Database.csv",
    main_database.csv = "strprofiler/shiny_app/www/main_database.csv"
)

outDir <- file.path("inst", "extdata")
stopifnot(dir.exists(outDir))

for (f in names(files)) {
    utils::download.file(paste0(base, files[[f]]), file.path(outDir, f), mode = "wb", quiet = TRUE)
}
