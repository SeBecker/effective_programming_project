/*
The file "regression.do" executes the fixed effects analysis from Acemoglu 2008 :cite:`Acemoglu1`.
Firstly the file creates a log file in *bld/out/analysis/log* and loads the model specifications from *bld/src/model_specs*. After each regression the results are saved in a matrix which are merged at the end of the do file and saved in *bld/out/analysis/`2'_estimation_results.dta.

.. literalinclude:: ../../src/analysis/regression.do
    :lines: 217-239




The following regressions are run:

Five Year panel
===============

The following regressions use the Five year panel data set. For more information see also :

Pooled cross-sectional OLS
---------------------------
        .. literalinclude:: ../../src/analysis/regression.do
            :lines: 123

        Regression of ${DEPVAR} on lagged values of ${DEPVAR} and ${INDEP1} with time dummies (yr*) and robust standard errors clustured by country. Observations are only included if ${SAMPLE} ==1.
        Furthermore the file performs a nonlinear test of significance for _b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}]).


Fixed effects OLS
-----------------
        .. literalinclude:: ../../src/analysis/regression.do
            :lines: 133

        Regression of ${DEPVAR} on lagged values of ${DEPVAR} and ${INDEP1} with time (yr*) and country dummies (cd*). As before the robust standard errors are clustured by country and a nonlinear test of significance is executed. Observations are only included if ${SAMPLE} == 1.

Anderson-Hsiao IV
-----------------
        .. literalinclude:: ../../src/analysis/regression.do
            :lines: 143

        The next regression uses the instrumental variable method of Anderson and Hsia :cite:`Anderson`. The instrumented variables are the lagged values of ${DEPVAR} and ${INDEP1} which are estimated by using the double lag of this variables and the time dummies as instruments. As before observations are only included if ${SAMPLE} == 1 and the standard errors are clustured by country.


Arellano-Bond GMM
-----------------
        .. literalinclude:: ../../src/analysis/regression.do
            :lines: 154

        The 4th regression uses the GMM of Arellano and Bond :cite:`Arellano`.

Fixed effects OLS
-----------------
        .. literalinclude:: ../../src/analysis/regression.do
            :lines: 163

        The last regression on the 5-year panel data set is a fixed effect regression of ${DEPVAR} on lagged ${INDEP1} with year and country dummies. As before Observations are only included if ${SAMPLE} = 1 and the standard errors are clustured by country.

Annual panel
============
The following regression uses the annual panel data set for more information see also:

Fixed effects OLS
-----------------
        .. literalinclude:: ../../src/analysis/regression.do
            :lines: 172

        The next regression of ${DEPVAR} includes lagged values of ${DEPVAR and ${INDEP1} as far as 5 periods before the dependend variable. Also it includes country and time specific dummies and robust standard errors which are clustured by country.

        Furthermore two significance tests for all five lags of ${DEPVAR} and ${INDEP1} are executed.

        .. literalinclude:: ../../src/analysis/regression.do
            :lines: 174-179


Ten Year Panel
==============
The following regression uses the ten year panel data set for more information see also:


Fixed effects OLS
-----------------
        .. literalinclude:: ../../src/analysis/regression.do
            :lines: 189

        This regression is similar to the second regression from the Five Year Panel section. It regresses ${DEPVAR} on lagged ${DEPVAR} and ${INDEP1}. ALso it includes time and country specific dummies to respect time and country specific fixed effects. As always it uses robust standard errors clustered by country and observations are only included as dependend variable as long as ${SAMPLE} is equal to 1.

Arellano-Bond GMM
------------------
        .. literalinclude:: ../../src/analysis/regression.do
            :lines: 197


        Exactly as the 4th regression of the five year panel data set this regression uses the GMM of Arellano and Bond :cite:`Arellano`.

Twenty year panel
=================
The following regression uses the ten year panel data set for more information see also:

Fixed effects OLS
-----------------
        .. literalinclude:: ../../src/analysis/regression.do
            :lines: 209

        This regression is similar to the second regression from the Five Year Panel section. It regresses ${DEPVAR} on lagged ${DEPVAR} and ${INDEP1}. ALso it includes time and country specific dummies to respect time and country specific fixed effects. As always it uses robust standard errors clustered by country and observations are only included as dependend variable as long as ${SAMPLE} is equal to 1.




*/


// Read in the model controls
include project_paths
log using `"${PATH_OUT_ANALYSIS}/log/`1'.log"', replace

do `"${PATH_OUT_MODEL_SPECS}/`2'"'

ssc install xtabond2, replace

use `"${PATH_OUT_DATA}//5_year_panel_all"', clear

// Table 2 column 1 Pooled OLS with 5-year data


reg ${DEPVAR} L.(${DEPVAR}) L.(${INDEP1}) yr* if ${SAMPLE}==1, cluster(code)


testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0

mat ${DEPVAR}_pool = [_b[L1.${DEPVAR}]\ _se[L.${DEPVAR}]\ _b[L1.${INDEP1}] \ _se[L1.${INDEP1}]\ . \ . \(_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ r(p)  \ e(N)  \ e(N_clust) \ e(r2) ]

// Table 2 column 2 Fixed effects OLS with 5-year data


reg ${DEPVAR} L.(${DEPVAR}) L.(${INDEP1}) yr* cd* if ${SAMPLE}==1, cluster(code)


testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0

mat ${DEPVAR}_fixed1 = [_b[L1.${DEPVAR}]\ _se[L.${DEPVAR}]\ _b[L1.${INDEP1}] \ _se[L1.${INDEP1}]\ . \ . \(_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ r(p) \ e(N) \ e(N_clust) \ e(r2) ]

// Table 2 column 3 Anderson-Hsiao IV with 5-year data


ivreg D.${DEPVAR} yr* (LD.(${DEPVAR} ${INDEP1})= L2.(${DEPVAR} ${INDEP1})) if ${SAMPLE}==1, cluster(code)


testnl (_b[LD.${INDEP1}]/(1 - _b[LD.${DEPVAR}])) = 0

mat ${DEPVAR}_AndHsiaoIV = [_b[LD.${DEPVAR}]\ _se[LD.${DEPVAR}]\ _b[LD.${INDEP1}] \ _se[LD.${INDEP1}]\ . \ . \(_b[LD.${INDEP1}]/(1 - _b[LD.${DEPVAR}])) \ r(p)  \ e(N) \ e(N_clust) \ .]


// Table 2 column 4 Arellano Bond GMM with 5-year data


xtabond2 ${DEPVAR} L.(${DEPVAR} ${INDEP1}) yr* if sample==1, gmm(L.(${DEPVAR})) iv( yr*) iv(L2.${INDEP1}, passthru) noleveleq robust

testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0

mat ${DEPVAR}_GMMIV = [_b[L1.${DEPVAR}]\ _se[L.${DEPVAR}]\ _b[L1.${INDEP1}] \ _se[L1.${INDEP1}]\ e(hansenp) \ e(ar2p) \(_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ r(p) \ e(N) \ . \ .]

// Table 2 column 5 Fixed effects OLS without lagged democracy with 5-year data


reg ${DEPVAR} L.(${INDEP1}) yr* cd* if ${SAMPLE}==1, cluster(code)

mat ${DEPVAR}_fixed2 = [ .\ .\ _b[L1.${INDEP1}] \ _se[L1.${INDEP1}]\ . \ . \ . \ . \ e(N) \ e(N_clust) \ e(r2) ]

use `"${PATH_OUT_DATA}//annual_panel_all"', clear

// Table 2 column 6 Fixed effects OLS with annual panel


reg ${DEPVAR} L(1/5).(${DEPVAR} ${INDEP1}) yr* cd* if ${SAMPLE}==1, cluster(code)

test L1.${DEPVAR} L2.${DEPVAR} L3.${DEPVAR} L4.${DEPVAR} L5.${DEPVAR}
sca def F1 = `r(p)'


test L1.${INDEP1} L2.${INDEP1} L3.${INDEP1} L4.${INDEP1} L5.${INDEP1}
sca def F2 = `r(p)'


mat ${DEPVAR}_fixedannual = [ F1 \ . \ F2 \ . \ . \ . \ . \ . \ e(N) \ e(N_clust) \ e(r2) ]

use `"${PATH_OUT_DATA}//10_year_panel_all"', clear

// Table 2 column 7 Fixed effects OLS with 10-year panel


reg ${DEPVAR} L.(${DEPVAR}) L.(${INDEP1}) yr* cd* if ${SAMPLE}==1, cluster(code)

mat ${DEPVAR}_fixed10 = [_b[L1.${DEPVAR}]\ _se[L.${DEPVAR}]\ _b[L1.${INDEP1}] \ _se[L1.${INDEP1}]\ . \ . \ . \ .  \ e(N) \ e(N_clust) \ e(r2) ]


// Table 2 column 8 Arellano-Bond GMM with 10-year panel


xtabond2 ${DEPVAR} L.(${DEPVAR} ${INDEP1}) yr* if sample==1, gmm(L.(${DEPVAR})) iv( yr*) iv(L2.${INDEP1}, passthru) noleveleq robust

testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0

mat ${DEPVAR}_GMMIV10 = [_b[L1.${DEPVAR}]\ _se[L.${DEPVAR}]\ _b[L1.${INDEP1}] \ _se[L1.${INDEP1}]\ e(hansenp) \ e(ar2p) \(_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ r(p)  \ e(N) \ . \ . ]

use `"${PATH_OUT_DATA}//20_year_panel_all"', clear


// Table 2 column 9 Fixed effects OLS with 20-year panel


reg ${DEPVAR} L.(${DEPVAR}) L.(${INDEP1}) yr* cd* if ${SAMPLE}==1, cluster(code)

testnl (_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) = 0

mat ${DEPVAR}_fixed20 = [_b[L1.${DEPVAR}]\ _se[L.${DEPVAR}]\ _b[L1.${INDEP1}] \ _se[L1.${INDEP1}]\ . \ . \(_b[L1.${INDEP1}]/(1 - _b[L1.${DEPVAR}])) \ r(p)  \ e(N)  \ e(N_clust) \ e(r2) ]



mat `2' =[${DEPVAR}_pool, ${DEPVAR}_fixed1, ${DEPVAR}_AndHsiaoIV, ${DEPVAR}_GMMIV, ${DEPVAR}_fixed2, ${DEPVAR}_fixedannual, ${DEPVAR}_fixed10, ${DEPVAR}_GMMIV10, ${DEPVAR}_fixed20 ]

svmat `2', names(`2'_)
format `2'_1 `2'_2 `2'_3 `2'_4 `2'_5 `2'_6 `2'_7 `2'_8 `2'_9 %9.2f
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











log close

