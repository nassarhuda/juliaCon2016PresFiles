using PyPlot
using MatrixNetworks
function graphplot(A,xy)
    (ei,ej,w) = findnz(triu(A))
    lx = [xy[ei,1]';xy[ej,1]';NaN*ones(1,length(ei))]
    ly = [xy[ei,2]';xy[ej,2]';NaN*ones(1,length(ei))]
    for i = 1:length(w)
        PyPlot.plot(lx[:,i],ly[:,i],linewidth=1,alpha=0.5,color=[0.0,0.0,0.0],zorder = 0)
    end
    PyPlot.axis("off")
end

using JLD
d = load("GOT.jld")
A = d["A"]
xy = d["xy"]
include("diffusions.jl")

M = MatrixNetwork(A)

n = size(A,1)

seed = 23 #Daenerys
target = 62 #Meera
(d,dt,pred) = bfs(M,seed,target)

graphplot(A,xy)
P = PyPlot.scatter(xy[:,1],xy[:,2],50,edgecolors="none",zorder=2,color=[0.0,0.0,1.0])

v = target
while v!=seed
    u = pred[v]
    lx = [xy[u,1];xy[v,1];NaN]
    ly = [xy[u,2];xy[v,2];NaN]
    # draw a line between u and v
    PyPlot.plot(lx,ly,linewidth=4,alpha=0.95,color=[1.0,0.0,0.0],zorder = 0)
    v = u
end
savefig("bfs.eps")