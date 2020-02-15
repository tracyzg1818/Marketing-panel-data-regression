xtset province month
xtdes
xtsum
rename name provincename
xtsum
xtline sales
reg sales roadshow,vce(cluster province)
reg sales roadshow
rename month t
label variable t "counted by month"
reg sales roadshow i.province t,vce(cluster province)
estimates store OLS
xtpcse sales roadshow i.province t
estimates store PCSE
xtpcse sales roadshow i.province t,corr(ar1)
estimates store AR1
xtpcse sales roadshow i.province t,corr(psar1)
estimates store PSAR1
esttab OLS PCSE AR1 PSAR1,r2 se mtitles star(* 0.1 ** 0.05 *** 0.01)
xtgls sales roadshow i.province t,panels(cor)cor(ar1)
xtgls sales roadshow i.province t,panels(cor)cor(psar1)
ssc install xttest3
quietly xtreg sales roadshow i.province t,r fe
xttest3
quietly xtgls sales roadshow i.province t
xttest3
net install st0039
tab province,gen(province)
xtserial sales roadshow province2-province10 t
ssc install xttest2
quietly xtreg sales roadshow t,fe
xttest2
ssc install xtcsd
quietly xtreg sales roadshow t,fe
xtcsd,pes
xtcsd,fri
xtcsd,fre abs show
reg sales roadshow i.province i.province#c.roadshow t,vce(cluster province)
reg sales roadshow i.province i.province#roadshow t,vce(cluster province)
xtrc sales roadshow, betas
xtrc sales roadshow,beta
xtline sales roadshow
gen ifroadshow=roadshow*2500
xtline sales ifroadshow
graph export "F:\实习\麦肯锡学长\Trends of sales&roadshow.pgn.png", as(png) replace
graph export "F:\实习\麦肯锡学长\Trends of sales&roadshow.pgn.png", as(png) replace
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
save "F:\实习\麦肯锡学长\roadshow.dta", replace
