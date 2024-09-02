include("../src/gradient.jl")


F_random = [
    0.757740130578333 0.706046088019609 0.823457828327293 0.438744359656398 0.489764395788231
    0.743132468124916 0.0318328463774207 0.694828622975817 0.381558457093008 0.445586200710899
    0.392227019534168 0.27692298496089 0.317099480060861 0.765516788149002 0.646313010111265
    0.655477890177557 0.0461713906311539 0.950222048838355 0.795199901137063 0.709364830858073
    0.171186687811562 0.0971317812358475 0.0344460805029088 0.186872604554379 0.754686681982361
]

@testset "gradient tests" begin
    @testset "gradient no scale integer" begin
        N = 5
        F = reshape(1:N^2, N, N)
        Fx, Fy = gradient(F)
        @test isapprox(Fx, ones(size(Fx)) .* N)
        @test isapprox(Fy, ones(size(Fy)))
    end

    @testset "gradient no scale random" begin
        Gx = [
            -0.0516940425587247 0.0328588488744796 -0.133650864181605 -0.166846716269531 0.0510200361318328
            -0.711299621747496 -0.0241519225745496 0.174862805357794 -0.124621211132459 0.0640277436178911
            -0.115304034573278 -0.0375637697366538 0.244296901594056 0.164606765025202 -0.119203778037738
            -0.609306499546403 0.147372079330399 0.374514255252955 -0.120428608990141 -0.0858350702789906
            -0.0740549065757142 -0.0683703036543265 0.0448704116592655 0.360120300739726 0.567814077427982
        ]

        Gy = [
            -0.0146076624534173 -0.674213241642188 -0.128629205351476 -0.0571859025633898 -0.0441781950773316
            -0.182756555522083 -0.214561551529359 -0.253179174133216 0.163386214246302 0.0782743071615168
            -0.0438272889736798 0.00716927212686663 0.127696712931269 0.206820722022027 0.131889315073587
            -0.110520165861303 -0.0898956018625212 -0.141326699778976 -0.289322091797312 0.0541868359355481
            -0.484291202365995 0.0509603906046936 -0.915775968335446 -0.608327296582685 0.0453218511242883
        ]

        Fx, Fy = gradient(F_random)
        @test isapprox(Fx, Gx)
        @test isapprox(Fy, Gy)
    end

    @testset "gradient with single scale random" begin
        Gx = [
            -0.0164547248032477 0.010459296445366 -0.042542391366012 -0.0531089592658936 0.0162401818942166
            -0.226413701641019 -0.0076877957258246 0.0556605596712177 -0.0396681635316591 0.0203806637836158
            -0.036702414121552 -0.0119569192695084 0.0777621189414567 0.052395960640254 -0.0379437410198702
            -0.193948282521659 0.0469099897983279 0.119211589963775 -0.0383336168209241 -0.0273221514510832
            -0.0235724088834668 -0.0217629435745599 0.0142826956282806 0.114629851940935 0.180740834359655
        ]

        Gy = [
            -0.00464976337295848 -0.214608740210729 -0.0409439477153396 -0.01820283813627 -0.0140623562468707
            -0.0581732183875757 -0.0682970630467279 -0.0805894341024501 0.0520074472607409 0.0249154858036975
            -0.0139506593649561 0.00228205019472354 0.0406471261591964 0.065833080487281 0.0419816728699314
            -0.0351796614163251 -0.0286146587972825 -0.0449856857213766 -0.0920940821104586 0.0172482055793041
            -0.154154677504931 0.0162211961332615 -0.291500544250707 -0.193636592537727 0.0144263932730109
        ]

        Fx, Fy = gradient(F_random, pi)
        @test isapprox(Fx, Gx)
        @test isapprox(Fy, Gy)
    end

    @testset "gradient with dimensional scale random" begin
        Gx = [
            -0.0172313475195749 0.0109529496248265 -0.0445502880605351 -0.0556155720898436 0.0170066787106109
            -0.237099873915832 -0.00805064085818319 0.0582876017859313 -0.0415404037108196 0.0213425812059637
            -0.0384346781910927 -0.0125212565788846 0.0814323005313521 0.0548689216750674 -0.0397345926792459
            -0.203102166515468 0.0491240264434664 0.124838085084318 -0.0401428696633804 -0.0286116900929969
            -0.0246849688585714 -0.0227901012181088 0.0149568038864218 0.120040100246575 0.189271359142661
        ]

        Gy = [
            -0.00365191561335432 -0.168553310410547 -0.0321573013378689 -0.0142964756408475 -0.0110445487693329
            -0.0456891388805207 -0.0536403878823399 -0.063294793533304 0.0408465535615755 0.0195685767903792
            -0.0109568222434199 0.00179231803171666 0.0319241782328172 0.0517051805055068 0.0329723287683966
            -0.0276300414653258 -0.0224739004656303 -0.035331674944744 -0.072330522949328 0.013546708983887
            -0.121072800591499 0.0127400976511734 -0.228943992083862 -0.152081824145671 0.0113304627810721
        ]

        Fx, Fy = gradient(F_random, [3, 4])
        @test isapprox(Fx, Gx)
        @test isapprox(Fy, Gy)
    end

    @testset "Errors" begin
        @test_throws ArgumentError gradient(zeros(5, 5), zeros(5, 5, 5, 5, 5, 5))
    end

    @testset "Normals" begin
        n_gt = cat(
            -1 * [-0.128684851976251 -0.988031169889811 -0.610392027469799 -0.282049620567648 -0.366189164096752
                -0.246575283941464 -0.901710372103414 -0.78253357102467 0.714947417037564 0.550376308702105
                -0.275999176936338 0.0669632644810228 0.435474011705333 0.731815610050747 0.646606901249411
                -0.176192006910476 -0.450607356712159 -0.342531768704931 -0.879523100023053 0.380280760696334
                -0.968539600339864 0.387764658903852 -0.992913687685696 -0.852038517030579 0.0783666116519155
            ],
            -1 * [
                -0.455393889059047 0.0481532620385916 -0.63422161194254 -0.82291353126087 0.422900581397642
                -0.959685991557508 -0.101500193937263 0.540471055664424 -0.545319036971694 0.450203322965533
                -0.726118803715545 -0.350857465481528 0.833106423354898 0.582445506367435 -0.584414177078705
                -0.971360603216996 0.738711813975092 0.90770555356935 -0.366096286849317 -0.602386636100007
                -0.148103267760464 -0.520239094737843 0.0486499399952119 0.504393553796705 0.98181482425025
            ],
            [
                0.880940755487863 0.146545797214432 0.474536110055194 0.493215299443774 0.828891183661437
                0.134920076183899 0.420257201570445 0.309082914779129 0.437581236786473 0.703137886058089
                0.629742754798473 0.934031562703276 0.341022099715066 0.353840564376719 0.490264810980815
                0.159420686295013 0.501256287711695 0.242368759222868 0.303994449424627 0.701795471410536
                0.199991161435121 0.760913827980231 0.108423208515775 0.140062515987193 0.172911321377864
            ],
            dims=3
        )
        n = normals(F_random, 0.1, true)
        @test isapprox(n, n_gt)
    end
end
