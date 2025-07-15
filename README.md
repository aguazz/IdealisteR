# IdealisteR: an Idealista API data scraper

This project provides an R script to fetch real estate listings from the Idealista API and save them as a CSV. It includes:

- **R code** to authenticate, request data, and save results.
- **Data** raw listings with 48 variables per record.
- **Documentation** API specs and a data dictionary.

---

## Repository Structure

```
IdealisteR/
├── README.md                         # Project overview and instructions
├── data/
|   └── idealista_*.csv               # Fetched listings data (* includes province, operation, property type, etc)
├── docs/
│   ├── data_dictionary.md            # Definitions for each variable in the CSV
│   ├── oauth2-documentation.pdf      # OAuth 2.0 Authentication file
│   └── property-search-api-v3_5.pdf  # Property search descriptors and examples
├── R/
│   ├── get_location_id.R             # Script to retrieve the codes for Spanish provinces (hard coded)
|   └── get_data.R                    # Script to pull data from Idealista

```

---

## Usage

  1. Open the main script `get_data.R`
  2. Tune up the mandatory parameters
  
| Parameter      | Data Type | Description                                                                | Additional Info                                     |
| -------------- | --------- | -------------------------------------------------------------------------- | --------------------------------------------------- |
| `country_val`      | string    | Site country: es - idealista.com<br>it - idealista.it<br>pt - idealista.pt | values: es, it, pt                                  |
| `operation_val`    | string    | Transaction type                                                           | values: sale, rent                                  |
| `propertyType_val` | string    | Property category                                                          | values: homes, offices, premises, garages, bedrooms |
| `locationId_val`   | string    | Idealista location code                                                    |                                                     |
| `maxItems_val`     | string   | Number of items per page (up to 50)                                        | 50 as maximum allowed                               |

  See the script `get_location_id.R` for more on the `locationId` parameter. For more parameters, read
  `docs/oauth2-documentation.pdf`. The parameters' values are included in `get_location_id.R` as 
  `parameter_name_val` (e.g., `maxItems_val` is the value assigned to the parameter `maxItems_val`)
  
  3. Run the script. This will:
    3.1. Read your credentials;
    3.2. Obtain an OAuth2 token;
    3.3. Fetch up to `max_pages` pages of listings (configurable in the script);
    3.4. Save the combined dataset to `data/idealista_*.csv`.

---

## Data Files

- `idealista_*.csv`: Contains all fetched listings. The symbol * is a wildcard that includes the parameters defined 
  in the script `get_data` to retrieve the data. Each row is one property, with 48 columns defined in `docs/data_dictionary.md`.

---

## Data Dictionary

See `docs/data_dictionary.md` for a full list of variables and their descriptions.

---

## API Documentation

- **OAuth2 Flow**: See `docs/oauth2-documentation.pdf` for how the client credentials grant works.
- **Search API**: See `docs/property-search-api-v3_5.pdf` for detailed parameters and response formats.