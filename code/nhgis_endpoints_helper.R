
# Libraries ---------------------------------------------------------------
library(httr2)
library(jsonlite)
library(tidyverse)


## Mostly think this is just for help writing out json 

# Replace 'my_key' with your actual IPUMS API key
source('code/secrets_shhh.R')

## So these guys get you broadest level of available IPUMS data
nhgis_metadata <- "https://api.ipums.org/metadata/nhgis/datasets?version=2"
nhgis_tbls <- "https://api.ipums.org/metadata/nhgis/data_tables?version=2"

## This one hooks you up to a specifc tbl (using nhgis_tbls naming output)
nhgis_single_tbl_exp <-  
  "https://api.ipums.org/metadata/nhgis/datasets/1990_STF1/data_tables/NP19?version=2"




# query function ----------------------------------------------------------------

see_nhgis_endpoints <- function(url_name){
  
  url <- url_name
  
  nhgis_req <-
    request(url) %>% 
    req_headers(Authorization = my_key) %>%
    req_perform()
  
  nhgis_result <- 
    resp_body_json(nhgis_req, simplifyDataFrame = TRUE)
  
  return(nhgis_result)}
  


# function calls ----------------------------------------------------------


nhgis_metadata <- see_nhgis_endpoints(nhgis_metadata)
nhgis_tbls <- see_nhgis_endpoints(nhgis_tbls)
nhgis_single_tbl_exp <- see_nhgis_endpoints(nhgis_single_tbl_exp)


