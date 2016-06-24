using Compose
include("diffusions.jl")
include("utils.jl")
using DiffusionAlgorithms
using DiffusionTutorialUtilities
utils = DiffusionTutorialUtilities
using PyPlot

using JLD
d = load("GOT.jld")
A = d["A"]
xy = d["xy"]
include("diffusions.jl")

n = size(A,1)

seed = 99 #Tyrion

bestset,bestcond = DiffusionAlgorithms.ppr_grow(A,seed)
fig = utils.cgraphplot(A,xy,bestset,seed)
img = PDF("figures/Tyrion.pdf",150mm,150mm)
draw(img,fig)
