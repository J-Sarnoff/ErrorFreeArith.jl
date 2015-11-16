module ErrorFreeArith

export eftSum2, eftSum2inOrder, eftDiff2, eftDiff2inOrder, eftProd2, eftDiv2, eftRecip, eftSqrt

if isdefined(:inlineErrorFreeArith) && (inlineErrorFreeArith == true)
   import("inlined.jl")
else
   import("funcall.jl")
end

end # module

