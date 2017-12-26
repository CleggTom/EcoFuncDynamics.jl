#Code for the species type and for the automatic creation of communities

"""
# Species Type

    Species(R0_G::Float64,E_G::Float64)

Custom type that contains the parameter values for each species.

## Arguments
* `R0_G::Float64` : The normalisation constant of the growth rate.
* `E_G::Float64` : The activation energy or temperature sensitivity of the growth rate.
"""
struct Species
    R0_G::Float64
    E_G::Float64
end


"""
# Generate Community

    community(S::Int64,R0::Float64,E::Float64)

Generates a community of identical species given `R0` and `E` values and the
number of species.
"""
function community(S::Int64,R0::Float64,E::Float64)
    return(fill(Species(R0,E),S))
end

"""
    community(R0::Array{Float64},E::Array{Float64})

Can also take arrays giving specific values
"""
function community(R0::Array{Float64},E::Array{Float64})
    @assert length(R0) == length(E)

    sp = Array{Species}(size(R0,1))
    for i = 1:size(R0,1)
        sp[i] = Species(R0[i],E[i])
    end
    return(sp)
end
