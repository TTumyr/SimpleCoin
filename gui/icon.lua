-- layout data for the SimpleCoin icon
local tilesize, textx, texty
if (sc_wowtextversion == "Classic") then
    tilesize = 24
    textx = 1
    texty = 1
else
    tilesize = 16
    textx = 0
    texty = 2
end

-- SimpleCoin icon
SimpleCoin_icon = CreateFrame("Button", "SimpleCoin.icon", UIParent, sc_AddonBackdropTemplate)
SimpleCoin_icon:SetWidth(24)
SimpleCoin_icon:SetHeight(24)
SimpleCoin_icon:ClearAllPoints()
SimpleCoin_icon:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -200, -160)
SimpleCoin_icon:SetBackdrop(
    {
        bgFile = "Interface\\addons\\SimpleCoin\\img\\Guild",
        tile = "true",
        tileSize = tilesize,
        insets = {left = "-2", right = "-20", top = "-2", bottom = "2"}
    }
)
SimpleCoin_icon.title = SimpleCoin_icon:CreateFontString("$parent_Title", "OVERLAY", "GameFontNormal")
SimpleCoin_icon.title:SetPoint("CENTER", textx, texty)
SimpleCoin_icon.title:SetFontObject("GameFontNormalSmall")
SimpleCoin_icon.title:SetText("sc")
SimpleCoin_icon:SetScript("OnClick", simplecoin_showtoggle)

--function calls
simplecoin_makemoveable(SimpleCoin_icon)
