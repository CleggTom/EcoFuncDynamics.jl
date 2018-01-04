#Functions that outline the model to be used
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
function SpeciesResp(C::Float64,Sp::Species,T::Float64,k::Float64,N::Float64)
    R_r = C * (Sp.R0_r * exp(-Sp.E_r / (k * (273.15+T))))
    return(R_r)
end


"""
# Community Carbon Flux
    dcdtCommunity(t,C,p::Dict{Symbol,Any})

Gives the carbon mass change across a whole community. Note that the last carbon
mass is the nutrient concentration

"""

function dcdtCommunity(t,C,p::Dict{Symbol,Any})
    dcdt = zeros(length(C))

    S = length(p[:Com])

    SpResp = zeros(S)
    SpPhot = zeros(S)

    for i = 1:S
        SpResp[i] = SpeciesResp(C[i],p[:Com][i],p[:T],p[:k],C[end])
        SpPhot[i] = SpeciesPhoto(C[i],p[:Com][i],p[:T],p[:k],C[end])
    end

    dcdt[1:end-1] = SpPhot .- SpResp

    dcdt[end] = sum(SpResp) - sum(SpPhot)

    #Shampine et al advice
    for i = 1:length(dcdt)
        if C[i] < 0.0
         dcdt[i] = max.(0,dcdt)
        end
    end

    return(dcdt)
end
