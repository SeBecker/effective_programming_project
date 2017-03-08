
// Read in the model controls
include project_paths
log using `"${PATH_OUT_ANALYSIS}/log/`1'.log"', replace

do `"${PATH_OUT_MODEL_SPECS}/`2'"'



ssc install xtabond2, replace



use `"${PATH_OUT_DATA}//5_year_panel_all"', clear

// Table 2 column 1 Pooled OLS with 5-year data


reg ${DEPVAR} L.(${DEPVAR}) L.(${INDEP1}) yr* if ${SAMPLE}==1, cluster(code)

sca def NC= `e(N_clust)'
sca def N = `e(N)'

testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0
sca def p = `r(p)'

mat ${DEPVAR}_pool = [_b[L1.${DEPVAR}]\ _se[L.${DEPVAR}]\ _b[L1.${INDEP1}] \ _se[L1.${INDEP1}]\ . \ . \(_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ p  \ N  \ NC \ e(r2) ]

// Table 2 column 2 Fixed effects OLS with 5-year data


reg ${DEPVAR} L.(${DEPVAR}) L.(${INDEP1}) yr* cd* if ${SAMPLE}==1, cluster(code)

sca def NC = `e(N_clust)'
sca def N = `e(N)'

testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0
sca def p = `r(p)'

mat ${DEPVAR}_fixed1 = [_b[L1.${DEPVAR}]\ _se[L.${DEPVAR}]\ _b[L1.${INDEP1}] \ _se[L1.${INDEP1}]\ . \ . \(_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ p  \ N \ NC \ e(r2) ]

// Table 2 column 3 Anderson-Hsiao IV with 5-year data


ivreg D.${DEPVAR} yr* (LD.(${DEPVAR} ${INDEP1})= L2.(${DEPVAR} ${INDEP1})) if sample==1, cluster(code)

sca def NC = `e(N_clust)'
sca def N = `e(N)'

testnl (_b[LD.${INDEP1}]/(1 - _b[LD.${DEPVAR}])) = 0
sca def p = `r(p)'

mat ${DEPVAR}_AndHsiaoIV = [_b[LD.${DEPVAR}]\ _se[LD.${DEPVAR}]\ _b[LD.${INDEP1}] \ _se[LD.${INDEP1}]\ . \ . \(_b[LD.${INDEP1}]/(1 - _b[LD.${DEPVAR}])) \ p  \ N \ NC \ .]


// Table 2 column 4 Arellano Bond GMM with 5-year data


xtabond2 ${DEPVAR} L.(${DEPVAR} ${INDEP1}) yr* if sample==1, gmm(L.(${DEPVAR})) iv( yr*) iv(L2.${INDEP1}, passthru) noleveleq robust

sca def N = `e(N)'
sca def ar = `e(ar2p)'
sca def hj = `e(hansenp)'

testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0
sca def p = `r(p)'

mat ${DEPVAR}_GMMIV = [_b[L1.${DEPVAR}]\ _se[L.${DEPVAR}]\ _b[L1.${INDEP1}] \ _se[L1.${INDEP1}]\ hj \ ar \(_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ p  \ N \ . \ .]

// Table 2 column 5 Fixed effects OLS without lagged democracy with 5-year data


reg ${DEPVAR} L.(${INDEP1}) yr* cd* if ${SAMPLE}==1, cluster(code)

sca def NC = `e(N_clust)'
sca def N = `e(N)'

mat ${DEPVAR}_fixed2 = [ .\ .\ _b[L1.${INDEP1}] \ _se[L1.${INDEP1}]\ . \ . \ . \ . \ N \ NC \ e(r2) ]

use `"${PATH_OUT_DATA}//annual_panel_all"', clear

// Table 2 column 6 Fixed effects OLS with annual panel


reg ${DEPVAR} L(1/5).(${DEPVAR} ${INDEP1}) yr* cd* if sample==1, cluster(code)

test L1.${DEPVAR} L2.${DEPVAR} L3.${DEPVAR} L4.${DEPVAR} L5.${DEPVAR}
sca def F1 = `r(p)'


test L1.${INDEP1} L2.${INDEP1} L3.${INDEP1} L4.${INDEP1} L5.${INDEP1}
sca def F2 = `r(p)'

sca def NC = `e(N_clust)'
sca def N = `e(N)'

mat ${DEPVAR}_fixedannual = [ F1 \ . \ F2 \ . \ . \ . \ . \ . \ N \ NC \ e(r2) ]

use `"${PATH_OUT_DATA}//10_year_panel_all"', clear

// Table 2 column 7 Fixed effects OLS with 10-year panel


reg ${DEPVAR} L.(${DEPVAR}) L.(${INDEP1}) yr* cd* if ${SAMPLE}==1, cluster(code)

sca def NC = `e(N_clust)'
sca def N = `e(N)'

mat ${DEPVAR}_fixed10 = [_b[L1.${DEPVAR}]\ _se[L.${DEPVAR}]\ _b[L1.${INDEP1}] \ _se[L1.${INDEP1}]\ . \ . \ . \ .  \ N \ NC \ e(r2) ]


// Table 2 column 8 Arellano-Bond GMM with 10-year panel


xtabond2 ${DEPVAR} L.(${DEPVAR} ${INDEP1}) yr* if sample==1, gmm(L.(${DEPVAR})) iv( yr*) iv(L2.${INDEP1}, passthru) noleveleq robust

sca def N = `e(N)'
sca def ar = `e(ar2p)'
sca def hj =`e(hansenp)'

testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0
sca def p = `r(p)'

mat ${DEPVAR}_GMMIV10 = [_b[L1.${DEPVAR}]\ _se[L.${DEPVAR}]\ _b[L1.${INDEP1}] \ _se[L1.${INDEP1}]\ ar \ hj \(_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ p  \ N \ . \ . ]

use `"${PATH_OUT_DATA}//20_year_panel_all"', clear


// Table 2 column 9 Fixed effects OLS with 20-year panel


reg ${DEPVAR} L.(${DEPVAR}) L.(${INDEP1}) yr* cd* if ${SAMPLE}==1, cluster(code)

sca def NC = `e(N_clust)'
sca def N = `e(N)'

testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0
sca def p = `r(p)'

mat ${DEPVAR}_fixed20 = [_b[L1.${DEPVAR}]\ _se[L.${DEPVAR}]\ _b[L1.${INDEP1}] \ _se[L1.${INDEP1}]\ . \ . \(_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ p  \ N \ NC \ e(r2) ]



mat `2' =[${DEPVAR}_pool, ${DEPVAR}_fixed1, ${DEPVAR}_AndHsiaoIV, ${DEPVAR}_GMMIV, ${DEPVAR}_fixed2, ${DEPVAR}_fixedannual, ${DEPVAR}_fixed10, ${DEPVAR}_GMMIV10, ${DEPVAR}_fixed20 ]

svmat `2', names(`2'_)
format `2'_1 `2'_2 `2'_3 `2'_4 `2'_5 `2'_6 `2'_7 `2'_8 `2'_9 %05.2f
gen id = _n
sort id
drop if id>11
gen str `2'_colstring = "Democracy t-1" if id==1
replace `2'_colstring = "SE Democracy t-1" if id==2
replace `2'_colstring = "Log GDP per capita t-1" if id==3
replace `2'_colstring = "SE Log GDP per capita t-1" if id==4
replace `2'_colstring = "Hansen J test" if id==5
replace `2'_colstring = "AR(2) test" if id==6
replace `2'_colstring = "Implied cumultative \\ effect of income" if id==7
replace `2'_colstring = "" if id==8
replace `2'_colstring = "Observations" if id==9
replace `2'_colstring = "Countries" if id==10
replace `2'_colstring = "R squared" if id==11

keep `2'_colstring `2'_1 `2'_2 `2'_3 `2'_4 `2'_5 `2'_6 `2'_7 `2'_8 `2'_9


save `"${PATH_OUT_ANALYSIS}/`2'_estimation_results"', replace







save `"${PATH_OUT_ANALYSIS}/`2'_regression"', replace




log close

