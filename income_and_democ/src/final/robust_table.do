// Read in the model controls


include project_paths


log using `"${PATH_OUT_FINAL}/log/`1'.log"', replace


use `"${PATH_OUT_ANALYSIS}/`2'_robustness_check_results"', clear

do `"${PATH_OUT_MODEL_SPECS}/`2'"'

listtab `2'_colstring `2'_robust_1 `2'_robust_2 `2'_robust_3 `2'_robust_4 `2'_robust_5 `2'_robust_6 `2'_robust_7 `2'_robust_8 ///
    using `"${PATH_OUT_TABLES}/`2'_robust.tex"', replace type rstyle(tabular) ///
    head("\begin{table}[htb]" "\caption{Fixed Effects Results Using ${TABLETITLE} Measure of Democracy: Robustness Check}" ///
    "\footnotesize" "\begin{center}" "\begin{adjustbox}{max width=\textwidth}" "\begin{tabular}{lccccccccc}" ///
    "\toprule" ///
    "& \multicolumn{8}{c}{Five-year data} \\" ///
    "\cmidrule(lr){2-9}" ///
    "&&&\multicolumn{2}{c}{\multirow{3}{*}{\shortstack[c]{Base Sample, 1960-2000 \\ without socialist \\ countries}}}&&&\\" ///
    "&&&&&&&& \\" ///
    " & \multicolumn{2}{c}{Balanced Panel, 1970-2000} & & &   \multicolumn{4}{c}{Base Sample, 1960-2000}\\" ///
    "\cmidrule(lr){2-3}" "\cmidrule(lr){4-5}" "\cmidrule(lr){6-9}"  ///
    "& \begin{tabular}[c]{@{}c@{}} Fixed effects\\ OLS\end{tabular}" ///
    "& \begin{tabular}[c]{@{}c@{}} Arellano-\\ Bond GMM\end{tabular}" ///
    "& \begin{tabular}[c]{@{}c@{}} Fixed effects \\ OLS \end{tabular}" ///
    "& \begin{tabular}[c]{@{}c@{}} Arellano- \\ Bond GMM \end{tabular}" ///
    "& \begin{tabular}[c]{@{}c@{}} Fixed effects \\ OLS \end{tabular}" ///
    "& \begin{tabular}[c]{@{}c@{}} Arellano- \\ Bond GMM \end{tabular}" ///
    "& \begin{tabular}[c]{@{}c@{}} Fixed effects \\ OLS \end{tabular}" ///
    "& \begin{tabular}[c]{@{}c@{}} Arellano-\\ Bond GMM \end{tabular} \\" ///
    " & (1) & (2) & (3) & (4) & (5) & (6) & (7) & (8) \\" ///
    "\midrule" ///
    "\vspace{0.1cm}\\" ///
    "& \multicolumn{8}{c}{\textit{Dependent variable is democracy}:}\\" ///
    "\cmidrule(lr){2-9}" ///
    "\vspace{0.1cm}\\") ///
    foot("\bottomrule" "\end{tabular}" "\end{adjustbox}" "\end{center}" "\end{table}" )






