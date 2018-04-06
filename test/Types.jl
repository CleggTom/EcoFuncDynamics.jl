#Tests for the types Code

#TPC Type
tpc = TPC(1.,0.65,295.)
@test typeof(tpc) == TPC

#Compartment Supertype
@test issubtype(Species,Compartment)
@test issubtype(Resource,Compartment)

#Species Super
@test issubtype(Autotroph,Species)
@test issubtype(Heterotroph,Species)

#Autotroph type
auto = Autotroph(tpc,.1,.1,tpc,.1,.1)
@test typeof(auto) == Autotroph

#Heterotroph type
het = Heterotroph(.1,.1,tpc,.1,tpc,.1,.1)
@test typeof(het) == Heterotroph

#Resource Type
@test issubtype(Cpool,Resource)
@test issubtype(Spool,Resource)

#Cpool
C = Cpool(true)
@test isa(C,Cpool)

#Spool
S = Spool(0.0)
@test isa(S,Spool)

#Community Type
comp = [auto,het,C,S]
eco = Ecosystem(comp)
@test typeof(eco) == Ecosystem
@test eco.N_sp == length(comp)
