using EcoFuncDynamics
using Plots
using BenchmarkTools

gr()


#get data
# P = EcoFuncDynamics.TPC(1.2e-05,0.45277277,295.)
# Ra = EcoFuncDynamics.TPC(1.5e-06,0.7692876,295.)

P = TPC(1e1,0.32,295.)
Ra = TPC(1e0,0.65,295.)

μ = TPC(1e1,0.78,295.)
Rh = TPC(1e0,0.65,295.)

aut = Autotroph(P,0.8,0.1,Ra,.1,.1)
het = Heterotroph(0.8,0.1,μ,1.0,Rh,.1,.1)

C = Cpool(true)
S = Spool(10.)
eco = [aut,het,C,S]

#make parameters
p = Parameter(eco)

C = [1.,1.,1.,1.]

simulate(p,C,0,100)

Juno.profiler()
