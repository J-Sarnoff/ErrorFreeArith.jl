# ErrorFreeArith.jl
#### Error-Free transformations for arithmetic ops
```ruby
                         Jeffrey Sarnoff            2015-Nov-25
```
 

There are two versions, one is inlined.  To use the inlined version, before loading do this:

inlineErrorFreeArith = true

Exports: eftSum2, eftDiff2, eftProd2, eftDiv2, eftSum3, eftProd3, eftFMA, and a few others

Use:  hi, lo = eft<function>()

The lo part is the residual value not captured in the high part.
The ideal result is much closer to hi+lo (in extended precision).

Runs as fast as it may, with hardware fma -- faster.

```
These are distinct operators that substitute directly for (+),(-),(*),(/) in situations where one wants to obtain more of mathematically true result than is usually available:

two = 2.0; sqrt2 = sqrt(2);
residualValueRoundedAway = Float64(sqrt(big(2)) - sqrt2) # -9.667293313452913e-17
 
mostSignficantPart, leastSignificantPart = eftSqrt(two)
mostSignificantPart ==  1.4142135623730951
leastSignificantPart == -9.667293313452912e-17 # we recover the residual value, itself at Float64 precision 

so we obtain the arithmetic result at twice the 'working' precision (in two parts, the mspart == the usual result).

exp1log2 = exp(1.0)*log(2.0);                                                                       #  1.88416938536372
residualValueRoundedAway = Float64(exp(big(1))*log(big(2)) - exp1log2) #  8.146538547111741e-17

mostSignficantPart, leastSignificantPart = eftProd2( exp(1.0), log(2.0) )   # (1.88416938536372, -8.177744937186283e-17)

------
These transformations have the additional benefit that the two parts are well separated, they do not overlap in the working precision.
So, in all cases, mostSignificantPart + leastSignificantPart == mostSignificantPart.  
They are as well separated as possible, without losing information.

These functions are well-suited to assisting the implementation of extended precision Floating Point math.
Another application (that, until otherwise informed, I'll say is from me) is to accelerate inline rounding:
  (RoundFast.jl, there to see how).

Assuming one had a Float64 unum-ish capability, a double-double float would extend the precision.
(Ultimately, all these parts should meld)
```

