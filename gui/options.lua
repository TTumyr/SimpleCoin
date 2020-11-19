SimpleCoin.options = CreateFrame("Frame", "$parent_Options", SimpleCoin.main_frame, sc_AddonBackdropTemplate)
SimpleCoin.options:SetWidth(300)
SimpleCoin.options:SetHeight(160)
SimpleCoin.options:SetMovable(true)
SimpleCoin.options:EnableMouse(true)
SimpleCoin.options:ClearAllPoints()
SimpleCoin.options:SetPoint("TOPRIGHT", SimpleCoin.main_frame, "TOPRIGHT", SimpleCoin.options:GetWidth(), 0)
SimpleCoin.options:SetBackdrop(
    {
        bgFile = "Interface\\addons\\SimpleCoin\\img\\UI-DialogBox-Background",
        edgeFile = "Interface\\addons\\SimpleCoin\\img\\UI-DialogBox-Border",
        tile = "true",
        tileSize = 32,
        edgeSize = 32,
        insets = {left = 11, right = 12, top = 12, bottom = 11}
    }
)
SimpleCoin.options:SetMinResize(300, 200)
SimpleCoin.options:SetMaxResize(900, 600)

-- Checkboxes section
SimpleCoin.options.chk_frame = CreateFrame("Frame", "$parent_Checkboxes", SimpleCoin.options)
SimpleCoin.options.chk_frame:SetWidth(SimpleCoin.options.chk_frame:GetParent():GetWidth())
SimpleCoin.options.chk_frame:SetHeight(80)
SimpleCoin.options.chk_frame:SetPoint("TOPLEFT", 0, 0)
SimpleCoin.options.chk_frame:SetClampedToScreen(true)
SimpleCoin.options.chk_frame.label_screen = SimpleCoin.options.chk_frame:CreateFontString()
SimpleCoin.options.chk_frame.label_screen:SetFontObject("GameFontNormalSmall")
SimpleCoin.options.chk_frame.label_screen:SetText("Display on screen")
SimpleCoin.options.chk_frame.label_screen:SetPoint("TOPLEFT", 20, -10)
SimpleCoin.options.chk_frame.label_chat = SimpleCoin.options.chk_frame:CreateFontString()
SimpleCoin.options.chk_frame.label_chat:SetFontObject("GameFontNormalSmall")
SimpleCoin.options.chk_frame.label_chat:SetText("Chat notifications")
SimpleCoin.options.chk_frame.label_chat:SetPoint("TOPRIGHT", -34, -10)

-- create options screen checkboxes
local options_chk_boxes = {
    {name = "screen_display_player", text = "Character", box_pnt = {"TOPLEFT", 20, -20}, txt_pnt = {"TOPLEFT", 30, -6}, toggle = simplecoin_coinframe_toggle},
    {name = "screen_display_faction", text = "Faction", box_pnt = {"TOPLEFT", 20, -40}, txt_pnt = {"TOPLEFT", 30, -6}, toggle = simplecoin_coinframe_toggle},
    {name = "screen_display_opposite_faction", text = "Opposite faction", box_pnt = {"TOPLEFT", 20, -60}, txt_pnt = {"TOPLEFT", 30, -6}, toggle = simplecoin_coinframe_toggle},
    {name = "screen_display_realm", text = "Realm", box_pnt = {"TOPLEFT", 20, -80}, txt_pnt = {"TOPLEFT", 30, -6}, toggle = simplecoin_coinframe_toggle},
    {name = "screen_display_all_realms", text = "All realms", box_pnt = {"TOPLEFT", 20, -100}, txt_pnt = {"TOPLEFT", 30, -6}, toggle = simplecoin_coinframe_toggle},
    {name = "screen_display_transparent", text = "Transparent", box_pnt = {"TOPLEFT", 20, -120}, txt_pnt = {"TOPLEFT", 30, -6}, toggle = simplecoin_coinframe_toggle},
    {name = "box_chat_player", text = "Character", box_pnt = {"TOPRIGHT", -100, -20}, txt_pnt = {"TOPLEFT", 30, -6}, toggle = simplecoin_chat_money_player},
    {name = "box_chat_all", text = "Realm", box_pnt = {"TOPRIGHT", -100, -40}, txt_pnt = {"TOPLEFT", 30, -6}, toggle = simplecoin_chat_money_player}
}
for k, v in pairs(options_chk_boxes) do
    simplecoin_chk_box(SimpleCoin.options.chk_frame, v.name, v.text, v.box_pnt, v.txt_pnt, v.toggle)
end
SimpleCoin.options:Hide()
