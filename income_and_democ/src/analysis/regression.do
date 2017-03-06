

// Read in the model controls
include project_paths
log using `"${PATH_OUT_ANALYSIS}/log/`1'.log"', replace

do `"${PATH_OUT_MODEL_SPECS}/FHI"'



ssc install xtabond2, replace

local dem_mes ="${DEPVAR1} ${DEPVAR2}"


foreach i in `dem_mes'  {

    use `"${PATH_OUT_DATA}//5_year_panel_all"', clear


    reg `i' L.(`i') L.(${INDEP}) yr* if ${SAMPLE}==1, cluster(code)

    sca def NC= `e(N_clust)'
    sca def N = `e(N)'

    testnl (_b[L1.${INDEP}]/(1 - _b[L1.`i'])) = 0
    sca def p = `r(p)'

    mat `i'_est_pool = [_b[L1.`i']\ _se[L.`i']\ _b[L1.${INDEP}] \ _se[L1.${INDEP}]\ . \ . \(_b[L1.${INDEP}]/(1 - _b[L1.`i'])) \ p  \ N \ NC \ e(r2) ]
    mat list `i'_est_pool

    reg `i' L.(`i') L.(${INDEP}) yr* cd* if ${SAMPLE}==1, cluster(code)

    sca def NC = `e(N_clust)'
    sca def N = `e(N)'

    testnl (_b[L1.${INDEP}]/(1 - _b[L1.`i'])) = 0
    sca def p = `r(p)'

    mat `i'_est_fixed1 = [_b[L1.`i']\ _se[L.`i']\ _b[L1.${INDEP}] \ _se[L1.${INDEP}]\ . \ . \(_b[L1.${INDEP}]/(1 - _b[L1.`i'])) \ p  \ N \ NC \ e(r2) ]
    mat list `i'_est_fixed1

    ivreg D.`i' yr* (LD.(`i' ${INDEP})= L2.(`i' ${INDEP})) if sample==1, cluster(code)

    sca def NC = `e(N_clust)'
    sca def N = `e(N)'

    testnl (_b[LD.${INDEP}]/(1 - _b[LD.`i'])) = 0
    sca def p = `r(p)'

    mat `i'_AndHsiaoIV = [_b[LD.`i']\ _se[LD.`i']\ _b[LD.${INDEP}] \ _se[LD.${INDEP}]\ . \ . \(_b[LD.${INDEP}]/(1 - _b[LD.`i'])) \ p  \ N \ NC \ .]

    xtabond2 `i' L.(`i' ${INDEP}) yr* if sample==1, gmm(L.(`i')) iv( yr*) iv(L2.${INDEP}, passthru) noleveleq robust

    sca def N = `e(N)'
    sca def ar = `e(ar2p)'
    sca def hj = `e(hansenp)'

    testnl (_b[L1.${INDEP}]/(1 - _b[L1.`i'])) = 0
    sca def p = `r(p)'

    mat `i'_GMMIV = [_b[L1.`i']\ _se[L.`i']\ _b[L1.${INDEP}] \ _se[L1.${INDEP}]\ . \ . \(_b[L1.${INDEP}]/(1 - _b[L1.`i'])) \ p  \ N \ . \ .]


    reg `i' L.(${INDEP}) yr* cd* if ${SAMPLE}==1, cluster(code)

    sca def NC = `e(N_clust)'
    sca def N = `e(N)'

    mat `i'_est_fixed2 = [ .\ .\ _b[L1.${INDEP}] \ _se[L1.${INDEP}]\ . \ . \ . \ . \ N \ NC \ e(r2) ]

    use `"${PATH_OUT_DATA}//annual_panel_all"', clear

    reg `i' L(1/5).(`i' ${INDEP}) yr* cd* if sample==1, cluster(code)

    test L1.`i' L2.`i' L3.`i' L4.`i' L5.`i'
    sca def F1 = `r(p)'


    test L1.${INDEP} L2.${INDEP} L3.${INDEP} L4.${INDEP} L5.${INDEP}
    sca def F2 = `r(p)'

    sca def NC = `e(N_clust)'
    sca def N = `e(N)'

    mat `i'_fixed_annual = [ F1 \ . \ F2 \ . \ . \ . \ . \ . \ N \ NC \ e(r2) ]
    mat list `i'_fixed_annual

    use `"${PATH_OUT_DATA}//10_year_panel_all"', clear

    reg `i' L.(`i') L.(${INDEP}) yr* cd* if ${SAMPLE}==1, cluster(code)

    sca def NC = `e(N_clust)'
    sca def N = `e(N)'

    mat `i'_fixed10 = [_b[L1.`i']\ _se[L.`i']\ _b[L1.${INDEP}] \ _se[L1.${INDEP}]\ . \ . \ . \ .  \ N \ NC \ e(r2) ]


    xtabond2 `i' L.(`i' ${INDEP}) yr* if sample==1, gmm(L.(`i')) iv( yr*) iv(L2.${INDEP}, passthru) noleveleq robust

    sca def N = `e(N)'
    sca def ar = `e(ar2p)'
    sca def hj =`e(hansenp)'

    testnl (_b[L1.${INDEP}]/(1 - _b[L1.`i'])) = 0
    sca def p = `r(p)'

    mat `i'_GMMIV10 = [_b[L1.`i']\ _se[L.`i']\ _b[L1.${INDEP}] \ _se[L1.${INDEP}]\ . \ . \(_b[L1.${INDEP}]/(1 - _b[L1.`i'])) \ p  \ N \ . \ . ]

    use `"${PATH_OUT_DATA}//20_year_panel_all"', clear

    reg `i' L.(`i') L.(${INDEP}) yr* cd* if ${SAMPLE}==1, cluster(code)

    sca def NC = `e(N_clust)'
    sca def N = `e(N)'

    testnl (_b[L1.${INDEP}]/(1 - _b[L1.`i'])) = 0
    sca def p = `r(p)'

    mat `i'_fixed20 = [_b[L1.`i']\ _se[L.`i']\ _b[L1.${INDEP}] \ _se[L1.${INDEP}]\ . \ . \(_b[L1.${INDEP}]/(1 - _b[L1.`i'])) \ p  \ N \ NC \ e(r2) ]



    mat `i'_tab =[`i'_est_pool, `i'_est_fixed1, `i'_AndHsiaoIV, `i'_GMMIV, `i'_fixed_annual, `i'_fixed20, `i'_fixed10, `i'_GMMIV10, `i'_fixed20 ]

    svmat `i'_tab, names(`i'_tab_)
    format `i'_tab_1 `i'_tab_2 `i'_tab_3 `i'_tab_4 `i'_tab_5 `i'_tab_6 `i'_tab_7 `i'_tab_8 `i'_tab_9 %5.2f
    gen id = _n
    sort id
    gen str `i'_colstring = "Democracy t-1" if id==1
    replace `i'_colstring = "SE Democracy t-1" if id==2
    replace `i'_colstring = "Log GDP per capita t-1" if id==3
    replace `i'_colstring = "SE Log GDP per capita t-1" if id==4
    replace `i'_colstring = "Hansen J test" if id==5
    replace `i'_colstring = "AR(2) test" if id==6
    replace `i'_colstring = "Implied cumultative effect of income" if id==7
    replace `i'_colstring = "p value nonlinear test of significance" if id==8
    replace `i'_colstring = "Observations" if id==9
    replace `i'_colstring = "Countries" if id==10
    replace `i'_colstring = "R squared" if id==11

    keep `i'_colstring `i'_tab_1 `i'_tab_2 `i'_tab_3 `i'_tab_4 `i'_tab_5 `i'_tab_6 `i'_tab_7 `i'_tab_8 `i'_tab_9
    save `"${PATH_OUT_ANALYSIS}/`i'_estimation_results"', replace


}




save `"${PATH_OUT_ANALYSIS}/regression"', replace




log close

