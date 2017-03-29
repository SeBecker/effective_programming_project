/*
The file "long_run.do" replicates the table 7 from Acemoglu 2008 s.828 :cite:`Acemoglu1`. Note that this analysis uses only the Polity measure of democracy (polity4) as dependent variable.
First the file creates a log file in *bld/out/analysis/log* and loads the model specifications from *bld/src/model_specs/POL.do*. The file loops over 25 and 50 such that all regressions are made for both the 25 and the 50 year panel (see also :ref:`original_data`). All regressions uses a balanced panel for period between 1875 and 2000. After each regression the results are saved in a matrix. Finally all matrices are merged at the end of the do file and saved in *bld/out/analysis/long_run_`i'.dta*.
I
The following regressions are run:

Pooled OLS
===========

    .. literalinclude:: ../../src/analysis/long_run.do
        :lines: 75

    Pooled OLS regression of ${DEPVAR} on lags of ${DEPVAR} and ${INDEP1}. The regression includes time dummies and uses robust standard errors clustured by the highest level of aggregation for income data (madid).

Fixed effects OLS
=================

    .. literalinclude:: ../../src/analysis/long_run.do
        :lines: 83

    Fixed effects OLS regression of ${DEPVAR} on lags of ${DEPVAR} and ${INDEP1}. The regression includes time and country dummies and uses robust standard errors clustured by the highest level of aggregation for income data (madid).

Arellano-Bond GMM
=================

    .. literalinclude:: ../../src/analysis/long_run.do
        :lines: 91

    The regression uses the GMM of Arellano and Bond :cite:`Arellano` with robust standard errors. Income is instrumented by using a double lag of Income.

Fixed effects OLS
=================

    .. literalinclude:: ../../src/analysis/long_run.do
        :lines: 99

    Fixed effects OLS regression of ${DEPVAR} on lags of ${DEPVAR} and ${INDEP1}. The regression includes time and country dummies and uses robust standard errors clustured by the highest level of aggregation for income data (madid).

Fixed effects OLS
=================

    .. literalinclude:: ../../src/analysis/long_run.do
        :lines: 106

    Fixed effects OLS regression of ${DEPVAR} on lag of  ${INDEP1}. The regression includes time and country dummies and uses robust standard errors clustured by the highest level of aggregation for income data (madid). Furthermore this regression excludes countries for which the level of aggregation for income data changesacross the sample period.







*/







// Read in the model controls
include project_paths

log using `"${PATH_OUT_ANALYSIS}/log/`1'.log"', replace

do `"${PATH_OUT_MODEL_SPECS}/POL"'


foreach i in 25 50 {

    use `"${PATH_OUT_DATA}//`i'_year_panel_all"', clear

    // Table 7 Long run estimation col 1

    reg ${DEPVAR} L.(${DEPVAR} ${INDEP6}) yr* if ${SAMPLE}==1, cluster(madid)

    testnl (_b[L.${INDEP6}]/(1 - _b[L.${DEPVAR}])) = 0

    mat POL1_`i'=[ _b[L.${DEPVAR}]\ _se[L.${DEPVAR}] \_b[L.${INDEP6}]\ _se[L.${INDEP6}]\ . \ . \ (_b[L.${INDEP6}]/(1 - _b[L.${DEPVAR}]))\ r(p) \ e(N) \ e(N_clust)\ e(r2)]

    // Table 7 Long run estimation col 2

    reg ${DEPVAR} L.(${DEPVAR} ${INDEP6}) yr* cd* if ${SAMPLE}==1, cluster(madid)

    testnl (_b[L.${INDEP6}]/(1 - _b[L.${DEPVAR}])) = 0

    mat POL2_`i'=[ _b[L.${DEPVAR}]\ _se[L.${DEPVAR}] \_b[L.${INDEP6}]\ _se[L.${INDEP6}]\ . \ . \ (_b[L.${INDEP6}]/(1 - _b[L.${DEPVAR}]))\ r(p) \ e(N) \ e(N_clust)\ e(r2)]

    // Table 7 Long run estimation col 3

    xtabond2 ${DEPVAR} L.(${DEPVAR} ${INDEP6}) yr* if ${SAMPLE}==1, gmm(L.(${DEPVAR})) iv(yr*) iv(L2.${INDEP6}, passthru) noleveleq robust

    testnl (_b[L.${INDEP6}]/(1 - _b[L.${DEPVAR}])) = 0

    mat POL3_`i'=[ _b[L.${DEPVAR}]\ _se[L.${DEPVAR}] \_b[L.${INDEP6}]\ _se[L.${INDEP6}]\ e(hansenp) \ e(ar2p) \ (_b[L.${INDEP6}]/(1 - _b[L.${DEPVAR}]))\ r(p) \ e(N) \ .\ .]

    // Table 7 Long run estimation col 4

    reg ${DEPVAR} L.(${INDEP6}) yr* cd* if ${SAMPLE}==1, cluster(madid)


    mat POL4_`i'=[ . \ . \_b[L.${INDEP6}]\ _se[L.${INDEP6}]\ . \ . \ . \ . \ e(N) \ e(N_clust)\ e(r2)]

    // Table 7 Long run estimation col 5

    reg ${DEPVAR} L.(${DEPVAR} ${INDEP6}) yr* cd* if ${SAMPLE}==1 & noextrapolation==1, cluster(madid)

    testnl (_b[L.${INDEP6}]/(1 - _b[L.${DEPVAR}])) = 0

    mat POL5_`i'=[ _b[L.${DEPVAR}]\ _se[L.${DEPVAR}] \_b[L.${INDEP6}]\ _se[L.${INDEP6}]\ . \ . \ (_b[L.${INDEP6}]/(1 - _b[L.${DEPVAR}]))\ r(p) \ e(N) \ e(N_clust)\ e(r2)]





    mat POL_`i'= [POL1_`i', POL2_`i', POL3_`i', POL4_`i', POL5_`i' ]

    svmat POL_`i', names(POL_`i'_)
    format POL_`i'_1 POL_`i'_2 POL_`i'_3 POL_`i'_4 POL_`i'_5 %9.3f
    gen id = _n
    sort id
    drop if id>11
    gen str POL_`i'_colstring = "Democracy t-1" if id==1
    replace POL_`i'_colstring = "" if id==2
    replace POL_`i'_colstring = "Log GDP per capita t-1" if id==3
    replace POL_`i'_colstring = "" if id==4
    replace POL_`i'_colstring = "Hansen J test" if id==5
    replace POL_`i'_colstring = "AR(2) test" if id==6
    replace POL_`i'_colstring = "Implied cumulative effect of income" if id==7
    replace POL_`i'_colstring = "" if id==8
    replace POL_`i'_colstring = "Observation" if id==9
    replace POL_`i'_colstring = "Countries" if id==10
    replace POL_`i'_colstring = "R-squared" if id==11

    keep POL_`i'_colstring POL_`i'_1 POL_`i'_2 POL_`i'_3 POL_`i'_4 POL_`i'_5
    save `"${PATH_OUT_ANALYSIS}/long_run_`i'"' , replace

}
