# ------
# Get codes for Spanish provinces
# ------
# Static lookup of all Spanish provinces
# Visit the catalogue (≈8 000 entries) for more lication IDs (e.g., districts, municipalities, etc)
# "https://raw.githubusercontent.com/igolaizola/idealista-scraper/main/data/es.json"
province_lookup <- data.frame(
  name = c(
    "Álava", "Albacete", "Alicante", "Almería", "Ávila", "Badajoz", 
    "Illes Balears", "Barcelona", "Burgos", "Cáceres", "Cádiz", 
    "Castellón", "Ciudad Real", "Córdoba", "A Coruña", "Cuenca", 
    "Girona", "Granada", "Guadalajara", "Gipuzkoa", "Huelva", "Huesca", 
    "Jaén", "León", "Lleida", "La Rioja", "Lugo", "Madrid", "Málaga", 
    "Murcia", "Navarra", "Ourense", "Asturias", "Palencia", "Las Palmas", 
    "Pontevedra", "Salamanca", "S. C. de Tenerife", "Cantabria", "Segovia", 
    "Sevilla", "Soria", "Tarragona", "Teruel", "Toledo", "Valencia", 
    "Valladolid", "Bizkaia", "Zamora", "Zaragoza", "Ceuta", "Melilla"
  ),
  code = sprintf("%02d", c(
    1,  2,  3,  4,  5,  6, 
    7,  8,  9, 10, 11, 
    12, 13, 14, 15, 16, 
    17, 18, 19, 20, 21, 22, 
    23, 24, 25, 26, 27, 28, 29, 
    30, 31, 32, 33, 34, 35, 
    36, 37, 38, 39, 40, 
    41, 42, 43, 44, 45, 
    46, 47, 48, 49, 50, 
    51, 52
  )),
  stringsAsFactors = FALSE
)

# Helper: find a province (partial or full, case-insensitive)
get_location_id <- function(province_name, country = "ES") {
  # look for any partial match in the name column
  hits <- province_lookup[grepl(province_name, province_lookup$name, ignore.case = TRUE), ]
  if (nrow(hits) == 0) {
    stop("Province not found: '", province_name, "'. Available are: ",
         paste(head(province_lookup$name, 10), collapse = ", "),
         if (nrow(province_lookup) > 10) ", …" else "")
  }
  # if multiple match, return them all
  ids <- sprintf("0-EU-%s-%s", toupper(country), hits$code)
  names(ids) <- hits$name
  ids
}

# # 3. Examples
# get_location_id("Madrid")
# #>   Madrid 
# #> "0-EU-ES-28"
# 
# get_location_id("dri")   # fuzzy substring match
# #>   Madrid 
# #> "0-EU-ES-28"
# 
# get_location_id("soria")
# #>   Soria 
# #> "0-EU-ES-42"
# 
# get_location_id("palencia|leon")
# #>     Palencia       León 
# #> "0-EU-ES-34" "0-EU-ES-24" 