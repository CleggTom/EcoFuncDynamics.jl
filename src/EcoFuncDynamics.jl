module EcoFuncDynamics

    using DifferentialEquations

    export simulate,
           make_parameters

    include(joinpath(".", "Types.jl"))
    include(joinpath(".", "Parameters.jl"))
    include(joinpath(".", "Constants.jl"))
    include(joinpath(".", "dcdt.jl"))
    include(joinpath(".", "simulate.jl"))
    include(joinpath(".", "EcosystemFunction.jl"))


end # module