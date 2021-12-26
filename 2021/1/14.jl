using DelimitedFiles
using StaticArrays
using Pipe
using DataFrames
using Underscores
using StatsBase

d = open("14.txt") do f readlines(f) end

p = d[1]

t = @pipe d[3:end] |> split.(_, " -> ") |>  hcat(_...) |> permutedims
# transpose doesn't work here
# https://discourse.julialang.org/t/transpose-of-an-array-of-strings/40431/3

for j in 1:10

    n = string(p[1])
    
    for i in 1: (length(p) - 1)
        n *= t[t[:,1] .== p[i:i+1], 2][1] * p[i+1]
    end

    p = n
    
end


freq = countmap([c for c in p])

maximum(values(freq)) - minimum(values(freq))


# part 2

t = hcat(t, string.(last.(t[:,1])) .* t[:,2])

t = hcat(t, zeros(Int, size(t)[1]))

for j in 1:40

    @show j

    n = string(p[1])
    
    for i in 1 : (length(p) - 1)
        if t[t[:,1] .== p[i:i+1], 4] == [0]:
            @views n *= t[t[:,1] .== p[i:i+1], 3][1]
            @views t[t[:,1] .== p[i:i+1], 4] += [1]
        else
            @views t[t[:,1] .== p[i:i+1], 4] += [1]
        end
        
        # https://discourse.julialang.org/t/why-is-a-manual-in-place-addition-so-much-faster-than-and-on-range-indexed-arrays/3302
    end

    p = n
    
end


