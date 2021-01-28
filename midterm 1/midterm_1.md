---
title: "Midterm 1"
author: "Srinidhi Viswanathan"
date: "2021-01-27"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your code should be organized, clean, and run free from errors. Be sure to **add your name** to the author header above. You may use any resources to answer these questions (including each other), but you may not post questions to Open Stacks or external help sites. There are 12 total questions.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

This exam is due by **12:00p on Thursday, January 28**.  

## Load the tidyverse
If you plan to use any other libraries to complete this assignment then you should load them here.

```r
library("tidyverse")
library("janitor")
library("skimr")
```

## Questions
**1. (2 points) Briefly explain how R, RStudio, and GitHub work together to make work flows in data science transparent and repeatable. What is the advantage of using RMarkdown in this context?**  
###### R is a scripting language that you can use through RStudio, a graphical user interface. RStudio makes R easier to use by providing an interface that is more user-friendly and easier to navigate. Github is a place in which programmers can store code they have written. It is useful to programmers because this code is publicly available and can be used by everybody. It is also a way to easily store your work in an organized way. RMarkdown is a type of document in which code can be embedded. This type of document makes it easy for other programmers to view and understand the code you have written. Therefore, it is advantageous to use RMarkdown on Github because it allows for others to view your code in an organized way.

**2. (2 points) What are the three types of `data structures` that we have discussed? Why are we using data frames for BIS 15L?**

###### The three types of data structures that we have discussed are vectors, data matrices, and data frames. We use data frames in BIS15L because there are a lot of functions that are useful to manipulate data in data frames. These functions are especially useful in a biological context, which is one of the goals of this class.

In the midterm 1 folder there is a second folder called `data`. Inside the `data` folder, there is a .csv file called `ElephantsMF`. These data are from Phyllis Lee, Stirling University, and are related to Lee, P., et al. (2013), "Enduring consequences of early experiences: 40-year effects on survival and success among African elephants (Loxodonta africana)," Biology Letters, 9: 20130011. [kaggle](https://www.kaggle.com/mostafaelseidy/elephantsmf).  

**3. (2 points) Please load these data as a new object called `elephants`. Use the function(s) of your choice to get an idea of the structure of the data. Be sure to show the class of each variable.**

```r
elephants <- readr::read_csv("data/ElephantsMF.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   Age = col_double(),
##   Height = col_double(),
##   Sex = col_character()
## )
```

```r
skim(elephants)
```


Table: Data summary

|                         |          |
|:------------------------|:---------|
|Name                     |elephants |
|Number of rows           |288       |
|Number of columns        |3         |
|_______________________  |          |
|Column type frequency:   |          |
|character                |1         |
|numeric                  |2         |
|________________________ |          |
|Group variables          |None      |


**Variable type: character**

|skim_variable | n_missing| complete_rate| min| max| empty| n_unique| whitespace|
|:-------------|---------:|-------------:|---:|---:|-----:|--------:|----------:|
|Sex           |         0|             1|   1|   1|     0|        2|          0|


**Variable type: numeric**

|skim_variable | n_missing| complete_rate|   mean|   sd|    p0|    p25|    p50|    p75|   p100|hist  |
|:-------------|---------:|-------------:|------:|----:|-----:|------:|------:|------:|------:|:-----|
|Age           |         0|             1|  10.97|  8.4|  0.01|   4.58|   9.46|  16.50|  32.17|▆▇▂▂▂ |
|Height        |         0|             1| 187.68| 50.6| 75.46| 160.75| 200.00| 221.09| 304.06|▃▃▇▇▁ |


**4. (2 points) Change the names of the variables to lower case and change the class of the variable `sex` to a factor.**

```r
elephants <- elephants %>% 
  select_all(tolower) 
elephants$sex <- as.factor(elephants$sex)
names(elephants)
```

```
## [1] "age"    "height" "sex"
```

```r
is.factor(elephants$sex)
```

```
## [1] TRUE
```


**5. (2 points) How many male and female elephants are represented in the data?**

```r
elephants %>% 
  count(sex, sort = T) 
```

```
## # A tibble: 2 x 2
##   sex       n
##   <fct> <int>
## 1 F       150
## 2 M       138
```
###### There are 150 females and 138 males. 

**6. (2 points) What is the average age all elephants in the data?**

```r
elephants %>% 
  summarise(avg_age = mean(age))
```

```
## # A tibble: 1 x 1
##   avg_age
##     <dbl>
## 1    11.0
```
###### The average age is 10.97132.

**7. (2 points) How does the average age and height of elephants compare by sex?**

```r
elephants %>% 
  group_by(sex) %>% 
  summarize(avg_age = mean(age))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 2 x 2
##   sex   avg_age
##   <fct>   <dbl>
## 1 F       12.8 
## 2 M        8.95
```
###### The average age for female elephants is 12.835400 years.
###### The average age for male elephants is 8.945145 years.


**8. (2 points) How does the average height of elephants compare by sex for individuals over 25 years old. Include the min and max height as well as the number of individuals in the sample as part of your analysis.**

```r
elephants %>% 
  filter(age>25) %>% 
  group_by(sex) %>% 
  summarize(average_height = mean(height),
            max_height = max(height),
            min_height = min(height),
            number_indv=n())
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 2 x 5
##   sex   average_height max_height min_height number_indv
##   <fct>          <dbl>      <dbl>      <dbl>       <int>
## 1 F               233.       278.       206.          25
## 2 M               273.       304.       237.           8
```


For the next series of questions, we will use data from a study on vertebrate community composition and impacts from defaunation in [Gabon, Africa](https://en.wikipedia.org/wiki/Gabon). One thing to notice is that the data include 24 separate transects. Each transect represents a path through different forest management areas.  

Reference: Koerner SE, Poulsen JR, Blanchard EJ, Okouyi J, Clark CJ. Vertebrate community composition and diversity declines along a defaunation gradient radiating from rural villages in Gabon. _Journal of Applied Ecology_. 2016. This paper, along with a description of the variables is included inside the midterm 1 folder.  

**9. (2 points) Load `IvindoData_DryadVersion.csv` and use the function(s) of your choice to get an idea of the overall structure. Change the variables `HuntCat` and `LandUse` to factors.**

```r
vertabrate <- readr::read_csv("data/IvindoData_DryadVersion.csv") %>% 
  select_all(tolower) 
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   .default = col_double(),
##   HuntCat = col_character(),
##   LandUse = col_character()
## )
## ℹ Use `spec()` for the full column specifications.
```

```r
vertabrate$huntcat <- as.factor(vertabrate$huntcat)
vertabrate$landuse <- as.factor(vertabrate$landuse)

skim(vertabrate)
```


Table: Data summary

|                         |           |
|:------------------------|:----------|
|Name                     |vertabrate |
|Number of rows           |24         |
|Number of columns        |26         |
|_______________________  |           |
|Column type frequency:   |           |
|factor                   |2          |
|numeric                  |24         |
|________________________ |           |
|Group variables          |None       |


**Variable type: factor**

|skim_variable | n_missing| complete_rate|ordered | n_unique|top_counts              |
|:-------------|---------:|-------------:|:-------|--------:|:-----------------------|
|huntcat       |         0|             1|FALSE   |        3|Non: 9, Mod: 8, Hig: 7  |
|landuse       |         0|             1|FALSE   |        3|Log: 13, Par: 7, Nei: 4 |


**Variable type: numeric**

|skim_variable           | n_missing| complete_rate|  mean|    sd|    p0|   p25|   p50|   p75|  p100|hist  |
|:-----------------------|---------:|-------------:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|:-----|
|transectid              |         0|             1| 13.50|  8.51|  1.00|  5.75| 14.50| 20.25| 27.00|▇▃▅▆▆ |
|distance                |         0|             1| 11.88|  7.28|  2.70|  5.67|  9.72| 17.68| 26.76|▇▂▂▅▂ |
|numhouseholds           |         0|             1| 37.88| 17.80| 13.00| 24.75| 29.00| 54.00| 73.00|▇▇▂▇▂ |
|veg_rich                |         0|             1| 14.83|  2.07| 10.88| 13.10| 14.94| 16.54| 18.75|▃▂▃▇▁ |
|veg_stems               |         0|             1| 32.80|  5.96| 23.44| 28.69| 32.44| 37.08| 47.56|▆▇▆▃▁ |
|veg_liana               |         0|             1| 11.04|  3.29|  4.75|  9.03| 11.94| 13.25| 16.38|▃▂▃▇▃ |
|veg_dbh                 |         0|             1| 46.09| 10.67| 28.45| 40.65| 43.90| 50.57| 76.48|▂▇▃▁▁ |
|veg_canopy              |         0|             1|  3.47|  0.35|  2.50|  3.25|  3.43|  3.75|  4.00|▁▁▇▅▇ |
|veg_understory          |         0|             1|  3.02|  0.34|  2.38|  2.88|  3.00|  3.17|  3.88|▂▆▇▂▁ |
|ra_apes                 |         0|             1|  2.04|  3.03|  0.00|  0.00|  0.48|  3.82| 12.93|▇▂▁▁▁ |
|ra_birds                |         0|             1| 58.64| 14.71| 31.56| 52.51| 57.89| 68.18| 85.03|▅▅▇▇▃ |
|ra_elephant             |         0|             1|  0.54|  0.67|  0.00|  0.00|  0.36|  0.89|  2.30|▇▂▂▁▁ |
|ra_monkeys              |         0|             1| 31.30| 12.38|  5.84| 22.70| 31.74| 39.88| 54.12|▂▅▃▇▂ |
|ra_rodent               |         0|             1|  3.28|  1.47|  1.06|  2.05|  3.23|  4.09|  6.31|▇▅▇▃▃ |
|ra_ungulate             |         0|             1|  4.17|  4.31|  0.00|  1.23|  2.54|  5.16| 13.86|▇▂▁▁▂ |
|rich_allspecies         |         0|             1| 20.21|  2.06| 15.00| 19.00| 20.00| 22.00| 24.00|▁▁▇▅▁ |
|evenness_allspecies     |         0|             1|  0.77|  0.05|  0.67|  0.75|  0.78|  0.81|  0.83|▃▁▅▇▇ |
|diversity_allspecies    |         0|             1|  2.31|  0.15|  1.97|  2.25|  2.32|  2.43|  2.57|▂▃▇▆▅ |
|rich_birdspecies        |         0|             1| 10.33|  1.24|  8.00| 10.00| 11.00| 11.00| 13.00|▃▅▇▁▁ |
|evenness_birdspecies    |         0|             1|  0.71|  0.08|  0.56|  0.68|  0.72|  0.77|  0.82|▅▁▇▆▇ |
|diversity_birdspecies   |         0|             1|  1.66|  0.20|  1.16|  1.60|  1.68|  1.78|  2.01|▂▂▅▇▃ |
|rich_mammalspecies      |         0|             1|  9.88|  1.68|  6.00|  9.00| 10.00| 11.00| 12.00|▂▂▃▅▇ |
|evenness_mammalspecies  |         0|             1|  0.75|  0.06|  0.62|  0.71|  0.74|  0.78|  0.86|▂▃▇▂▅ |
|diversity_mammalspecies |         0|             1|  1.70|  0.17|  1.38|  1.57|  1.70|  1.81|  2.06|▅▇▇▇▃ |

```r
view(vertabrate)
```


**10. (4 points) For the transects with high and moderate hunting intensity, how does the average diversity of birds and mammals compare?**

```r
vertabrate %>% 
  group_by(huntcat) %>% 
  summarize(avg_diversity_mammals = mean(diversity_mammalspecies),
            average_diversity_birds = mean(diversity_birdspecies),
            total_observations = n())
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 3 x 4
##   huntcat  avg_diversity_mammals average_diversity_birds total_observations
##   <fct>                    <dbl>                   <dbl>              <int>
## 1 High                      1.74                    1.66                  7
## 2 Moderate                  1.68                    1.62                  8
## 3 None                      1.68                    1.70                  9
```
###### Among the transects with high hunting intensity, the average diversity of mammals is 1.73700, and the average diversity of birds is 1.660857. 
###### Among the transects with moderate hunting intensity, the average diversity of mammals is 1.68375, and the average diversity of birds is 1.621250.

**11. (4 points) One of the conclusions in the study is that the relative abundance of animals drops off the closer you get to a village. Let's try to reconstruct this (without the statistics). How does the relative abundance (RA) of apes, birds, elephants, monkeys, rodents, and ungulates compare between sites that are less than 5km from a village to sites that are greater than 20km from a village? The variable `Distance` measures the distance of the transect from the nearest village. Hint: try using the `across` operator.**  

```r
relative_abundance <- vertabrate %>% 
  select(starts_with("ra"))
relative_abundance
```

```
## # A tibble: 24 x 6
##    ra_apes ra_birds ra_elephant ra_monkeys ra_rodent ra_ungulate
##      <dbl>    <dbl>       <dbl>      <dbl>     <dbl>       <dbl>
##  1    1.87     52.7        0         38.6       4.22        2.66
##  2    0        52.2        0.86      28.5       6.04       12.4 
##  3    4.49     37.4        1.33      41.8       1.06       13.9 
##  4   12.9      59.3        0.56      19.8       3.66        3.71
##  5    0        52.6        1         41.3       2.52        2.53
##  6    2.48     38.6        0         43.3       1.83       13.8 
##  7    3.78     42.7        1.11      46.2       3.1         3.1 
##  8    6.17     33.8        0.43      49.5       1.26        8.76
##  9    0        73.1        2.2       20.0       4.37        0.34
## 10    0        85.0        0          5.84      6.31        2.36
## # … with 14 more rows
```

```r
close <- vertabrate %>% 
  filter(distance<5) %>% 
  summarise(across(c(ra_apes, ra_birds, ra_elephant, ra_monkeys, ra_ungulate),mean))
close
```

```
## # A tibble: 1 x 5
##   ra_apes ra_birds ra_elephant ra_monkeys ra_ungulate
##     <dbl>    <dbl>       <dbl>      <dbl>       <dbl>
## 1    0.08     70.4      0.0967       24.1        1.59
```

```r
far <- vertabrate %>% 
  filter(distance>20) %>% 
  summarise(across(c(ra_apes, ra_birds, ra_elephant, ra_monkeys, ra_ungulate),mean))
far
```

```
## # A tibble: 1 x 5
##   ra_apes ra_birds ra_elephant ra_monkeys ra_ungulate
##     <dbl>    <dbl>       <dbl>      <dbl>       <dbl>
## 1    7.21     44.5       0.557       40.1        4.98
```
###### In general, the relative abundance is higher farther away from human populations. However, birds have a higher relative abundance closer to humans.


**12. (4 points) Based on your interest, do one exploratory analysis on the `gabon` data of your choice. This analysis needs to include a minimum of two functions in `dplyr.`**
###### What is the average diversity of birds and mammals when considering what the land they are on is used for?

```r
vertabrate %>% 
  group_by(landuse) %>% 
  summarize(across(c(diversity_birdspecies, diversity_mammalspecies, diversity_allspecies), mean)) %>% 
  arrange(desc(diversity_allspecies))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 3 x 4
##   landuse diversity_birdspecies diversity_mammalspecies diversity_allspecies
##   <fct>                   <dbl>                   <dbl>                <dbl>
## 1 Park                     1.77                    1.75                 2.43
## 2 Neither                  1.81                    1.66                 2.36
## 3 Logging                  1.56                    1.68                 2.23
```

