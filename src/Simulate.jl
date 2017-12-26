#Function that preforms the simualtions

"""
# Simulate


"""

function simulate(p::Dict{Symbol,Any}, C::Array{Float64};
    start::Int64=0, stop::Int64=500, use::Symbol=:nonstiff)

    @assert stop > start
    @assert length(C) == p[:S]
    @assert use ∈ vec([:stiff :nonstiff])

    # Pre-allocate the timeseries matrix
    t = (float(start), float(stop))
    t_keep = collect(start:1.0:stop)

    # Pre-assign function
    f(t, c) = dcdtCommunity(t, c, p)

    # Perform the actual integration
    prob = ODEProblem(f, C, t)

    if use == :stiff
    alg = Rodas4()
    else
    alg = Tsit5()
    end

    sol = solve(prob, alg, dtmax = 1, saveat=t_keep, dense=false, save_timeseries=false)

    output = Dict{Symbol,Any}(
    :p => p,
    :t => sol.t,
    :C => hcat(sol.u...)'
    )

end
