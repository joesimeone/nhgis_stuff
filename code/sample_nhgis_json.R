library(httr2)
library(jsonlite)


## documentation: https://developer.ipums.org/docs/v2/workflows/create_extracts/nhgis_data/

url <- "https://api.ipums.org/extracts/?collection=nhgis&version=2"
mybody <- '

{
  "datasets": {
    "1988_1997_CBPa": {
      "years": ["1988", "1989", "1990", "1991", "1992", "1993", "1994"],
      "breakdownValues": ["bs30.si0762", "bs30.si2026"],
      "dataTables": [
        "NT001"
      ],
      "geogLevels": [
        "county"
      ]
    },
    "2000_SF1b": {
      "dataTables": [
        "NP001A"
      ],
      "geogLevels": [
        "blck_grp"
      ]
    }
  },
  "timeSeriesTables": {
    "A00": {
      "geogLevels": [
        "state"
      ],
      "years": [
        "1990"
      ]
    }
  },
  "shapefiles": [
    "us_state_1790_tl2000"
  ],
  "timeSeriesTableLayout": "time_by_file_layout",
  "geographicExtents": ["010"],
  "dataFormat": "csv_no_header",
  "description": "example extract request",
  "breakdownAndDataTypeLayout": "single_file"
}

'

# JSON Query to extract from website --------------------------------------


mybody_json <- fromJSON(mybody, simplifyVector = FALSE)
result <- POST(url, add_headers(Authorization = my_key), body = mybody_json, encode = "json", verbose())
res_df <- content(result, "parsed", simplifyDataFrame = TRUE)
my_number <- res_df$number


# Check extract status ----------------------------------------------------


data_extract_status_res <- GET("https://api.ipums.org/extracts/6?collection=nhgis&version=2", add_headers(Authorization = my_key))
des_df <- content(data_extract_status_res, "parsed", simplifyDataFrame = TRUE)
des_df