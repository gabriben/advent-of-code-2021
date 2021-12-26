using DelimitedFiles
using StaticArrays
using Pipe
using DataFrames
using Underscores

d = open("5.txt") do f readlines(f) end

d = split.(d, " -> ")
start = [i[1] for i in d]
finish = [i[2] for i in d]
start = @pipe start |> split.(_, ",") |>  hcat(_...) |> parse.(Int, _) |> transpose
finish = @pipe finish |> split.(_, ",") |>  hcat(_...) |> parse.(Int, _) |> transpose
d = DataFrame(hcat(start, finish), [:x1, :y1, :x2, :y2])
