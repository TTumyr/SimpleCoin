-- Setup DB
SimpleCoinSettings = {}
SimpleCoinData = {realms = {}}

-- Global API Compatibility wrappers
if not GetAddOnMetadata then
    GetAddOnMetadata = C_AddOns and C_AddOns.GetAddOnMetadata
end

-- global functions
simplecoin_bg_trans_opac = 0.1
simplecoin_bg_med_light_opac = 0.3
simplecoin_bg_med_opac = 0.5
simplecoin_bg_heavy_med_opac = 0.9
simplecoin_bg_heavy_opac = 0.95
simplecoin_bg_solid = 1
simplecoin_main_cw_height = 0

-- wow versions
local wowversion, wowbuild, wowdate, wowtocversion = GetBuildInfo()

-- Defaults
sc_wowtextversion = "Classic"
sc_AddonBackdropTemplate = BackdropTemplateMixin and "BackdropTemplate"

if wowtocversion < 19999 then
    sc_wowtextversion = "Classic"
elseif wowtocversion < 59999 then
    sc_wowtextversion = "Classic"
elseif wowtocversion >= 90000 then
    sc_wowtextversion = "Retail"
end
