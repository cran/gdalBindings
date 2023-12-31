.onUnload <- function(libpath) {
  library.dynam.unload("gdalBindings", libpath)
  invisible()
}

#' @useDynLib gdalBindings, .registration=TRUE
.onLoad <- function(libname, pkgname) {
  .gdalBindings_CACHE <- new.env(FALSE, parent = globalenv())
  assign("old.PROJ_LIB", Sys.getenv("PROJ_LIB"), envir = .gdalBindings_CACHE)
  Rcpp::loadModule("gdal_module", TRUE, TRUE)
  InitializeGDAL()
}

.onAttach <- function(libname, pkgname) {
  # Setup copied from rgdal package
  Sys.setenv("PROJ_LIB" = system.file("proj", package = pkgname)[1])
}
