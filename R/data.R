#' STR profiles of patient-derived models from JAX and the NCI PDMR
#'
#' Reference STR profiles for 1,258 patient-derived models: 435 from The
#' Jackson Laboratory PDX program and 823 from the NCI Patient-Derived Models
#' Repository (PDMR). This is the default database of [STRprofilerApp()], and
#' can be passed as the `reference` of [compareProfiles()] or [scoreProfiles()]
#' to check models against it.
#'
#' @format A [STRProfiles] object of 1,258 samples typed at 18 markers:
#'   amelogenin and 17 autosomal STRs (the 13 CODIS core loci plus D2S1338,
#'   D19S433, Penta D, and Penta E). [sampleData()] holds
#'   \describe{
#'     \item{`Center`}{Source of the model, `"JAX"` or `"PDMR"`.}
#'     \item{`Passage`}{Passage of the profiled material, where recorded.}
#'     \item{`nDroppedCalls`}{Calls dropped at ingest as not being alleles (see
#'       [readSTRProfiles()]).}
#'   }
#'
#' @details
#' Built by `inst/scripts/make-pdxSTRProfiles.R`, which reads
#' `inst/extdata/main_database.csv` with [readSTRProfiles()] defaults. The raw
#' file is kept alongside, as an example of a database file with metadata
#' columns:
#'
#' ```
#' system.file("extdata", "main_database.csv", package = "STRprofilerR")
#' ```
#'
#' Twenty-two samples each carry one call that is not an allele (mostly `OL`,
#' off-ladder), dropped at ingest and counted in `nDroppedCalls`.
#'
#' @source Profiles provided by
#'   [The Jackson Laboratory PDX program](https://tumor.informatics.jax.org/mtbwi/pdxSearch.do)
#'   and the [NCI PDMR](https://pdmr.cancer.gov/), as compiled for the default
#'   database of the `strprofiler` Python package (0.5.1,
#'   `strprofiler/shiny_app/www/main_database.csv`), and redistributed here under
#'   the package's MIT license. See `inst/scripts/README.md`.
#'
#' @references
#' Andrews JM, Lloyd MW, Neuhauser SB, Bundy M, Jocoy EL, Airhart SD, Bult CJ,
#' Evrard YA, Chuang JH, Baker S (2024). STRprofiler: efficient comparisons of
#' short tandem repeat profiles for biomedical model authentication.
#' *Bioinformatics*, btae713. \doi{10.1093/bioinformatics/btae713}.
#'
#' @usage data(pdxSTRProfiles)
#'
#' @examples
#' data(pdxSTRProfiles)
#' pdxSTRProfiles
#' table(sampleData(pdxSTRProfiles)$Center)
#'
#' # Check a batch of models against it.
#' batch <- readSTRProfiles(
#'     system.file("extdata", "Example_Batch_File.csv", package = "STRprofilerR")
#' )
#' cmp <- compareProfiles(batch, pdxSTRProfiles)
#' summary(cmp)[, c("Sample", "mixed", "topHit")]
#'
#' @docType data
#' @keywords datasets
#' @name pdxSTRProfiles
"pdxSTRProfiles"
