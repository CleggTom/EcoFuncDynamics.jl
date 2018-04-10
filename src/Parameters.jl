#Code that makes the parameters object for simualtions

"""
# Make Parameters

    Parameter(Eco::Vector{Compartment}, T::Float64 = 295.0)

This function makes a dictionary containing all the parameters required for
simulations. The only mandatory argument is a vector of components (an ecosystem).

## Arguments
* `Eco::Vector{Compartment}` : The vector of species types that includes all species.
* `n_sp::Int64` : determines wether a Carbon pool links autotrophs and heterotrophs
* `T::Float64` : The temperature at which the simulation occurs.
* `s_i::Int64` : The index of the nutrient pool
* `c_i::Int64` : The index of the carbon pool
"""

struct Parameter
        Eco::Vector{Compartment}
        n_sp::Int64
        T::Float64
        s_i::Int64
        c_i::Int64

        function Parameter(Eco::Vector{Compartment}, T::Float64 = 295.0)

                @assert length(find(x -> isa(x,Cpool) , Eco)) == 1
                @assert length(find(x -> isa(x,Spool) , Eco)) == 1

                n_sp = length(Eco)
                s_i = find(x -> isa(x,Spool), Eco)[1]
                c_i = find(x -> isa(x,Cpool), Eco)[1]

                new(Eco,n_sp,T,s_i,c_i)
    end
end
