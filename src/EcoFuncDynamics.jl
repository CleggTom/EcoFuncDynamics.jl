module EcoFuncDynamics

    using DifferentialEquations

    export TPC, Compartment, Species, Heterotroph, Autotroph, Resource, Cpool, Spool
    export Parameter,simulate,eco_func


    include(joinpath(".", "Types.jl"))
    include(joinpath(".", "Parameters.jl"))
    include(joinpath(".", "Constants.jl"))
    include(joinpath(".", "dcdt.jl"))
    include(joinpath(".", "Simulate.jl"))
    include(joinpath(".", "EcosystemFunction.jl"))


end # module
