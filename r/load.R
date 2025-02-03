box::use(
  reticulate
)

processed_data <- function() {
  pyload <- reticulate::import("src.load")
  df <- pyload$processed_data()
  print("Loading data...")
  return(df)
}