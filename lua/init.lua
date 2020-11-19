-- Setup DB
SimpleCoinData = {realms = {}}

-- wow versions
local wowversion, wowbuild, wowdate, wowtocversion = GetBuildInfo()
local wowtextversion
if wowtocversion < 19999 then
    sc_wowtextversion = "Classic"
end
if wowtocversion >= 90000 then
    sc_wowtextversion = "Retail"
    sc_AddonBackdropTemplate = "BackdropTemplate"
end
