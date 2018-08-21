.. _model_specifications:

********************
Model specifications
********************

The directory *src/model_specs* contains `JSON <http://www.json.org/>`_ files with model specifications.


.. _FHI and Pol:

FHI.json and POL.json
######################
Both files contains the following specifications which are used for all regressions but the 500 year estimation:

#. INDEP1 - lrgdpch

    Log real GDP per capita, Data for 1950-2000 from `Penn World Tables <http://dc1.chass.utoronto.ca/cgi-bin/pwt61/retrieve_pwt61>`_

#. INDEP2 - lpop

    Log total population in thousands from World Development indicators 2002

#. INDEP3 - education

    Average total years of schooling in the population age 25 and over. Data for every 5 years for 1960-1995 from Barro and Lee :cite:`BarroLee`

#. INDEP4 - laborshare

    Labor share of gross value added (0-1 scale) from Rodrik :cite:`Rodrik`

#. INDEP5 - worlddemocracy

    Variable constructed by using the `Freedom House Political Rights Index <https://freedomhouse.org/report-types/freedom-world>`_, GDP per capita from `Penn World Tables <http://dc1.chass.utoronto.ca/cgi-bin/pwt61/retrieve_pwt61>`_ and average trade shares between 1980 and 1989 from IMF :cite:`IMF2005`.
    See also Bollen 2001 :cite:`Bollen`

#. INDEP6 - lrgdpmad

    Log real GDP per capita for 1500-2000 from `Maddison <http://www.ggdc.net/maddison/maddison-project/home.htm>`_

#. AGEMED - medage

    Median Age in population

#. AGEVY - age_veryyoung

    Percent population age 0-15

#. AGEY - age_young

    Percent population age 15-30

#. AGEM - age_mid

    Percent population age 30-45

#. AGEO - age_old


    Percent population age 45-60

#. INST1 - nsave


    Data for 1950-2000 measured as $\frac{(Y-C-G)}{Y}$ from `Penn World Tables <http://dc1.chass.utoronto.ca/cgi-bin/pwt61/retrieve_pwt61>`_

#. INST2 - worldincome

    Variable constructed by using GDP per capita from `Penn World Tables <http://dc1.chass.utoronto.ca/cgi-bin/pwt61/retrieve_pwt61>`_ and average trade shares between 1980 and 1989 from IMF :cite:`IMF2005`.
    For specific information about the construction process see also Appendix in :cite:`Acemoglu1`

#. SAMPLE - sample

    Dummy for observations that are used in the base sample.

#. SAMPLEBALFE - samplebalancefe


    Dummy for alanced sample for fixed effects regression.

#. SAMPLEBALGMM - samplebalancegmm

    Dummy for balanced sample for GMM analysis.

#. SOCIAL- socialist

    Dummy for former socialist countries (including iron curtain)

#. TABLETITLE - Freedom House Measure/Polity Measure

    Title for Table construction.

#. IVTITLE1 - Saving Rate Instrument

    Title for the first IV Table construction.

#. IVTITLE2 - Trade-Weighted World Income Instrument

    Title for the second IV Table construction.

The files differ in the specification of the dependent variable:

#. FHI.json DEPVAR  - fhpolrigaug

    `Freedom House Political Rights Index <https://freedomhouse.org/report-types/freedom-world>`_, Data for 1972-2000, data for 1950, 1955, 1960, 1965 from Bollen 2001 :cite:`Bollen`. The Index is normalized between 0 and 1.

#. POL.json DEPVAR - polity4

    `Polity Composite Democracy Index <http://www.systemicpeace.org/polity/polity4x.htm>`_ , normalized between 0 and 1.

.. _Model specification very_long:

very_long.json
##############

The file very_long.json contains specifications for the analysis of the 500 year panel.

#. DEPVAR - democ

    The variable is defined as the change in democracy over 500 years. See also Acemoglu, Johnson and Robinso 2004 :cite: `add source here`

#. INDEP1 - growth

    The variable describes the change of income per capita over the 500 year time span.

#. INDEP2 - consfirstaug

    The value is calculated as the average of constraint on the executive in a country during the first ten years after independence (or the first ten years that are available) and is normalized between 0-1.
    See also: `Polity Composite Democracy Index <http://www.systemicpeace.org/polity/polity4x.htm>`_

#. INDEP3 - indcent

    Year of independence divided by 100. Any year before 1800 is coded as 1800.

#. INDEP4 - `rel_*`

    Variable to implement all religion related variables in do files.

#. INDEP5 - lpd1500s

    Indigeneous population divided by arable land in 1500.
    See also:  Acemoglu, Johnson and Robinso 2002 :cite:`Acemoglu2`

#. DUMMY1 - colony

    Dummy with value equal to 1 if the country is a former colony.

#. DUMMY2 - world

    Dummy with value equal to 1 if the country should be included in the base sample for the 1500-2000 analysis.

#. LIST1 - rel_muslim80

    Share of muslim population in 1980.

#. LIST2 - rel_protmg80


    Share of protestant population in 1980.

#. LIST3 - rel_catho80:

    Share of catholic population in 1980.

.. _Model specification figures:


F1.json, F2.json, F3.json, F4.json, F5.json and F6.json
########################################################
The files specify parameters and titles for the construction of figure 1 to 6.

#. F1.json DEPVAR - fhpolrigaug

    `Freedom House Political Rights Index <https://freedomhouse.org/report-types/freedom-world>`_, for more information :ref:`FHI and POL`

#. F1.json INDEP - lrgdpch

    Log real GDP per capita, Data for 1950-2000 from `Penn World Tables <http://dc1.chass.utoronto.ca/cgi-bin/pwt61/retrieve_pwt61>`_

#. F2.json DEPVAR - s5fhpolrigaug

    Change in `Freedom House Political Rights Index <https://freedomhouse.org/report-types/freedom-world>`_ between 1970 and 1995.

#. F2.json INDEP - s5lrgdpch

    Change in Log real GDP per capita between 1970 and 1995 from `Penn World Tables <http://dc1.chass.utoronto.ca/cgi-bin/pwt61/retrieve_pwt61>`_

#. F3.json DEPVAR - s5polity4

    Change in `Polity Composite Democracy Index <http://www.systemicpeace.org/polity/polity4x.htm>`_ between 1970 and 1995.

#. F3.json INDEP - s5lrgdpch

    Change in Log real GDP per capita between 1970 and 1995 from `Penn World Tables <http://dc1.chass.utoronto.ca/cgi-bin/pwt61/retrieve_pwt61>`_

#. F4.json DEPVAR - s2polity4

    Change in `Polity Composite Democracy Index <http://www.systemicpeace.org/polity/polity4x.htm>`_ between 1900 and 2000.

#. F4.json INDEP - s2lrgdpmadalt

    Change in Log real GDP per capita between 1900 and 2000 from `Maddison <http://www.ggdc.net/maddison/maddison-project/home.htm>`_ .

#. F5.json DEPVAR - democ

    Change in democracy over 500 years. See also Acemoglu, Johnson and Robinso 2004 :cite: `add source here`

#. F5.json INDEP - growth

    The variable describes the change of income per capita over the 500 year time span.

#. F6.json DEPVAR1 - democ

    Change in democracy over 500 years. See also Acemoglu, Johnson and Robinso 2004 :cite: `add source here`

#. F6.json DEPVAR2 - growth

    The variable describes the change of income per capita over the 500 year time span.

#. F6.json INDEP1 - consfirstaug

    The value is calculated as the average of constraint on the executive in a country during the first ten years after independence (or the first ten years that are available) and is normalized between 0-1.
    See also: `Polity Composite Democracy Index <http://www.systemicpeace.org/polity/polity4x.htm>`_

#. F6.json INDEP2 - indcent

    Year of independence divided by 100. Any year before 1800 is coded as 1800.


#. F6.json DUMMY - `rel_*`

    Variable to implement all religion related variables in do files.

#. F6.json RESID1 - democresid

    Residual of a regression of democ on INDEP1 INDEP2 and DUMMY.

#. F6.json RESID1 - growthresid

    Residual of a regression of growth on INDEP1 INDEP2 and DUMMY.

#. TITLE

    Title of the specific figure.

#. SUBTITLE

    Subtitle of the specific figure.

#. XTITLE

    X axis title of specific figure.

#. YTITLE

    Y axis title of specific figure.







.. [#] Note that there is `insheetjson <http://ideas.repec.org/c/boc/bocode/s457407.html>`_, but that will read a JSON file into the data set rather than into macros, which is what we need here.
