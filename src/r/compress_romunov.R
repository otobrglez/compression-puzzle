string <- "AAABBAAC"
result <- "3A2B2A1C"

xy <- strsplit(x = string, split = "")[[1]]
xlr <- rle(xy)

out <- paste0(xlr$length, xlr$values)
out <- paste(out, collapse = "")

stopifnot(
  identical(out, result)
)
