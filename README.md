# ErrorFreeArith.jl
error free transformations for arithmetic ops

There are two versions, one is inlined.  To use the inlined version, before loading do this:

inlineErrorFreeArith = true

Exports: eftSum2, eftDiff2, eftProd2, eftDiv2, eftSum3, eftProd3, eftFMA, and a few others

Use:  hi, lo = eft<function>()

The lo part is the residual value not captured in the high part.
The ideal result is much closer to hi+lo (in extended precision) than to hi alone.

