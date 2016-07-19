The 'SIOPE' database
========================================================
author: Pietro D'Ambrosio
date: July 18, 2016
autosize: true

The SIOPE Project
========================================================

'SIOPE' is an Information System that collect all economical and financial operations of Italian public offices.

The SIOPE system is managed by the Bank of Italy, Istat and Italian General Accounting Office and is an electronic detection system of receipts and payments made by local government offices.

In this application we show you some SIOPE data on the cash availability of italian municipalities, grouped by region.



The Data used
========================================================
the data have been previous extracted from Siope's monthly Reports and collected in a csv file called "cashdata".

```r
cashdata <- read.csv("../shinyapp/data/SIOPE_cassa.csv")
nrow(cashdata); names(cashdata)
```

```
[1] 19242
```

```
[1] "Area" "Cod"  "Ind"  "Anno" "Mese" "Val" 
```

The APP Outputs
========================================================

The APP shows the trends of 4 accounting voices (in a variable period) for each italian region.
The plots shows the decompose time series (with monthly frequency).

A second page shows the current cash value of Italy municipalities and a choropleth map of regions.


Insights
========================================================

Here you can found the app DEMO: https://pdambrosio.shinyapps.io/shinyapp/

And here i published the source files: https://github.com/pietrodambrosio/DevelopingDataProducts

Enjoy !
