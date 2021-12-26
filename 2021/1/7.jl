using DelimitedFiles
using StaticArrays
using Pipe
using DataFrames
using Underscores
using Statistics

d = open("7.txt") do f readlines(f) end

pos = @pipe d |> split.(_, ",") |>  hcat(_...) |> parse.(Int, _)

optimal = median(pos)

fuel = abs.(optimal .- pos)

sum(fuel)

# part 2

alignment = [i for i in 1:maximum(pos)]

optimalFuel = 1e100

for a in alignment
    steps = abs.(a .- pos)
    totalFuel = sum([sum([j for j in 1 : i]) for i in steps])
    @show a
    @show totalFuel
    if totalFuel < optimalFuel
        optimalFuel = totalFuel
    end
end

optimalFuel

