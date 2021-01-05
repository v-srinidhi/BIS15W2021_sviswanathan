---
title: "RMarkdown Practice"
output: 
  html_document: 
    keep_md: yes
---



# This is my title.
## **This is my first Markdown file**
### _This is my first Markdown file_


```r
4*2
```

```
## [1] 8
```

## This is [Google](http://www.google.com)


```r
3*3
```

```
## [1] 9
```

```r
median(3,4,6,7,4,5)
```

```
## [1] 3
```

```r
2-6
```

```
## [1] -4
```

```r
3/2
```

```
## [1] 1.5
```

```r
1+1
```

```
## [1] 2
```

```r
#install.packages("tidyverse")
library("tidyverse")
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
```

```
## ✓ ggplot2 3.3.3     ✓ purrr   0.3.4
## ✓ tibble  3.0.4     ✓ dplyr   1.0.2
## ✓ tidyr   1.1.2     ✓ stringr 1.4.0
## ✓ readr   1.4.0     ✓ forcats 0.5.0
```

```
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```


```r
ggplot(mtcars, aes(x = factor(cyl))) +
    geom_bar()
```

![](RMarkdown-Practice_files/figure-html/unnamed-chunk-4-1.png)<!-- -->
