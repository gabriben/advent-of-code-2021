using DelimitedFiles

function increaseSum(x)
    sub = vcat(x, 0) - vcat(missing, x)
    return sum(skipmissing(sub[1:end-1] .> 0))
end

d = readdlm("input.txt")

increaseSum(d)

aggs = [sum(d[i:i+2]) for i in 1:(length(d) - 2)]

increaseSum(aggs)
