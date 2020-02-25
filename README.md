# Marketing-panel-data-regression
The project developed various panel data regression models including cluster OLS, PSAR(1), AR(1) to quantify the effect of roadshow strategy on sales volume.

## Technology
The project is created with:
* Stata version: 14

## Table of Contents
* Dataset Overview
* Conclusions
* Assumptions & Models
* Assumption Illustration & Test
* Model Comparison & Results

## Dataset Overview
We learn from the graph that roadshow seems to increase sales instantly and the effect lasts in the following months. The increase volumne, average sales level and volatility of sales differ in different regions. 
<p align="center">
  <img src="https://github.com/tracyzg1818/Marketing-panel-data-regression/blob/master/images/roadshow_sales%20volume%20trends.png?raw=true" alt="roadshow_sales volume trends"/>
</p>

More specifically, we find that:
* Increase of sales by one roadshow is higher in first-tier region and lower in inland provinces.
* Average sales are higher in first-tier region and lower in inland provinces.
* Fluctuation of sales is greater in first-tier region and smoother in inland provinces.

## Conclusions
* The increase of sales by a roadshow is statistically significant, though the increment quantity differs in different models.
* Our best models, AR(1) and PSAR(1) estimate the increase of sales by a roadshow to be 670 - 948.
* The effect of a roadshow lasts for 5 months.

*Note: We measure the last of roadshow effect in this way: Roadshows of previous 1 month, 2 months, 3 months and 4 months have significant influence on sales but roadshows of previous 5 months do not, so the effect lasts for 5 months.*

We show the increase of sales by 1 roadshow in different models. The models here assume roadshow has the same effect on each province, e.g, 1 roadshow in Guangdong increases same amount of sales as in Hunan. We'll discuss about the validity of these assumptions later.

<p align="center">
  <img src="https://github.com/tracyzg1818/Marketing-panel-data-regression/blob/master/images/increment%20of%20sales%20by%20roadshow_all%20provinces%20equal.png?raw=true" alt="results by model"/>
</p>

Below, we show the increase of sales by 1 roadshow in different provinces. The models here assume roadshows affects provinces differently. For instance, in Sichuan, 1 roadshow increases sales by 388 * 4 - 645 = 907 > 0.

<p align="center">
  <img src="https://github.com/tracyzg1818/Marketing-panel-data-regression/blob/master/images/increment%20of%20sales%20by%20roadshow_provinces%20differ.png?raw=true" alt="results by province"/>
</p>

## Assumptions and Models 
#### Assumptions
For panel data models, it's most common to consider the following 5 effects. Whether these effects exist determines the validility of models because models are based on different assumptions of these effects.
* Same or different province sales regardless of roadshow: Different province effect
* Same or different effect of roadshow in provinces: Different roadshow effect
* <b>Groupwise heteroskedasticity</b>: Different variations among provinces
* <b>Autocorrelation within each group</b>: Serial correlation within a province
* <b>Groupwise contemporaneous correlation</b>: Cross province dependence

#### Models
We try the following nine panel data models and list their main assumptions out here.
* <b>OLS</b>: only considers same effect of roadshows on sales in each province
* <b>Clustering OLS</b>: only considers different effect of roadshows on sales in each province
* Panel-Corrected Standard Error (<b>PCSE</b>): only considers groupwise heteroskedasticity and groupwise contemporaneous correlation
* Feasible Generalized Least Lquares <b>AR(1)</b> (Autoregressive Process): only considers same autocorrelation within each group
* Feasible Generalized Least Lquares <b>PSAR(1)</b> (Panel-Specific Autoregressive Process): only considers different autocorrelation within each group
* Feasible Generalized Least Lquares (<b>FGLS same beta</b>): considers groupwise heteroskedasticity, groupwise contemporaneous correlation and same autocorrelation within each group
* Feasible Generalized Least Lquares (<b>FGLS different beta</b>): considers groupwise heteroskedasticity, groupwise contemporaneous correlation and different autocorrelation within each group
* <b>Varying Coefficients - constant</b>: different but constant coefficients for each province
* <b>Varying Coefficients - random variable</b>: different coefficients for each province and view coefficients as random variables

## Assumption Illustration & Test
#### Illustration
We give simple and clear examples of the five effects we need to consider. After interpreting these effects, we think all the effects except for the different roadshow effect exist.

<p align="center">
  <img src="https://github.com/tracyzg1818/Marketing-panel-data-regression/blob/master/images/effects%20explaination.png?raw=true" alt="assumptions illustration"/>
</p>

#### Test
* We verify the existence of Groupwise heteroskedasticity by Greene-Wald test
* We verify the existence of Autocorrelation within each group by Wooldridge-Wald test
* We verify the existence of Groupwise contemporaneous correlation by Greene: Breusch-Pagan LM test
Test codes are listed in the report. 

## Model Comparison & Results
Based on the test and our analysis, we think AR(1) and PSAR(1) are the best models because they consider all the three effects that are proved to exist in the model and consider different province effect. Assuming the roadshow effect on each province is the same (which should be a reasonable assumption), AR(1) and PSAR(1) estimate the increase of sales by a roadshow to be 670 - 948. Here're the assumptions and results of five regression models.

<p align="center">
  <img src="https://github.com/tracyzg1818/Marketing-panel-data-regression/blob/master/images/model%20assumptions%20&%20results.png?raw=true" alt="model comparison & results"/>
</p>

*Note: Tick represents the model considers the effect , ‘—’ represents the model does not. The numbers of the last column indicates the increase of sales in present month by 1 roadshow in this month (e.g 381) and by 1 roadshow in previous 4 months(e.g 1073).
Total increase of sales by 1 roadshow : PSAR(1): 62 + 152 * 4 = 670, AR(1): 96 + 213 * 4 = 948*
