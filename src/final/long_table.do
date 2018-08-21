/*
The file "long_table.do" transfers the results from the fixed effects long run analysis (:ref:`long run analysis`) into a latex table structure and saves the tex file in *bld/out/tables*.
*/

// Read in the model controls


include project_paths


log using `"${PATH_OUT_FINAL}/log/`1'.log"', replace

do `"${PATH_OUT_MODEL_SPECS}/POL"'

use `"${PATH_OUT_ANALYSIS}/long_run_25"', clear
    listtab POL_25_colstring POL_25_1 POL_25_2 POL_25_3 POL_25_4 POL_25_5 ///
    using `"${PATH_OUT_TABLES}/long_run_table.tex"', replace type rstyle(tabular) ///
    head("\begin{table}[!htb]" "\caption{Fixed Effects Results Using ${TABLETITLE}  Measure of Democracy in the Long Run}" ///
    "\footnotesize" "\begin{center}" "\begin{adjustbox}{max width=\textwidth}" "\begin{tabular}{lccccc}" ///
    "\toprule" ///
    "\midrule" ///
    " & \multicolumn{5}{c}{\textit{Balanced Panel, 1875-2000}} \\" ///
    "\cmidrule(lr){2-6}" ///
    "& \begin{tabular}[c]{@{}c@{}} Pooled\\ OLS\end{tabular}" ///
    "& \begin{tabular}[c]{@{}c@{}} Fixed effects\\ OLS\end{tabular}" ///
    "& \begin{tabular}[c]{@{}c@{}} Arellano- \\ Bond GMM \end{tabular}" ///
    "& \begin{tabular}[c]{@{}c@{}} Fixed effects \\ OLS \end{tabular}" ///
    "& \begin{tabular}[c]{@{}c@{}} Fixed effects \\ OLS \end{tabular} \\" ///
    " & (1) & (2) & (3) & (4) & (5) \\" ///
    "\midrule" ///
    "\textit{Panel A} &  \multicolumn{5}{c}{\textit{Dependent variable is democracy}} \\" ///
    "\midrule" ) ///

use `"${PATH_OUT_ANALYSIS}/long_run_50"', clear
    listtab POL_50_colstring POL_50_1 POL_50_2 POL_50_3 POL_50_4 POL_50_5, ///
    appendto(`"${PATH_OUT_TABLES}/long_run_table.tex"') type rstyle(tabular) ///
    head("\midrule" ///
    "\textit{Panel B} &  \multicolumn{5}{c}{\textit{Dependent variable is democracy}} \\" ///
    "\midrule" ) ///
    foot("\bottomrule" "\end{tabular}" "\end{adjustbox}" "\end{center}" "\end{table}" )













