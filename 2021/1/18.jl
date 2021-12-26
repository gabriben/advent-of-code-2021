using DelimitedFiles
using StaticArrays
using Pipe
using DataFrames
using Underscores
using StatsBase

d = open("18.txt") do f readlines(f) end

function check_str(a)
    return tryparse(Float64, a) !== nothing
end

occursin(d[1][4], "123456789")

parse(Int, d[1][4])

for (i, char) in enumerate(d[1])
    @show i
    @show occursin(d[1][i+2], "123456789")
end

d[1][1:3] * d[1][6:end] 

(1 == 1) &
(3 == 3)

function findExplodingPair(x, char, i, iPlode, brackets, lastNum, exploded)
    if iPlode == 0
        exploded = occursin(char, "123456789") &
                   (brackets > 3) &
                   occursin(x[minimum([i+2, length(x)])], "123456789")
        if exploded
            iPlode = i
            if lastNum > 0
                @show lastNum
                @show brackets
                left = string(parse(Int, x[lastNum]) +
                                    parse(Int, char)
                                    )
                x = x[1 : (lastNum - 1)] * left * x[1 : (lastNum + 1)]
                @show left
            end
        end
        elseif occursin(char, "123456789")
            lastNum = i
        end

    end
    return x, iPlode, lastNum
end    


function explode(x)
    brackets = 0
    lastNum = 0
    iPlode = 0
    exploded = false
    
    for (i, char) in enumerate(x)
        if char == '['
            brackets +=1
        end
        if char == ']'
            brackets -=1
        end

        if iPlode == 0
            exploded = occursin(char, "123456789") &
                       (brackets > 3) &
                       occursin(x[minimum([i+2, length(x)])], "123456789")
            
            if exploded
                iPlode = i
                if lastNum > 0
                    @show lastNum
                    @show brackets
                    left = string(parse(Int, x[lastNum]) +
                                        parse(Int, char)
                                        )
                    x = x[1 : (lastNum - 1)] * left * x[1 : (lastNum + 1)]
                    @show left
                end
            elseif occursin(char, "123456789")
                lastNum = i
            end

        end        

        # @show x, char, i, iPlode, brackets, lastNum, exploded
        # (x, iPlode, lastNum) = findExplodingPair(x, char, i, iPlode, brackets, lastNum, exploded)
        @show exploded
        @show iPlode
        
        if occursin(char, "123456789") & (iPlode > 0)
            @show iPlode
            x[i] = string(parse(Int, x[i]) +
                          parse(Int, x[iPlode+2])
                          )
            x = x[1 : (iPlode - 1)] * "0" * x[(iPlode + 4) : end]
            break
        end
    end
    x
end         
            
@label escape_label






for char in d[1]
    @show char
end

parse(Int, d[1][4])

function isInt(x::Char)
    try
        parse(Int, x)
    catch e
        if isa(e, ArgumentError)
            false
        else
            true
        end
    end
end


function isInt(x::Char)
    try parse(Int, x) catch; false end
end

    
isInt(d[1][3])
            
        
    
convert(Int, string(d[1][4]))
    
Int(String(d[1][4]))




#####

d = eval.(Meta.parse.(d))

eval(Meta.parse.(d)[1])

eval([[9, 2], [[2, 9], 3]])

convert(Vector{Int64}, [[2, 9], 3])

eval([[9, 2], [1]])

add(x,y) = [x,y]

function nests(x)
    y = x[1]
    D = 1
    while length(y) != 1
        y = x[1]
        D += 1
        nests(y)
    end
    D
end


([1,2])

ffmap(f, x::Int) = f(x)
ffmap(f, x::Union{Tuple, Array}) = map(y -> ffmap(f, y), x)

ffmap(f, x::Int) = f(x)
ffmap(f, x::Array) = ffmap.(f, x)

ffmap(Float64, d[1])


#####

nested(x, n) = x * 0 + n

self(x) = x
self(5)

ffmap(f, x::Int, n) = f(n)
function ffmap(f, x::Array, n)
    n += 1
    ffmap.(f, x, n)
end
    

ffmap(self, d[1], 1)

ffmap(Float64, d[1], 1)

ffmap(Float64, d[1])



  
function blop(x, n)
    setfield!(x, name::Int64, n)
end

blop(x, n) = n

a[:] = 4
a = 3
blop(a, 4)

function wrong1_fill_with_twos!(v::Vector{Int64})
    v=[2 for ii in 1:length(v)]
end

function right1_fill_with_twos!(v::Vector{Int64})
    v[:]=[2 for ii in 1:length(v)]
end

v = [1,1]
right1_fill_with_twos!(v)
a[1]

nested(x::Int, n) = Int64(x)
nested(x::Array, n) = nested.(x, n+1)

nested(d[1])

nested

nested(f, x::Int) = f(x)
nested(f, x) = map(y -> nested(y), x)

nested(d[1])

nests = 0
x = x[1]

nests(d[1])

[size.(x) for x in d[1]]

add(d[1], d[2])

[[5, 6], [1, 2]]
