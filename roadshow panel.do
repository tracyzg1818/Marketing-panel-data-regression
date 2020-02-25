* set panel data: time label (month)
* rename province names
xtset province month
xtdes
rename name provincename

* descriptive analysis of all the variables
xtsum

* plot trends of sales and the number of roadshow and save the graph
xtline sales
xtline sales roadshow
gen ifroadshow=roadshow*2500
xtline sales ifroadshow
graph export "F:\Internship\Trends of sales&roadshow.pgn.png", as(png) replace

* OLS & cluster OLS regression
reg sales roadshow
reg sales roadshow,vce(cluster province)
rename month t
label variable t "counted by month"

* cluster OLS that considers province individual difference
reg sales roadshow i.province t,vce(cluster province)
estimates store OLS

* Panel-Corrected Standard Error regression that considers 
* groupwise heteroskedasticity and contemporaneous correlation
xtpcse sales roadshow i.province t
estimates store PCSE

* Feasible Generalized Least Square that only considers 
* AR(1) autoregressive process
* each province has the same autocorrelation beta in the error term
xtpcse sales roadshow i.province t,corr(ar1)
estimates store AR1

* Feasible Generalized Least Square that only considers 
* panel-specific AR(1) autoregressive process
* each province has different autocorrelation beta in the error term
xtpcse sales roadshow i.province t,corr(psar1)
estimates store PSAR1
esttab OLS PCSE AR1 PSAR1,r2 se mtitles star(* 0.1 ** 0.05 *** 0.01)

* feasible generalized least squares that considers groupwise
* heteroskedasticity, groupwise contemporaneous correlation
* and AR(1)/PSAR(1) autoregressive process (same and different beta)
xtgls sales roadshow i.province t,panels(cor)cor(ar1)
xtgls sales roadshow i.province t,panels(cor)cor(psar1)

* install xttest3 command to test if there's groupwise heteroskedasticity
ssc install xttest3
quietly xtreg sales roadshow i.province t,r fe
xttest3
quietly xtgls sales roadshow i.province t
xttest3

* install st0039 to test autocorrelation in panel data
net install st0039
tab province,gen(province)
xtserial sales roadshow province2-province10 t

* install xttest2 to test groupwise contemporaneous correlation
ssc install xttest2
quietly xtreg sales roadshow t,fe
xttest2

* install xtcsd to test groupwise contemporaneous correlation
* for short panel data (T<n)
ssc install xtcsd
quietly xtreg sales roadshow t,fe
xtcsd,pes
xtcsd,fri
xtcsd,fre abs show

* different coefficients for each province 
* (coefficients are constant)
reg sales roadshow i.province i.province#c.roadshow t,vce(cluster province)
reg sales roadshow i.province i.province#roadshow t,vce(cluster province)

* different coefficients for each province
* (coefficients are random variables)
xtrc sales roadshow, betas
xtrc sales roadshow,beta


* export regression results of different models
reg sales roadshow i.province t,vce(cluster province)
outreg2 using olsjulei.doc
xtgls sales roadshow i.province t,panels(cor)cor(psar1)
outreg2 using psar.doc
xtgls sales roadshow i.province t,panels(cor)cor(psar1)
estimates store FGLS(PSAR1)
estimates store FGLS_PSAR1
xtgls sales roadshow i.province t,panels(cor)cor(ar1)
estimates store FGLS_AR1
esttab FGLS_AR1 FGLS_PSAR1,r2 se mtitles star(* 0.1 ** 0.05 *** 0.01)
xtrc sales roadshow t, betas
estimates store VC
esttab VC,r2 se mtitles star(* 0.1 ** 0.05 *** 0.01)
save "F:\Internship\roadshow.dta", replace
