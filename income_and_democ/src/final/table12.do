// Read in the model controls


include project_paths


log using `"${PATH_OUT_FINAL}/log/`1'.log"', replace


use `"${PATH_OUT_ANALYSIS}/`2'_estimation_results"', clear

do `"${PATH_OUT_MODEL_SPECS}/`2'"'


listtab `2'_colstring `2'_1 `2'_2 `2'_3 `2'_4 `2'_5 `2'_6 `2'_7 `2'_8 `2'_9 ///
    using `"${PATH_OUT_TABLES}/`2'.tex"', replace type rstyle(tabular) ///
    head("\begin{table}[htb]" "\caption{Fixed Effects Results Using ${TITLETABULAR} Measure of Democracy}" ///
    "\footnotesize" "\begin{center}" "\begin{adjustbox}{max width=\textwidth}" "\begin{tabular}{lccccccccc}" ///
    "\toprule" ///
    "& \multicolumn{9}{c}{Base Sample 1960-2000} \\" ///
    "\midrule" ///
    " & \multicolumn{5}{c}{Five-year data} & Annual data & \multicolumn{2}{c}{Ten-year data} & Twenty-year data \\ " ///
    "\cmidrule(lr){2-6}" "\cmidrule(lr){7-7}" "\cmidrule(lr){8-9}" "\cmidrule(lr){10-10}" ///
    "& \begin{tabular}[c]{@{}c@{}} Pooled OLS \end{tabular}" ///
    "& \begin{tabular}[c]{@{}c@{}} Fixed effects\\ OLS \end{tabular}" ///
    "& \begin{tabular}[c]{@{}c@{}} Anderson \\-Hsiao IV \end{tabular}" ///
    "& \begin{tabular}[c]{@{}c@{}} Arellano\\-Bond GMM \end{tabular}" ///
    "& \begin{tabular}[c]{@{}c@{}} Fixed effects\\ OLS \end{tabular}" ///
    "& \begin{tabular}[c]{@{}c@{}} Fixed effects\\ OLS \end{tabular}" ///
    "& \begin{tabular}[c]{@{}c@{}} Fixed effects\\ OLS \end{tabular}" ///
    "& \begin{tabular}[c]{@{}c@{}} Arellano \\-Bond GMM \end{tabular}" ///
    "& \begin{tabular}[c]{@{}c@{}} Fixed effects \\OLS \end{tabular} \\" ///
    " & (1) & (2) & (3) & (4) & (5) & (6) & (7) & (8) & (9)\\ " ///
    "\midrule" ///
    "\vspace{0.1cm}\\ " ///
    "& \multicolumn{9}{c}{\textit{Dependent variable is democracy}:}\\ ") ///
    foot("\bottomrule" "\end{tabular}" "\end{adjustbox}" "\end{center}" "\end{table}" )

