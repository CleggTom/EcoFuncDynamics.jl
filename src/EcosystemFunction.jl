#Code that calculates C flux (photosynthesis and respiration) given a community

"""
# Individual compartment function

    individual_func(comp::Autotroph,u::Array{Float64},p::Parameter,i::Int64)


"""
function individual_func(comp::Autotroph,u::Array{Float64},p::Parameter,i::Int64)

    in = u[i]  * limit(u[p.s_i],comp.ks) * boltzman(comp.P,p.T) - (u[i]*u[i] * comp.a)
    out = u[i] * boltzman(comp.R,p.T)

    return(in - out)
end

"""
## Heterotroph

    individual_func(comp::Autotroph,u::Array{Float64},p::Parameter,i::Int64)


"""
function individual_func(comp::Heterotroph,u::Array{Float64},p::Parameter,i::Int64)

     - u[i] * boltzman(comp.R,p.T)

end


"""
# Ecosystem Function

    eco_func(u,p)

gets the net flux given a set of parameters
"""
function eco_func(u,p)
    Flux = zeros(u)
    #move through and return dc
        for i in 1:p.n_sp
            if isa(p.Eco[i],Species)
                Flux[i] = individual_func(p.Eco[i],u,p,i)
            end
        end

    return(Flux)
end
