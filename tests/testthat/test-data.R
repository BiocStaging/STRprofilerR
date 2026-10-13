# data/pdxSTRProfiles.rda is built from inst/extdata/main_database.csv by
# inst/scripts/make-pdxSTRProfiles.R. If these fail, re-run that script.

loadPdx <- function() {
    env <- new.env()
    utils::data("pdxSTRProfiles", package = "STRprofilerR", envir = env)
    env$pdxSTRProfiles
}

test_that("the bundled dataset is a valid STRProfiles object", {
    pdx <- loadPdx()

    expect_s4_class(pdx, "STRProfiles")
    expect_true(validObject(pdx))
    expect_identical(dim(pdx), c(1258L, 18L))
    expect_identical(as.vector(table(sampleData(pdx)$Center)[c("JAX", "PDMR")]), c(435L, 823L))
})

test_that("the bundled dataset matches a fresh read of its source file", {
    pdx <- loadPdx()
    fresh <- readSTRProfiles(ed("main_database.csv"))

    expect_identical(alleles(pdx), alleles(fresh))
    expect_identical(markerData(pdx), markerData(fresh))
    expect_identical(sampleData(pdx), sampleData(fresh))
    expect_identical(provenance(pdx)$options, provenance(fresh)$options)
    expect_identical(provenance(pdx)$files, "main_database.csv")
})

test_that("the application defaults to the bundled dataset", {
    pdx <- STRprofilerR:::.defaultDatabase()

    expect_identical(alleles(pdx), alleles(loadPdx()))
    expect_false(exists("pdxSTRProfiles", envir = globalenv(), inherits = FALSE))
})
