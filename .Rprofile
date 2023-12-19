options(menu.graphics = FALSE)
options(Ncpus = 8)
if (grepl("\\.au$", Sys.getenv("HOSTNAME"))) {
  options(repos = c(CRAN = "https://mirror.aarnet.edu.au/pub/CRAN"))
}

if (interactive()) {
  try(utils::loadhistory("~/.Rhistory"))
}
.Last <- function() {
  if (interactive()) try(savehistory("~/.Rhistory"))
}
