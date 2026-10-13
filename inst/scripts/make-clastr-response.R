# Records inst/extdata/clastr_response.json, a reply from the CLASTR REST API
# (https://www.cellosaurus.org/str-search/) used to test the parsing in
# clastrQuery() and the application without network access.
#
# The query is Sample_A of inst/extdata/Example_clastr_input.csv, the profile
# of HT-29 (CVCL_0320), with clastrQuery()'s defaults except for maxResults.
# The recorded reply was made on 2026-09-15 against Cellosaurus release 56.0.
# The results are Cellosaurus content, available under CC BY 4.0
# (https://www.cellosaurus.org/description.html).
#
# Run from the root of the package source, with network access:
#
#   Rscript -e 'pkgload::load_all(); source("inst/scripts/make-clastr-response.R")'
#
# A later Cellosaurus release can return different hits, so re-recording may
# change the counts and values asserted in tests/testthat/test-clastr.R and
# tests/testthat/test-app.R.

library(STRprofilerR)

input <- readSTRProfiles(file.path("inst", "extdata", "Example_clastr_input.csv"))

# The body clastrQuery() sends: markers under CLASTR's spellings, then the
# search parameters. The file spells amelogenin "Amel", which CLASTR also
# accepts; the recording used "Amelogenin", as the vignette's example does.
profile <- STRprofilerR:::.asClastrProfiles(input["Sample_A", ])[["Sample_A"]]
names(profile)[names(profile) == "Amel"] <- "Amelogenin"

body <- c(
    profile,
    list(
        algorithm = 1L, # Tanabe
        scoringMode = 1L, # Non-empty markers
        scoreFilter = 80L,
        minMarkers = 8L,
        maxResults = 10L,
        includeAmelogenin = FALSE
    )
)

req <- httr2::request("https://www.cellosaurus.org/str-search/api/query/")
req <- httr2::req_body_json(req, body, auto_unbox = TRUE)
resp <- httr2::req_perform(req)

writeLines(httr2::resp_body_string(resp), file.path("inst", "extdata", "clastr_response.json"), sep = "")
