SimpleCoin.options = CreateFrame("Frame", "$parent_Options", SimpleCoin.main_frame, sc_AddonBackdropTemplate)
SimpleCoin.options:SetWidth(300)
SimpleCoin.options:SetHeight(200)
SimpleCoin.options:SetMovable(true)
SimpleCoin.options:EnableMouse(true)
SimpleCoin.options:ClearAllPoints()
SimpleCoin.options:SetPoint("TOPRIGHT", SimpleCoin.main_frame, "TOPRIGHT", SimpleCoin.options:GetWidth(), 0)
SimpleCoin.options:SetBackdrop(
    {
        bgFile = "Interface\\addons\\SimpleCoin\\img\\bg-marble",
        tile = false,
        tileSize = 256
    }
)
SimpleCoin.options:SetMinResize(300, 200)
SimpleCoin.options:SetMaxResize(900, 600)

-- Checkboxes section
SimpleCoin.options.chk_frame = CreateFrame("Frame", "$parent_Checkboxes", SimpleCoin.options, sc_AddonBackdropTemplate)
SimpleCoin.options.chk_frame:SetWidth(SimpleCoin.options.chk_frame:GetParent():GetWidth())
SimpleCoin.options.chk_frame:SetHeight(200)
SimpleCoin.options.chk_frame:SetPoint("TOPLEFT", 0, 0)
SimpleCoin.options.chk_frame:SetPoint("BOTTOMRIGHT", 0, 0)
SimpleCoin.options.chk_frame:SetBackdrop(
    {
        bgFile = "Interface\\addons\\SimpleCoin\\img\\Black-Background",
        tile = true,
        tileSize = 32
    }
)
SimpleCoin.options.chk_frame:SetBackdropColor(1, 1, 1, simplecoin_bg_med_opac)
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
    {name = "screen_display_faction_total", text = "Faction total", box_pnt = {"TOPLEFT", 20, -100}, txt_pnt = {"TOPLEFT", 30, -6}, toggle = simplecoin_coinframe_toggle},
    {name = "screen_display_opposite_faction_total", text = "Opposite faction total", box_pnt = {"TOPLEFT", 20, -120}, txt_pnt = {"TOPLEFT", 30, -6}, toggle = simplecoin_coinframe_toggle},
    {name = "screen_display_all_realms", text = "All realms", box_pnt = {"TOPLEFT", 20, -140}, txt_pnt = {"TOPLEFT", 30, -6}, toggle = simplecoin_coinframe_toggle},
    {name = "screen_display_transparent", text = "Transparent", box_pnt = {"TOPLEFT", 20, -160}, txt_pnt = {"TOPLEFT", 30, -6}, toggle = simplecoin_coinframe_toggle},
    {name = "box_chat_player", text = "Character", box_pnt = {"TOPRIGHT", -100, -20}, txt_pnt = {"TOPLEFT", 30, -6}, toggle = simplecoin_chat_money_player},
    {name = "box_chat_all", text = "Realm", box_pnt = {"TOPRIGHT", -100, -40}, txt_pnt = {"TOPLEFT", 30, -6}, toggle = simplecoin_chat_money_player}
}
for k, v in pairs(options_chk_boxes) do
    simplecoin_chk_box(SimpleCoin.options.chk_frame, v.name, v.text, v.box_pnt, v.txt_pnt, v.toggle)
end
SimpleCoin.options:Hide()
