#Functions that outline the model to be used

"""
# Species Carbon flux
    dcdtSpecies(C::Float64,Sp::Species,T::Float64,k::Float64)

Gives the carbon mass change based on species parameters and current biomass
"""
function dcdtSpecies(C::Float64,Sp::Species,T::Float64,k::Float64,N::Float64)
    R_p = C * (Sp.R0_p * exp(-Sp.E_p / (k * (273.15+T)))) * (N / (Sp.K_s + N))
    R_r = C * (Sp.R0_r * exp(-Sp.E_r / (k * (273.15+T))))
    dC = (R_p - R_r)
    return(dC)
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

    for i = 1:S
        dcdt[i] = dcdtSpecies(C[i],p[:Com][i],p[:T],p[:k],C[end])
    end

    dcdt[end] = p[:D]*(p[:N_Max] - C[end]) - sum(dcdt)

    #Shampine et al advice
    for i = 1:length(dcdt)
        if C[i] < 0.0
         dcdt[i] = max(0,dcdt)
        end
    end

    return(dcdt)
end
