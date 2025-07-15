# Idealita Houses — Data Dictionary

The following table lists all 48 variables in `idealista_*.csv` with their types and descriptions.

| Variable                                        | Type      | Description                                                                     |
|-------------------------------------------------|-----------|---------------------------------------------------------------------------------|
| `propertyCode`                                  | character | Unique identifier of the property listing                                       |
| `thumbnail`                                     | character | URL to a small preview image of the property                                     |
| `externalReference`                             | character | External reference code (often set by agencies)                                 |
| `numPhotos`                                     | integer   | Number of photos included in the listing                                        |
| `price`                                         | numeric   | Asking price of the property (in the listing currency)                          |
| `propertyType`                                  | character | Specific sub-type of property (e.g., “penthouse”, “flat”, “chalet”)                 |
| `operation`                                     | character | Transaction type — either “sale” or “rent”                                      |
| `size`                                          | numeric   | Usable interior area of the property, in square meters                          |
| `rooms`                                         | integer   | Number of rooms                                                                 |
| `bathrooms`                                     | integer   | Number of bathrooms                                                             |
| `address`                                       | character | Street address of the property                                                  |
| `province`                                      | character | Province where the property is located                                          |
| `municipality`                                  | character | Municipality of the property                                                    |
| `district`                                      | character | Administrative district of the property                                         |
| `country`                                       | character | Country code of the listing (e.g., “es”, “it”, “pt”)                            |
| `latitude`                                      | numeric   | Latitude coordinate of the property                                             |
| `longitude`                                     | numeric   | Longitude coordinate of the property                                            |
| `showAddress`                                   | logical   | Whether the full address is displayed (depends on owner consent)                |
| `url`                                           | character | Direct URL to the property’s detail page on Idealista                           |
| `description`                                   | character | Textual description entered in the listing                                      |
| `hasVideo`                                      | logical   | Indicates if the listing includes a video                                       |
| `status`                                        | character | Condition status (e.g., “good”, “renew”)                       |
| `newDevelopment`                                | logical   | Flag indicating if part of a new-build project                                   |
| `priceByArea`                                   | numeric   | Price per square meter (i.e., `price` ÷ `size`)                                 |
| `hasPlan`                                       | logical   | Whether the listing includes a floor plan                                       |
| `has3DTour`                                     | logical   | Whether a 3D virtual tour is available                                          |
| `has360`                                        | logical   | Whether 360° panoramic images are provided                                      |
| `hasStaging`                                    | logical   | Whether the listing uses virtual staging                                        |
| `notes`                                         | character | Any extra notes or remarks                                                      |
| `topNewDevelopment`                             | logical   | Flag for “Top New Development” featured listings                                |
| `topPlus`                                       | logical   | Flag for “Top+” premium featured listings                                       |
| `floor`                                         | character | Floor level (e.g., “ground”, “4”)                                                |
| `exterior`                                      | logical   | Whether the property has at least one exterior-facing side                      |
| `hasLift`                                       | logical   | Indicates if the building has an elevator                                       |
| `neighborhood`                                  | character | Specific neighborhood within the district                                       |
| `priceInfo.price.amount`                        | numeric   | Numeric amount of the listing price                                             |
| `priceInfo.price.currencySuffix`                | character | Currency symbol (e.g., “€” )                                          |
| `priceInfo.price.priceDropInfo.formerPrice`     | numeric   | Original price before any reduction                                              |
| `priceInfo.price.priceDropInfo.priceDropValue`  | numeric   | Absolute value of the price drop                                                 |
| `priceInfo.price.priceDropInfo.priceDropPercentage` | numeric | Percentage reduction off the former price                                        |
| `parkingSpace.hasParkingSpace`                  | logical   | Whether the property includes parking                                            |
| `parkingSpace.isParkingSpaceIncludedInPrice`    | logical   | If parking cost is already included in the listing price                         |
| `parkingSpace.parkingSpacePrice`                | numeric   | Extra fee for parking if not included                                            |
| `detailedType.typology`                         | character | Main property typology (e.g., “flat”, “chalet”)                                 |
| `detailedType.subTypology`                     | character | Secondary sub-typology (e.g., “penthouse”, “independantHouse”)                             |
| `suggestedTexts.subtitle`                       | character | AI-generated subtitle suggestion                                                 |
| `suggestedTexts.title`                          | character | AI-generated title suggestion                                                    |
| `highlight.groupDescription`                    | character | Promotional highlight or grouping text (e.g., “Top+”)               |
| `NewDevelopmentFinished`                    | logical | Flag indicating if the new building is finished               |

