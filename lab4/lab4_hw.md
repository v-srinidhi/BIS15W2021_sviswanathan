---
title: "Lab 4 Homework"
author: "Srinidhi Viswanathan"
date: "2021-01-24"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the tidyverse

```r
library(tidyverse)
```

## Data
For the homework, we will use data about vertebrate home range sizes. The data are in the class folder, but the reference is below.  

**Database of vertebrate home range sizes.**  
Reference: Tamburello N, Cote IM, Dulvy NK (2015) Energy and the scaling of animal space use. The American Naturalist 186(2):196-211. http://dx.doi.org/10.1086/682070.  
Data: http://datadryad.org/resource/doi:10.5061/dryad.q5j65/1  

**1. Load the data into a new object called `homerange`.**

```r
homerange <- readr::read_csv("data/Tamburelloetal_HomeRangeDatabase.csv")
```

```
## Parsed with column specification:
## cols(
##   .default = col_character(),
##   mean.mass.g = col_double(),
##   log10.mass = col_double(),
##   mean.hra.m2 = col_double(),
##   log10.hra = col_double(),
##   preymass = col_double(),
##   log10.preymass = col_double(),
##   PPMR = col_double()
## )
```

```
## See spec(...) for full column specifications.
```

**2. Explore the data. Show the dimensions, column names, classes for each variable, and a statistical summary. Keep these as separate code chunks.**  

```r
dim(homerange)
```

```
## [1] 569  24
```


```r
colnames(homerange)
```

```
##  [1] "taxon"                      "common.name"               
##  [3] "class"                      "order"                     
##  [5] "family"                     "genus"                     
##  [7] "species"                    "primarymethod"             
##  [9] "N"                          "mean.mass.g"               
## [11] "log10.mass"                 "alternative.mass.reference"
## [13] "mean.hra.m2"                "log10.hra"                 
## [15] "hra.reference"              "realm"                     
## [17] "thermoregulation"           "locomotion"                
## [19] "trophic.guild"              "dimension"                 
## [21] "preymass"                   "log10.preymass"            
## [23] "PPMR"                       "prey.size.reference"
```


```r
#summary(homerange)
```


```r
#str(homerange)
```

**3. Change the class of the variables `taxon` and `order` to factors and display their levels.**  

```r
homerange$taxon <- as.factor(homerange$taxon)
homerange$order <- as.factor(homerange$order)
levels(homerange$taxon)
```

```
## [1] "birds"         "lake fishes"   "lizards"       "mammals"      
## [5] "marine fishes" "river fishes"  "snakes"        "tortoises"    
## [9] "turtles"
```


```r
levels(homerange$order)
```

```
##  [1] "accipitriformes"    "afrosoricida"       "anguilliformes"    
##  [4] "anseriformes"       "apterygiformes"     "artiodactyla"      
##  [7] "caprimulgiformes"   "carnivora"          "charadriiformes"   
## [10] "columbidormes"      "columbiformes"      "coraciiformes"     
## [13] "cuculiformes"       "cypriniformes"      "dasyuromorpha"     
## [16] "dasyuromorpia"      "didelphimorphia"    "diprodontia"       
## [19] "diprotodontia"      "erinaceomorpha"     "esociformes"       
## [22] "falconiformes"      "gadiformes"         "galliformes"       
## [25] "gruiformes"         "lagomorpha"         "macroscelidea"     
## [28] "monotrematae"       "passeriformes"      "pelecaniformes"    
## [31] "peramelemorphia"    "perciformes"        "perissodactyla"    
## [34] "piciformes"         "pilosa"             "proboscidea"       
## [37] "psittaciformes"     "rheiformes"         "roden"             
## [40] "rodentia"           "salmoniformes"      "scorpaeniformes"   
## [43] "siluriformes"       "soricomorpha"       "squamata"          
## [46] "strigiformes"       "struthioniformes"   "syngnathiformes"   
## [49] "testudines"         "tetraodontiformes\xa0" "tinamiformes"
```

**4. What taxa are represented in the `homerange` data frame? Make a new data frame `taxa` that is restricted to taxon, common name, class, order, family, genus, species.**  

```r
taxa <- select(homerange, "taxon", "common.name", "class", "order", "family", "genus", "species")
#taxa <- data.frame(taxa)
#taxa
```

_You don't need to make a data frame out of a data frame here_

**5. The variable `taxon` identifies the large, common name groups of the species represented in `homerange`. Make a table the shows the counts for each of these `taxon`.**  

```r
table(homerange$taxon)
```

```
## 
##         birds   lake fishes       lizards       mammals marine fishes 
##           140             9            11           238            90 
##  river fishes        snakes     tortoises       turtles 
##            14            41            12            14
```


**6. The species in `homerange` are also classified into trophic guilds. How many species are represented in each trophic guild.**  

```r
table(homerange$trophic.guild)
```

```
## 
## carnivore herbivore 
##       342       227
```


**7. Make two new data frames, one which is restricted to carnivores and another that is restricted to herbivores.** 

```r
df_carnivore <- data.frame(filter(homerange, trophic.guild=="carnivore"))
df_herbivore <- data.frame(filter(homerange, trophic.guild=="herbivore"))
glimpse(df_carnivore)
```

```
## Observations: 342
## Variables: 24
## $ taxon                      <fct> lake fishes, river fishes, river fishes, r…
## $ common.name                <chr> "american eel", "blacktail redhorse", "cen…
## $ class                      <chr> "actinopterygii", "actinopterygii", "actin…
## $ order                      <fct> anguilliformes, cypriniformes, cypriniform…
## $ family                     <chr> "anguillidae", "catostomidae", "cyprinidae…
## $ genus                      <chr> "anguilla", "moxostoma", "campostoma", "cl…
## $ species                    <chr> "rostrata", "poecilura", "anomalum", "fund…
## $ primarymethod              <chr> "telemetry", "mark-recapture", "mark-recap…
## $ N                          <chr> "16", NA, "20", "26", "17", "5", "2", "2",…
## $ mean.mass.g                <dbl> 887.00, 562.00, 34.00, 4.00, 4.00, 3525.00…
## $ log10.mass                 <dbl> 2.9479236, 2.7497363, 1.5314789, 0.6020600…
## $ alternative.mass.reference <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
## $ mean.hra.m2                <dbl> 282750.00, 282.10, 116.11, 125.50, 87.10, …
## $ log10.hra                  <dbl> 5.4514026, 2.4504031, 2.0648696, 2.0986437…
## $ hra.reference              <chr> "Minns, C. K. 1995. Allometry of home rang…
## $ realm                      <chr> "aquatic", "aquatic", "aquatic", "aquatic"…
## $ thermoregulation           <chr> "ectotherm", "ectotherm", "ectotherm", "ec…
## $ locomotion                 <chr> "swimming", "swimming", "swimming", "swimm…
## $ trophic.guild              <chr> "carnivore", "carnivore", "carnivore", "ca…
## $ dimension                  <chr> "3D", "2D", "2D", "2D", "2D", "2D", "2D", …
## $ preymass                   <dbl> NA, NA, NA, NA, NA, NA, 1.39, NA, NA, NA, …
## $ log10.preymass             <dbl> NA, NA, NA, NA, NA, NA, 0.1430148, NA, NA,…
## $ PPMR                       <dbl> NA, NA, NA, NA, NA, NA, 530, NA, NA, NA, N…
## $ prey.size.reference        <chr> NA, NA, NA, NA, NA, NA, "Brose U, et al. 2…
```


```r
glimpse(df_herbivore)
```

```
## Observations: 227
## Variables: 24
## $ taxon                      <fct> marine fishes, marine fishes, marine fishe…
## $ common.name                <chr> "lined surgeonfish", "orangespine unicornf…
## $ class                      <chr> "actinopterygii", "actinopterygii", "actin…
## $ order                      <fct> perciformes, perciformes, perciformes, per…
## $ family                     <chr> "acanthuridae", "acanthuridae", "acanthuri…
## $ genus                      <chr> "acanthurus", "naso", "naso", "ophioblenni…
## $ species                    <chr> "lineatus", "lituratus", "unicornis", "atl…
## $ primarymethod              <chr> "direct observation", "telemetry", "teleme…
## $ N                          <chr> NA, "8", "7", "20", "11", NA, NA, "18", NA…
## $ mean.mass.g                <dbl> 109.04, 772.16, 151.84, 6.20, 1086.71, 2.5…
## $ log10.mass                 <dbl> 2.0375858, 2.8877073, 2.1813862, 0.7923917…
## $ alternative.mass.reference <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
## $ mean.hra.m2                <dbl> 11.13, 32092.86, 17900.00, 0.52, 34423.00,…
## $ log10.hra                  <dbl> 1.04649516, 4.50640842, 4.25285303, -0.283…
## $ hra.reference              <chr> "Nursall JR. 1974. Some Territorial Behavi…
## $ realm                      <chr> "aquatic", "aquatic", "aquatic", "aquatic"…
## $ thermoregulation           <chr> "ectotherm", "ectotherm", "ectotherm", "ec…
## $ locomotion                 <chr> "swimming", "swimming", "swimming", "swimm…
## $ trophic.guild              <chr> "herbivore", "herbivore", "herbivore", "he…
## $ dimension                  <chr> "2D", "2D", "2D", "2D", "2D", "2D", "2D", …
## $ preymass                   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
## $ log10.preymass             <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
## $ PPMR                       <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
## $ prey.size.reference        <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
```


**8. Do herbivores or carnivores have, on average, a larger `mean.hra.m2`? Remove any NAs from the data.**  

```r
mean(df_carnivore$mean.hra.m2, na.rm = T)
```

```
## [1] 13039918
```


```r
mean(df_herbivore$mean.hra.m2, na.rm = T)
```

```
## [1] 34137012
```
#### Herbivores have a larger mean.hra.m2 on average.

**9. Make a new dataframe `deer` that is limited to the mean mass, log10 mass, family, genus, and species of deer in the database. The family for deer is cervidae. Arrange the data in descending order by log10 mass. Which is the largest deer? What is its common name?** 

```r
colnames(homerange)
```

```
##  [1] "taxon"                      "common.name"               
##  [3] "class"                      "order"                     
##  [5] "family"                     "genus"                     
##  [7] "species"                    "primarymethod"             
##  [9] "N"                          "mean.mass.g"               
## [11] "log10.mass"                 "alternative.mass.reference"
## [13] "mean.hra.m2"                "log10.hra"                 
## [15] "hra.reference"              "realm"                     
## [17] "thermoregulation"           "locomotion"                
## [19] "trophic.guild"              "dimension"                 
## [21] "preymass"                   "log10.preymass"            
## [23] "PPMR"                       "prey.size.reference"
```


```r
deer <- data.frame(select(homerange, "mean.mass.g", "log10.mass", "family", "genus", "species"))
deer <- filter(deer, family=="cervidae")
sort(deer$log10.mass, decreasing = T)
```

```
##  [1] 5.48746 5.37062 5.00885 4.94391 4.85400 4.79812 4.73130 4.54407 4.46909
## [10] 4.38112 4.13033 3.87506
```

```r
deer
```

```
##    mean.mass.g log10.mass   family      genus     species
## 1    307227.44    5.48746 cervidae      alces       alces
## 2     62823.19    4.79812 cervidae       axis        axis
## 3     24050.27    4.38112 cervidae  capreolus   capreolus
## 4    234757.78    5.37062 cervidae     cervus     elaphus
## 5     29450.32    4.46909 cervidae     cervus      nippon
## 6     71449.63    4.85400 cervidae       dama        dama
## 7     13499.88    4.13033 cervidae  muntiacus     reevesi
## 8     53864.17    4.73130 cervidae odocoileus    hemionus
## 9     87884.04    4.94391 cervidae odocoileus virginianus
## 10    35000.16    4.54407 cervidae ozotoceros bezoarticus
## 11     7499.98    3.87506 cervidae       pudu        puda
## 12   102058.69    5.00885 cervidae   rangifer    tarandus
```


```r
large_deer <- max(deer$mean.mass.g)
large_deer
```

```
## [1] 307227.4
```


```r
deer_commonname <- data.frame(select(homerange, "common.name","mean.mass.g", "log10.mass", "family", "genus", "species"))
deer_commonname <- filter(homerange, family=="cervidae")
largest_deer <- subset(deer_commonname, mean.mass.g==max(mean.mass.g))
largest_deer
```

```
## # A tibble: 1 x 24
##   taxon common.name class order family genus species primarymethod N    
##   <fct> <chr>       <chr> <fct> <chr>  <chr> <chr>   <chr>         <chr>
## 1 mamm… moose       mamm… arti… cervi… alces alces   telemetry*    <NA> 
## # … with 15 more variables: mean.mass.g <dbl>, log10.mass <dbl>,
## #   alternative.mass.reference <chr>, mean.hra.m2 <dbl>, log10.hra <dbl>,
## #   hra.reference <chr>, realm <chr>, thermoregulation <chr>, locomotion <chr>,
## #   trophic.guild <chr>, dimension <chr>, preymass <dbl>, log10.preymass <dbl>,
## #   PPMR <dbl>, prey.size.reference <chr>
```
#### The largest deer is a Moose with a mean mass of 307227.4 g.

**10. As measured by the data, which snake species has the smallest homerange? Show all of your work, please. Look this species up online and tell me about it!** **Snake is found in taxon column**    

```r
df_snake <- filter(homerange, taxon == "snakes")
df_snake
```

```
## # A tibble: 41 x 24
##    taxon common.name class order family genus species primarymethod N    
##    <fct> <chr>       <chr> <fct> <chr>  <chr> <chr>   <chr>         <chr>
##  1 snak… western wo… rept… squa… colub… carp… vermis  radiotag      1    
##  2 snak… eastern wo… rept… squa… colub… carp… viridis radiotag      10   
##  3 snak… racer       rept… squa… colub… colu… constr… telemetry     15   
##  4 snak… yellow bel… rept… squa… colub… colu… constr… telemetry     12   
##  5 snak… ringneck s… rept… squa… colub… diad… puncta… mark-recaptu… <NA> 
##  6 snak… eastern in… rept… squa… colub… drym… couperi telemetry     1    
##  7 snak… great plai… rept… squa… colub… elap… guttat… telemetry     12   
##  8 snak… western ra… rept… squa… colub… elap… obsole… telemetry     18   
##  9 snak… hognose sn… rept… squa… colub… hete… platir… telemetry     8    
## 10 snak… European w… rept… squa… colub… hier… viridi… telemetry     32   
## # … with 31 more rows, and 15 more variables: mean.mass.g <dbl>,
## #   log10.mass <dbl>, alternative.mass.reference <chr>, mean.hra.m2 <dbl>,
## #   log10.hra <dbl>, hra.reference <chr>, realm <chr>, thermoregulation <chr>,
## #   locomotion <chr>, trophic.guild <chr>, dimension <chr>, preymass <dbl>,
## #   log10.preymass <dbl>, PPMR <dbl>, prey.size.reference <chr>
```


```r
smallest_snake_hr <- subset(df_snake, mean.hra.m2==min(mean.hra.m2))
smallest_snake_hr
```

```
## # A tibble: 1 x 24
##   taxon common.name class order family genus species primarymethod N    
##   <fct> <chr>       <chr> <fct> <chr>  <chr> <chr>   <chr>         <chr>
## 1 snak… namaqua dw… rept… squa… viper… bitis schnei… telemetry     11   
## # … with 15 more variables: mean.mass.g <dbl>, log10.mass <dbl>,
## #   alternative.mass.reference <chr>, mean.hra.m2 <dbl>, log10.hra <dbl>,
## #   hra.reference <chr>, realm <chr>, thermoregulation <chr>, locomotion <chr>,
## #   trophic.guild <chr>, dimension <chr>, preymass <dbl>, log10.preymass <dbl>,
## #   PPMR <dbl>, prey.size.reference <chr>
```
#### The snake species with the smallest homerange is the Namaqua Dwarf Adder.

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
