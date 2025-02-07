# libraries ---------------------------------------------------------------
library(ipumsr)
library(tidyverse)


source("code/secrets_shhh.R")

set_ipums_api_key(my_key)

ipums_data_collections()

huh <- get_sample_info("usa")


huh %>% view()

"B25071"


get_sample_info("usa") %>% view()


rent_spec_pa <- define_extract_micro(
  collection = "usa",
  description = "Trying to understand",
  samples = ("us2023a"),
  variables = list(
    var_spec("STATEFIP", case_selections = "42"),
    var_spec("SEX"),
    var_spec("POVERTY")
  )
)
    

tst_extract <- submit_extract(rent_spec_pa
                              )
    
)

filepath <- download_extract(tst_extract)


hmm <- read_ipums_ddi(filepath)
dawg <- read_ipums_micro(hmm)