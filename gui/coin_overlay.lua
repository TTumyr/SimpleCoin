SimpleCoin_olay = CreateFrame("Frame", "SimpleCoin_Overlay", UIParent, sc_AddonBackdropTemplate)
SimpleCoin_olay:SetWidth(320)
SimpleCoin_olay:SetHeight(72)
SimpleCoin_olay:RegisterForDrag("LeftButton")
SimpleCoin_olay:ClearAllPoints()
SimpleCoin_olay:SetPoint("TOP", UIParent, "TOP", 0, -200)
SimpleCoin_olay:EnableMouse(true)
SimpleCoin_olay:SetMovable(true)
-- Background for adjustment
SimpleCoin_olay:SetBackdrop(
    {
        bgFile = "Interface\\addons\\SimpleCoin\\img\\UI-DialogBox-Background",
        tile = "false",
        tileSize = 32
    }
)
SimpleCoin_olay:SetScript(
    "OnDragStart",
    function(self)
        self:StartMoving()
    end
)
SimpleCoin_olay:SetScript(
    "OnDragStop",
    function(self)
        self:StopMovingOrSizing()
        simplecoin_coin_pos(self)
    end
)
if (sc_wowtextversion == "Classic") then
    SimpleCoin_olay:SetFrameStrata("DIALOG")
end
simplecoin_coin_widget(SimpleCoin_olay, {14, 14, 14, 14, 14}, {0, 0, 0, 0})
