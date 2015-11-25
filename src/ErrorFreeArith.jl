module ErrorFreeArith

export eftRecip, eftSquare, eftCube, eftSqrt, eftRecipSqrt, # see comment for eftSqrt
       eftSum2, eftSum2inOrder, eftDiff2, eftDiff2inOrder, eftProd2, eftDiv2

if isdefined(:inlineErrorFreeArith) && (inlineErrorFreeArith == true)
   include("inlined.jl")
else
   include("funcall.jl")
end

end # module

