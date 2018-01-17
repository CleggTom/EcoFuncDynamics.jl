#Code that makes the parameters object for simualtions

"""
# Make Parameters

    make_parameters(Com::Vector{Species}; T::Float64 = 15.0,
                    D::Float64 = 0.25, N_Max::Float64 = 10.0)

This function makes a dictionary containing all the parameters required for
simulations. The only mandatory argument is a vector of species (a community).

## Parameters

* `Com::Vector{Species}` : The vector of species types that includes all species.
* `S::Int64` : The number of species (calculated internaly).
* `T::Float64 = 273.15` : The temperature``(K)`` at which the simulation occurs.
* `D::Float64 = 0.25` : The nutrient turnover.
* `N_Supply:Float64 = 10.0` : The nutrient supply concentration.
"""
function make_parameters(Com::Vector{Species}; T::Float64 = 15.0,
                         D::Float64 = 0.25, N_supply::Float64 = 10.0)

    S = length(Com)

    params = Dict(:Com => Com,
                  :S => S,
                  :T => T,
                  :D => D,
                  :N_supply => N_supply)

    check_parameters(params)
    return(params)
end

"""
# Check Parameters
    check_parameters(p::Dict{Symbol,Any})

Checks the created parameters and makes sure all values are the
correct types and have the right dimensions. Used internaly by `make_parameters`
.
"""
function check_parameters(p::Dict{Symbol,Any})
    #check types
    @assert isa(p[:Com],Vector{Species})
    @assert isa(p[:S],Int)
    @assert isa(p[:T],Float64)
    @assert isa(p[:D],Float64)
    @assert isa(p[:N_supply],Float64)


    #check dimensions
    @assert length(p[:Com]) == p[:S]
end
