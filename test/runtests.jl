using EcoFunc
using Base.Test

# write your own tests here
@test 1 == 2

#Problems
#1) negative biomass changes contribute to the nutrient concentration
#         -We only want it to be removed by +ve growth



a = community(10,
          1.0,0.32,293.15,
          0.1,0.65,293.15,
          10.0,0.00,293.15,
          0.3)

C = rand(10)/1000

results = zeros(100)

for i = 1:100
          p = make_parameters(a,T = linspace(273.15,280.0,100)[i])
          s = simulate(p,C,exp(1),stop = 1000)
          uptake = 0.0;
          for sp in 1:10
                    uptake += boltzman(p[:Com][sp].P,p[:T]) *
                              # n_lim(s[:C][end,end],boltzman(p[:Com][sp].Ks,p[:T])) *
                              s[:C][end,sp]
          end
          results[i] =  uptake
end

plot(linspace(273.15,280.0,100),results)
