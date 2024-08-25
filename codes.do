
import excel "C:\Users\HP\Downloads\ECO342A_project_data.xlsx", sheet("Sheet1") firstrow

* first normalise the variables *

gen logY = log(trade_ijt/1000)
gen logX1 = log(gdp_it/100000000000)
gen logX2 = log(gdp_jt/100000000000)
gen logX3 = log(dis_ij/1000)
gen logX4 = log(pop_it/1000000000)
gen logX5 = log(pop_jt/1000000000)
gen logX6 = log(rex_it/100)
gen logX7 = log(rex_jt/100)
gen logX8 = log(mtr_ij)
gen X9 = Diaspora
gen X10 = TradeAffinity
gen X11 = log(infr_it1to5)
gen X12 = log(infr_jt1to5)
gen X14 = log(ins_itscaled)
gen X16 = log(ins_jtscaled)
gen X18 = ta_ijFTA
gen X20 = COMCOL



* define panel data *

xtset id Year

* run panel sfa *

sfpanel logY logX1 logX2 logX3 logX4 logX5 logX6 logX7 logX8 X9 X10 X11 X12 X14 X16  X18  X20 Year,
model(tfe) distribution(tn) efficiency(eta_ij)

* run random effect GLS regression *

xtreg logY logX1 logX2 logX3 logX4 logX5 logX6 logX7 logX8 X9 X10 X11 X12 X14 X16  X18  X20 Year, re i(id)

* calculate technical efficiency *

predict eff, u
sort eff
predict effi, te
egen fegrp = cut(effi), at(0, .3, .6, .9, 1)
tab fegrp

*Technical Efficiency Table *

list id Year eff effi te in 1/10

