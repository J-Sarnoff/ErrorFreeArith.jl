# ErrorFreeArith.jl
#### Error-Free transformations for arithmetic ops
```ruby
                         Jeffrey Sarnoff            2015-Nov-20
```
 

There are two versions, one is inlined.  To use the inlined version, before loading do this:

inlineErrorFreeArith = true

Exports: eftSum2, eftDiff2, eftProd2, eftDiv2, eftSum3, eftProd3, eftFMA, and a few others

Use:  hi, lo = eft<function>()

The lo part is the residual value not captured in the high part.
The ideal result is much closer to hi+lo (in extended precision).

Runs as fast as it may, with hardware fma -- faster.

