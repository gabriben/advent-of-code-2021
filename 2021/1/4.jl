using DelimitedFiles
using StaticArrays
using Pipe

d = open("4.txt") do f readlines(f) end

d = split.(d, ",")

draws = parse.(Int, d[1])

n = sum([d[i] == [""] for i in 1:length(d)])

boards = Array{Int}(undef, n, 5, 5)

N = 1
L = 1
for i in 3:length(d)
    # @show i
    if d[i] != [""]
        boards[N,L,:] = @pipe d[i] |> split.(_, " ")[1] |> filter!(e->e≠"",_) |>  parse.(Int, _)
        L += 1
    else
        L = 1
        N += 1
    end
end


result = zeros(Int, n, 5, 5)
score = 0


for digit in draws
    local winBoard
    result = result .+ (boards .== digit)
    rowResult = sum(result, dims= 2) .== 5
    colResult = sum(result, dims= 3) .== 5
    @show digit
    @show sum(rowResult) + sum(colResult)
    if sum(rowResult) + sum(colResult) == 1
        if sum(rowResult) == 1
            whichWin = sum(rowResult, dims = 3) .== 1
            whichWin = findall(x -> x == 1, whichWin[:,:,1][:])
        end
        if sum(colResult) == 1
            whichWin = sum(colResult, dims = 2) .== 1
            whichWin = findall(x -> x == 1, whichWin[:,:,1][:])
        end
        
        winBoard = boards[whichWin, :, :]
        sumBoard = sum(winBoard .* ((result[whichWin, :, :] .- 1) .* (-1)))
        score = sumBoard * digit
    end
    if score > 0
        break
    end
end

score

# part 2


result = zeros(Int, n, 5, 5)
score = 0
whichNotWon = 0

for digit in draws
    result = result .+ (boards .== digit)
    rowResult = sum(result, dims= 2) .== 5
    colResult = sum(result, dims= 3) .== 5
    @show digit
    yetToBeWon = sum(sum(rowResult, dims = 3) .== 0 .+ sum(colResult, dims = 2) .== 0)
    @show yetToBeWon
    if yetToBeWon == 1

        whichNotWon = sum(rowResult, dims = 3) .== 0 .+ sum(colResult, dims = 2) .== 0
        whichNotWon = findall(x -> x == 1, whichNotWon[:,:,1][:])
        @show whichNotWon
    end
    
    if yetToBeWon == 0
        whichJustWon = whichNotWon
        winBoard = boards[whichJustWon, :, :]
        sumBoard = sum(winBoard .* ((result[whichJustWon, :, :] .- 1) .* (-1)))
        score = sumBoard * digit
    end
    if score > 0
        break
    end
end

score
