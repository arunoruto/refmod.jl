include("setup.jl")

@testset "RefMod Tests" begin
    include("gradient.jl")
    include("h-function.jl")
    include("phase-function.jl")
    include("coefficients.jl")
    include("roughness.jl")
end
