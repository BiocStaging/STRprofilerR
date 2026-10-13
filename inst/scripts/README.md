# Data provenance

How each file in `inst/extdata/` and `data/` was made, where it came from, and
the terms it is distributed under.

The scripts here are run from the root of the package source:

| Script | Makes |
|--------|-------|
| `make-extdata.R` | The example files taken from the `strprofiler` Python package, fetched from its 0.5.1 release. |
| `make-clastr-response.R` | `inst/extdata/clastr_response.json`, a recorded CLASTR reply. Needs network access. |
| `make-pdxSTRProfiles.R` | `data/pdxSTRProfiles.rda`, from `inst/extdata/main_database.csv`. |

## Example files from strprofiler

STRprofilerR is an R port of [strprofiler](https://github.com/j-andrews7/STRprofiler)
(MIT license, copyright 2024 Jared Andrews and Mike Lloyd). These files are
copied unchanged, apart from line endings, from its 0.5.1 release by
`make-extdata.R`, so the two packages' tests and examples run on the same
inputs. They are distributed under MIT, as the rest of this package is.

They stay as raw files rather than R objects because they are inputs to
`readSTRProfiles()` and the command line and Shiny applications, which read
files. Their job is to demonstrate the formats those accept.

| File | Contents | Origin | Used by |
|------|----------|--------|---------|
| `ExampleSTR.xlsx` | Two samples in the wide layout of a capillary electrophoresis export: one row per sample and marker, with `Allele`, `Size`, and `Height` columns. | Synthetic, written for strprofiler's tests (`tests/`). | `readSTRProfiles()` example, vignette, ingest tests. |
| `ExampleSTR_long.csv` | Two query samples in the long layout, one row per sample. | Synthetic (`tests/`). | Most function examples, vignette, tests. |
| `ExampleSTR_long_1samp.csv` | The first sample of `ExampleSTR_long.csv` alone. | Synthetic (`tests/`). | Test that a lone profile with no reference is rejected. |
| `ExampleSTR_database.csv` | Five reference profiles in the long layout, two matching the queries above. | Synthetic (`tests/`). | Most function examples, vignette, tests. |
| `Example_Custom_Database.csv` | `ExampleSTR_database.csv` with the sample and amelogenin columns named `Sample` and `Amelogenin`. | Synthetic (`strprofiler/shiny_app/www/`). | Offered for download by the Shiny application's database tab as a template; `STRprofilerApp()` example; tests. |
| `Example_app_database.csv` | Three profiles over amelogenin and five generic markers, with `Center` and `Passage` metadata columns. | Synthetic (`tests/`). | Tests that metadata columns are not scored. |
| `SampleMap_exp.csv` | A headerless two-column table mapping sample names in an input to the names to use instead. | Synthetic (`tests/`). | The `sampleMap` argument of `readSTRProfiles()`: example and tests. |
| `Example_Batch_File.csv` | Three profiles over the 18 markers of `main_database.csv`. `Sample_A` and `Sample_C` are JAX models J000077451 and J000078366. `Sample_B` is J000077960 with extra or substituted alleles at five markers, mimicking contamination. | Derived from `main_database.csv` (`strprofiler/shiny_app/www/`). | Offered for download by the Shiny application's batch tab as a template; `flagMixedSamples()` example; vignette; tests. |
| `Example_clastr_input.csv` | Three human profiles in the CLASTR marker vocabulary. `Sample_A` is the Cellosaurus profile of HT-29 ([CVCL_0320](https://www.cellosaurus.org/CVCL_0320)). | Written for strprofiler's CLASTR tests (`tests/`). | `clastrBatchQuery()` example; the query behind `clastr_response.json`. |
| `main_database.csv` | STR profiles of 1,258 patient-derived models, 435 from JAX and 823 from the PDMR, with `Center` and `Passage` columns. | See below (`strprofiler/shiny_app/www/`). | Source of `pdxSTRProfiles`; `readSTRProfiles()` example; vignette; ingest tests, which rely on its real-world quirks (off-ladder `OL` calls, a lone comma, a stray backtick). |

## `main_database.csv` and `data/pdxSTRProfiles.rda`

The profiles were provided by
[The Jackson Laboratory PDX program](https://tumor.informatics.jax.org/mtbwi/pdxSearch.do)
and the [NCI Patient-Derived Models Repository (PDMR)](https://pdmr.cancer.gov/),
which make them publicly available. They were compiled into the default database
of strprofiler's Shiny application (added in strprofiler commit
[4b3c34a](https://github.com/j-andrews7/STRprofiler/commit/4b3c34a), 2024-08-21)
and are redistributed here under the package's MIT license.

`make-pdxSTRProfiles.R` reads the file with `readSTRProfiles()` defaults and
saves the result as `data/pdxSTRProfiles.rda`, the documented dataset
`?pdxSTRProfiles`. It is the default database of `STRprofilerApp()`, and can be
loaded with `data(pdxSTRProfiles)` to use as a reference in
`compareProfiles()`. `tests/testthat/test-data.R` checks the saved object
against a fresh read of the CSV, so re-run the script after changing either the
file or ingest.

## `clastr_response.json`

The JSON reply of the [CLASTR](https://www.cellosaurus.org/str-search/) REST
API to a search with `Sample_A` of `Example_clastr_input.csv` (Tanabe
algorithm, non-empty markers scoring mode, score filter 80, at least 8 markers,
at most 10 results, amelogenin excluded). Recorded by `make-clastr-response.R`
on 2026-09-15 against Cellosaurus release 56.0. It lets the CLASTR parsing in
`clastrQuery()` and the Shiny application be tested without network access.

Cellosaurus content is available under the
[Creative Commons Attribution 4.0 International license](https://creativecommons.org/licenses/by/4.0/)
(CC BY 4.0). Cite Bairoch (2018), *J Biomol Tech* 29:25-38, and Robin,
Capes-Davis, and Bairoch (2020), *Int J Cancer* 146:1299-1306.
