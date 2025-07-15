# ------------------------------------------------------------------------------
# R script to fetch ALL “homes for sale” listings in a given Spanish province
# ------------------------------------------------------------------------------
# 1) Reads your Idealista client_key/secret from environment variables
# 2) Obtains an OAuth2 token
# 3) Fetches up to N pages of listings
# 4) Saves to ../data/file_name.csv

# ---------------------------------------------------------------------
# 1. Install & load required libraries and functions
# ---------------------------------------------------------------------
required_packages <- c("httr", "jsonlite", "dplyr", "readr")

install_if_missing <- function(pkgs) {
  missing <- pkgs[!(pkgs %in% installed.packages()[, "Package"])]
  if (length(missing)) {
    install.packages(missing, repos = "https://cran.rstudio.com/")
  }
}

install_if_missing(required_packages)
lapply(required_packages, library, character.only = TRUE, quietly = TRUE)

# Load the get_location_id function to get codes for Spanish provinces
source("get_location_id.R")

# ---------------------------------------------------------------------
# 2. API credentials & OAuth2 token retrieval
# ---------------------------------------------------------------------
# Replace these with your actual Idealista API credentials
client_key    <- "client_key"
client_secret <- "client_secret"

# Encode credentials as per OAuth2 “client_credentials” flow :contentReference[oaicite:0]{index=0}
auth_string <- jsonlite::base64_enc(paste(client_key, client_secret, sep = ":"))
token_resp  <- httr::POST(
  url = "https://api.idealista.com/oauth/token",
  httr::add_headers(
    Authorization = paste("Basic", auth_string),
    `Content-Type` = "application/x-www-form-urlencoded;charset=UTF-8"
  ),
  body = list(grant_type = "client_credentials"),
  encode = "form"
)

access_token <- httr::content(token_resp)$access_token
bearer       <- paste("Bearer", access_token)

# ---------------------------------------------------------------------
# 3. Search parameters setup
# ---------------------------------------------------------------------
# Country code, operation type, property type, and location ID :contentReference[oaicite:1]{index=1}
locationStr <- "madrid"
params <- list(
  country      = "es",
  operation    = "sale",
  propertyType = "homes",
  locationId   = get_location_id(locationStr),
  maxItems     = "50"
)

base_url <- "https://api.idealista.com/3.5/es/search"

# ---------------------------------------------------------------------
# 4. Function to fetch a single page of results
# ---------------------------------------------------------------------
fetch_page <- function(page_num, bearer_token, params) {
  # Combine query parameters
  query <- c(params, numPage = page_num)
  
  # Send POST request
  resp <- httr::POST(
    url = base_url,
    httr::add_headers(Authorization = bearer_token),
    body = query,
    encode = "form"
  )
  
  # Parse JSON response
  content_list <- httr::content(resp)$elementList
  if (is.null(content_list)) return(NULL)
  
  # Normalize list of listings to a data frame
  df <- jsonlite::fromJSON(jsonlite::toJSON(content_list), flatten = TRUE)
  as.data.frame(df, stringsAsFactors = FALSE)
}

# ---------------------------------------------------------------------
# 5. Loop through pages, combine results, and unlist data frame
# ---------------------------------------------------------------------
all_pages_list <- list()
max_pages     <- 84  # maximum number of pages

for (pg in seq_len(max_pages)) {
  message("Fetching page ", pg, " of ", max_pages, "...")
  page_data <- fetch_page(pg, bearer, params)
  
  if (is.null(page_data)) break
  all_pages_list[[pg]] <- page_data
  
  Sys.sleep(1)  #  pause to respect rate limits
}

# Combine all pages into one data.frame
all_pages_df <- bind_rows(all_pages_list)

# Function to unlist each column of a data frame
unlist_df <- function(df) {
  # For each list‐column, map to an atomic vector of length nrow(df)
  for (col in names(df)) {
    if (is.list(df[[col]])) {
      df[[col]] <- sapply(df[[col]], function(x) {
        if (is.null(x) || length(x) == 0) {
          NA_character_
        } else if (length(x) == 1 && !is.list(x)) {
          # simple scalar → to string
          as.character(x)
        } else {
          # vector or nested list → collapse
          paste(unlist(x), collapse = ",")
        }
      }, USE.NAMES = FALSE)
    }
  }
  df
}

# Unlist all_pages_df
all_pages_df <- unlist_df(all_pages_df)

# ---------------------------------------------------------------------
# 6. Save results
# ---------------------------------------------------------------------
# get today’s date
today <- format(Sys.Date(), "%Y-%m-%d")
# get total fetched pages 
fetched_pages <- length(all_pages_list)
# create data file name
file_name <- sprintf("../data/idealista_%s_%s_%s_%s_pages%s_%s.csv",
                     params$country, params$operation, params$propertyType, 
                     locationStr, fetched_pages, today)
write_csv(all_pages_df, file = file_name)
