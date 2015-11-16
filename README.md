# ErrorFreeArith.jl
error free transformations for arithmetic ops

There are two versions, one is inlined.  To use the inlined version, before loading do this:

inlineErrorFreeArith = true

Exports: eftSum2, eftDiff2, eftProd2, eftDiv2, and a few others

hi, lo = eftFn()

The lo part is the residual value not captured in the high part.
