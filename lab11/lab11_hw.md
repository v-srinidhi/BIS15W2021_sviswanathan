---
title: "Lab 11 Homework"
author: "Srinidhi Viswanathan"
date: "2021-02-17"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above. For any included plots, make sure they are clearly labeled. You are free to use any plot type that you feel best communicates the results of your analysis.  

**In this homework, you should make use of the aesthetics you have learned. It's OK to be flashy!**

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
library(here)
library(naniar)
library(skimr)
```

## Resources
The idea for this assignment came from [Rebecca Barter's](http://www.rebeccabarter.com/blog/2017-11-17-ggplot2_tutorial/) ggplot tutorial so if you get stuck this is a good place to have a look.  

## Gapminder
For this assignment, we are going to use the dataset [gapminder](https://cran.r-project.org/web/packages/gapminder/index.html). Gapminder includes information about economics, population, and life expectancy from countries all over the world. You will need to install it before use. This is the same data that we will use for midterm 2 so this is good practice.

```r
#install.packages("gapminder")
library("gapminder")
```

## Questions
The questions below are open-ended and have many possible solutions. Your approach should, where appropriate, include numerical summaries and visuals. Be creative; assume you are building an analysis that you would ultimately present to an audience of stakeholders. Feel free to try out different `geoms` if they more clearly present your results.  

**1. Use the function(s) of your choice to get an idea of the overall structure of the data frame, including its dimensions, column names, variable classes, etc. As part of this, determine how NA's are treated in the data.**  

```r
glimpse(gapminder)
```

```
## Rows: 1,704
## Columns: 6
## $ country   <fct> Afghanistan, Afghanistan, Afghanistan, Afghanistan, Afgha...
## $ continent <fct> Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asi...
## $ year      <int> 1952, 1957, 1962, 1967, 1972, 1977, 1982, 1987, 1992, 199...
## $ lifeExp   <dbl> 28.801, 30.332, 31.997, 34.020, 36.088, 38.438, 39.854, 4...
## $ pop       <int> 8425333, 9240934, 10267083, 11537966, 13079460, 14880372,...
## $ gdpPercap <dbl> 779.4453, 820.8530, 853.1007, 836.1971, 739.9811, 786.113...
```

```r
naniar::miss_var_summary(gapminder)
```

```
## # A tibble: 6 x 3
##   variable  n_miss pct_miss
##   <chr>      <int>    <dbl>
## 1 country        0        0
## 2 continent      0        0
## 3 year           0        0
## 4 lifeExp        0        0
## 5 pop            0        0
## 6 gdpPercap      0        0
```

```r
skim(gapminder)
```


Table: Data summary

|                         |          |
|:------------------------|:---------|
|Name                     |gapminder |
|Number of rows           |1704      |
|Number of columns        |6         |
|_______________________  |          |
|Column type frequency:   |          |
|factor                   |2         |
|numeric                  |4         |
|________________________ |          |
|Group variables          |None      |


**Variable type: factor**

|skim_variable | n_missing| complete_rate|ordered | n_unique|top_counts                             |
|:-------------|---------:|-------------:|:-------|--------:|:--------------------------------------|
|country       |         0|             1|FALSE   |      142|Afg: 12, Alb: 12, Alg: 12, Ang: 12     |
|continent     |         0|             1|FALSE   |        5|Afr: 624, Asi: 396, Eur: 360, Ame: 300 |


**Variable type: numeric**

|skim_variable | n_missing| complete_rate|        mean|           sd|       p0|        p25|        p50|         p75|         p100|hist  |
|:-------------|---------:|-------------:|-----------:|------------:|--------:|----------:|----------:|-----------:|------------:|:-----|
|year          |         0|             1|     1979.50|        17.27|  1952.00|    1965.75|    1979.50|     1993.25|       2007.0|▇▅▅▅▇ |
|lifeExp       |         0|             1|       59.47|        12.92|    23.60|      48.20|      60.71|       70.85|         82.6|▁▆▇▇▇ |
|pop           |         0|             1| 29601212.32| 106157896.74| 60011.00| 2793664.00| 7023595.50| 19585221.75| 1318683096.0|▇▁▁▁▁ |
|gdpPercap     |         0|             1|     7215.33|      9857.45|   241.17|    1202.06|    3531.85|     9325.46|     113523.1|▇▁▁▁▁ |

```r
view(gapminder)
```

**2. Among the interesting variables in gapminder is life expectancy. How has global life expectancy changed between 1952 and 2007?**

```r
life_exp_year <- gapminder %>% 
  group_by(year) %>% 
  summarize(avg_life_expectany=mean(lifeExp)) 

life_exp_year
```

```
## # A tibble: 12 x 2
##     year avg_life_expectany
##  * <int>              <dbl>
##  1  1952               49.1
##  2  1957               51.5
##  3  1962               53.6
##  4  1967               55.7
##  5  1972               57.6
##  6  1977               59.6
##  7  1982               61.5
##  8  1987               63.2
##  9  1992               64.2
## 10  1997               65.0
## 11  2002               65.7
## 12  2007               67.0
```

```r
life_exp_year %>% 
   ggplot(aes(x=year, y=avg_life_expectany))+geom_line()+
  geom_point(shape=1)+
  theme()+
  labs(title = "Global Life Expectancy per Year",
       x = "Year",
       y= "Global Average Life Expectancy")
```

![](lab11_hw_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

**3. How do the distributions of life expectancy compare for the years 1952 and 2007?**

```r
gapminder$year <- as.factor(gapminder$year)
```


```r
gapminder %>% 
  filter(year=="1952"| year=="2007") %>% 
  ggplot(aes(x=lifeExp, group=year, fill=year))+
  geom_density(alpha=0.5)+
  scale_fill_brewer(palette = "Accent")+
  labs(title="Life Expectancy Distributions from 1952 and 2007",
       x="Life Expectancy")
```

![](lab11_hw_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

**4. Your answer above doesn't tell the whole story since life expectancy varies by region. Make a summary that shows the min, mean, and max life expectancy by continent for all years represented in the data.**

```r
gapminder %>% 
  group_by(year, continent) %>% 
  summarise(min_lifeexp=min(lifeExp),
            mean_lifeexp=mean(lifeExp),
            max_lifeexp=max(lifeExp))
```

```
## `summarise()` has grouped output by 'year'. You can override using the `.groups` argument.
```

```
## # A tibble: 60 x 5
## # Groups:   year [12]
##    year  continent min_lifeexp mean_lifeexp max_lifeexp
##    <fct> <fct>           <dbl>        <dbl>       <dbl>
##  1 1952  Africa           30           39.1        52.7
##  2 1952  Americas         37.6         53.3        68.8
##  3 1952  Asia             28.8         46.3        65.4
##  4 1952  Europe           43.6         64.4        72.7
##  5 1952  Oceania          69.1         69.3        69.4
##  6 1957  Africa           31.6         41.3        58.1
##  7 1957  Americas         40.7         56.0        70.0
##  8 1957  Asia             30.3         49.3        67.8
##  9 1957  Europe           48.1         66.7        73.5
## 10 1957  Oceania          70.3         70.3        70.3
## # ... with 50 more rows
```

**5. How has life expectancy changed between 1952-2007 for each continent?**

```r
gapminder %>% 
  group_by(year, continent) %>% 
  summarize(avg_life_expectancy=mean(lifeExp)) %>% 
  ggplot(aes(x=year, y=avg_life_expectancy, group=continent, color=continent))+
  geom_line()+
  labs(title="Life Expectancy through the Years by Country",
       x="Year", y="Life Expectancy")
```

```
## `summarise()` has grouped output by 'year'. You can override using the `.groups` argument.
```

![](lab11_hw_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

**6. We are interested in the relationship between per capita GDP and life expectancy; i.e. does having more money help you live longer?**

```r
gapminder %>% 
  ggplot(aes(x=gdpPercap, y=lifeExp, fill=continent, color=continent))+
  geom_point()+
  labs(title="GDP per capita vs. Life Expectancy",
       x="GDP per capita", y="Life Expectancy")
```

![](lab11_hw_files/figure-html/unnamed-chunk-13-1.png)<!-- -->


**7. Which countries have had the largest population growth since 1952?**

```r
gap_wide <- gapminder %>% 
  select(country, year, pop) %>%
  filter(year=="1952" | year=="2007") %>% 
  pivot_wider(names_from = year,
              names_prefix = "year_",
              values_from = pop) 
gap_wide
```

```
## # A tibble: 142 x 3
##    country     year_1952 year_2007
##    <fct>           <int>     <int>
##  1 Afghanistan   8425333  31889923
##  2 Albania       1282697   3600523
##  3 Algeria       9279525  33333216
##  4 Angola        4232095  12420476
##  5 Argentina    17876956  40301927
##  6 Australia     8691212  20434176
##  7 Austria       6927772   8199783
##  8 Bahrain        120447    708573
##  9 Bangladesh   46886859 150448339
## 10 Belgium       8730405  10392226
## # ... with 132 more rows
```

```r
gap_wide %>% 
  mutate(pop_growth= year_2007-year_1952) %>% 
  arrange(desc(pop_growth))
```

```
## # A tibble: 142 x 4
##    country       year_1952  year_2007 pop_growth
##    <fct>             <int>      <int>      <int>
##  1 China         556263527 1318683096  762419569
##  2 India         372000000 1110396331  738396331
##  3 United States 157553000  301139947  143586947
##  4 Indonesia      82052000  223547000  141495000
##  5 Brazil         56602560  190010647  133408087
##  6 Pakistan       41346560  169270617  127924057
##  7 Bangladesh     46886859  150448339  103561480
##  8 Nigeria        33119096  135031164  101912068
##  9 Mexico         30144317  108700891   78556574
## 10 Philippines    22438691   91077287   68638596
## # ... with 132 more rows
```
##### CHina has the biggest population growth, followed by India, the US, Indonesia, and Brazil.

**8. Use your results from the question above to plot population growth for the top five countries since 1952.**

```r
gapminder %>% 
  filter(country=="China"|country=="India"| country=="United States"| country=="Indonesia"| country=="Brazil") %>% 
  ggplot(aes(x=year, y=pop, group=country, color=country))+
  geom_line()+
  labs(title="Population Growth by Country",
       x="Year", y="Population")
```

![](lab11_hw_files/figure-html/unnamed-chunk-16-1.png)<!-- -->

**9. How does per-capita GDP growth compare between these same five countries?**

```r
gapminder %>% 
  filter(country=="China"|country=="India"| country=="United States"| country=="Indonesia"| country=="Brazil") %>% 
  ggplot(aes(x=year, y=gdpPercap, group=country, color=country))+
  geom_line()+
  labs(title="Per-capita GDP Growth by Country",
       x="Year", y="GDP per capita")
```

![](lab11_hw_files/figure-html/unnamed-chunk-17-1.png)<!-- -->

**10. Make one plot of your choice that uses faceting!**

```r
gapminder %>% 
  filter(country=="China"|country=="India"| country=="United States"| country=="Indonesia"| country=="Brazil") %>%
  ggplot(aes(x=lifeExp))+
  geom_density(alpha=0.5)+
  scale_fill_brewer(palette = "Accent")+
  labs(title="Life Expectancy Distribution for the Countries with the Highest Population Growth",
       x="Life Expectancy")+
  facet_grid(~country)
```

![](lab11_hw_files/figure-html/unnamed-chunk-18-1.png)<!-- -->

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences. 
