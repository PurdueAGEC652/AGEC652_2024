Substitutions

1. Delete all instances of "---" after the first two
2. Replace all "--" by ". . ."
3. Replace blocks of 

"
.pull-left[
%FIRST CONTENT%
]

.pull-right[
%SECOND CONTENT%
]
"

by

::: {.columns}
::: {.column}
%FIRST CONTENT%
:::
::: {.column}
%SECOND CONTENT%
:::
:::

4. Replace 
 "<img src="%CONTENT%", ?.>"
by

"![](%CONTENT%)"
