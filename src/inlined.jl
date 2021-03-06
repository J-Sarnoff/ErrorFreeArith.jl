#= single parameter error-free transformations =#

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

@inline function eftRecipSqrt(a::Float64)
     r = 1.0/a
     x = sqrt(r)
     t = fma(x,-x,r)
     y = t / (x*2.0)
     x,y
end

@inline function eftSquare(a::Float64)
    x = a * a
    y = fma(a, a, -x)
    x,y
end

@inline function eftCube(a::Float64)
    p = a*a; e = fma(a, a, -p)
    x = p*a; p = fma(p, a, -x)
    y = e*a
    x,y
end

#= two parameter error-free transformations =#

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

# 'y' must be negated to get the right result
@inline function eftDiv2{T<:AbstractFloat}(a::T,b::T)
     x = a/b
     y = -(fma(x,b,-a)/b)
     x,y
end

#= three parameter error-free transformations =#

function eftSum3{T<:Float64}(a::T,b::T,c::T)
    s,t = eftSum2(b, c)
    x,u = eftSum2(a, s)
    y,z = eftSum2(u, t)
    x,y = eftSum2inOrder(x, y)
    x,y,z
end

function eftSum3inOrder{T<:Float64}(a::T,b::T,c::T)
    s,t = eftSum2inOrder(b, c)
    x,u = eftSum2inOrder(a, s)
    y,z = eftSum2inOrder(u, t)
    x,y = eftSum2inOrder(x, y)
    x,y,z
end

function eftProd3{T<:Float64}(a::T, b::T, c::T)
    p,e = eftProd2(a,b)
    x,p = eftProd2(p,c)
    y,z = eftProd2(e,c)
    x,y,z
end

function eftFMA{T<:Float64}(a::T, b::T, c::T)
    x = fma(a,b,c)
    u1,u2 = eftProd2(a,b)
    a1,a2 = eftSum2(u2,c)
    b1,b2 = eftSum2(u1,a1)
    g = (b1-x)+b2
    y,z = eftSum2inOrder(g,a2)
    x,y,z
end

function eftFMS{T<:Float64}(a::T, b::T, c::T)
    x = fma(a,b,c)
    u1,u2 = eftProd2(a,b)
    a1,a2 = eftDiff2(u2,c)
    b1,b2 = eftSum2(u1,a1)
    g = (b1-x)+b2
    y,z = eftSum2inOrder(g,a2)
    x,y,z
end
