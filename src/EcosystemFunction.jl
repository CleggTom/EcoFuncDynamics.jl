#Code that calculates C flux (photosynthesis and respiration) given a community

"""
# Individual compartment function

    individual_func(comp::Autotroph,u::Array{Float64},p::Dict{Symbol,Any},i::Int64)


"""
function individual_func(comp::Autotroph,u::Array{Float64},p::Dict{Symbol,Any},
    i::Int64)

    in = u[i]  * limit(u[p[:s_i]],comp.ks) * boltzman(comp.P,p[:T])
    out = u[i] * boltzman(comp.R,p[:T])

    return(in - out)
end

"""
## Heterotroph

    individual_func(comp::Autotroph,u::Array{Float64},p::Dict{Symbol,Any},i::Int64)


"""
function individual_func(comp::Heterotroph,u::Array{Float64},p::Dict{Symbol,Any},
    i::Int64)

     - u[i] * boltzman(comp.R,p[:T])

end


"""
# Ecosystem Function

    dcdt(dc,c,p,t)

Defines the system of equations to be used by the solver.
"""
function eco_func(u,p)
    Flux = zeros(u)
    #move through and return dc
        for i in 1:length(p[:Eco].sp)
            if isa(p[:Eco].sp[i],Species)
                Flux[i] = individual_func(p[:Eco].sp[i],u,p,i)
            end
        end

    return(Flux)
end
