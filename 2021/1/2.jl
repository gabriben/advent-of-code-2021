using DelimitedFiles

d = readdlm("input2.txt")

forward = sum(d[d[:, 1] .== "forward", 2])
down = sum(d[d[:, 1] .== "down", 2])
up = sum(d[d[:, 1] .== "up", 2])

(down-up) * forward

downAim = d[:,2]
upAim = d[:,2]
forward = d[:,2]
downAim[d[:, 1] .!= "down"] .= 0
upAim[d[:, 1] .!= "up"] .= 0
forward[d[:, 1] .!= "forward"] .= 0

aim = cumsum(downAim - upAim)
depth = sum(forward .* aim)
horiz = sum(forward)
depth * horiz
