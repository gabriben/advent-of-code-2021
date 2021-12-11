using DelimitedFiles
using StaticArrays
using Pipe

d = open("input3.txt") do f readlines(f) end

d = @pipe d |> split.(_, "") |> hcat(_...) |> parse.(Int, _) |> transpose
# https://stackoverflow.com/questions/29164632/how-to-convert-arrayarrayfloat64-1-1-to-matrix-in-julia

# mostCommon(x) = (sum(x, dims = 1) .> size(x)[1]/2) * 1
mostCommon(x, i) = (sum(x[:, i]) => size(x)[1]/2) * 1

γbin = (sum(d, dims = 1) .> size(d)[1]/2) * 1
εbin = (γbin .- 1) .* (-1)
#εbin = (sum(d, dims = 1) .< size(d)[1]/2) * 1

γ = parse(Int,join(string.(γbin)), base = 2)
ε = parse(Int,join(string.(εbin)), base = 2)

γ * ε

# part 2

CO2 = d
oxygen = d
for i in 1:size(d)[2]
    mostBin = mostCommon(CO2, i)
    leastBin = (mostCommon(oxygen, i) - 1) * (-1)
    oxygen = oxygen[oxygen[:, i] .== mostBin,:]
    prin("hi")
    print(oxygen)
    flush(stdout)
    CO2 = CO2[CO2[:, i] .== leastBin,:]
end
    

d[d[:, 1] .== 1, :]

d .== γbin

d[prod(d .== γbin, dims=2)[:,1],:]
d[prod(d .== εbin, dims=2)[:,1],:]97


d[:, [1]][:, 1] == 1

d[:, [1]]

hcat([2,1], [3,4])[:,1]
