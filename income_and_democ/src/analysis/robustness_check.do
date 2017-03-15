// Read in the model controls
include project_paths
log using `"${PATH_OUT_ANALYSIS}/log/`1'.log"', replace


do `"${PATH_OUT_MODEL_SPECS}/`2'"'

use `"${PATH_OUT_DATA}//5_year_panel_all"', clear

//le 4 column 1 Fixed effects OLS with Balanced Panel


reg ${DEPVAR} L.(${DEPVAR} ${INDEP1}) yr* cd* if ${SAMPLEBALFE}==1, cluster(code)

sca def NC= `e(N_clust)'
sca def N = `e(N)'

testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0
sca def p = `r(p)'

mat bal_fe_${DEPVAR} = [_b[L1.${DEPVAR}]\ _se[L1.${DEPVAR}] \ _b[L1.${INDEP1}]\ _se[L1.${INDEP1}] \ . \ . \ . \ . \ . \ . \ . \ (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ p \ N \ NC \ e(r2) ]


//le 4 column 2 Arellano Bond GMM with Balanced Panel


drop if year<1960
xtabond2 ${DEPVAR} L.(${DEPVAR} ${INDEP1}) yr* if ${SAMPLEBALGMM}==1, gmm(L.${DEPVAR}) iv( yr*) iv(L2.${INDEP1}, passthru) noleveleq robust

sca def N = `e(N)'
sca def ar = `e(ar2p)'
sca def hj = `e(hansenp)'

testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0
sca def p = `r(p)'

mat bal_gmm_${DEPVAR} = [_b[L1.${DEPVAR}]\ _se[L1.${DEPVAR}] \ _b[L1.${INDEP1}]\ _se[L1.${INDEP1}] \ . \ . \ . \ . \ . \ hj \ ar \ (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ p \ N \ . \ .]


//le 4 column 3 Fixed effects OLS with Base Sample without former socialist countries

use `"${PATH_OUT_DATA}//5_year_panel_all"', clear

reg ${DEPVAR} L.(${DEPVAR} ${INDEP1}) yr* cd* if ${SAMPLE}==1&${SOCIAL}~=1, cluster(code)

sca def NC= `e(N_clust)'
sca def N = `e(N)'

testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0
sca def p = `r(p)'

mat base_fews_${DEPVAR} = [_b[L1.${DEPVAR}]\ _se[L1.${DEPVAR}] \ _b[L1.${INDEP1}]\ _se[L1.${INDEP1}] \ . \ . \ . \ . \ . \ . \ . \ (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ p \ N \ NC \ e(r2)]


//le 4 column 4 Arellano Bond GMM with Base Sample without former socialist countries


xtabond2 ${DEPVAR} L.(${DEPVAR} ${INDEP1}) yr* if ${SAMPLE}==1&${SOCIAL}~=1, gmm(L.(${DEPVAR})) iv( yr*) iv(L2.${INDEP1}, passthru) noleveleq robust

sca def N = `e(N)'
sca def ar = `e(ar2p)'
sca def hj = `e(hansenp)'

testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0
sca def p = `r(p)'

mat base_gmmws_${DEPVAR} = [_b[L1.${DEPVAR}]\ _se[L1.${DEPVAR}] \ _b[L1.${INDEP1}]\ _se[L1.${INDEP1}] \ . \ . \ . \ . \ . \ hj \ ar \ (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ p \ N \ . \ .]


//le 4 column 5 Fixed effects OLS with Base Sample and population parameters

reg ${DEPVAR} L.${DEPVAR} L.${INDEP1} L.${INDEP2} L.${AGEMED} L.${AGEVY} L.${AGEY} L.${AGEM} L.${AGEO}  yr* cd* if ${SAMPLE}==1, cluster(code)

sca def NC= `e(N_clust)'
sca def N = `e(N)'

testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0
sca def p = `r(p)'

test L.${AGEM} L.${AGEY} L.${AGEVY} L.${AGEO} L.${AGEMED}
sca def F1 = `r(p)'

mat base_fe_${DEPVAR} = [_b[L1.${DEPVAR}]\ _se[L1.${DEPVAR}] \ _b[L1.${INDEP1}]\ _se[L1.${INDEP1}] \ _b[L1.${INDEP2}] \ _se[L1.${INDEP2}] \ . \ . \ F1 \ . \ . \ (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ p \ N \ NC \ e(r2) ]


//le 4 column 6 Arellano-Bond GMM with Base Sample and population parameters

xtabond2 ${DEPVAR} L.(${DEPVAR} ${INDEP1}) L.${INDEP2} L.${AGEMED} L.${AGEVY} L.${AGEY} L.${AGEM} L.${AGEO}  yr* if ${SAMPLE}==1, gmm(L.(${DEPVAR})) iv(L.${INDEP2} L.${AGEMED} L.${AGEVY} L.${AGEY} L.${AGEM} L.${AGEO} yr*) iv(L2.${INDEP1}, passthru) noleveleq robust

sca def N = `e(N)'
sca def ar = `e(ar2p)'
sca def hj = `e(hansenp)'

testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0
sca def p = `r(p)'

test L.${AGEM} L.${AGEY} L.${AGEVY} L.${AGEO} L.${AGEMED}
sca def F1 = `r(p)'

mat base_gmm_${DEPVAR} = [_b[L1.${DEPVAR}]\ _se[L1.${DEPVAR}] \ _b[L1.${INDEP1}]\ _se[L1.${INDEP1}] \ _b[L1.${INDEP2}] \ _se[L1.${INDEP2}] \ . \ . \ F1 \ hj \ ar \ (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ p \ N \ NC \ e(r2) ]

//le 4 column 7 Fixed effects OLS with Base Sample, population and education parameters

reg ${DEPVAR} L.${DEPVAR} L.${INDEP1} L.${INDEP2} L.${INDEP3} L.${AGEMED} L.${AGEVY} L.${AGEY} L.${AGEM} L.${AGEO}  yr* cd* if ${SAMPLE}==1, cluster(code)

sca def NC= `e(N_clust)'
sca def N = `e(N)'

testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0
sca def p = `r(p)'

test L.${AGEM} L.${AGEY} L.${AGEVY} L.${AGEO} L.${AGEMED}
sca def F1 = `r(p)'

mat base_fewe_${DEPVAR} = [_b[L1.${DEPVAR}]\ _se[L1.${DEPVAR}] \ _b[L1.${INDEP1}]\ _se[L1.${INDEP1}] \ _b[L1.${INDEP2}] \ _se[L1.${INDEP2}] \ _b[L1.${INDEP3}]\ _se[L1.${INDEP3}] \ F1 \ . \ . \ (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ p \ N \ NC \ e(r2) ]


//le 4 column 8 Arellano-Bond GMM with Base Sample, population and education parameters

xtabond2 ${DEPVAR} L.(${DEPVAR} ${INDEP1}) L.${INDEP3} L.${INDEP2} L.${AGEMED} L.${AGEVY} L.${AGEY} L.${AGEM} L.${AGEO}  yr* if ${SAMPLE}==1, gmm(L.($DEPVAR)) iv(L.${INDEP3} L.${INDEP2} L.${AGEMED} L.${AGEVY} L.${AGEY} L.${AGEM} L.${AGEO} yr*) iv(L2.${INDEP1}, passthru) noleveleq robust

sca def N = `e(N)'
sca def ar = `e(ar2p)'
sca def hj = `e(hansenp)'

testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0
sca def p = `r(p)'

test L.${AGEM} L.${AGEY} L.${AGEVY} L.${AGEO} L.${AGEMED}
sca def F1 = `r(p)'

mat base_gmmwe_${DEPVAR} = [_b[L1.${DEPVAR}]\ _se[L1.${DEPVAR}] \ _b[L1.${INDEP1}]\ _se[L1.${INDEP1}] \ _b[L1.${INDEP2}] \ _se[L1.${INDEP2}] \ _b[L1.${INDEP3}]\ _se[L1.${INDEP3}] \ F1 \ hj \ ar \ (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ p \ N \ NC \ e(r2) ]


mat `2'_robust =[ bal_fe_${DEPVAR}, bal_gmm_${DEPVAR}, base_fews_${DEPVAR}, base_gmmws_${DEPVAR}, base_fe_${DEPVAR}, base_gmm_${DEPVAR}, base_fewe_${DEPVAR}, base_gmmwe_${DEPVAR} ]

svmat `2'_robust, names(`2'_robust_)
    format `2'_robust_1 `2'_robust_2 `2'_robust_3 `2'_robust_4 `2'_robust_5 `2'_robust_6 `2'_robust_7 `2'_robust_8 %5.3f
    gen id = _n
    sort id
    drop if id>16

    gen str `2'_colstring = "Democracy t-1" if id==1
    replace `2'_colstring = "SE Democracy t-1" if id==2
    replace `2'_colstring = "Log GDP per capita t-1" if id==3
    replace `2'_colstring = "SE Log GDP per capita t-1" if id==4
    replace `2'_colstring = "Log population t-1" if id==5
    replace `2'_colstring = "SE Log population t-1" if id==6
    replace `2'_colstring = "Education t-1" if id==7
    replace `2'_colstring = "SE Education t-1" if id==8
    replace `2'_colstring = "Age structure t-1" if id==9
    replace `2'_colstring = "Hansen J test" if id==10
    replace `2'_colstring = "AR(2) test" if id==11
    replace `2'_colstring = "Implied cumultative effect of income" if id==12
    replace `2'_colstring = "p value nonlinear test of significance" if id==13
    replace `2'_colstring = "Observations" if id==14
    replace `2'_colstring = "Countries" if id==15
    replace `2'_colstring = "R squared" if id==16

    keep `2'_colstring `2'_robust_1 `2'_robust_2 `2'_robust_3 `2'_robust_4 `2'_robust_5 `2'_robust_6 `2'_robust_7 `2'_robust_8

     save `"${PATH_OUT_ANALYSIS}/`2'_robustness_check_results"', replace










log close

