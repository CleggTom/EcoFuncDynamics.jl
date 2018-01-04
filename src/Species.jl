#Code for the species type and for the automatic creation of communities

"""
# Species Type

    Species(R0_G::Float64,E_G::Float64)

Custom type that contains the parameter values for each species.

## Values
* `R0_G::Float64` : The normalisation constant of the max growth rate.
* `E_G::Float64` : The activation energy or temperature sensitivity of the max growth rate.
* `K_s::Float64` : The half saturation densitiy of nutrient uptake
"""
struct Species
    R0_G::Float64
    E_G::Float64
    K_s::Float64
end


"""
# Generate Community

    community(S::Int64,R0::Float64,E::Float64,K_s::Float64)

Generates a community of identical species given `R0, E and K_s` values and the
number of species.
"""
function community(S::Int64,R0::Float64,E::Float64,K_s::Float64)
    return(fill(Species(R0,E,K_s),S))
end

"""
    community(R0::Array{Float64},E::Array{Float64},K_s::Array{Float64})

Can also take arrays giving specific values
"""
function community(R0::Array{Float64},E::Array{Float64},K_s::Array{Float64})
    @assert length(R0) == length(E) == length(K_s)

    sp = Array{Species}(size(R0,1))
    for i = 1:size(R0,1)
        sp[i] = Species(R0[i],E[i],K_s[i])
    end
    return(sp)
end
