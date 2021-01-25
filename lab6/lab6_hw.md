---
title: "Lab 6 Homework"
author: "Srinidhi Viswanathan"
date: "2021-01-25"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
library(skimr)
```

For this assignment we are going to work with a large data set from the [United Nations Food and Agriculture Organization](http://www.fao.org/about/en/) on world fisheries. These data are pretty wild, so we need to do some cleaning. First, load the data.  

Load the data `FAO_1950to2012_111914.csv` as a new object titled `fisheries`.

```r
fisheries <- readr::read_csv("data/FAO_1950to2012_111914.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   .default = col_character(),
##   `ISSCAAP group#` = col_double(),
##   `FAO major fishing area` = col_double()
## )
## ℹ Use `spec()` for the full column specifications.
```

```r
fisheries
```

```
## # A tibble: 17,692 x 71
##    Country `Common name` `ISSCAAP group#` `ISSCAAP taxono… `ASFIS species#`
##    <chr>   <chr>                    <dbl> <chr>            <chr>           
##  1 Albania Angelsharks,…               38 Sharks, rays, c… 10903XXXXX      
##  2 Albania Atlantic bon…               36 Tunas, bonitos,… 1750100101      
##  3 Albania Barracudas n…               37 Miscellaneous p… 17710001XX      
##  4 Albania Blue and red…               45 Shrimps, prawns  2280203101      
##  5 Albania Blue whiting…               32 Cods, hakes, ha… 1480403301      
##  6 Albania Bluefish                    37 Miscellaneous p… 1702021301      
##  7 Albania Bogue                       33 Miscellaneous c… 1703926101      
##  8 Albania Caramote pra…               45 Shrimps, prawns  2280100117      
##  9 Albania Catsharks, n…               38 Sharks, rays, c… 10801003XX      
## 10 Albania Common cuttl…               57 Squids, cuttlef… 3210200202      
## # … with 17,682 more rows, and 66 more variables: `ASFIS species name` <chr>,
## #   `FAO major fishing area` <dbl>, Measure <chr>, `1950` <chr>, `1951` <chr>,
## #   `1952` <chr>, `1953` <chr>, `1954` <chr>, `1955` <chr>, `1956` <chr>,
## #   `1957` <chr>, `1958` <chr>, `1959` <chr>, `1960` <chr>, `1961` <chr>,
## #   `1962` <chr>, `1963` <chr>, `1964` <chr>, `1965` <chr>, `1966` <chr>,
## #   `1967` <chr>, `1968` <chr>, `1969` <chr>, `1970` <chr>, `1971` <chr>,
## #   `1972` <chr>, `1973` <chr>, `1974` <chr>, `1975` <chr>, `1976` <chr>,
## #   `1977` <chr>, `1978` <chr>, `1979` <chr>, `1980` <chr>, `1981` <chr>,
## #   `1982` <chr>, `1983` <chr>, `1984` <chr>, `1985` <chr>, `1986` <chr>,
## #   `1987` <chr>, `1988` <chr>, `1989` <chr>, `1990` <chr>, `1991` <chr>,
## #   `1992` <chr>, `1993` <chr>, `1994` <chr>, `1995` <chr>, `1996` <chr>,
## #   `1997` <chr>, `1998` <chr>, `1999` <chr>, `2000` <chr>, `2001` <chr>,
## #   `2002` <chr>, `2003` <chr>, `2004` <chr>, `2005` <chr>, `2006` <chr>,
## #   `2007` <chr>, `2008` <chr>, `2009` <chr>, `2010` <chr>, `2011` <chr>,
## #   `2012` <chr>
```

1. Do an exploratory analysis of the data (your choice). What are the names of the variables, what are the dimensions, are there any NA's, what are the classes of the variables?  

```r
glimpse(fisheries)
```

```
## Rows: 17,692
## Columns: 71
## $ Country                   <chr> "Albania", "Albania", "Albania", "Albania",…
## $ `Common name`             <chr> "Angelsharks, sand devils nei", "Atlantic b…
## $ `ISSCAAP group#`          <dbl> 38, 36, 37, 45, 32, 37, 33, 45, 38, 57, 33,…
## $ `ISSCAAP taxonomic group` <chr> "Sharks, rays, chimaeras", "Tunas, bonitos,…
## $ `ASFIS species#`          <chr> "10903XXXXX", "1750100101", "17710001XX", "…
## $ `ASFIS species name`      <chr> "Squatinidae", "Sarda sarda", "Sphyraena sp…
## $ `FAO major fishing area`  <dbl> 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37,…
## $ Measure                   <chr> "Quantity (tonnes)", "Quantity (tonnes)", "…
## $ `1950`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1951`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1952`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1953`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1954`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1955`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1956`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1957`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1958`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1959`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1960`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1961`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1962`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1963`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1964`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1965`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1966`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1967`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1968`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1969`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1970`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1971`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1972`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1973`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1974`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1975`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1976`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1977`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1978`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1979`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1980`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1981`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1982`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ `1983`                    <chr> NA, NA, NA, NA, NA, NA, "559", NA, NA, NA, …
## $ `1984`                    <chr> NA, NA, NA, NA, NA, NA, "392", NA, NA, NA, …
## $ `1985`                    <chr> NA, NA, NA, NA, NA, NA, "406", NA, NA, NA, …
## $ `1986`                    <chr> NA, NA, NA, NA, NA, NA, "499", NA, NA, NA, …
## $ `1987`                    <chr> NA, NA, NA, NA, NA, NA, "564", NA, NA, NA, …
## $ `1988`                    <chr> NA, NA, NA, NA, NA, NA, "724", NA, NA, NA, …
## $ `1989`                    <chr> NA, NA, NA, NA, NA, NA, "583", NA, NA, NA, …
## $ `1990`                    <chr> NA, NA, NA, NA, NA, NA, "754", NA, NA, NA, …
## $ `1991`                    <chr> NA, NA, NA, NA, NA, NA, "283", NA, NA, NA, …
## $ `1992`                    <chr> NA, NA, NA, NA, NA, NA, "196", NA, NA, NA, …
## $ `1993`                    <chr> NA, NA, NA, NA, NA, NA, "150 F", NA, NA, NA…
## $ `1994`                    <chr> NA, NA, NA, NA, NA, NA, "100 F", NA, NA, NA…
## $ `1995`                    <chr> "0 0", "1", NA, "0 0", "0 0", NA, "52", "30…
## $ `1996`                    <chr> "53", "2", NA, "3", "2", NA, "104", "8", NA…
## $ `1997`                    <chr> "20", "0 0", NA, "0 0", "0 0", NA, "65", "4…
## $ `1998`                    <chr> "31", "12", NA, NA, NA, NA, "220", "18", NA…
## $ `1999`                    <chr> "30", "30", NA, NA, NA, NA, "220", "18", NA…
## $ `2000`                    <chr> "30", "25", "2", NA, NA, NA, "220", "20", N…
## $ `2001`                    <chr> "16", "30", NA, NA, NA, NA, "120", "23", NA…
## $ `2002`                    <chr> "79", "24", NA, "34", "6", NA, "150", "84",…
## $ `2003`                    <chr> "1", "4", NA, "22", NA, NA, "84", "178", NA…
## $ `2004`                    <chr> "4", "2", "2", "15", "1", "2", "76", "285",…
## $ `2005`                    <chr> "68", "23", "4", "12", "5", "6", "68", "150…
## $ `2006`                    <chr> "55", "30", "7", "18", "8", "9", "86", "102…
## $ `2007`                    <chr> "12", "19", NA, NA, NA, NA, "132", "18", NA…
## $ `2008`                    <chr> "23", "27", NA, NA, NA, NA, "132", "23", NA…
## $ `2009`                    <chr> "14", "21", NA, NA, NA, NA, "154", "20", NA…
## $ `2010`                    <chr> "78", "23", "7", NA, NA, NA, "80", "228", N…
## $ `2011`                    <chr> "12", "12", NA, NA, NA, NA, "88", "9", NA, …
## $ `2012`                    <chr> "5", "5", NA, NA, NA, NA, "129", "290", NA,…
```

2. Use `janitor` to rename the columns and make them easier to use. As part of this cleaning step, change `country`, `isscaap_group_number`, `asfis_species_number`, and `fao_major_fishing_area` to data class factor. 

```r
fisheries <- janitor::clean_names(fisheries)
```


```r
fisheries$country <- as.factor(fisheries$country)
fisheries$isscaap_group_number <- as.factor(fisheries$isscaap_group_number)
fisheries$asfis_species_number <- as.factor(fisheries$asfis_species_number)
fisheries$fao_major_fishing_area <- as.factor(fisheries$fao_major_fishing_area)
```

We need to deal with the years because they are being treated as characters and start with an X. We also have the problem that the column names that are years actually represent data. We haven't discussed tidy data yet, so here is some help. You should run this ugly chunk to transform the data for the rest of the homework. It will only work if you have used janitor to rename the variables in question 2!

```r
fisheries_tidy <- fisheries %>% 
  pivot_longer(-c(country,common_name,isscaap_group_number,isscaap_taxonomic_group,asfis_species_number,asfis_species_name,fao_major_fishing_area,measure),
               names_to = "year",
               values_to = "catch",
               values_drop_na = TRUE) %>% 
  mutate(year= as.numeric(str_replace(year, 'x', ''))) %>% 
  mutate(catch= str_replace(catch, c(' F'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('...'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('-'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('0 0'), replacement = ''))

fisheries_tidy$catch <- as.numeric(fisheries_tidy$catch)
```

3. How many countries are represented in the data? Provide a count and list their names.

```r
tabyl(fisheries,country)
```

```
##                    country   n      percent
##                    Albania  67 3.787022e-03
##                    Algeria  59 3.334841e-03
##             American Samoa  32 1.808727e-03
##                     Angola  88 4.974000e-03
##                   Anguilla   3 1.695682e-04
##        Antigua and Barbuda  22 1.243500e-03
##                  Argentina 140 7.913181e-03
##                      Aruba   5 2.826136e-04
##                  Australia 301 1.701334e-02
##                    Bahamas  14 7.913181e-04
##                    Bahrain  62 3.504409e-03
##                 Bangladesh   8 4.521818e-04
##                   Barbados  21 1.186977e-03
##                    Belgium  57 3.221795e-03
##                     Belize 133 7.517522e-03
##                      Benin  68 3.843545e-03
##                    Bermuda  47 2.656568e-03
##   Bonaire/S.Eustatius/Saba   2 1.130454e-04
##     Bosnia and Herzegovina   1 5.652272e-05
##                     Brazil 136 7.687090e-03
##   British Indian Ocean Ter   7 3.956591e-04
##     British Virgin Islands  18 1.017409e-03
##          Brunei Darussalam   8 4.521818e-04
##                   Bulgaria 197 1.113498e-02
##                 Cabo Verde  26 1.469591e-03
##                   Cambodia   8 4.521818e-04
##                   Cameroon  36 2.034818e-03
##                     Canada 125 7.065340e-03
##             Cayman Islands   4 2.260909e-04
##            Channel Islands  65 3.673977e-03
##                      Chile 141 7.969704e-03
##                      China 236 1.333936e-02
##       China, Hong Kong SAR  32 1.808727e-03
##           China, Macao SAR   4 2.260909e-04
##                   Colombia  81 4.578340e-03
##                    Comoros  43 2.430477e-03
##    Congo, Dem. Rep. of the  21 1.186977e-03
##         Congo, Republic of  53 2.995704e-03
##               Cook Islands  55 3.108750e-03
##                 Costa Rica  45 2.543522e-03
##                    Croatia 103 5.821840e-03
##                       Cuba 162 9.156681e-03
##                 Cura\xe7ao   9 5.087045e-04
##                     Cyprus  96 5.426181e-03
##           C\xf4te d'Ivoire  67 3.787022e-03
##                    Denmark 103 5.821840e-03
##                   Djibouti  14 7.913181e-04
##                   Dominica  13 7.347954e-04
##         Dominican Republic  50 2.826136e-03
##                    Ecuador 100 5.652272e-03
##                      Egypt  87 4.917477e-03
##                El Salvador  25 1.413068e-03
##          Equatorial Guinea  15 8.478408e-04
##                    Eritrea  49 2.769613e-03
##                    Estonia 184 1.040018e-02
##                   Ethiopia   5 2.826136e-04
##     Falkland Is.(Malvinas)  33 1.865250e-03
##              Faroe Islands  96 5.426181e-03
##          Fiji, Republic of  50 2.826136e-03
##                    Finland  16 9.043636e-04
##                     France 489 2.763961e-02
##              French Guiana  18 1.017409e-03
##           French Polynesia  31 1.752204e-03
##       French Southern Terr   3 1.695682e-04
##                      Gabon  45 2.543522e-03
##                     Gambia  49 2.769613e-03
##                    Georgia  86 4.860954e-03
##                    Germany 306 1.729595e-02
##                      Ghana  94 5.313136e-03
##                  Gibraltar   1 5.652272e-05
##                     Greece 125 7.065340e-03
##                  Greenland  60 3.391363e-03
##                    Grenada  47 2.656568e-03
##                 Guadeloupe   8 4.521818e-04
##                       Guam  23 1.300023e-03
##                  Guatemala  38 2.147863e-03
##                     Guinea  56 3.165272e-03
##               GuineaBissau  32 1.808727e-03
##                     Guyana  11 6.217499e-04
##                      Haiti   6 3.391363e-04
##                   Honduras  68 3.843545e-03
##                    Iceland 107 6.047931e-03
##                      India 108 6.104454e-03
##                  Indonesia 223 1.260457e-02
##     Iran (Islamic Rep. of)  64 3.617454e-03
##                       Iraq  16 9.043636e-04
##                    Ireland 191 1.079584e-02
##                Isle of Man  41 2.317432e-03
##                     Israel  79 4.465295e-03
##                      Italy 261 1.475243e-02
##                    Jamaica   6 3.391363e-04
##                      Japan 611 3.453538e-02
##                     Jordan  12 6.782727e-04
##                      Kenya  31 1.752204e-03
##                   Kiribati  27 1.526113e-03
##   Korea, Dem. People's Rep  14 7.913181e-04
##         Korea, Republic of 620 3.504409e-02
##                     Kuwait  23 1.300023e-03
##                     Latvia 162 9.156681e-03
##                    Lebanon  20 1.130454e-03
##                    Liberia  76 4.295727e-03
##                      Libya  56 3.165272e-03
##                  Lithuania 215 1.215239e-02
##                 Madagascar  35 1.978295e-03
##                   Malaysia 166 9.382772e-03
##                   Maldives  12 6.782727e-04
##                      Malta 104 5.878363e-03
##           Marshall Islands  13 7.347954e-04
##                 Martinique  16 9.043636e-04
##                 Mauritania  93 5.256613e-03
##                  Mauritius  30 1.695682e-03
##                    Mayotte  14 7.913181e-04
##                     Mexico 198 1.119150e-02
##  Micronesia, Fed.States of  13 7.347954e-04
##                     Monaco   1 5.652272e-05
##                 Montenegro  24 1.356545e-03
##                 Montserrat   1 5.652272e-05
##                    Morocco 153 8.647976e-03
##                 Mozambique  30 1.695682e-03
##                    Myanmar   5 2.826136e-04
##                    Namibia  76 4.295727e-03
##                      Nauru   9 5.087045e-04
##                Netherlands 155 8.761022e-03
##       Netherlands Antilles  17 9.608863e-04
##              New Caledonia  26 1.469591e-03
##                New Zealand 208 1.175673e-02
##                  Nicaragua  59 3.334841e-03
##                    Nigeria  50 2.826136e-03
##                       Niue  11 6.217499e-04
##             Norfolk Island   1 5.652272e-05
##       Northern Mariana Is.  19 1.073932e-03
##                     Norway 188 1.062627e-02
##                       Oman  53 2.995704e-03
##                  Other nei 100 5.652272e-03
##                   Pakistan  60 3.391363e-03
##                      Palau  33 1.865250e-03
##    Palestine, Occupied Tr.  25 1.413068e-03
##                     Panama 121 6.839249e-03
##           Papua New Guinea  20 1.130454e-03
##                       Peru  54 3.052227e-03
##                Philippines 138 7.800136e-03
##           Pitcairn Islands   1 5.652272e-05
##                     Poland 263 1.486548e-02
##                   Portugal 763 4.312684e-02
##                Puerto Rico  49 2.769613e-03
##                      Qatar  35 1.978295e-03
##                    Romania 191 1.079584e-02
##         Russian Federation 523 2.956138e-02
##                 R\xe9union  37 2.091341e-03
##        Saint Barth\xe9lemy   1 5.652272e-05
##               Saint Helena  19 1.073932e-03
##      Saint Kitts and Nevis  28 1.582636e-03
##                Saint Lucia  27 1.526113e-03
##   Saint Vincent/Grenadines  71 4.013113e-03
##                SaintMartin   1 5.652272e-05
##                      Samoa  15 8.478408e-04
##      Sao Tome and Principe  35 1.978295e-03
##               Saudi Arabia 128 7.234908e-03
##                    Senegal 140 7.913181e-03
##      Serbia and Montenegro  45 2.543522e-03
##                 Seychelles  70 3.956591e-03
##               Sierra Leone  59 3.334841e-03
##                  Singapore  40 2.260909e-03
##               Sint Maarten   2 1.130454e-04
##                   Slovenia  50 2.826136e-03
##            Solomon Islands  18 1.017409e-03
##                    Somalia   3 1.695682e-04
##               South Africa 200 1.130454e-02
##                      Spain 915 5.171829e-02
##                  Sri Lanka  34 1.921773e-03
##    St. Pierre and Miquelon  40 2.260909e-03
##                      Sudan   3 1.695682e-04
##             Sudan (former)   3 1.695682e-04
##                   Suriname  27 1.526113e-03
##     Svalbard and Jan Mayen   1 5.652272e-05
##                     Sweden  72 4.069636e-03
##       Syrian Arab Republic  34 1.921773e-03
##   Taiwan Province of China 310 1.752204e-02
##   Tanzania, United Rep. of  49 2.769613e-03
##                   Thailand 150 8.478408e-03
##                 TimorLeste   7 3.956591e-04
##                       Togo  78 4.408772e-03
##                    Tokelau  10 5.652272e-04
##                      Tonga  14 7.913181e-04
##        Trinidad and Tobago  39 2.204386e-03
##                    Tunisia  85 4.804431e-03
##                     Turkey  76 4.295727e-03
##       Turks and Caicos Is.   6 3.391363e-04
##                     Tuvalu  10 5.652272e-04
##                    Ukraine 294 1.661768e-02
##         Un. Sov. Soc. Rep. 515 2.910920e-02
##       United Arab Emirates  52 2.939182e-03
##             United Kingdom 362 2.046123e-02
##   United States of America 627 3.543975e-02
##                    Uruguay 131 7.404477e-03
##          US Virgin Islands  29 1.639159e-03
##                    Vanuatu  71 4.013113e-03
##    Venezuela, Boliv Rep of  80 4.521818e-03
##                   Viet Nam  14 7.913181e-04
##      Wallis and Futuna Is.   5 2.826136e-04
##             Western Sahara   3 1.695682e-04
##                      Yemen  39 2.204386e-03
##             Yugoslavia SFR  36 2.034818e-03
##                   Zanzibar  19 1.073932e-03
```


```r
fisheries %>% 
  summarize(num_countries = n_distinct(country))
```

```
## # A tibble: 1 x 1
##   num_countries
##           <int>
## 1           204
```

4. Refocus the data only to include only: country, isscaap_taxonomic_group, asfis_species_name, asfis_species_number, year, catch.

```r
fisheries_tidy %>% 
  select(country, isscaap_taxonomic_group, asfis_species_name, asfis_species_number, year, catch)
```

```
## # A tibble: 376,771 x 6
##    country isscaap_taxonomic_g… asfis_species_na… asfis_species_num…  year catch
##    <fct>   <chr>                <chr>             <fct>              <dbl> <dbl>
##  1 Albania Sharks, rays, chima… Squatinidae       10903XXXXX          1995    NA
##  2 Albania Sharks, rays, chima… Squatinidae       10903XXXXX          1996    53
##  3 Albania Sharks, rays, chima… Squatinidae       10903XXXXX          1997    20
##  4 Albania Sharks, rays, chima… Squatinidae       10903XXXXX          1998    31
##  5 Albania Sharks, rays, chima… Squatinidae       10903XXXXX          1999    30
##  6 Albania Sharks, rays, chima… Squatinidae       10903XXXXX          2000    30
##  7 Albania Sharks, rays, chima… Squatinidae       10903XXXXX          2001    16
##  8 Albania Sharks, rays, chima… Squatinidae       10903XXXXX          2002    79
##  9 Albania Sharks, rays, chima… Squatinidae       10903XXXXX          2003     1
## 10 Albania Sharks, rays, chima… Squatinidae       10903XXXXX          2004     4
## # … with 376,761 more rows
```

5. Based on the asfis_species_number, how many distinct fish species were caught as part of these data?

```r
fisheries_tidy %>% 
  summarise(distinct_fish_species = n_distinct(asfis_species_name))
```

```
## # A tibble: 1 x 1
##   distinct_fish_species
##                   <int>
## 1                  1546
```

6. Which country had the largest overall catch in the year 2000?

```r
summary(fisheries_tidy)
```

```
##                      country       common_name        isscaap_group_number
##  United States of America: 18080   Length:376771      33     : 69821      
##  Spain                   : 17482   Class :character   36     : 61839      
##  Japan                   : 15429   Mode  :character   37     : 38992      
##  Portugal                : 11570                      34     : 27360      
##  Korea, Republic of      : 10824                      38     : 23210      
##  France                  : 10639                      32     : 21616      
##  (Other)                 :292747                      (Other):133933      
##  isscaap_taxonomic_group    asfis_species_number asfis_species_name
##  Length:376771           199XXXXXXX010: 14289    Length:376771     
##  Class :character        1750102610   :  6866    Class :character  
##  Mode  :character        199XXXXXXX054:  6405    Mode  :character  
##                          1750102501   :  5785                      
##                          1750102612   :  5341                      
##                          1750400301   :  5143                      
##                          (Other)      :332942                      
##  fao_major_fishing_area   measure               year          catch         
##  27     : 58309         Length:376771      Min.   :1950   Min.   :    0.00  
##  34     : 47080         Class :character   1st Qu.:1977   1st Qu.:    2.00  
##  37     : 40698         Mode  :character   Median :1991   Median :    7.00  
##  51     : 33244                            Mean   :1989   Mean   :   39.36  
##  31     : 30530                            3rd Qu.:2003   3rd Qu.:   32.00  
##  71     : 30065                            Max.   :2012   Max.   :77000.00  
##  (Other):136845                                           NA's   :133583
```

```r
view(fisheries_tidy)
```


```r
fisheries_tidy %>% 
  filter(year=="2000") %>% 
  group_by(country) %>% 
  summarize(largest_fish=max(catch, na.rm=T)) %>% 
  arrange(desc(largest_fish))
```

```
## Warning in max(catch, na.rm = T): no non-missing arguments to max; returning -
## Inf

## Warning in max(catch, na.rm = T): no non-missing arguments to max; returning -
## Inf

## Warning in max(catch, na.rm = T): no non-missing arguments to max; returning -
## Inf

## Warning in max(catch, na.rm = T): no non-missing arguments to max; returning -
## Inf

## Warning in max(catch, na.rm = T): no non-missing arguments to max; returning -
## Inf

## Warning in max(catch, na.rm = T): no non-missing arguments to max; returning -
## Inf
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 193 x 2
##    country                  largest_fish
##    <fct>                           <dbl>
##  1 China                            9068
##  2 Peru                             5717
##  3 Russian Federation               5065
##  4 Viet Nam                         4945
##  5 Chile                            4299
##  6 United States of America         2438
##  7 Philippines                       999
##  8 Japan                             988
##  9 Bangladesh                        977
## 10 Senegal                           970
## # … with 183 more rows
```

7. Which country caught the most sardines (_Sardina pilchardus_) between the years 1990-2000?


```r
fisheries_tidy %>% 
  filter(year>=1990,year<=2000) %>%
  filter(asfis_species_name=="Sardina pilchardus") %>% 
  group_by(country) %>% 
  summarize(sardine_catch=sum(catch, na.rm=T)) %>% 
  arrange(desc(sardine_catch))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 37 x 2
##    country               sardine_catch
##    <fct>                         <dbl>
##  1 Morocco                        7470
##  2 Spain                          3507
##  3 Russian Federation             1639
##  4 Ukraine                        1030
##  5 France                          966
##  6 Portugal                        818
##  7 Greece                          528
##  8 Italy                           507
##  9 Serbia and Montenegro           478
## 10 Denmark                         477
## # … with 27 more rows
```

8. Which five countries caught the most cephalopods between 2008-2012?

```r
fisheries_tidy %>% 
  filter(year>=2008,year<=2012) %>%
  filter(asfis_species_name=="Cephalopoda") %>% 
  group_by(country) %>% 
  summarize(cephalopod_catch=sum(catch, na.rm=T)) %>% 
  arrange(desc(cephalopod_catch))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 16 x 2
##    country                  cephalopod_catch
##    <fct>                               <dbl>
##  1 India                                 570
##  2 China                                 257
##  3 Spain                                 198
##  4 Algeria                               162
##  5 France                                101
##  6 Mauritania                             90
##  7 TimorLeste                             76
##  8 Italy                                  66
##  9 Mozambique                             16
## 10 Cambodia                               15
## 11 Taiwan Province of China               13
## 12 Madagascar                             11
## 13 Croatia                                 7
## 14 Israel                                  0
## 15 Somalia                                 0
## 16 Viet Nam                                0
```
##### India, China, Spain, Algeria, France

9. Which species had the highest catch total between 2008-2012? (hint: Osteichthyes is not a species)

```r
fisheries_tidy %>% 
  filter(year>=2008,year<=2012) %>%
  group_by(asfis_species_name) %>% 
  summarize(species_sum=sum(catch, na.rm=T)) %>% 
  arrange(desc(species_sum))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 1,472 x 2
##    asfis_species_name    species_sum
##    <chr>                       <dbl>
##  1 Osteichthyes               107808
##  2 Theragra chalcogramma       41075
##  3 Engraulis ringens           35523
##  4 Katsuwonus pelamis          32153
##  5 Trichiurus lepturus         30400
##  6 Clupea harengus             28527
##  7 Thunnus albacares           20119
##  8 Scomber japonicus           14723
##  9 Gadus morhua                13253
## 10 Thunnus alalunga            12019
## # … with 1,462 more rows
```
##### Theragra chalcogramma

10. Use the data to do at least one analysis of your choice.
##### Which year had the biggest catch totals?

```r
fisheries_tidy %>% 
  group_by(year) %>% 
  summarize(catch_totals=sum(catch, na.rm=T)) %>% 
  arrange(desc(catch_totals))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 63 x 2
##     year catch_totals
##    <dbl>        <dbl>
##  1  2007       268130
##  2  2006       257669
##  3  2001       257320
##  4  2002       255807
##  5  2012       255406
##  6  2008       255013
##  7  2004       254115
##  8  2005       251877
##  9  2009       251181
## 10  2010       244839
## # … with 53 more rows
```
##### 2007 had the biggest catch totals.
## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
