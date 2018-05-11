using EcoFuncDynamics
using Plots, StatPlots
using BenchmarkTools
using GLM, DataFrames

gr()

#get data
# P = EcoFuncDynamics.TPC(1.2e-05,0.45277277,295.)
# Ra = EcoFuncDynamics.TPC(1.5e-06,0.7692876,295.)

P = TPC(5e0,0.62,295.)
Ra = TPC(1e0,1.38,295.)

μ = TPC(1e1,0.65,295.)
Rh = TPC(1e0,0.78,295.)

aut = Autotroph(P,0.3,1.0,Ra,.1,.1)
het = Heterotroph(0.3,1.0,μ,0.1,Rh,.05,.01)

C = Cpool(true)
S = Spool(10)
eco = [aut,het,C,S]

#make parameters
p = Parameter(eco,295.)
C0 = [1.,1.,1.,1.0] .* 1
sol = simulate(p,C0,0,30,0.1)

func = Vector{Float64}(length(sol.u))
for i = 1:length(sol.u)
    func[i] = sum(eco_func(sol[:,i],p),1)[1]
end
plot(func)



a = plot(sol,size = (200,200),ylim = (0,12),legend = false,
    label = ["Autotroph","Heterotroph","Carbon","Nutrient"],
    xaxis = "")

p = Parameter(eco,285.)
sol = simulate(p,C0,0,30,0.1)
b = plot(sol,size = (200,200),ylim = (0,12),
    label = ["Autotroph","Heterotroph","Carbon","Nutrient"],
    xaxis = "")

savefig(a,"/Users/Tom/Documents/Work/Projects/EcoFunc_miniproject/docs/QMEE_MiniSymp/images/dynamicsa")
savefig(b,"/Users/Tom/Documents/Work/Projects/EcoFunc_miniproject/docs/QMEE_MiniSymp/images/dynamicsb")

#plot functioning over simulation time
func = zeros(100)
for i = 1:100
    func[i] = sum(eco_func(sol[:,i],p))
end
plot(func)

function sim(eco,T,C)
    p = Parameter(eco,T)
    sol = simulate(p,C,0,300)
    return(sol)
end

function plot_sol(sol,i)
    title = string(linspace(275.0,315.0,100)[i])
    a = plot(sol, title = title)
    name = join(["run",i,".png"])
    path = joinpath("/Users/Tom/Desktop/EcoFuncFigs",name)
    savefig(a,path)
end

result = Array{Float64,2}(4,100)
endbiomass = Array{Float64,2}(4,100)
func_time = Array{Float64,2}(100,100)
for i in 1:100
    sol = sim(eco,linspace(275.0,315.0,100)[i],C0)
    # plot_sol(sol,i)

    func = zeros(100)
    for j = 1:100
        func[j] = sum(eco_func(sol[:,j],p))
    end
    func_time[:,i] = func
    result[:,i] = eco_func(sol[:,end],p)
    endbiomass[:,i] = sol[end]
end

plot(linspace(275.0,315.0,100),func_time,legend = false)

T = repeat(linspace(275.0,315.0,100), inner = 100)
F = hcat(func_time...)

scatter(T,F)

#plot the flux
plot(linspace(275.0,315.0,100),result')
plot(linspace(275.0,315.0,100),endbiomass')

fun = sum(result',2)
plot(linspace(275.0,315.0,100),fun)

#cleaning to log
fun = fun .- minimum(fun)

#start at minimum
index = findmin(fun)[2]+1:70
plot(fun[index])
#get -ves
result = fun[index]
Temp = collect(linspace(275.0,315.0,100)[index])
Temp = 1 ./ (Temp * EcoFuncDynamics.k)

a = plot(Temp,log.(result))
savefig(a,"/Users/Tom/Desktop/a.png")
df = DataFrame([Temp,log.(result)])
lm1 = fit(LinearModel, @formula(x2 ~ x1), df)
lm1
