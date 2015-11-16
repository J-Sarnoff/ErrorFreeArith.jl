module ErrorFreeArith

export eftSum2, eftSum2inOrder, eftDiff2, eftDiff2inOrder, eftProd2, eftDiv2, eftRecip, eftSqrt

@inline function eftSum2{T<:AbstractFloat}(a::T, b::T)
  x = a + b
  t = x - a
  y = (a - (x - t)) + (b - t)
  x,y
end


@inline function eftSum2inOrder{T<:AbstractFloat}(a::T, b::T)
  x = a + b
  y = b - (x - a)
  x,y
end


@inline function eftDiff2{T<:AbstractFloat}(a::T, b::T)
  x = a - b
  t = x - a
  y = (a - (x - t)) - (b + t)
  x,y
end


@inline function eftDiff2inOrder{T<:AbstractFloat}(a::T, b::T)
  x = a - b
  y = (a - x) - b
  x,y
end

@inline function eftProd2{T<:AbstractFloat}(a::T, b::T)
    x = a * b
    y = fma(a, b, -x)
    x,y
end

# !!sassafrass!!
# 'y' must be negated to get the right result
@inline function eftDiv2{T<:AbstractFloat}(a::T,b::T)
     x = a/b
     y = -(fma(x,b,-a)/b)
     x,y
end

# !!sassafrass!!
# 'y' must be negated to get the right result
@inline function eftRecip{T<:AbstractFloat}(a::T)
     x = one(T)/a
     y = -(fma(x,a,-1.0)/a)
     x,y
end

#=
   While not strictly an error-free transformation it is quite reliable and recommended for use.
   Augmented precision square roots, 2-D norms and discussion on correctly reounding sqrt(x^2 + y^2)
   by Nicolas Brisebarre, Mioara Joldes, Erik Martin-Dorel, Hean-Michel Muller, Peter Kornerup
=#
@inline function eftSqrt(a::AbstractFloat)
     x = sqrt(a)
     t = fma(x,-x,a)
     y = t / (x*2.0)
     x,y
end 

end # module

