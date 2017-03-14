
// Read in the model controls
include project_paths
log using `"${PATH_OUT_ANALYSIS}/log/`1'.log"', replace

do `"${PATH_OUT_MODEL_SPECS}/`2'"'




local inst ="${INST1} ${INST2}"

foreach i in `inst' {
    use `"${PATH_OUT_DATA}//5_year_panel_all"', clear

    // Table 5/6 column 1 Pooled OLS with 5-year data and Instrument

    ivreg ${DEPVAR} yr* cd* (L.${INDEP1}=L.(L.`i')) if sample==1, cluster(code)
    reg ${DEPVAR} L.${INDEP1} yr* if e(sample)==1, cluster(code)

    mat `i'_1up = [. \ .\ _b[L.${INDEP1}] \ _se[L.${INDEP1}]\ . \ .]
    mat `i'_1do = [. \ . \ . \ . \ . \ . \ . \ . \ . \ . \ . \ . \ e(N) \ e(N_clust) \ . ]
    mat list `i'_1up
    mat list `i'_1do


    // Table 5/6 column 2 Fixed effects OLS with 5-year data and Instrument

    ivreg ${DEPVAR} (L.${INDEP1}=L.(L.`i')) yr* cd*  if ${SAMPLE}==1, cluster(code)
    reg ${DEPVAR} L.${INDEP1} yr* cd* if e(sample)==1, cluster(code)

    mat `i'_2up = [. \ .\ _b[L.${INDEP1}] \ _se[L.${INDEP1}]\ . \ .]
    mat `i'_2do = [. \ . \ . \ . \ . \ . \ . \ . \ . \ . \ . \ . \ e(N) \ e(N_clust) \ . ]



    // Table 5/6 column 3 Fixed effects OLS with lagged democracy with 5-year data and Instrument

    ivreg ${DEPVAR} (L.${INDEP1}=L.(L.`i')) yr* cd*  if ${SAMPLE}==1, cluster(code)
    reg ${DEPVAR} L.${INDEP1} L.${DEPVAR} yr* cd* if e(sample)==1, cluster(code)

    testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0

    mat `i'_3up = [_b[L.${DEPVAR}] \ _se[L.${DEPVAR}] \ _b[L.${INDEP1}] \ _se[L.${INDEP1}]\ . \ .]
    mat `i'_3do = [. \ . \ . \ . \ . \ . \ . \ . \ . \ . \ (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ r(p) \ e(N) \ e(N_clust) \ . ]

    mat list `i'_3up
    mat list `i'_3do


    // Table 5/6 column 4 Fixed effects 2SLS with 5-year data and Instrument

    ivreg ${DEPVAR} (L.${INDEP1}=L.(L.`i')) yr* cd*  if ${SAMPLE}==1, cluster(code)




    mat `i'_4up = [ . \ . \ _b[L.${INDEP1}] \ _se[L.${INDEP1}]\ . \ .]

    reg L.${INDEP1} L2.(`i') yr* cd* if e(sample), cluster(code)


    mat `i'_4do = [. \ . \ . \ . \ _b[L2.`i']  \ _se[L2.`i'] \ . \ . \ . \ . \ . \ . \ e(N) \ e(N_clust) \ e(r2)]


    // Table 5/6 column 5 Fixed effects 2SLS (including lagged democracy) with 5-year data and Instrument

    ivreg ${DEPVAR} L.${DEPVAR} yr* cd* (L.${INDEP1}=L.(L.`i')) if ${SAMPLE}==1, cluster(code)

    mat `i'_5up = [ _b[L.${DEPVAR}] \ _se[L.${DEPVAR}] \ _b[L.${INDEP1}] \ _se[L.${INDEP1}]\ . \ .]

    reg L.${INDEP1} L.${DEPVAR} L2.(`i') yr* cd* if e(sample), cluster(code)


    mat `i'_5do = [_b[L.${DEPVAR]}] \ _se[L.${DEPVAR}] \ . \ . \ _b[L2.`i'] \ _se[L2.`i'] \ . \ . \ .  \ . \ . \ . \ e(N) \ e(N_clust) \ e(r2)]


    // Table 5/6 column 6 Arellano-Bond GMM with 5-year data and Instrument

    xtabond2 ${DEPVAR} L.(${DEPVAR} ${INDEP1}) yr* if ${SAMPLE}==1, gmm(L.(${DEPVAR})) iv( yr*) iv(L.(L.`i')) noleveleq robust

    mat `i'_6up = [ _b[L.${DEPVAR}] \ _se[L.${DEPVAR}] \ _b[L.${INDEP1}] \ _se[L.${INDEP1}]\ . \ .]

    testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0

    mat `i'_6do = [. \ . \ . \ . \ . \ .  \ . \ . \ `e(hansenp)'  \ `e(ar2p)' \ (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ r(p) \ e(N) \ . \ .]




    // Table 5/6 column 7 Fixed effects 2SLS (including labor share) with 5-year data and Instrument
    ge x = "`i'"

    if x == "nsave" {
        ivreg ${DEPVAR} L.${INDEP4} yr* cd* (L.${INDEP1}=L.(L.`i')) if ${SAMPLE}==1 , cluster(code)

        mat `i'_7up = [. \ . \_b[L.${INDEP1}]\ _se[L.${INDEP1}]\ _b[L.${INDEP4}]\ _se[L.${INDEP4}]]

        reg L.${INDEP1} L2.`i' L.${INDEP4} yr* cd* if e(sample), cluster(code)


        mat `i'_7do = [ . \ . \ _b[L.${INDEP4}] \ _se[L.${INDEP4}] \ _b[L2.`i'] \ _se[L2.`i'] \ . \ . \ . \ . \ . \ . \ e(N) \ e(N_clust) \ e(r2)]
    }
    else if x == "worldincome" {

        ivreg ${DEPVAR} ${INDEP5} yr* cd* (L.${INDEP1}=(L.`i')) if ${SAMPLE}==1 , cluster(code)

        mat `i'_7up = [. \ . \_b[L.${INDEP1}]\ _se[L.${INDEP1}]\ _b[${INDEP5}]\ _se[${INDEP5}]]

        reg L.${INDEP1} L.`i' ${INDEP5} yr* cd* if e(sample), cluster(code)


        mat `i'_7do = [ . \ . \ _b[${INDEP5}] \ _se[${INDEP5}] \ _b[L.`i'] \ _se[L.`i'] \ . \ . \ . \ . \ . \ . \ e(N) \ e(N_clust) \ e(r2)]
    }



    // Table 5/6 column 8 Fixed effects 2SLS (including lagged democracy in first stage) with 5-year data and Instrument
    if x == "nsave" {

        ivreg ${DEPVAR} L(1/3).${DEPVAR} yr* cd* (L.${INDEP1}=L.(L.`i')) if ${SAMPLE}==1, cluster(code)

        test L1.${DEPVAR} L2.${DEPVAR} L3.${DEPVAR}

        mat `i'_8up = [ `r(p)' \ . \ _b[L.${INDEP1}] \ _se[L.${INDEP1}]\ .  \ . ]

        reg L.${INDEP1} L2.`i' L(1/3).${DEPVAR} yr* cd* if e(sample), cluster(code)

        test L1.${DEPVAR} L2.${DEPVAR} L3.${DEPVAR}


        mat `i'_8do = [ r(p) \ . \ .\ . \ _b[L2.`i'] \ _se[L2.`i']  \ . \ . \ . \ . \ . \ . \ e(N) \ e(N_clust) \ e(r2)]
        mat list `i'_8do
    }

    else if x == "worldincome" {

     ivreg ${DEPVAR} (L.${INDEP1}=L.(L.`i')) yr* cd*  if ${SAMPLE}==1, cluster(code)

        mat `i'_8up = [ . \ . \ _b[L.${INDEP1}] \ _se[L.${INDEP1}]\ .  \ . ]

        reg L.${INDEP1} L2.`i'  yr* cd* if e(sample), cluster(code)


        mat `i'_8do = [. \ . \ .\ . \ _b[L2.`i'] \ _se[L2.`i']  \ . \ . \ . \ . \ . \ . \ e(N) \ e(N_clust) \ e(r2)]
        mat list `i'_8do
    }






    // Table 5/6 column 9 Fixed effects 2SLS (including lagged democracy in first stage) with 5-year data and Instrument
    if x == "nsave" {

        ivreg ${DEPVAR} (L.${INDEP1}=L(1/2).(L.`i')) yr* cd*  if ${SAMPLE}==1, cluster(code)

        mat `i'_9up = [ . \ . \ _b[L.${INDEP1}] \ _se[L.${INDEP1}]\ .  \ . ]

        reg L.${INDEP1} L2.`i' L3.`i' yr* cd* if e(sample), cluster(code)


        mat `i'_9do = [. \ . \ .\ . \ _b[L2.`i'] \ _se[L2.`i']  \ _b[L3.`i'] \ _se[L3.`i'] \ . \ . \ . \ . \ e(N) \ e(N_clust) \ e(r2)]
    }
    else if x == "worldincome" {
        ivreg ${DEPVAR} (L.${INDEP1}=L(1/2).(`i')) yr* cd*  if ${SAMPLE}==1, cluster(code)

        mat `i'_9up = [ . \ . \ _b[L.${INDEP1}] \ _se[L.${INDEP1}]\ .  \ . ]

        reg L.${INDEP1} L2.`i' L.`i' yr* cd* if e(sample), cluster(code)




        mat `i'_9do = [. \ . \ .\ . \ _b[L.`i'] \ _se[L.`i']  \ _b[L2.`i'] \ _se[L2.`i'] \ . \ . \ . \ . \ e(N) \ e(N_clust) \ e(r2)]
    }




    mat `i'_up =[`i'_1up, `i'_2up, `i'_3up, `i'_4up, `i'_5up, `i'_6up, `i'_7up, `i'_8up, `i'_9up ]
    mat list `i'_up

    svmat `i'_up, names(`i'_up_)
    format `i'_up_1 `i'_up_2 `i'_up_3 `i'_up_4 `i'_up_5 `i'_up_6 `i'_up_7 `i'_up_8 `i'_up_9 %9.3f
    gen id = _n
    sort id
    drop if id>6
    gen str `i'_up_colstring = "Democracy t-1" if id==1
    replace `i'_up_colstring = "" if id==2
    replace `i'_up_colstring = "Log GDP per capita t-1" if id==3
    replace `i'_up_colstring = "" if id==4
    replace `i'_up_colstring = "Labor Share t-1" if id==5 & x == "nsave"
    replace `i'_up_colstring = "Trade-weighted democracy t" if id==5 & x == "worldincome"
    replace `i'_up_colstring = "" if id==6

    keep `i'_up_colstring `i'_up_1 `i'_up_2 `i'_up_3 `i'_up_4 `i'_up_5 `i'_up_6 `i'_up_7 `i'_up_8 `i'_up_9

    save `"${PATH_OUT_ANALYSIS}/`2'_`i'up_IVestimation_results"', replace

    mat `i'_do =[`i'_1do, `i'_2do, `i'_3do, `i'_4do, `i'_5do, `i'_6do, `i'_7do, `i'_8do, `i'_9do ]
    mat list `i'_do

    svmat `i'_do, names(`i'_do_)
    format `i'_do_1 `i'_do_2 `i'_do_3 `i'_do_4 `i'_do_5 `i'_do_6 `i'_do_7 `i'_do_8 `i'_do_9 %9.3f
    gen x = "`i'"
    gen id = _n
    sort id
    drop if id>15
    gen str `i'_do_colstring = "Democracy t-1" if id==1
    replace `i'_do_colstring = "" if id==2
    replace `i'_do_colstring = "Labor Share t-1" if id==3 & x== "nsave"
    replace `i'_do_colstring = "Trade weighted democracy t" if id==3 & x== "worldincome"
    replace `i'_do_colstring = "" if id==4
    replace `i'_do_colstring = "Saving rate t-2" if id==5 & x == "nsave"
    replace `i'_do_colstring = "Trade-weighted log GDP t-1" if id==5 & x == "worldincome"
    replace `i'_do_colstring = "" if id==6
    replace `i'_do_colstring = "Saving rate t-3" if id==7 & x == "nsave"
    replace `i'_do_colstring = "Trade weighted log GDP t-2" if id==7 & x == "worldincome"
    replace `i'_do_colstring = "" if id==8
    replace `i'_do_colstring = "Hansen J test" if id==9
    replace `i'_do_colstring = "AR(2) test" if id==10
    replace `i'_do_colstring = "Implied cumultative \\ effect of income" if id==11
    replace `i'_do_colstring = "" if id==12
    replace `i'_do_colstring = "Observations" if id==13
    replace `i'_do_colstring = "Countries" if id==14
    replace `i'_do_colstring = "R squared in first stage" if id==15
    drop x

    keep `i'_do_colstring `i'_do_1 `i'_do_2 `i'_do_3 `i'_do_4 `i'_do_5 `i'_do_6 `i'_do_7 `i'_do_8 `i'_do_9


    save `"${PATH_OUT_ANALYSIS}/`2'_`i'do_IVestimation_results"', replace


























}


log close