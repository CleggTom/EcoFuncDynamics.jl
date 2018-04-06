#Code that makes the parameters object for simualtions

"""
# Make Parameters

    make_parameters(Com::Community; CPool::Bool = true, T::Float64 = 15.0)

This function makes a dictionary containing all the parameters required for
simulations. The only mandatory argument is a vector of species (a community).

## Parameters
* `Com::Community` : The vector of species types that includes all species.
* `CPool::Bool = true` : determines wether a Carbon pool links autotrophs and heterotrophs
* `T::Float64 = 15.0` : The temperature at which the simulation occurs.
"""
function make_parameters(Eco::Ecosystem; T::Float64 = 295.0)

        @assert length(find(x -> isa(x,Cpool) , Eco.sp)) == 1
        @assert length(find(x -> isa(x,Spool) , Eco.sp)) == 1

        s_i = find(x -> isa(x,Spool), Eco.sp)[1]
        c_i = find(x -> isa(x,Cpool), Eco.sp)[1]

        p = Dict{Symbol,Any}(:Eco => Eco,
                             :T => T,
                             :s_i => s_i,
                             :c_i => c_i)
        return(p)
end
