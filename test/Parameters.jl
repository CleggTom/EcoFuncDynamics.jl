#test the parameters functions

#get data
tpc = TPC(1.,0.65,295.)
auto = Autotroph(tpc,.1,.1,tpc,.1,.1)
het = Heterotroph(.1,.1,tpc,.1,tpc,.1,.1)
C = Cpool(false)
S = Spool(0.0)
comp = [auto,het,C,S]
eco = Ecosystem(comp)

#make parameters
p = make_parameters(eco)
@test isa(p,Dict{Symbol,Any})
