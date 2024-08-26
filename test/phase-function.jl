include("../src/hapke/functions.jl")

@testset "phase function tests" begin
    @testset "double Hanyey-Greenstein" begin
        p = double_henyey_greenstein(LinRange(0, 1, 10), 0.18, 1.1)
        @test p == [0.9224097096832116, 0.9841088950802653, 1.0518545991668653, 1.1266473003371191, 1.2096863798918371, 1.302425123769974, 1.4066436006532723, 1.5245467267973298, 1.6588983383879818, 1.8132076210091634]
    end
end
