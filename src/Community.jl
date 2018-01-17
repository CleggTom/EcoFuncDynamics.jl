#Code that generates communities from TPC parameters


"""
# Generate Community

    community(S::Int64,P0::Float64,E_P::Float64,T_ref_P::Float64,
                       R0::Float64,E_R::Float64,T_ref_R::Float64,
                       Ks0::Float64,E_Ks::Float64,T_ref_Ks::Float64,
                       ϵ::Float64)

Generates a community of identical species given the TPC parameters for `P`,`R` and
`Ks`.
"""
function community(S::Int64,P0::Float64,E_P::Float64,T_ref_P::Float64,
                            R0::Float64,E_R::Float64,T_ref_R::Float64,
                            Ks0::Float64,E_Ks::Float64,T_ref_Ks::Float64,
                            ϵ::Float64)
    #generate individual TPC
    P = TpcParams(P0,E_P,T_ref_P)
    R = TpcParams(R0,E_R,T_ref_R)
    Ks = TpcParams(Ks0,E_Ks,T_ref_Ks)
    #Generate Species
    sp = Species(P,R,Ks,ϵ)
    #Return community Array
    return(fill(sp,S))
end

"""
    community(P0::Array{Float64},E_P::Array{Float64},T_ref_P::Array{Float64},
              R0::Array{Float64},E_R::Array{Float64},T_ref_R::Array{Float64},
              Ks0::Array{Float64},E_Ks::Array{Float64},T_ref_Ks::Array{Float64},
              ϵ::Float64)

Can also take arrays giving specific values
"""
function community(P0::Array{Float64},E_P::Array{Float64},T_ref_P::Array{Float64},
                   R0::Array{Float64},E_R::Array{Float64},T_ref_R::Array{Float64},
                   Ks0::Array{Float64},E_Ks::Array{Float64},T_ref_Ks::Array{Float64},
                   ϵ::Array{Float64})

    @assert length(P0) == length(E_P) == length(T_ref_P) ==
            length(R0) == length(E_R) == length(T_ref_R) ==
            length(Ks0) == length(E_Ks) == length(T_ref_Ks) ==
            length(ϵ)

    com = Array{Species}(size(R0,1))

    for i = 1:size(R0,1)
        #generate individual TPC
        P = TpcParams(P0[i],E_P[i],T_ref_P[i])
        R = TpcParams(R0[i],E_R[i],T_ref_R[i])
        Ks = TpcParams(Ks0[i],E_Ks[i],T_ref_Ks[i])
        #Generate Species
        sp = Species(P,R,Ks,ϵ[i])
        com[i] = sp
   end
    return(com)
end
