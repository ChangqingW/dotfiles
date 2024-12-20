options(menu.graphics = FALSE)
options(pager = function(files, header, title, delete.file){
  # debug info
  # cat(sprintf("Inputs:\n  files: %s\n  header: %s\n  title: %s\n  delete.file: %s\n", files, header, title, delete.file))
  system2("nvim", args = c(files, '+Man!', sprintf("+'file! %s'", title)))
  if(delete.file){
    file.remove(files)
  }
})

options(Ncpus = 8)
if (grepl("\\.au$", Sys.getenv("HOSTNAME"))) {
  options(repos = c(CRAN = "https://mirror.aarnet.edu.au/pub/CRAN"))
}

if (interactive() & Sys.getenv("RADIAN_VERSION") == "") {
  try(utils::loadhistory("~/.Rhistory"))
}
.Last <- function() {
  if (interactive() & Sys.getenv("RADIAN_VERSION") == "") try(savehistory("~/.Rhistory"))
}
options(HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(), paste(getRversion(), R.version["platform"], R.version["arch"], R.version["os"])))
