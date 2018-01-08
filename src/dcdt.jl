#Functions that outline the model
"""
# Species Photosynthetic Carbon flux
    dcdtSpecies(C::Float64,Sp::Species,T::Float64,k::Float64)

Gives the photosynthetic flux based on species parameters and current biomass
"""
function SpeciesPhoto(C::Float64,Sp::Species,T::Float64,k::Float64,N::Float64)
    R_p = C * (Sp.R0_p * exp(-Sp.E_p / (k * (273.15+T)))) * (N / (Sp.K_s + N))
    return(R_p)
end

"""
# Species Respiration Carbon flux
    dcdtSpecies(C::Float64,Sp::Species,T::Float64,k::Float64)

Gives the respiration flux based on species parameters and current biomass
"""
function SpeciesResp(C::Float64,Sp::Species,T::Float64,k::Float64)
    R_r = C * (Sp.R0_r * exp(-Sp.E_r / (k * (273.15+T))))
    return(R_r)
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
    SpResp = zeros(S)
    SpPhot = zeros(S)


# Calculuate the fluxes for species carbon biomass change
    for i = 1:S
        SpPhot[i] = SpeciesPhoto(C[i],p[:Com][i],p[:T],p[:k],C[end])
        SpResp[i] = SpeciesResp(C[i],p[:Com][i],p[:T],p[:k])
    end

# Get total carbon biomass change
    dcdt[1:end-1] = SpPhot .- SpResp

# Calculuate the nutrient concentration change
    dcdt[end] = (p[:D]*(p[:N_supply] - C[end])) - sum(SpPhot)

# Shampine et al. advice (to avoid negative biomass/nutrient concentrations)
    for i = 1:length(dcdt)
        if C[i] < 0.0
         dcdt[i] = max.(0,dcdt)
        end
    end

    return(dcdt)
end
