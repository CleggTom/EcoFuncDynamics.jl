using EcoFuncDynamics
using Plots
gr()

function main()
    #get data
    P = EcoFuncDynamics.TPC(3,0.32,295.)
    Ra = EcoFuncDynamics.TPC(1,0.65,295.)
    μ = EcoFuncDynamics.TPC(5,0.98,295.)
    Rh = EcoFuncDynamics.TPC(1,0.65,295.)

    aut = EcoFuncDynamics.Autotroph(P,0.9,20.0,Ra,.1,.1)
    het = EcoFuncDynamics.Heterotroph(0.9,5.0,μ,1.0,Rh,.1,.1)

    C = EcoFuncDynamics.Cpool(true)
    S = EcoFuncDynamics.Spool(9.0)
    comp = [aut,het,C,S]
    eco = EcoFuncDynamics.Ecosystem(comp)

    #make parameters
    p = make_parameters(eco)

    C = [0.1,0.1,0.1,0.1]

    simulate(p,C,0,5000)
end

@time main()

@profile main()
Juno.profiler()




plot(sol)

u = sol[:,end]

EcoFuncDynamics.eco_func(u,p)

plot(sol(1:50,Val{1}))

@profile main()
