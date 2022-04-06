local coinframe_chkbox, coinframes, data, faction_tilesize_overlay, faction_tilesize_list, sc_coin_realm, settings, textx, texty, sc_coin_realm, sc_opposite_faction
local sc_realm = GetRealmName()
local sc_faction = UnitFactionGroup("player")
local sc_player = GetUnitName("player")
-- copper
-- first entering world flag
local first_enter = false
local getMoney = 0
local sc_player_copper = 0
local sc_faction_copper = 0
local sc_opposite_faction_copper = 0
local sc_realm_copper = 0
local sc_faction_total_copper = 0
local sc_opposite_faction_total_copper = 0
local sc_total_copper = 0
local sc_coin_hgt_crnd = true
local colorTable = {
    ["Default"] = "|cff00e0e0",
    ["Realm"] = "|cff00e0e0",
    ["Alliance"] = "|cff00ccff",
    ["Horde"] = "|cffff0000",
    ["Beige"] = "|cFFF5F5DC",
    ["Bisque"] = "|cFFFFE4C4",
    ["Grey"] = "|cff888888",
    ["LightBlue"] = "|cff00ccff",
    ["DeepBlue"] = "|cff0000ff",
    ["LightRed"] = "|cffff6060",
    ["DeepRed"] = "|cffff0000",
    ["Death Knight"] = "|cffc41f3b",
    ["Demon Hunter"] = "|cffa330c9",
    ["Druid"] = "|cffff7d0a",
    ["Hunter"] = "|cffabd473",
    ["Mage"] = "|cff69ccf0",
    ["Monk"] = "|cff00ff96",
    ["Paladin"] = "|cfff58cba",
    ["Priest"] = "|cffffffff",
    ["Rogue"] = "|cfffff569",
    ["Shaman"] = "|cff0070de",
    ["Warlock"] = "|cff9482c9",
    ["Warrior"] = "|cffc79c6e",
    ["White"] = "|cffffffff"
}

----
-- INIT
----
-- set opposite faction
if (sc_faction == "Alliance") then
    sc_opposite_faction = "Horde"
else
    sc_opposite_faction = "Alliance"
end
-- layout data for the SimpleCoin icon
if (sc_wowtextversion == "Classic") then
    faction_tilesize_list = 20
    faction_tilesize_overlay = 16
else
    faction_tilesize_list = 16
    faction_tilesize_overlay = 12
end
-- set up coin display shortend realm name
if (#sc_realm > 10) then
    local string_split = {strsplit(" ", sc_realm)}
    local ret_string = {}
    local long_str = math.max(#unpack(string_split))
    local abbr_done = false
    for k, v in pairs(string_split) do
        if (#v == long_str and not abbr_done) then
            if (#string_split > 1) then
                tinsert(ret_string, string.sub(v, 1, 1) .. ".")
            else
                tinsert(ret_string, string.sub(v, 1, 10))
            end
            abbr_done = true
        else
            tinsert(ret_string, v)
        end
    end
    sc_coin_realm = strjoin(" ", unpack(ret_string))
else
    sc_coin_realm = sc_realm
end
-- setup datastorage
function simplecoin_var_setup()
    -- if (settings["realm_select_menu"] == nil) then
    --     settings["realm_select_menu"] = {}
    -- end
    if (data["realms"]["copper"] == nil) then
        data["realms"]["copper"] = 0
    end
    if (data["realms"][sc_realm] == nil) then
        data["realms"][sc_realm] = {}
    end
    if (data["realms"][sc_realm]["copper"] == nil) then
        data["realms"][sc_realm]["copper"] = 0
    end
    if (data["realms"][sc_realm][sc_faction] == nil) then
        data["realms"][sc_realm] = {["Alliance"] = {}, ["Horde"] = {}}
    end
    if (data["realms"][sc_realm][sc_faction]["copper"] == nil) then
        data["realms"][sc_realm][sc_faction]["copper"] = 0
    end
    if (data["realms"][sc_realm][sc_faction]["characters"] == nil) then
        data["realms"][sc_realm][sc_faction]["characters"] = {}
    end
    if (data["realms"][sc_realm][sc_faction]["characters"][sc_player] == nil) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player] = {}
    end
    if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["data"] == nil) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["data"] = {}
    end
    if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["copper"] == nil) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["copper"] = 0
    end
    if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["class"] == nil) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["class"] = UnitClass("player")
    end
    if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"] == nil) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"] = {}
    end
    if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["mainwindow_show"] == nil) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["mainwindow_show"] = false
    end
    -- coin overlay
    if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"] == nil) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"] = {}
    end
    if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["pos"] == nil) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["pos"] = {}
    end
    if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["transparent"] == nil) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["transparent"] = false
    end
    if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["switches"] == nil) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["switches"] = {true, true, true, true, true, true, true}
    end
    -- chat frame
    if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_player"] == nil) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_player"] = false
    end
    if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_allchars"] == nil) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_allchars"] = false
    end
end
----
-- EVENT FUNCTIONS
----
function simplecoin_onevent(self, event)
    if (event == "ADDON_LOADED") then
        coinframe_chkbox = {
            SimpleCoin.options.chk_frame.screen_display_player,
            SimpleCoin.options.chk_frame.screen_display_faction,
            SimpleCoin.options.chk_frame.screen_display_opposite_faction,
            SimpleCoin.options.chk_frame.screen_display_realm,
            SimpleCoin.options.chk_frame.screen_display_faction_total,
            SimpleCoin.options.chk_frame.screen_display_opposite_faction_total,
            SimpleCoin.options.chk_frame.screen_display_all_realms
        }
        coinframes = {
            SimpleCoin_olay.player,
            SimpleCoin_olay.player_faction,
            SimpleCoin_olay.opposite_faction,
            SimpleCoin_olay.realm,
            SimpleCoin_olay.player_faction_total,
            SimpleCoin_olay.opposite_faction_total,
            SimpleCoin_olay.all_realms
        }
    end
    if (event == "VARIABLES_LOADED") then
        -- setup data from saved variables
        simplecoin_get_saved_variables()
        simplecoin_var_setup()
        -- get realm data
        simplecoin_get_static_copper()
        simplecoin_disp_screen_currency()
        -- interface configuration
        simplecoin_gui_initial_setup()
        simplecoin_realmselector_menu()
        -- coin overlay and main coin frame
        simplecoin_update_display_cw_text(SimpleCoin_olay)
        simplecoin_update_display_cw_text(SimpleCoin.main_frame.coin_display)
    end
    if (event == "PLAYER_ENTERING_WORLD") then
        simplecoin_get_saved_variables()
        -- error handling
        simplecoin_error_handling()
        if (not data["realms"][sc_realm][sc_faction]["characters"][sc_player]) then
            print("character not in data")
        end
        if (data["realms"][sc_realm][sc_faction]["characters"][sc_player] ~= nil) then
            if (sc_faction_copper or sc_realm_copper or sc_total_copper == 0) then
                simplecoin_get_session_copper()
            end
            if (not first_enter) then
                simplecoin_copperchange()
                first_enter = true
            end
        end
    end
    if (event == "PLAYER_MONEY") then
        simplecoin_copperchange()
    end
end
----
-- CURRENCY CALCULATION FUNCTIONS
----
function simplecoin_getmoney()
    getMoney = GetMoney()
end
function simplecoin_get_session_copper()
    local faction = data["realms"][sc_realm][sc_faction]["characters"]
    local realm = data["realms"][sc_realm]
    -- get player money
    if (data["realms"][sc_realm][sc_faction]["characters"][tostring(sc_player)]["copper"] ~= nil) then
        data["realms"][sc_realm][sc_faction]["characters"][tostring(sc_player)]["copper"] = getMoney
    end
    -- active character faction money
    if (sc_faction_copper == 0) then
        for k, v in pairs(faction) do
            if (tostring(k) ~= tostring(sc_player) and faction[k]["copper"] ~= nil) then
                sc_faction_copper = sc_faction_copper + faction[k]["copper"]
            end
        end
    end
    if (data["realms"][sc_realm][sc_faction]["copper"] ~= nil) then
        data["realms"][sc_realm][sc_faction]["copper"] = sc_faction_copper + getMoney
    end
    -- opposite faction
    if (data["realms"][sc_realm] ~= nil) then
        for k, v in pairs(data["realms"][sc_realm]) do
            if (k ~= "copper" and k ~= sc_faction and data["realms"][sc_realm][k]["copper"] ~= nil) then
                sc_opposite_faction_copper = data["realms"][sc_realm][k]["copper"]
            end
        end
    end
    -- realm copper from both factions
    if (sc_realm_copper == 0) then
        for k, v in pairs(realm) do
            if (k ~= "copper") then
                if (realm[k] ~= "copper" and realm[k]["copper"] ~= nil) then
                    sc_realm_copper = sc_realm_copper + realm[k]["copper"]
                end
            end
        end
    end
    if (data["realms"][sc_realm]["copper"] ~= nil) then
        data["realms"][sc_realm]["copper"] = sc_realm_copper
    end
end
function simplecoin_get_static_copper()
    -- these values will not be affected by change
    local faction = data["realms"][sc_realm][sc_faction]["characters"]
    local realm = data["realms"][sc_realm]
    if (data["realms"][sc_realm]["copper"] ~= nil) then
        data["realms"][sc_realm]["copper"] = sc_realm_copper
    end
    -- total copper for all reamls and factions
    for k, v in pairs(data["realms"]) do
        if (k ~= "copper" and k ~= sc_realm) then
            for kf, vf in pairs(data["realms"][k]) do
                if (kf ~= "copper") then
                    if (kf == sc_faction) then
                        if (data["realms"][k][kf]["copper"] ~= nil) then
                            sc_faction_total_copper = sc_faction_total_copper + data["realms"][k][kf]["copper"]
                        end
                    else
                        if (kf ~= "copper") then
                            if (data["realms"][k][kf]["copper"] ~= nil) then
                                sc_opposite_faction_total_copper = sc_opposite_faction_total_copper + data["realms"][k][kf]["copper"]
                            end
                        end
                    end
                end
            end
            if (data["realms"][k]["copper"] ~= nil) then
                sc_total_copper = sc_total_copper + data["realms"][k]["copper"]
            end
        end
    end
end
function simplecoin_set_copper()
    -- set player copper
    if (data["realms"][sc_realm][sc_faction]["characters"][tostring(sc_player)]["copper"] ~= nil) then
        data["realms"][sc_realm][sc_faction]["characters"][tostring(sc_player)]["copper"] = getMoney
    end
    -- set player faction copper
    if (data["realms"][sc_realm][sc_faction]["copper"] ~= nil) then
        data["realms"][sc_realm][sc_faction]["copper"] = sc_faction_copper + getMoney
    end
    -- set realm copper
    if (data["realms"][sc_realm]["copper"] ~= nil) then
        data["realms"][sc_realm]["copper"] = sc_realm_copper + getMoney
    end
    -- set total copper
    if (data["realms"]["copper"] ~= nil) then
        data["realms"]["copper"] = sc_total_copper + sc_realm_copper + getMoney
    end
end
-- change in money / display money routine
function simplecoin_copperchange()
    simplecoin_getmoney()
    simplecoin_set_copper()
    simplecoin_update_display()
end
----
-- DISPLAY UPDATE FUNCTIONS
----
function simplecoin_reformat_coinstring(str)
    local separator = "%1" .. LARGE_NUMBER_SEPERATOR .. "%2"
    str = str:gsub("(%d)(%d%d%d)$", separator)
    repeat
        local rept
        str, rept = str:gsub("(%d)(%d%d%d%D)", separator)
    until rept <= 0
    return str
end
function simplecoin_update_display_cw_text(self)
    -- updates coin widget display labels
    self.player.text:SetText(colorTable[UnitClass("player")] .. sc_player .. colorTable["White"] .. ":")
    self.player_faction.text:SetText(colorTable["Grey"] .. "(" .. colorTable[sc_faction] .. sc_faction .. colorTable["Grey"] .. ")|r " .. sc_coin_realm .. colorTable["White"] .. ":")
    self.opposite_faction.text:SetText(colorTable["Grey"] .. "(" .. colorTable[sc_opposite_faction] .. sc_opposite_faction .. colorTable["Grey"] .. ")|r " .. sc_coin_realm .. colorTable["White"] .. ":")
    self.realm.text:SetText(sc_realm .. colorTable["White"] .. ":")
    self.player_faction_total.text:SetText(colorTable["Grey"] .. "(" .. colorTable[sc_faction] .. sc_faction .. colorTable["Grey"] .. ")|r " .. "total" .. colorTable["White"] .. ":")
    self.opposite_faction_total.text:SetText(colorTable["Grey"] .. "(" .. colorTable[sc_opposite_faction] .. sc_opposite_faction .. colorTable["Grey"] .. ")|r " .. "total" .. colorTable["White"] .. ":")
    self.all_realms.text:SetText("All realms" .. colorTable["White"] .. ":")
end
function simplecoin_update_display_cw_copper(self)
    -- updates coin widget copper values
    self.player.copper:SetText(colorTable["White"] .. simplecoin_reformat_coinstring(GetCoinTextureString(getMoney)))
    self.player_faction.copper:SetText(colorTable["White"] .. simplecoin_reformat_coinstring(GetCoinTextureString(sc_faction_copper + getMoney)))
    self.opposite_faction.copper:SetText(colorTable["White"] .. simplecoin_reformat_coinstring(GetCoinTextureString(sc_opposite_faction_copper)))
    self.realm.copper:SetText(colorTable["White"] .. simplecoin_reformat_coinstring(GetCoinTextureString(sc_realm_copper + getMoney)))
    self.player_faction_total.copper:SetText(colorTable["White"] .. simplecoin_reformat_coinstring(GetCoinTextureString(sc_faction_total_copper + sc_faction_copper + getMoney)))
    self.opposite_faction_total.copper:SetText(colorTable["White"] .. simplecoin_reformat_coinstring(GetCoinTextureString(sc_opposite_faction_total_copper)))
    self.all_realms.copper:SetText(colorTable["White"] .. simplecoin_reformat_coinstring(GetCoinTextureString(sc_total_copper + sc_realm_copper + getMoney)))
end
function simplecoin_update_display()
    -- set copper on realm selector
    if (SimpleCoin.realm_select.realm_name:GetText() == sc_realm) then
        if (SimpleCoin.realm_select.realm_copper ~= nil) then
            if (data["realms"][sc_realm]["copper"] ~= nil) then
                SimpleCoin.realm_select.realm_copper:SetText(colorTable["White"] .. simplecoin_reformat_coinstring(GetCoinTextureString(data["realms"][sc_realm]["copper"])))
            else
                SimpleCoin.realm_select.realm_copper:SetText(colorTable["White"] .. simplecoin_reformat_coinstring(GetCoinTextureString(getMoney)))
            end
        end
    end
    -- set total copper on character list display
    if (SimpleCoin.char_list.data[sc_realm][sc_faction] ~= nil) then
        SimpleCoin.char_list.data[sc_realm][sc_faction].copper:SetText(colorTable["White"] .. simplecoin_reformat_coinstring(GetCoinTextureString(sc_faction_copper + getMoney)))
    end
    if (SimpleCoin.char_list.data[sc_realm][sc_faction] ~= nil) then
        SimpleCoin.char_list.data[sc_realm][sc_faction].player_Copper:SetText(colorTable["White"] .. simplecoin_reformat_coinstring(GetCoinTextureString(getMoney)))
    end
    -- coin widget
    simplecoin_update_display_cw_copper(SimpleCoin_olay)
    simplecoin_update_display_cw_copper(SimpleCoin.main_frame.coin_display)
    -- chat display
    if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_player"]) then
        print(colorTable[UnitClass("player")] .. sc_player .. "|r: " .. simplecoin_reformat_coinstringsimplecoin_reformat_coinstring(GetCoinTextureString(getMoney)))
    end
    if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_allchars"]) then
        print("Total on " .. colorTable[UnitClass("player")] .. sc_realm .. "|r: " .. simplecoin_reformat_coinstring(GetCoinTextureString(sc_faction_copper + getMoney)))
    end
end
-- display currency overlay
function simplecoin_disp_screen_currency()
    local coinElementsY = 0
    -- to counter strange pos shift in WoW
    local point, rel, relP, xof, yof = unpack(data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["pos"])
    local prevHeight = SimpleCoin_olay:GetHeight()
    for k, v in pairs(coinframes) do
        if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["switches"][k]) then
            v:Show()
            v:ClearAllPoints()
            v:SetPoint("TOPLEFT", 0, coinElementsY)
            v:SetPoint("TOPRIGHT", 0, coinElementsY)
            coinElementsY = coinElementsY - SimpleCoin_olay.l_height
        else
            v:Hide()
        end
    end
    SimpleCoin_olay:SetHeight(coinElementsY)
    if (sc_coin_hgt_crnd == true) then
        if (point ~= nil) then
            if rel ~= nil then
                rel = nil
            end
            if (string.match(point, "BOTTOM") ~= nil) then
                SimpleCoin_olay:ClearAllPoints()
                SimpleCoin_olay:SetPoint(point, rel, relP, xof, yof + prevHeight)
            end
            if (string.match(point, "TOP") ~= nil) then
                SimpleCoin_olay:ClearAllPoints()
                SimpleCoin_olay:SetPoint(point, rel, relP, xof, yof - prevHeight)
            end
            if (string.match(point, "CENTER") ~= nil) then
                SimpleCoin_olay:ClearAllPoints()
                SimpleCoin_olay:SetPoint(point, rel, relP, xof, yof)
            end
        end
        if (point == nil) then
            SimpleCoin_olay:ClearAllPoints()
            SimpleCoin_olay:SetPoint("CENTER", UIParent, "CENTER")
        end
    end
    SimpleCoin_olay:SetMinResize(200, SimpleCoin_olay:GetHeight())
    SimpleCoin_olay:SetMaxResize(700, SimpleCoin_olay:GetHeight())
    sc_coin_hgt_crnd = false
    --
    if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["transparent"]) then
        SimpleCoin_olay:SetBackdrop(
            {
                nil
            }
        )
    else
        SimpleCoin_olay:SetBackdrop(
            {
                bgFile = "Interface\\addons\\SimpleCoin\\img\\Black-Background",
                tile = true,
                tileSize = 32
            }
        )
        SimpleCoin_olay:SetBackdropColor(1, 1, 1, simplecoin_bg_trans_opac)
    end
    local coinCheckVisible = 0
    for k, v in pairs(data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["switches"]) do
        if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["switches"][k]) then
            coinCheckVisible = coinCheckVisible + 1
        end
        if (coinCheckVisible) > 0 then
            SimpleCoin_olay:Show()
        else
            SimpleCoin_olay:Hide()
        end
    end
end
function simplecoin_showoptions()
    PlaySound(799)
    if (SimpleCoin.options:IsVisible()) then
        SimpleCoin.options:Hide()
        SimpleCoin.btn_options:SetNormalTexture("Interface\\addons\\SimpleCoin\\img\\UI-MicroButton-MainMenu-Up")
    else
        SimpleCoin.options:Show()
        SimpleCoin.btn_options:SetNormalTexture("Interface\\addons\\SimpleCoin\\img\\UI-MicroButton-MainMenu-Down")
    end
end
function simplecoin_makemoveable(self)
    self:EnableMouse(true)
    self:SetMovable(true)
    self:SetUserPlaced(true)
    self:RegisterForDrag("LeftButton")
    self:SetScript("OnDragStart", self.StartMoving)
    self:SetScript("OnDragStop", self.StopMovingOrSizing)
end
-- display currency on screen settings
function simplecoin_coinframe_toggle(self)
    function simplecoin_coinframe_checkboxes(self, id, box)
        if (self == box) then
            if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["switches"][id] == nil) then
                data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["switches"][id] = true
            end
            data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["switches"][id] = not data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["switches"][id]
            self:SetChecked(data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["switches"][id])
        end
    end
    if (self == SimpleCoin.options.chk_frame.screen_display_transparent) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["transparent"] = not data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["transparent"]
        self:SetChecked(data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["transparent"])
    end
    for k, v in pairs(coinframe_chkbox) do
        simplecoin_coinframe_checkboxes(self, k, v)
    end
    simplecoin_disp_screen_currency()
end
-- chat notifications
function simplecoin_chat_money_player(self)
    if data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_player"] then
        self:SetChecked(false)
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_player"] = false
    else
        self:SetChecked(true)
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_player"] = true
    end
end
function simplecoin_chat_money_allchars(self)
    if data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_allchars"] then
        self:SetChecked(false)
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_allchars"] = false
    else
        self:SetChecked(true)
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_allchars"] = true
    end
end
-- main window realm selector
function simplecoin_realmselector_menu()
    SimpleCoin.realm_select.realm_name:SetText(sc_realm)
    local info = {}
    SimpleCoin.realm_select_menu.initialize = function(self, level)
        function simplecoin_realm_menu_create_item(k)
            if (k ~= "copper") then
                if (data["realms"][k]["copper"] ~= nil) then
                    info.text = "   " .. k .. "  --  " .. simplecoin_reformat_coinstring(GetCoinTextureString(data["realms"][k]["copper"]))
                else
                    info.text = "   " .. k .. "  --  " .. simplecoin_reformat_coinstring(GetCoinTextureString(getMoney))
                end
                --info.notCheckable = 1
                if (SimpleCoin.realm_select.realm_name:GetText() == k) then
                    info.checked = "Red Pill", true
                else
                    info.checked = false
                end
                info.func = function()
                    if (data["realms"][k]["copper"] == nil) then
                        if (k == sc_realm) then
                            copper_string = getMoney
                        else
                            copper_string = 0
                        end
                    else
                        copper_string = data["realms"][k]["copper"]
                    end
                    SimpleCoin.realm_select.realm_name:SetText(k)
                    SimpleCoin.realm_select.realm_copper:SetText(colorTable["White"] .. simplecoin_reformat_coinstring(GetCoinTextureString(copper_string)))
                    simplecoin_set_visible_realm(k)
                end
                UIDropDownMenu_AddButton(info, level)
            end
        end
        if not level then
            return
        end
        wipe(info)
        if level == 1 then
            -- Create the title of the menu
            info.isTitle = 1
            info.text = "Select realm"
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level)

            info.disabled = nil
            info.isTitle = nil
            info.notCheckable = nil

            for k, _ in pairs(data["realms"]) do
                if (k ~= "copper" and k == sc_realm) then
                    simplecoin_realm_menu_create_item(k)
                end
            end
            for k, _ in pairs(data["realms"]) do
                if (k ~= "copper" and k ~= sc_realm) then
                    simplecoin_realm_menu_create_item(k)
                end
            end
        end
    end
end
-- main window character data
function simplecoin_fill_main_data()
    local charListy = -5
    local cL_char_h = 14
    local cL_fac_h = 18
    local realm
    function create_faction_plate(p_faction)
        local faction = p_faction or sc_faction
        SimpleCoin.char_list.data[realm][faction] = CreateFrame("Frame", "$parent_" .. faction, SimpleCoin.char_list.data[realm], sc_AddonBackdropTemplate)
        simplecoin_set_resizable(SimpleCoin.char_list.data[realm][faction])
        SimpleCoin.char_list.data[realm][faction]:SetWidth(SimpleCoin.char_list.data[realm][faction]:GetParent():GetWidth())
        SimpleCoin.char_list.data[realm][faction]:SetHeight(20)
        SimpleCoin.char_list.data[realm][faction]:SetPoint("TOPLEFT")
        SimpleCoin.char_list.data[realm][faction]:SetPoint("TOPRIGHT")
        SimpleCoin.char_list.data[realm][faction].Symbol = CreateFrame("Frame", "$parent_Symbol", SimpleCoin.char_list.data[realm], sc_AddonBackdropTemplate)
        SimpleCoin.char_list.data[realm][faction].Symbol:SetPoint("TOPLEFT", 4, charListy + 6)
        SimpleCoin.char_list.data[realm][faction].Symbol:SetWidth(20)
        SimpleCoin.char_list.data[realm][faction].Symbol:SetHeight(20)
        SimpleCoin.char_list.data[realm][faction].Symbol:SetBackdrop(
            {
                bgFile = "Interface\\BattlefieldFrame\\Battleground-" .. faction,
                tile = 0,
                tileSize = faction_tilesize_list
            }
        )
        -- frame for faction characters display
        SimpleCoin.char_list.data[realm][faction].Text = SimpleCoin.char_list.data[realm]:CreateFontString()
        SimpleCoin.char_list.data[realm][faction].Text:SetFontObject("GameFontNormalSmall")
        SimpleCoin.char_list.data[realm][faction].Text:SetText(faction)
        SimpleCoin.char_list.data[realm][faction].Text:SetPoint("TOPLEFT", 24, charListy)
        SimpleCoin.char_list.data[realm][faction].copper = SimpleCoin.char_list.data[realm]:CreateFontString()
        SimpleCoin.char_list.data[realm][faction].copper:SetFontObject("GameFontNormalSmall")
        SimpleCoin.char_list.data[realm][faction].copper:SetText(colorTable["White"] .. simplecoin_reformat_coinstring(GetCoinTextureString(data["realms"][realm][faction]["copper"])))
        SimpleCoin.char_list.data[realm][faction].copper:SetPoint("TOPRIGHT", -4, charListy)
        SimpleCoin.char_list.data[realm][faction].faction_data = CreateFrame("Frame", "$parent_Players" .. faction, SimpleCoin.char_list.data[realm][faction], sc_AddonBackdropTemplate)
        simplecoin_set_resizable(SimpleCoin.char_list.data[realm][faction].faction_data)
        SimpleCoin.char_list.data[realm][faction].faction_data:SetPoint("TOPLEFT")
        SimpleCoin.char_list.data[realm][faction].faction_data:SetWidth(SimpleCoin.char_list.data[realm][faction].faction_data:GetParent():GetWidth())
        charListy = charListy - cL_fac_h
    end
    function create_character_string(self, p_realm, p_faction, p_type, p_name)
        -- function variables
        local name = p_name or sc_player
        local realm = p_realm or sc_realm
        local faction = p_faction or sc_faction
        local char_path = data["realms"][realm][faction]["characters"]
        local class_color = colorTable[char_path[name]["class"]]
        local character_copper = char_path[name]["copper"] or getMoney
        -- character frame
        self[name] = CreateFrame("Frame", "$parent_" .. name, self, sc_AddonBackdropTemplate)
        self[name]:SetPoint("TOPLEFT", 14, charListy)
        self[name]:SetPoint("TOPRIGHT", -4, charListy)
        self[name]:SetHeight(cL_char_h)
        -- delete button
        if ((realm == sc_realm and name ~= sc_player) or realm ~= sc_realm) then
            self[name].Delete = CreateFrame("Button", "$parent_Delete", self[name], "UIPanelCloseButton")
            self[name].Delete:SetPoint("TOPLEFT", 0, 0 + 5)
            self[name].Delete:SetWidth(20)
            self[name].Delete:SetHeight(20)
            self[name].Delete:SetScript(
                "OnClick",
                function()
                    local char_flagged = false
                    for k, v in pairs(char_path) do
                        if (k == name) then
                            self[k]:Hide()
                            char_flagged = true
                            -- recalculate realm and faction copper
                            data["realms"][realm][faction]["copper"] = data["realms"][realm][faction]["copper"] - char_path[k]["copper"]
                            data["realms"][realm]["copper"] = data["realms"][realm]["copper"] - char_path[k]["copper"]
                            sc_total_copper = sc_total_copper - char_path[k]["copper"]
                            if (realm == sc_realm) then
                                sc_realm_copper = sc_realm_copper - char_path[k]["copper"]
                                if (faction == sc_faction) then
                                    sc_faction_copper = sc_faction_copper - char_path[k]["copper"]
                                else
                                    sc_opposite_faction_copper = sc_opposite_faction_copper - char_path[k]["copper"]
                                end
                            end
                            -- update GUI
                            SimpleCoin.char_list.data[realm][faction].copper:SetText(colorTable["White"] .. simplecoin_reformat_coinstring(GetCoinTextureString(0)))
                            simplecoin_update_display()
                            -- delete character
                            char_path[k] = nil
                        end
                        -- only characters from deleted and downwards are moved up
                        if (char_flagged) then
                            local l_point, l_rel, l_relPoint, l_x, l_y = self[k]:GetPoint()
                            self[k]:SetPoint(l_point, l_rel, l_relPoint, l_x, l_y + cL_char_h)
                        end
                    end
                end
            )
        end
        -- character
        self[p_type .. "_Name"] = self[name]:CreateFontString()
        self[p_type .. "_Name"]:SetFontObject("GameFontNormalSmall")
        self[p_type .. "_Name"]:SetText(class_color .. name .. colorTable["White"] .. ":")
        self[p_type .. "_Name"]:SetPoint("TOPLEFT", 20, 0)
        -- character copper
        self[p_type .. "_Copper"] = self[name]:CreateFontString()
        self[p_type .. "_Copper"]:SetFontObject("GameFontNormalSmall")
        self[p_type .. "_Copper"]:SetText(colorTable["White"] .. simplecoin_reformat_coinstring(GetCoinTextureString(character_copper)))
        self[p_type .. "_Copper"]:SetPoint("TOPRIGHT", 0, 0)
        charListy = charListy - cL_char_h
    end
    function create_realm_plate(p_realm)
        realm = p_realm or sc_realm
        -- realm frame
        SimpleCoin.char_list.data[realm] = CreateFrame("Frame", "$parent_" .. realm, SimpleCoin.char_list.data, sc_AddonBackdropTemplate)
        SimpleCoin.char_list.data[realm]:SetWidth(SimpleCoin.char_list.data[realm]:GetParent():GetWidth())
        SimpleCoin.char_list.data[realm]:SetHeight(20)
        SimpleCoin.char_list.data[realm]:SetPoint("TOPLEFT")
        SimpleCoin.char_list.data[realm]:SetPoint("TOPRIGHT")
        -- first time player registers
        local player_found_in_data = false
        function sort_factions(k)
            create_faction_plate(tostring(k))
            for kc, _ in pairs(data["realms"][realm][k]["characters"]) do
                if (kc == sc_player) then
                    -- active character
                    player_found_in_data = true
                    create_character_string(SimpleCoin.char_list.data[realm][k], realm, k, "player", kc)
                end
            end
            for kc, _ in pairs(data["realms"][realm][k]["characters"]) do
                if (kc ~= sc_player) then
                    -- other characters on realm
                    create_character_string(SimpleCoin.char_list.data[realm][k], realm, k, "character", kc)
                end
            end
            charListy = charListy - ((cL_fac_h * 2) - (cL_char_h * 2))
        end
        -- create character faction on top and opposite of character faction last
        if table_length(data["realms"][realm][sc_faction]) > 0 then
            sort_factions(sc_faction)
        end
        if table_length(data["realms"][realm][sc_opposite_faction]) > 0 then
            sort_factions(sc_opposite_faction)
        end
        -- keep for now
        -- if (player_found_in_data ~= true) then
        --     print("Welcome to SimpleCoin " .. colorTable[char_path[name]["class"]] .. sc_player)
        --     create_character_string(SimpleCoin.char_list.data[sc_realm][sc_faction], sc_realm, sc_faction, "player", sc_player)
        -- end

        -- for k, _ in pairs(data["realms"][realm]) do
        --     if table_length(data["realms"][realm][k]) > 0 then
        --         if (data["realms"][realm][k] == sc_faction) then
        --             create_faction_plate(tostring(k))
        --         end
        --         for kc, _ in pairs(data["realms"][realm][k]["characters"]) do
        --             if (kc == sc_player) then
        --                 -- active character
        --                 player_found_in_data = true
        --                 create_character_string(SimpleCoin.char_list.data[realm][k], realm, k, "player", kc)
        --             end
        --         end
        --         for kc, _ in pairs(data["realms"][realm][k]["characters"]) do
        --             if (kc ~= sc_player) then
        --                 -- other characters on realm
        --                 create_character_string(SimpleCoin.char_list.data[realm][k], realm, k, "character", kc)
        --             end
        --         end
        --         charListy = charListy - ((cL_fac_h * 2) - (cL_char_h * 2))
        --     end
        -- end

        -- if (kc ~= sc_player) then
        --     -- other characters on realm
        --     create_character_string(SimpleCoin.char_list.data[realm][k], realm, k, "character", kc)
        -- end
    end
    -- create realm display
    for k, _ in pairs(data["realms"]) do
        if (k ~= "copper") then
            create_realm_plate(k)
            charListy = -5
        end
    end
    -- set initial visible realm
    simplecoin_set_visible_realm(sc_realm)
    -- set char_list.data height based on amount of lines/characters
    --SimpleCoin.char_list.data:SetHeight(math.abs(charListy))
end
function table_length(tbl)
    local count = 0
    for _ in pairs(tbl) do
        count = count + 1
    end
    return count
end
-- handle active realm plate
function simplecoin_set_visible_realm(self)
    for k, _ in pairs(data["realms"]) do
        if (k ~= "copper") then
            if (k == self) then
                SimpleCoin.char_list.data[k]:Show()
            else
                SimpleCoin.char_list.data[k]:Hide()
            end
        end
    end
end
-- Initial GUI settinggs
function simplecoin_gui_initial_setup()
    -- adjust width of main frame coin widget elements
    local sc_cw_ch = {SimpleCoin.main_frame.coin_display:GetChildren()}
    for k, v in pairs(sc_cw_ch) do
        v:SetWidth(v:GetParent():GetWidth())
    end
    function simplecoin_set_coinframe_icon(self, symbol)
        self:SetBackdrop(
            {
                bgFile = "Interface\\BattlefieldFrame\\Battleground-" .. symbol,
                tile = 0,
                tileSize = faction_tilesize_overlay
            }
        )
    end
    -- set icons
    simplecoin_set_coinframe_icon(SimpleCoin_olay.player.symbol, sc_faction)
    simplecoin_set_coinframe_icon(SimpleCoin_olay.player_faction.symbol, sc_faction)
    simplecoin_set_coinframe_icon(SimpleCoin_olay.opposite_faction.symbol, sc_opposite_faction)
    simplecoin_set_coinframe_icon(SimpleCoin_olay.player_faction_total.symbol, sc_faction)
    simplecoin_set_coinframe_icon(SimpleCoin_olay.opposite_faction_total.symbol, sc_opposite_faction)
    simplecoin_set_coinframe_icon(SimpleCoin.main_frame.coin_display.player.symbol, sc_faction)
    simplecoin_set_coinframe_icon(SimpleCoin.main_frame.coin_display.player_faction.symbol, sc_faction)
    simplecoin_set_coinframe_icon(SimpleCoin.main_frame.coin_display.opposite_faction.symbol, sc_opposite_faction)
    simplecoin_set_coinframe_icon(SimpleCoin.main_frame.coin_display.player_faction_total.symbol, sc_faction)
    simplecoin_set_coinframe_icon(SimpleCoin.main_frame.coin_display.opposite_faction_total.symbol, sc_opposite_faction)
    if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["mainwindow_show"]) then
        SimpleCoin:Show()
    else
        SimpleCoin:Hide()
    end
    -- display character list
    simplecoin_fill_main_data()
    -- options window
    for k, v in pairs(coinframe_chkbox) do
        v:SetChecked(data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["switches"][k])
    end
    SimpleCoin.options.chk_frame.screen_display_transparent:SetChecked(data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["transparent"])
    SimpleCoin.options.chk_frame.box_chat_player:SetChecked(data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_player"])
    SimpleCoin.options.chk_frame.box_chat_all:SetChecked(data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_allchars"])
end
----
-- FRAME MANAGEMENT FUNCTIONS
----
function simplecoin_closemain(self)
    PlaySound(799)
    self:GetParent():GetParent():Hide()
    data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["mainwindow_show"] = false
end
-- toggle main options frame
function simplecoin_showtoggle(self)
    PlaySound(799)
    if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["mainwindow_show"] == false) then
        SimpleCoin:Show()
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["mainwindow_show"] = true
    else
        SimpleCoin:Hide()
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["mainwindow_show"] = false
    end
end
-- main window resize
function simplecoin_frame_resize(self, motion, savename)
    self:SetScript(
        "OnMouseDown",
        function(self, button)
            self:GetParent().main_frame:ClearAllPoints()
            self:GetParent().main_frame:SetPoint("TOPLEFT")
            self:GetParent().main_frame:SetPoint("BOTTOMRIGHT", 0, 30)
            self:GetParent().realm_select:ClearAllPoints()
            self:GetParent().realm_select:SetPoint("TOPLEFT", -6, -32)
            self:GetParent().realm_select:SetPoint("TOPRIGHT", -10, -60)
            -- scrollchild points has to be reset after scrolling on resizing
            self:GetParent().char_list.data:ClearAllPoints()
            self:GetParent().char_list.data:SetPoint("TOPLEFT")
            self:GetParent().char_list.data:SetPoint("TOPRIGHT")
            self:GetParent().realm_select:Hide()
            self:GetParent():StartSizing("BOTTOMRIGHT")
        end
    )
    self:SetScript(
        "OnMouseUp",
        function(self, button)
            -- scrollchild width has to be set for correct scrolling
            self:GetParent().char_list.data:SetWidth(self:GetParent().char_list.data:GetParent():GetWidth())
            UIDropDownMenu_SetWidth(SimpleCoin.realm_select, SimpleCoin.realm_select:GetParent():GetWidth() - 40)
            self:GetParent().realm_select:Show()
            self:GetParent():StopMovingOrSizing()
        end
    )
end
function simplecoin_olay_resize(self, motion, savename)
    self:SetScript(
        "OnMouseDown",
        function(self, button)
            self:GetParent():StartSizing("BOTTOMRIGHT")
        end
    )
    self:SetScript(
        "OnMouseUp",
        function(self, button)
            local coin_ch = {self:GetParent():GetChildren()}
            for k, v in pairs(coin_ch) do
                if (v ~= SimpleCoin_olay.resize) then
                    v:SetWidth(self:GetParent():GetWidth())
                end
            end
            self:GetParent():StopMovingOrSizing()
        end
    )
end
-- reset windows positions
function reset_windows()
    PlaySound(799)
    SimpleCoin:ClearAllPoints()
    SimpleCoin:SetPoint("CENTER", UIParent, "CENTER")
    SimpleCoin.options:ClearAllPoints()
    SimpleCoin.options:SetPoint("TOPRIGHT", SimpleCoin.main_frame, "TOPRIGHT", SimpleCoin.options:GetWidth(), 0)
    SimpleCoin_olay:ClearAllPoints()
    SimpleCoin_olay:SetPoint("TOP", UIParent, "TOP", 0, -200)
    SimpleCoin_icon:ClearAllPoints()
    SimpleCoin_icon:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -200, -160)
end
function simplecoin_set_resizable(self)
    self:SetResizable(true)
    self:SetUserPlaced(true)
    self:SetClampedToScreen(true)
end
function simplecoin_set_movable(self)
    self:EnableMouse(true)
    self:SetMovable(true)
    self:SetClampedToScreen(true)
end
-- coin overlay save pos
function simplecoin_coin_pos(self)
    data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["pos"] = {self:GetPoint()}
    sc_coin_hgt_crnd = true
end
----
-- error handling
----
function simplecoin_get_saved_variables()
    while (data == nil) do
        data = SimpleCoinData
    end
end
function simplecoin_error_handling()
    -- main window cw (incorrect size)
    if (SimpleCoin.realm_select:GetParent():GetHeight() ~= SimpleCoin.realm_select:GetParent():GetWidth() - 40) then
        UIDropDownMenu_SetWidth(SimpleCoin.realm_select, SimpleCoin.realm_select:GetParent():GetWidth() - 40)
    end
    if (SimpleCoin.main_frame.coin_display:GetHeight() < simplecoin_main_cw_height or SimpleCoin.main_frame.coin_display:GetHeight() > simplecoin_main_cw_height) then
        SimpleCoin.main_frame.coin_display:SetHeight(simplecoin_main_cw_height)
    end
end
