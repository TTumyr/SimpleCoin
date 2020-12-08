-- layout data for the SimpleCoin icon
local tilesize, textx, texty
if (sc_wowtextversion == "Classic") then
    tilesize = 24
    textx = 1
    texty = 1
else
    tilesize = 22
    textx = 2
    texty = -1
end

-- SimpleCoin icon
SimpleCoin_icon = CreateFrame("Button", "SimpleCoin.icon", UIParent, sc_AddonBackdropTemplate)
SimpleCoin_icon:SetWidth(32)
SimpleCoin_icon:SetHeight(32)
SimpleCoin_icon:ClearAllPoints()
SimpleCoin_icon:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -200, -160)
SimpleCoin_icon:SetBackdrop(
    {
        bgFile = "Interface\\addons\\SimpleCoin\\img\\Black-Circle",
        tile = false,
        tileSize = 32,
        insets = {left = -8, right = -8, top = -8, bottom = -8}
    }
)
SimpleCoin_icon:SetBackdropColor(1, 1, 1, simplecoin_bg_med_light_opac)
SimpleCoin_icon:SetNormalTexture("Interface\\Artifacts\\Artifacts-PerkRing-Final-Mask")
SimpleCoin_icon:SetHighlightTexture("Interface\\Artifacts\\Artifacts-PerkRing-Final-Mask")
SimpleCoin_icon.title = SimpleCoin_icon:CreateFontString("$parent_Title", "OVERLAY", "GameFontNormal")
SimpleCoin_icon.title:SetPoint("TOPLEFT", 1, 1)
SimpleCoin_icon.title:SetPoint("BOTTOMRIGHT")
SimpleCoin_icon.title:SetFontObject("GameFontNormal")
SimpleCoin_icon.title:SetText("sc")
SimpleCoin_icon:SetScript("OnClick", simplecoin_showtoggle)

--function calls
simplecoin_makemoveable(SimpleCoin_icon)
