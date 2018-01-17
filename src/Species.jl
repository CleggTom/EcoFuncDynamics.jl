#Code for the species and TpcParams type
"""
# Temperature preformance curve parameters

    TpcParams(B0::Float64, E::Float64, T_ref::Float64)

Type that contains the parameters needed to compute the TPC of a given process
"""
struct TpcParams
    B0::Float64
    E::Float64
    T_ref::Float64
end


"""
# Species Type

   Species(R::TpcParams, P::TpcParams, Ks::TpcParams, ϵ::Float64)

Type containing the parameters that define species thermal response and carbon
and nutrient uptake.
"""
struct Species
    #TpcParams
    P::TpcParams
    R::TpcParams
    Ks::TpcParams

    #Other traits
    ϵ::Float64
end
