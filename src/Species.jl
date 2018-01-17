#Code for the species type and for the automatic creation of communities

"""
# Species Type

    Species(R0_p::Float64,E_p::Float64,R0_r::Float64,E_r::Float64,K_s::Float64)

Custom type that contains the parameter values for each species.

## Values
* `R0_p::Float64` : The normalisation constant of photosynthetic rate.
* `E_p::Float64` : The temperature sensitivity of  photosynthetic rate.
* `R0_r::Float64` : The normalisation constant of respiration rate.
* `E_r::Float64` : The temperature sensitivity of  respiration rate.
* `K_s::Float64` : The half saturation densitiy of nutrient uptake.
* 'ϵ::Float64' : The uptake efficency
"""
struct Species
    R0_p::Float64
    E_p::Float64
    R0_r::Float64
    E_r::Float64
    K_s::Float64
    ϵ::Float64
end


"""
# Generate Community

    community(S::Int64,R0_p::Float64,E_p::Float64,
                       R0_r::Float64,E_r::Float64,
                       K_s::Float64 ,ϵ::Float64)

Generates a community of identical species given `R0, E,  K_s and ϵ` values and
the number of species.
"""
function community(S::Int64,R0_p::Float64,E_p::Float64,
                            R0_r::Float64,E_r::Float64,
                            K_s::Float64 ,ϵ::Float64)

    return(fill(Species(R0_p,E_p,R0_r,E_r,K_s,ϵ),S))
end

"""
    community(R0_p::Array{Float64},E_p::Array{Float64},
              R0_r::Array{Float64},E_r::Array{Float64},K_s::Array{Float64})

Can also take arrays giving specific values
"""
function community(R0_p::Array{Float64},E_p::Array{Float64},
                   R0_r::Array{Float64},E_r::Array{Float64},
                   K_s::Array{Float64} ,ϵ::Array{Float64})

    @assert length(R0_p) == length(E_p) ==
            length(R0_r) == length(E_r) ==
            length(K_s)  == length(ϵ)

    sp = Array{Species}(size(R0,1))

    for i = 1:size(R0,1)
        sp[i] = Species(R0_p[i],E_p[i],R0_r[i],E_r[i],K_s[i],ϵ[i])
    end
    return(sp)
end
