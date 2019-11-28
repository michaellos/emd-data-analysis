---
title: "Analiza danych: śledzie"
author: "Michał Kałczyński i Patryk Szczuczko"
date: "28 listopad, 2019"
output: 
 html_document:
    keep_md: true
    self_contained: true
    toc: true
    theme: united
---

## Wykorzystane biblioteki

```r
library(knitr)
library(dplyr)
```

## Wczytywanie danych

```r
df <- read.csv('data/sledzie.csv')
```

## Exploratory data analysis
### Struktura danych i podstawowe statystyki
Zbiór danych śledzie zawiera 52582 wierszy i 16 kolumn

```r
dim(df)
```

```
## [1] 52582    16
```

<p>Kolejne kolumny w zbiorze danych to:</p>
<ul>
<li><strong>X</strong>: numer porządkowy</li>
<li><strong><span style="color:#ce4844">length</span></strong>: długość złowionego śledzia [cm];</li>
<li><strong>cfin1</strong>: dostępność planktonu [zagęszczenie <em>Calanus finmarchicus</em> gat. 1];</li>
<li><strong>cfin2</strong>: dostępność planktonu [zagęszczenie <em>Calanus finmarchicus</em> gat. 2];</li>
<li><strong>chel1</strong>: dostępność planktonu [zagęszczenie <em>Calanus helgolandicus</em> gat. 1];</li>
<li><strong>chel2</strong>: dostępność planktonu [zagęszczenie <em>Calanus helgolandicus</em> gat. 2];</li>
<li><strong>lcop1</strong>: dostępność planktonu [zagęszczenie widłonogów gat. 1];</li>
<li><strong>lcop2</strong>: dostępność planktonu [zagęszczenie widłonogów gat. 2];</li>
<li><strong>fbar</strong>: natężenie połowów w regionie [ułamek pozostawionego narybku];</li>
<li><strong>recr</strong>: roczny narybek [liczba śledzi];</li>
<li><strong>cumf</strong>: łączne roczne natężenie połowów w regionie [ułamek pozostawionego narybku];</li>
<li><strong>totaln</strong>: łączna liczba ryb złowionych w ramach połowu [liczba śledzi];</li>
<li><strong>sst</strong>: temperatura przy powierzchni wody [°C];<br />
</li>
<li><strong>sal</strong>: poziom zasolenia wody [Knudsen ppt];</li>
<li><strong>xmonth</strong>: miesiąc połowu [numer miesiąca];</li>
<li><strong>nao</strong>: oscylacja północnoatlantycka [mb].</li>
</ul>

Wyświetlmy kilka pierwszych wierszy ze zbioru:

```r
head(df)
```

```
##   X length   cfin1   cfin2   chel1    chel2   lcop1    lcop2  fbar   recr
## 1 0   23.0 0.02778 0.27785 2.46875        ? 2.54787 26.35881 0.356 482831
## 2 1   22.5 0.02778 0.27785 2.46875 21.43548 2.54787 26.35881 0.356 482831
## 3 2   25.0 0.02778 0.27785 2.46875 21.43548 2.54787 26.35881 0.356 482831
## 4 3   25.5 0.02778 0.27785 2.46875 21.43548 2.54787 26.35881 0.356 482831
## 5 4   24.0 0.02778 0.27785 2.46875 21.43548 2.54787 26.35881 0.356 482831
## 6 5   22.0 0.02778 0.27785 2.46875 21.43548 2.54787        ? 0.356 482831
##        cumf   totaln           sst      sal xmonth nao
## 1 0.3059879 267380.8 14.3069330186 35.51234      7 2.8
## 2 0.3059879 267380.8 14.3069330186 35.51234      7 2.8
## 3 0.3059879 267380.8 14.3069330186 35.51234      7 2.8
## 4 0.3059879 267380.8 14.3069330186 35.51234      7 2.8
## 5 0.3059879 267380.8 14.3069330186 35.51234      7 2.8
## 6 0.3059879 267380.8 14.3069330186 35.51234      7 2.8
```

Już w pierwszej obserwacji możemy znaleźć zastanawiającą wartość w kolumnie chel2 - znak zapytania. Najprawdopodobniej tak musiała być oznaczana wartość brakująca (??)

W zbiorze danych możemy zauważyć kilka kolumn oznaczonych jako dane kategoryczne (typ danych Factor). Co ciekawe kolummny te dotyczą dostępności planktonu oraz temperatury wody przy powierzchni, które wydawać by się mogło powinny być wyrażone poprzez liczby, jako dane ilościowe.


```r
str(df)
```

```
## 'data.frame':	52582 obs. of  16 variables:
##  $ X     : int  0 1 2 3 4 5 6 7 8 9 ...
##  $ length: num  23 22.5 25 25.5 24 22 24 23.5 22.5 22.5 ...
##  $ cfin1 : Factor w/ 40 levels "?","0","0.01",..: 5 5 5 5 5 5 5 5 5 5 ...
##  $ cfin2 : Factor w/ 49 levels "?","0","0.01",..: 14 14 14 14 14 14 14 14 14 14 ...
##  $ chel1 : Factor w/ 49 levels "?","0","0.2287",..: 20 20 20 20 20 20 20 20 20 20 ...
##  $ chel2 : Factor w/ 52 levels "?","10.10963",..: 1 23 23 23 23 23 23 23 23 23 ...
##  $ lcop1 : Factor w/ 49 levels "?","0.30741",..: 20 20 20 20 20 20 20 20 20 20 ...
##  $ lcop2 : Factor w/ 52 levels "?","10.72889",..: 23 23 23 23 23 1 23 23 23 23 ...
##  $ fbar  : num  0.356 0.356 0.356 0.356 0.356 0.356 0.356 0.356 0.356 0.356 ...
##  $ recr  : int  482831 482831 482831 482831 482831 482831 482831 482831 482831 482831 ...
##  $ cumf  : num  0.306 0.306 0.306 0.306 0.306 ...
##  $ totaln: num  267381 267381 267381 267381 267381 ...
##  $ sst   : Factor w/ 52 levels "?","12.7690663857",..: 38 38 38 38 38 38 38 38 38 38 ...
##  $ sal   : num  35.5 35.5 35.5 35.5 35.5 ...
##  $ xmonth: int  7 7 7 7 7 7 7 7 7 7 ...
##  $ nao   : num  2.8 2.8 2.8 2.8 2.8 2.8 2.8 2.8 2.8 2.8 ...
```

ToDo: zamienić dane kategoryczne na ilościowe (?)

Obserowane długości śledzi są pomiędzy 19cm a 32.5cm. -> Szczegółowa analiza wartości atrybutów?

```r
summary(df)
```

```
##        X             length         cfin1           cfin2      
##  Min.   :    0   Min.   :19.0   0      :14287   0.70118: 4374  
##  1st Qu.:13145   1st Qu.:24.0   0.02778: 2225   0      : 3806  
##  Median :26291   Median :25.5   1.02508: 2067   0.296  : 3706  
##  Mean   :26291   Mean   :25.3   1.21333: 1985   0.11736: 2106  
##  3rd Qu.:39436   3rd Qu.:26.5   0.33333: 1914   4.55825: 2007  
##  Max.   :52581   Max.   :32.5   0.11111: 1891   0.85684: 1665  
##                                 (Other):28213   (Other):34918  
##       chel1            chel2            lcop1            lcop2      
##  11.5    : 4787   5.67765 : 4365   23      : 4787   9.17171 : 4370  
##  2.46875 : 2241   21.67333: 3710   2.54787 : 2215   24.85867: 3709  
##  12.15192: 2109   39.56809: 2101   12.49588: 2105   41.65566: 2102  
##  6.42127 : 2062   26.81218: 2002   10.92857: 2059   45.70773: 1998  
##  19.15475: 2001   15.03   : 1941   21.23147: 1979   17.68   : 1959  
##  9.66667 : 1926   9.43208 : 1661   27.33333: 1916   10.72889: 1676  
##  (Other) :37456   (Other) :36802   (Other) :37521   (Other) :36768  
##       fbar             recr              cumf             totaln       
##  Min.   :0.0680   Min.   : 140515   Min.   :0.06833   Min.   : 144137  
##  1st Qu.:0.2270   1st Qu.: 360061   1st Qu.:0.14809   1st Qu.: 306068  
##  Median :0.3320   Median : 421391   Median :0.23191   Median : 539558  
##  Mean   :0.3304   Mean   : 520367   Mean   :0.22981   Mean   : 514973  
##  3rd Qu.:0.4560   3rd Qu.: 724151   3rd Qu.:0.29803   3rd Qu.: 730351  
##  Max.   :0.8490   Max.   :1565890   Max.   :0.39801   Max.   :1015595  
##                                                                        
##             sst             sal            xmonth            nao          
##  13.6315997001: 4359   Min.   :35.40   Min.   : 1.000   Min.   :-4.89000  
##  14.0693330238: 3700   1st Qu.:35.51   1st Qu.: 5.000   1st Qu.:-1.89000  
##  14.4415996823: 2080   Median :35.51   Median : 8.000   Median : 0.20000  
##  13.5598663683: 2010   Mean   :35.51   Mean   : 7.258   Mean   :-0.09236  
##  13.694933032 : 1950   3rd Qu.:35.52   3rd Qu.: 9.000   3rd Qu.: 1.63000  
##  13.861999695 : 1673   Max.   :35.61   Max.   :12.000   Max.   : 5.08000  
##  (Other)      :36810
```
### Brakujące wartości
### Szczegółowa analiza wartości atrybutów
