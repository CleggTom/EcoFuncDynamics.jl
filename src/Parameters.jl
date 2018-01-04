#Code that makes the parameters object for simualtions

"""
# Make Parameters

    make_parameters(Com::Vector{Species}; T::Float64 = 15.0, k::Float64 = 8.617
    * 10^-5.0, D::Float64 = 0.25, N_Max::Float64 = 10.0)

This function makes a dictionary containing all the parameters required for
simulations. The only mandatory argument is a vector of species (a community).

## Parameters

* `Com::Vector{Species}` : The vector of species types that includes all species.
* `S::Int64` : The number of species (calculated internaly).
* `T::Float64 = 15.0` : The temperature at which the simulation occurs.
* `k::Float64 = 8.617 * 10^-5.0` : The boltzman constant.
* `D::Float64 = 0.25` : The nutrient turnover.
* `N_Max:Float64 = 10.0` : The maximum nutrient concentration.
"""
function make_parameters(Com::Vector{Species}; T::Float64 = 15.0,
    k::Float64 = 8.617 * 10^-5.0)

    S = length(Com)

    params = Dict(:Com => Com,
                  :S => S,
                  :T => T,
                  :k => k)

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
    @assert isa(p[:k],Float64)


    #check dimensions
    @assert length(p[:Com]) == p[:S]
end
