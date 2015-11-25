module ErrorFreeArith

export eftSum2, eftSum2inOrder, eftDiff2, eftDiff2inOrder, eftProd2, eftDiv2, eftRecip,
       eftSqrt, eftRecipSqrt, eftSquare, eftCube

if isdefined(:inlineErrorFreeArith) && (inlineErrorFreeArith == true)
   include("inlined.jl")
else
   include("funcall.jl")
end

end # module

