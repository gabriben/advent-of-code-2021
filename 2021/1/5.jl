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

xmax = maximum(hcat(d.x1, d.x2))
ymax = maximum(hcat(d.y1, d.y2))

grid = zeros(Int, xmax, ymax)

straights = (d.x1 .== d.x2) .+ (d.y1 .== d.y2) .> 0
d = d[straights, :]

transform!(d,
          [:x1, :x2] => max => :xmax,
          [:x1, :x2] => min => :xmin,
          [:y1, :y2] => max => :ymax,
          [:y1, :y2] => min => :ymin
          )

for i in eachrow(d)
    @views grid[i.xmin : i.xmax, i.ymin : i.ymax] .+= 1
    # https://discourse.julialang.org/t/why-is-a-manual-in-place-addition-so-much-faster-than-and-on-range-indexed-arrays/3302
    # @show grid[i.xmin : i.xmax, i.ymin : i.ymax]
end

sum(grid .> 1)


for i in eachrow(d)
    grid[i.xmin : i.xmax, i.ymin : i.ymax] .+= 1
end
sum(grid .> 1)


The focus of my research is on this and that

Working towards this agenda, I've been doing this and that

What are you are doing now (Intent based clustering)

What are you gonna do next


    
