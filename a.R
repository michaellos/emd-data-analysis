change_na_to_mean <- function(column) {
  column <- as.numeric(as.character(column))
  column[is.na(column)] <- mean(column[!is.na(column)])
  column
}