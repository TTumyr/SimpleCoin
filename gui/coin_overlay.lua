SimpleCoin_olay = CreateFrame("Frame", "SimpleCoin_Overlay", UIParent, sc_AddonBackdropTemplate)
SimpleCoin_olay:SetWidth(230)
SimpleCoin_olay:SetHeight(72)
SimpleCoin_olay:RegisterForDrag("LeftButton")
SimpleCoin_olay:ClearAllPoints()
SimpleCoin_olay:SetPoint("TOP", UIParent, "TOP", 0, -200)
simplecoin_set_movable(SimpleCoin_olay)
simplecoin_set_resizable(SimpleCoin_olay)
SimpleCoin_olay:SetMinResize(200, 20)
SimpleCoin_olay:SetMaxResize(700, 72)
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
-- global overlay line height
SimpleCoin_olay.l_height = 10
local l_h = SimpleCoin_olay.l_height
simplecoin_coin_widget(SimpleCoin_olay, {l_h, l_h, l_h, l_h, l_h}, {0, 0, 0, 0})

-- Resize button
SimpleCoin_olay.resize = CreateFrame("Button", "$parent_Move", SimpleCoin_olay, sc_AddonBackdropTemplate)
SimpleCoin_olay.resize:SetSize(12, 12)
SimpleCoin_olay.resize:SetPoint("BOTTOMRIGHT", 10, -10)
SimpleCoin_olay.resize:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
SimpleCoin_olay.resize:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
SimpleCoin_olay.resize:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
simplecoin_olay_resize(SimpleCoin_olay.resize)
