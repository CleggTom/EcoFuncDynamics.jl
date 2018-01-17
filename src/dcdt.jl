#Functions that outline the model
"""
# Boltzman Curve
    boltzman(B0::Float64,E::Float64,T::Float64,T_ref::Float64)

Calculates the rate at temperature `T` given a set of parameters with the
function:
```math
B = B0  exp((-E/k)((1/T)-(1/T_{ref})))
```

"""
function boltzman(B0::Float64,E::Float64,T::Float64,T_ref::Float64)
    return( B0 * exp((-E/(8.617 * 10^-5.0)) * ((1/T)-(1/T_ref))))
end


"""
    boltzman(params::TpcParams,T::Float64)

Can also take a `TpcParams` object instead of individual parameters
"""
function boltzman(p::TpcParams,T::Float64)
    return( p.B0 * exp((-p.E/(8.617 * 10^-5.0)) * ((1/T)-(1/p.T_ref))))
end

"""
# Nutrient Limitation
    n_lim(S::Float64,Ks::Float64)

returns the amount of nutrient limitation
"""
function n_lim(S::Float64,Ks::Float64)
    return(S/(Ks+S))
end

"""
# Community Carbon Flux
    dcdtCommunity(t,C,p::Dict{Symbol,Any})

Gives the carbon biomass change across a whole community. Note that the last
variable in the simulation is the nutrient concentration, not in carbon units.

"""

function dcdtCommunity(t,C,p::Dict{Symbol,Any})
# Preassign vectors to store fluxes
    dcdt = zeros(length(C))
    S = length(p[:Com])

#calculate S gains
    dcdt[end] = (p[:D]*(p[:N_supply] - C[end]))

# Calculuate the fluxes for species carbon biomass change
    for i = 1:S
        # P-R
        F = (boltzman(p[:Com][i].P,p[:T]) - boltzman(p[:Com][i].R,p[:T]))
        # N-Lim
        F *= n_lim(C[end],boltzman(p[:Com][i].Ks,p[:T])) * C[i]
        # Take from N-gain
        F > 0.0 ? dcdt[end] -= F : dcdt[end]
        # Scale by Biomass + efficency
        dcdt[i] = p[:Com][i].ϵ * F
    end

# Shampine et al. advice (to avoid negative biomass/nutrient concentrations)
    # for i = 1:length(dcdt)
    #     if C[i] < 0.0
    #       dcdt[i] = max.(0,dcdt)
    #     end
    # end

    return(dcdt)
end
