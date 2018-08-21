/*
The file "robustness_check.do" executes the robustness check from Acemoglu 2008 S.821 :cite:`Acemoglu1` for both measures of democracy defined in *src/model_spec*
(see also :ref:`FHI and POL`). Note that the robustness check apllies only on the five year panel. First the file creates a log file in *bld/out/analysis/log* and loads the model specifications from *bld/src/model_specs*. After each regression the results are saved in a matrix which are merged at the end of the do file and saved in *bld/out/analysis/`2'_robustness_check_results.dta*.

The following regressions are run:

Balanced Panel 1970-2000
========================
The following regressions refers to the Balanced panel (${SAMPLEBALFE} or ${SAMPLEBALGMM} = 1). As stated in Acemoglu 2008 :cite:`Acemoglu1` this allows to examine if the entry or exit of countries might effect the previous results.

Fixed effects OLS
-----------------
        .. literalinclude:: ../../src/analysis/robustness_check.do
            :lines: 101

    Here a regression of ${DEPVAR} on lags of ${DEPVAR} and ${INDEP1} is executed. Year and country dummies are included to consider time and country fixed effects. Standard errors are robust and clustured by country.

Arellano-Bond GMM
-----------------
        .. literalinclude:: ../../src/analysis/robustness_check.do
            :lines: 112
    The regression uses the GMM approach of Arellano and Bond :cite:`Arellano`. Income is instrumented by using a double lag of Income.


Base Sample without former socialist countries
==============================================
The next regressions exclude former socialist countries.

Fixed effects OLS
-----------------
        .. literalinclude:: ../../src/analysis/robustness_check.do
            :lines: 123

    Here a regression of ${DEPVAR} on lagged ${DEPVAR} and ${INDEP1} is executed. Time and country specific dummies are included to consider time and country fixed effects. Standard errors are robust and clustured by country. Observations are only included if ${SAMPLE} and ${SOCIAL} are equal to 1.

Arellano-Bond GMM
-----------------
        .. literalinclude:: ../../src/analysis/robustness_check.do
            :lines: 133
    The regression uses the GMM of Arellano and Bond :cite:`Arellano`. Income is instrumented by using a double lag of Income.

Base Sample 1960-2000
=====================
Regression 5 and 6 include log population and the age structure as independend variables and 7 and 8 add education parameters.

Fixed effects OLS
-----------------
        .. literalinclude:: ../../src/analysis/robustness_check.do
            :lines: 142

    This regression adds lagged Age parameters and log population to the previous fixed effect regression template. Furthermore it includes a significance test for all age structure paramters.

        .. literalinclude:: ../../src/analysis/robustness_check.do
            :lines: 147


Arellano-Bond GMM
-----------------
        .. literalinclude:: ../../src/analysis/robustness_check.do
            :lines: 155

    The regression uses the GMM of Arellano and Bond :cite:`Arellano` and also includes lagged log population and age structure parameters. As before income is instrumented by using a double lag of Income.

Fixed effects OLS
-----------------
        .. literalinclude:: ../../src/analysis/robustness_check.do
            :lines: 167

    This regression adds education parameters in the analysis. Furthermore it includes a significance test for all age structure paramters.

        .. literalinclude:: ../../src/analysis/robustness_check.do
            :lines: 172

Arellano-Bond GMM
-----------------
        .. literalinclude:: ../../src/analysis/robustness_check.do
            :lines: 180
    The regression uses the GMM approach by Arellano and Bond :cite:`Arellano` and adds education as a independent variable to the 6th regression. As before income is instrumented by using a double lag of Income.






*/



// Read in the model controls
include project_paths
log using `"${PATH_OUT_ANALYSIS}/log/`1'.log"', replace


do `"${PATH_OUT_MODEL_SPECS}/`2'"'

use `"${PATH_OUT_DATA}//5_year_panel_all"', clear

//Table 4 column 1 Fixed effects OLS with Balanced Panel


reg ${DEPVAR} L.(${DEPVAR} ${INDEP1}) yr* cd* if ${SAMPLEBALFE}==1, cluster(code)

testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0

mat bal_fe_${DEPVAR} = [_b[L1.${DEPVAR}]\ _se[L1.${DEPVAR}] \ _b[L1.${INDEP1}]\ _se[L1.${INDEP1}] \ . \ . \ . \ . \ . \ . \ . \ (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ r(p) \ e(N) \ e(N_clust) \ e(r2) ]


//Table 4 column 2 Arellano Bond GMM with Balanced Panel


drop if year<1960
xtabond2 ${DEPVAR} L.(${DEPVAR} ${INDEP1}) yr* if ${SAMPLEBALGMM}==1, gmm(L.${DEPVAR}) iv( yr*) iv(L2.${INDEP1}, passthru) noleveleq robust

testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0

mat bal_gmm_${DEPVAR} = [_b[L1.${DEPVAR}]\ _se[L1.${DEPVAR}] \ _b[L1.${INDEP1}]\ _se[L1.${INDEP1}] \ . \ . \ . \ . \ . \ e(hansenp) \ e(ar2p) \ (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ r(p) \ e(N) \ . \ .]


//Table 4 column 3 Fixed effects OLS with Base Sample without former socialist countries

use `"${PATH_OUT_DATA}//5_year_panel_all"', clear

reg ${DEPVAR} L.(${DEPVAR} ${INDEP1}) yr* cd* if ${SAMPLE}==1&${SOCIAL}~=1, cluster(code)

testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0

mat base_fews_${DEPVAR} = [_b[L1.${DEPVAR}]\ _se[L1.${DEPVAR}] \ _b[L1.${INDEP1}]\ _se[L1.${INDEP1}] \ . \ . \ . \ . \ . \ . \ . \ (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ r(p) \ e(N) \ e(N_clust) \ e(r2)]


//Table 4 column 4 Arellano Bond GMM with Base Sample without former socialist countries


xtabond2 ${DEPVAR} L.(${DEPVAR} ${INDEP1}) yr* if ${SAMPLE}==1&${SOCIAL}~=1, gmm(L.(${DEPVAR})) iv( yr*) iv(L2.${INDEP1}, passthru) noleveleq robust

testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0

mat base_gmmws_${DEPVAR} = [_b[L1.${DEPVAR}]\ _se[L1.${DEPVAR}] \ _b[L1.${INDEP1}]\ _se[L1.${INDEP1}] \ . \ . \ . \ . \ . \ e(hansenp) \ e(ar2p) \ (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ r(p) \ e(N) \ . \ .]


//Table 4 column 5 Fixed effects OLS with Base Sample and population parameters

reg ${DEPVAR} L.${DEPVAR} L.${INDEP1} L.${INDEP2} L.${AGEMED} L.${AGEVY} L.${AGEY} L.${AGEM} L.${AGEO}  yr* cd* if ${SAMPLE}==1, cluster(code)

testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0
sca def p = `r(p)'

test L.${AGEM} L.${AGEY} L.${AGEVY} L.${AGEO} L.${AGEMED}
sca def F1 = `r(p)'

mat base_fe_${DEPVAR} = [_b[L1.${DEPVAR}]\ _se[L1.${DEPVAR}] \ _b[L1.${INDEP1}]\ _se[L1.${INDEP1}] \ _b[L1.${INDEP2}] \ _se[L1.${INDEP2}] \ . \ . \ F1 \ . \ . \ (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ p \ e(N) \ e(N_clust) \ e(r2) ]


//Table 4 column 6 Arellano-Bond GMM with Base Sample and population parameters

xtabond2 ${DEPVAR} L.(${DEPVAR} ${INDEP1}) L.${INDEP2} L.${AGEMED} L.${AGEVY} L.${AGEY} L.${AGEM} L.${AGEO}  yr* if ${SAMPLE}==1, gmm(L.(${DEPVAR})) iv(L.${INDEP2} L.${AGEMED} L.${AGEVY} L.${AGEY} L.${AGEM} L.${AGEO} yr*) iv(L2.${INDEP1}, passthru) noleveleq robust

testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0
sca def p = `r(p)'

test L.${AGEM} L.${AGEY} L.${AGEVY} L.${AGEO} L.${AGEMED}
sca def F1 = `r(p)'

mat base_gmm_${DEPVAR} = [_b[L1.${DEPVAR}]\ _se[L1.${DEPVAR}] \ _b[L1.${INDEP1}]\ _se[L1.${INDEP1}] \ _b[L1.${INDEP2}] \ _se[L1.${INDEP2}] \ . \ . \ F1 \ e(hansenp) \ e(ar2p) \ (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ p \ e(N) \ e(N_clust) \ e(r2) ]

//Table 4 column 7 Fixed effects OLS with Base Sample, population and education parameters

reg ${DEPVAR} L.${DEPVAR} L.${INDEP1} L.${INDEP2} L.${INDEP3} L.${AGEMED} L.${AGEVY} L.${AGEY} L.${AGEM} L.${AGEO}  yr* cd* if ${SAMPLE}==1, cluster(code)

testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0
sca def p = `r(p)'

test L.${AGEM} L.${AGEY} L.${AGEVY} L.${AGEO} L.${AGEMED}
sca def F1 = `r(p)'

mat base_fewe_${DEPVAR} = [_b[L1.${DEPVAR}]\ _se[L1.${DEPVAR}] \ _b[L1.${INDEP1}]\ _se[L1.${INDEP1}] \ _b[L1.${INDEP2}] \ _se[L1.${INDEP2}] \ _b[L1.${INDEP3}]\ _se[L1.${INDEP3}] \ F1 \ . \ . \ (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ p \ e(N) \ e(N_clust) \ e(r2) ]


//Table 4 column 8 Arellano-Bond GMM with Base Sample, population and education parameters

xtabond2 ${DEPVAR} L.(${DEPVAR} ${INDEP1}) L.${INDEP3} L.${INDEP2} L.${AGEMED} L.${AGEVY} L.${AGEY} L.${AGEM} L.${AGEO}  yr* if ${SAMPLE}==1, gmm(L.($DEPVAR)) iv(L.${INDEP3} L.${INDEP2} L.${AGEMED} L.${AGEVY} L.${AGEY} L.${AGEM} L.${AGEO} yr*) iv(L2.${INDEP1}, passthru) noleveleq robust

testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0
sca def p = `r(p)'

test L.${AGEM} L.${AGEY} L.${AGEVY} L.${AGEO} L.${AGEMED}
sca def F1 = `r(p)'

mat base_gmmwe_${DEPVAR} = [_b[L1.${DEPVAR}]\ _se[L1.${DEPVAR}] \ _b[L1.${INDEP1}]\ _se[L1.${INDEP1}] \ _b[L1.${INDEP2}] \ _se[L1.${INDEP2}] \ _b[L1.${INDEP3}]\ _se[L1.${INDEP3}] \ F1 \ e(hansenp) \ e(ar2p) \ (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ p \ e(N) \ e(N_clust) \ e(r2) ]


mat `2'_robust =[ bal_fe_${DEPVAR}, bal_gmm_${DEPVAR}, base_fews_${DEPVAR}, base_gmmws_${DEPVAR}, base_fe_${DEPVAR}, base_gmm_${DEPVAR}, base_fewe_${DEPVAR}, base_gmmwe_${DEPVAR} ]

svmat `2'_robust, names(`2'_robust_)
    format `2'_robust_1 `2'_robust_2 `2'_robust_3 `2'_robust_4 `2'_robust_5 `2'_robust_6 `2'_robust_7 `2'_robust_8 %5.3f
    gen id = _n
    sort id
    drop if id>16

    gen str `2'_colstring = "\$ \text{Democracy}_{t-1} \$" if id==1
    replace `2'_colstring = "" if id==2
    replace `2'_colstring = "\$ \text{Log GDP per capita}_{t-1} \$" if id==3
    replace `2'_colstring = "" if id==4
    replace `2'_colstring = "\$ \text{Log population}_{t-1} \$" if id==5
    replace `2'_colstring = "" if id==6
    replace `2'_colstring = "\$ \text{Education}_{t-1} \$" if id==7
    replace `2'_colstring = "" if id==8
    replace `2'_colstring = "\$ \text{Age structure}_{t-1}\$" if id==9
    replace `2'_colstring = "Hansen J test" if id==10
    replace `2'_colstring = "AR(2) test" if id==11
    replace `2'_colstring = "Implied cumultative \\effect of income" if id==12
    replace `2'_colstring = "" if id==13
    replace `2'_colstring = "Observations" if id==14
    replace `2'_colstring = "Countries" if id==15
    replace `2'_colstring = "R squared" if id==16

    keep `2'_colstring `2'_robust_1 `2'_robust_2 `2'_robust_3 `2'_robust_4 `2'_robust_5 `2'_robust_6 `2'_robust_7 `2'_robust_8

     save `"${PATH_OUT_ANALYSIS}/`2'_robustness_check_results"', replace










log close

