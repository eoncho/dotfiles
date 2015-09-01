install_lib <- function(lib) {
  e <- try(packageVersion(lib))
  ce <- class(e)
  if (length(ce) == 1 && ce == "try-error") {
    install.packages(lib, repos="http://cran.ism.ac.jp/")
  } else {
    sprintf("already install [%s ver:%s]",lib, e)
  }
}

install_lib("dplyr")
install_lib("tidyr")
install_lib("data.table")
install_lib("foreach")
install_lib("reshape2")
install_lib("DBI")
install_lib("RMySQL")
install_lib("forecast")
install_lib("ggplot2")
install_lib("tseries")
install_lib("TTR")
install_lib("lme4")
install_lib("arm")
install_lib("randomForest")
