#Functions that outline the model to be used

"""
# Species Carbon flux
    dcdtSpecies(C::Float64,Sp::Species,T::Float64,k::Float64)

Gives the carbon mass change based on species parameters and current biomass
"""
function dcdtSpecies(C::Float64,Sp::Species,T::Float64,k::Float64)
    dC = C * ( Sp.R0_G * exp(-Sp.E_G / (k * (273.15+T)) ))
    return(dC)
end


"""
# Community Carbon Flux
    dcdtCommunity(t,C,p::Dict{Symbol,Any})

Gives the carbon mass change across a whole community

"""
function dcdtCommunity(t,C,p::Dict{Symbol,Any})
    S = length(p[:Com])

    dcdt = Vector{Float64}(S)
    for i = 1:S
        dcdt[i] = dcdtSpecies(C[i],p[:Com][i],p[:T],p[:k])
    end

    return(dcdt)
end
