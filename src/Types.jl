#Code for the various types used in the simulations

"""
# TPC Type

    TPC(B0::Float64,E::Float64,Tr::Float64)

Custom type containing the parameters for a boltzman TPC
"""
struct TPC
    B0::Float64
    E::Float64
    Tr::Float64
end

"""
# Compartment Abstract Type

Abstract supertype for compartment objects
"""
abstract type Compartment end

"""
# Species Abstract Type

Abstract supertype for autotroph and heterotroph types. Subtype of the `Compartment` type.
"""
abstract type Species <: Compartment end

"""
# Autotroph Species Type
    Autotroph(P::TPC, ϵ::Float64, ks::Float64, R::TPC, D::Float64, a::Float64)

Type for autotroph species containing relevant parameters.

## Arguments
- `P::TPC` : Net photosynthesis TPC
- `ϵ::Float64` : Carbon use efficency
- `ks::Float64` : Half-saturation density of nutrient uptake
- `R::TPC` : Net Respiration TPC
- `D::Float64` : Loss rate
- `a::Float64` : Interspecific interference
"""
struct Autotroph <: Species
    P::TPC
    ϵ::Float64
    ks::Float64
    R::TPC
    D::Float64
    a::Float64
end

"""
# Heterotroph Species Type
    Heterotroph(ϵ::Float64, ks::Float64, R::TPC, D::Float64, a::Float64)

Type for heterotroph species containing relevant parameters.

## Arguments
- `ϵ::Float64` : Carbon use efficency
- `ks::Float64` : Half-saturation density of nutrient uptake
- `μ::TPC` : Maximum growth rate TPC
- `kc::Float64` : Half-saturation density of carbon uptake
- `R::TPC` : Net Respiration TPC
- `D::Float64` : Loss rate
- `a::Float64` : Interspecific interference

For unlinked simulations (i.e where the carbon pool does not link Autotroph and
Heterotroph compartments) set `kc = 0` to avoid arbon limitation.
"""
struct Heterotroph <: Species
    ϵ::Float64
    ks::Float64
    μ::TPC
    kc::Float64
    R::TPC
    D::Float64
    a::Float64
end

"""
# Ecosystem Pools

Abstract type for ecosystem resource pools
"""
abstract type Resource <: Compartment end

"""
# Carbon Pool

Type for the carbon pool for use in simulations.

## Arguments
- `linked::Bool` : Determines whether carbon enters the pool from other compartments
"""
struct Cpool <: Resource
    linked::Bool
end

"""
# Resource Pool

Type for the resource pool. Biologically this can be interperated as some limiting
nutrient or an other resource such as light.

## Arguments
-`R::Float64` : Refresh rate for the nutrient pool
"""

struct Spool <: Resource
    R::Float64
end

"""
# Ecosystem
    Ecosystem(sp::Array{Compartment})

Type for communities with multiple compartments.
"""
struct Ecosystem
    sp::Vector{Compartment}
    N_sp::Int8

    function Ecosystem(comp::Vector{Compartment})
        n::Int8 = length(comp)
        new(comp,n)
    end
end
