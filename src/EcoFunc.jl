module EcoFunc

    using DifferentialEquations

    export simulate,
           community,
           make_parameters


    include(joinpath(".", "Species.jl"))
    include(joinpath(".", "Community.jl"))
    include(joinpath(".", "Parameters.jl"))
    include(joinpath(".", "Simulate.jl"))
    include(joinpath(".", "dcdt.jl"))


end # module
