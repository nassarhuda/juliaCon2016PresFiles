using JLD
d = load("GOT.jld")
A = d["A"]
xy = d["xy"]

using PyPlot

function graphplot(A,xy)
    (ei,ej,w) = findnz(triu(A))
    lx = [xy[ei,1]';xy[ej,1]';NaN*ones(1,length(ei))]
    ly = [xy[ei,2]';xy[ej,2]';NaN*ones(1,length(ei))]
    for i = 1:length(w)
        PyPlot.plot(lx[:,i],ly[:,i],linewidth=1,alpha=0.5,color=[0.0,0.0,0.0],zorder = 0)
    end
    PyPlot.axis("off")
end

graphplot(A,xy)
P = PyPlot.scatter(xy[:,1],xy[:,2],38,edgecolors="none",zorder=2,color=[0.0,0.0,1.0])
savefig("GOT.eps")
close()