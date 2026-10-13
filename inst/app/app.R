# An app.R for hosting the default/example STRprofiler application, e.g. on Posit Connect,
# Shiny Server, or shinyapps.io. Copy it into a directory of its own, point
# `database` at your reference database if you have one, and deploy from there.
#
# Run in place with shiny::runApp(system.file("app", package = "STRprofilerR")).
#
# The application's packages are in the Suggests of STRprofilerR, so they are
# attached explicitly here for deployment tools to detect and bundle.
library(shiny)
library(bslib)
library(DT)
library(readxl)
library(STRprofilerR)

STRprofilerApp()
