local coinframe_chkbox, coinframes, data, faction_tilesize_overlay, faction_tilesize_list, sc_coin_realm, textx, texty, sc_coin_realm, sc_opposite_faction, settings
local sc_realm = GetRealmName()
local sc_faction = UnitFactionGroup("player")
local sc_player = GetUnitName("player")
-- copper
local getMoney = 0
local sc_total_copper = 0
local sc_realm_copper = 0
local sc_faction_copper = 0
local sc_opposite_faction_copper = 0
local sc_realm_copper = 0
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
    if (not data["realms"]["copper"]) then
        data["realms"]["copper"] = 0
    end
    if (not data["realms"][sc_realm]) then
        data["realms"][sc_realm] = {}
    end
    if (not data["realms"][sc_realm]["copper"]) then
        data["realms"][sc_realm]["copper"] = 0
    end
    if (not data["realms"][sc_realm][sc_faction]) then
        data["realms"][sc_realm] = {["Alliance"] = {}, ["Horde"] = {}}
    end
    if (not data["realms"][sc_realm][sc_faction]["copper"]) then
        data["realms"][sc_realm][sc_faction]["copper"] = 0
    end
    if (not data["realms"][sc_realm][sc_faction]["characters"]) then
        data["realms"][sc_realm][sc_faction]["characters"] = {}
    end
    if (not data["realms"][sc_realm][sc_faction]["characters"][sc_player]) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player] = {}
    end
    if (not data["realms"][sc_realm][sc_faction]["characters"][sc_player]["data"]) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["data"] = {}
    end
    if (not data["realms"][sc_realm][sc_faction]["characters"][sc_player]["copper"]) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["copper"] = 0
    end
    if (not data["realms"][sc_realm][sc_faction]["characters"][sc_player]["class"]) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["class"] = UnitClass("player")
    end
    if (not data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"] = {}
    end
    if (not data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["mainwindow_show"]) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["mainwindow_show"] = false
    end
    -- coin overlay
    if (not data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"] = {}
    end
    if (not data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["pos"]) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["pos"] = {}
    end
    if (not data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["transparent"]) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["transparent"] = false
    end
    if (not data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["switches"]) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["switches"] = {true, true, true, true, true}
    end
    -- chat frame
    if (not data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_player"]) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_player"] = false
    end
    if (not data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_allchars"]) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_allchars"] = false
    end
end
--
function table_length(tbl)
    local count = 0
    for _ in pairs(tbl) do
        count = count + 1
    end
    return count
end
-- coin overlay save pos
function simplecoin_coin_pos(self)
    data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["pos"] = {self:GetPoint()}
    sc_coin_hgt_crnd = true
end
-- main window character data
function simplecoin_fill_main_data()
    local charListy = -5
    function create_faction_plate(faction)
        SimpleCoin.char_list.data[faction] = CreateFrame("Frame", "$parent_Name" .. faction, SimpleCoin.char_list.data, sc_AddonBackdropTemplate)
        simplecoin_set_resizable(SimpleCoin.char_list.data[faction])
        SimpleCoin.char_list.data[faction]:SetWidth(SimpleCoin.char_list.data[faction]:GetParent():GetWidth())
        SimpleCoin.char_list.data[faction]:SetHeight(SimpleCoin.char_list.data[faction]:GetParent():GetHeight())
        SimpleCoin.char_list.data[faction]:SetPoint("TOPLEFT")
        SimpleCoin.char_list.data[faction].Symbol = CreateFrame("Frame", "$parent_Symbol", SimpleCoin.char_list.data, sc_AddonBackdropTemplate)
        SimpleCoin.char_list.data[faction].Symbol:SetPoint("TOPLEFT", 30, charListy + 6)
        SimpleCoin.char_list.data[faction].Symbol:SetWidth(20)
        SimpleCoin.char_list.data[faction].Symbol:SetHeight(20)
        SimpleCoin.char_list.data[faction].Symbol:SetBackdrop(
            {
                bgFile = "Interface\\addons\\SimpleCoin\\img\\Battleground-" .. faction,
                tile = 0,
                tileSize = faction_tilesize_list
            }
        )
        -- frame for faction characters display
        SimpleCoin.char_list.data[faction].Text = SimpleCoin.char_list.data:CreateFontString()
        SimpleCoin.char_list.data[faction].Text:SetFontObject("GameFontNormalSmall")
        SimpleCoin.char_list.data[faction].Text:SetText(faction)
        SimpleCoin.char_list.data[faction].Text:SetPoint("TOPLEFT", 50, charListy)
        SimpleCoin.char_list.data[faction].copper = SimpleCoin.char_list.data:CreateFontString()
        SimpleCoin.char_list.data[faction].copper:SetFontObject("GameFontNormalSmall")
        SimpleCoin.char_list.data[faction].copper:SetText(colorTable["White"] .. GetCoinTextureString(data["realms"][sc_realm][sc_faction]["copper"]))
        SimpleCoin.char_list.data[faction].copper:SetPoint("TOPRIGHT", -30, charListy)
        SimpleCoin.char_list.data[faction].faction_data = CreateFrame("Frame", "$parent_Players" .. faction, SimpleCoin.char_list.data[faction], sc_AddonBackdropTemplate)
        simplecoin_set_resizable(SimpleCoin.char_list.data[faction].faction_data)
        SimpleCoin.char_list.data[faction].faction_data:SetPoint("TOPLEFT")
        SimpleCoin.char_list.data[faction].faction_data:SetWidth(SimpleCoin.char_list.data[faction].faction_data:GetParent():GetWidth())
        charListy = charListy - 20
    end
    for k, v in pairs(data["realms"][sc_realm]) do
        if (k ~= "copper") then
            if table_length(data["realms"][sc_realm][k]) > 0 then
                create_faction_plate(tostring(k))
                for kc, vc in pairs(data["realms"][sc_realm][k]["characters"]) do
                    if (kc == sc_player) then
                        -- active character
                        SimpleCoin.char_list.data[k].faction_data.player_Name = SimpleCoin.char_list.data[k]:CreateFontString()
                        SimpleCoin.char_list.data[k].faction_data.player_Name:SetFontObject("GameFontNormalSmall")
                        SimpleCoin.char_list.data[k].faction_data.player_Name:SetText(colorTable[data["realms"][sc_realm][sc_faction]["characters"][sc_player]["class"]] .. sc_player .. colorTable["White"] .. ":     ")
                        SimpleCoin.char_list.data[k].faction_data.player_Name:SetPoint("TOPLEFT", 60, charListy)
                        -- active character copper
                        SimpleCoin.char_list.data[k].faction_data.player_Copper = SimpleCoin.char_list.data[k]:CreateFontString()
                        SimpleCoin.char_list.data[k].faction_data.player_Copper:SetFontObject("GameFontNormalSmall")
                        SimpleCoin.char_list.data[k].faction_data.player_Copper:SetText(colorTable["White"] .. GetCoinTextureString(data["realms"][sc_realm][sc_faction]["characters"][sc_player]["copper"]))
                        SimpleCoin.char_list.data[k].faction_data.player_Copper:SetPoint("TOPRIGHT", -30, charListy)
                        charListy = charListy - 20
                    end
                    if (kc ~= sc_player) then
                        -- other characters on realm
                        SimpleCoin.char_list.data[k].faction_data.character_Name = SimpleCoin.char_list.data[k]:CreateFontString()
                        SimpleCoin.char_list.data[k].faction_data.character_Name:SetFontObject("GameFontNormalSmall")
                        SimpleCoin.char_list.data[k].faction_data.character_Name:SetText(colorTable[data["realms"][sc_realm][k]["characters"][kc]["class"]] .. kc .. colorTable["White"] .. ":")
                        SimpleCoin.char_list.data[k].faction_data.character_Name:SetPoint("TOPLEFT", 60, charListy)
                        -- character copper
                        SimpleCoin.char_list.data[k].faction_data.character_Copper = SimpleCoin.char_list.data[k]:CreateFontString()
                        SimpleCoin.char_list.data[k].faction_data.character_Copper:SetFontObject("GameFontNormalSmall")
                        SimpleCoin.char_list.data[k].faction_data.character_Copper:SetText(colorTable["White"] .. GetCoinTextureString(data["realms"][sc_realm][k]["characters"][kc]["copper"]))
                        SimpleCoin.char_list.data[k].faction_data.character_Copper:SetPoint("TOPRIGHT", -30, charListy)
                        charListy = charListy - 20
                    end
                end
            end
        end
    end
    -- set char_list.data height based on amount of lines/characters
    SimpleCoin.char_list.data:SetHeight(math.abs(charListy) + 20)
end
-- Initial GUI settinggs
function simplecoin_gui_initial_setup()
    function simplecoin_set_coinframe_icon(self, symbol)
        self:SetBackdrop(
            {
                bgFile = "Interface\\addons\\SimpleCoin\\img\\Battleground-" .. symbol,
                tile = 0,
                tileSize = faction_tilesize_overlay
            }
        )
    end
    -- set icons
    simplecoin_set_coinframe_icon(SimpleCoin_olay.player.symbol, sc_faction)
    simplecoin_set_coinframe_icon(SimpleCoin_olay.player_faction.symbol, sc_faction)
    simplecoin_set_coinframe_icon(SimpleCoin_olay.opposite_faction.symbol, sc_opposite_faction)
    simplecoin_set_coinframe_icon(SimpleCoin.main_frame.coin_display.player.symbol, sc_faction)
    simplecoin_set_coinframe_icon(SimpleCoin.main_frame.coin_display.player_faction.symbol, sc_faction)
    simplecoin_set_coinframe_icon(SimpleCoin.main_frame.coin_display.opposite_faction.symbol, sc_opposite_faction)
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
-- Event related functions
function simplecoin_onevent(self, event)
    if (event == "ADDON_LOADED") then
        coinframe_chkbox = {
            SimpleCoin.options.chk_frame.screen_display_player,
            SimpleCoin.options.chk_frame.screen_display_faction,
            SimpleCoin.options.chk_frame.screen_display_opposite_faction,
            SimpleCoin.options.chk_frame.screen_display_realm,
            SimpleCoin.options.chk_frame.screen_display_all_realms
        }
        coinframes = {
            SimpleCoin_olay.player,
            SimpleCoin_olay.player_faction,
            SimpleCoin_olay.opposite_faction,
            SimpleCoin_olay.realm,
            SimpleCoin_olay.all_realms
        }
        -- adjust width of main frame coin widget elements
        local sc_cw_ch = {SimpleCoin.main_frame.coin_display:GetChildren()}
        for k, v in pairs(sc_cw_ch) do
            v:SetWidth(v:GetParent():GetWidth())
        end
    end
    if (event == "VARIABLES_LOADED") then
        -- Setup data from saved variables
        settings = SimpleCoinSettings
        data = SimpleCoinData
        simplecoin_var_setup()
        if (data["realms"][sc_realm] ~= nil) then
            for k, v in pairs(data["realms"][sc_realm]) do
                if (k ~= "copper" and k ~= sc_faction and data["realms"][sc_realm][k]["copper"] ~= nil) then
                    sc_opposite_faction_copper = data["realms"][sc_realm][k]["copper"]
                end
            end
        end
        simplecoin_disp_screen_currency()
        -- interface configuration
        simplecoin_gui_initial_setup()
    end
    if (event == "PLAYER_ENTERING_WORLD") then
        simplecoin_copperchange()
    end
    if (event == "PLAYER_MONEY") then
        simplecoin_copperchange()
    end
end
-- change in money / display money routine
function simplecoin_copperchange()
    getMoney = GetMoney()
    if (data == nil) then
        data = SimpleCoinData
    end
    --variables
    local faction = data["realms"][sc_realm][sc_faction]["characters"]
    local realm = data["realms"][sc_realm]
    sc_realm_copper = 0
    sc_total_copper = 0
    -- get player money
    if (data["realms"][sc_realm][sc_faction]["characters"][tostring(sc_player)]["copper"] ~= nil) then
        data["realms"][sc_realm][sc_faction]["characters"][tostring(sc_player)]["copper"] = getMoney
    end
    -- get faction money
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
    -- total copper for all reamls and factions
    for k, v in pairs(data["realms"]) do
        if (k ~= "copper") then
            if (data["realms"][k]["copper"] ~= nil) then
                sc_total_copper = sc_total_copper + data["realms"][k]["copper"]
            end
        end
    end
    if (data["realms"]["copper"] ~= nil) then
        data["realms"]["copper"] = sc_total_copper
    end
    simplecoin_update_display()
end
function simplecoin_update_display()
    function simplecoin_update_display_coin_frame(self)
        self.player.text:SetText(colorTable[UnitClass("player")] .. sc_player .. colorTable["White"] .. ":")
        self.player.copper:SetText(colorTable["White"] .. GetCoinTextureString(getMoney))
        self.player_faction.text:SetText(colorTable["Grey"] .. "(" .. colorTable[sc_faction] .. sc_faction .. colorTable["Grey"] .. ")|r " .. sc_coin_realm .. colorTable["White"] .. ":")
        self.player_faction.copper:SetText(colorTable["White"] .. GetCoinTextureString(sc_faction_copper + getMoney))
        -- TODO this can be moved to update only once!
        self.opposite_faction.text:SetText(colorTable["Grey"] .. "(" .. colorTable[sc_opposite_faction] .. sc_opposite_faction .. colorTable["Grey"] .. ")|r " .. sc_coin_realm .. colorTable["White"] .. ":")
        self.opposite_faction.copper:SetText(colorTable["White"] .. GetCoinTextureString(sc_opposite_faction_copper))
        self.realm.text:SetText(sc_realm .. colorTable["White"] .. ":")
        self.realm.copper:SetText(colorTable["White"] .. GetCoinTextureString(data["realms"][sc_realm]["copper"]))
        self.all_realms.text:SetText(colorTable["Bisque"] .. "All realms" .. colorTable["White"] .. ":")
        self.all_realms.copper:SetText(colorTable["White"] .. GetCoinTextureString(sc_total_copper))
    end
    -- set total copper on character list display
    SimpleCoin.char_list.data[sc_faction].copper:SetText(colorTable["White"] .. GetCoinTextureString(data["realms"][sc_realm][sc_faction]["copper"]))
    SimpleCoin.char_list.data[sc_faction].faction_data.player_Copper:SetText(colorTable["White"] .. GetCoinTextureString(getMoney))
    -- chat display
    if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_player"]) then
        print(colorTable[UnitClass("player")] .. sc_player .. "|r: " .. GetCoinTextureString(getMoney))
    end
    if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_allchars"]) then
        print("Total on " .. colorTable[UnitClass("player")] .. sc_realm .. "|r: " .. GetCoinTextureString(sc_faction_copper + getMoney))
    end
    -- coin overlay and main coin frame
    simplecoin_update_display_coin_frame(SimpleCoin_olay)
    simplecoin_update_display_coin_frame(SimpleCoin.main_frame.coin_display)
end
function simplecoin_closemain(self)
    self:GetParent():GetParent():Hide()
    data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["mainwindow_show"] = false
end
-- toggle main options frame
function simplecoin_showtoggle(self)
    if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["mainwindow_show"] == false) then
        SimpleCoin:Show()
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["mainwindow_show"] = true
    else
        SimpleCoin:Hide()
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["mainwindow_show"] = false
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
                bgFile = "Interface\\addons\\SimpleCoin\\img\\UI-DialogBox-Background",
                tile = "false",
                tileSize = 32
            }
        )
    end
    -- TODO get this cleaner
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
            data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["switches"][id] = not data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["switches"][id]
            self:SetChecked(data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["switches"][id])
        end
    end
    -- TODO cleanup options checkbox
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
-- main window resize
function simplecoin_frame_resize(self, motion, savename)
    self:SetScript(
        "OnMouseDown",
        function(self, button)
            self:GetParent():StartSizing("BOTTOMRIGHT")
        end
    )
    self:SetScript(
        "OnMouseUp",
        function(self, button)
            self:GetParent():StopMovingOrSizing()
            self:GetParent().char_list:SetWidth(self:GetParent():GetWidth() - 20)
            self:GetParent().char_list.data:SetWidth(math.floor(self:GetParent():GetWidth()))
            self:GetParent().char_list.data:GetChildren():SetWidth(math.floor(self:GetParent():GetWidth()))
            self:GetParent().char_list:SetHeight(math.floor(self:GetParent():GetHeight() - 60))
            self:GetParent().main_frame.coin_display:SetWidth(SimpleCoin.main_frame.coin_display:GetParent():GetParent():GetWidth() - 30)
            local coin_ch = {self:GetParent().main_frame.coin_display:GetChildren()}
            for k, v in pairs(coin_ch) do
                v:SetWidth(self:GetParent().main_frame.coin_display:GetParent():GetWidth() - 30)
            end
            self:GetParent().main_frame:SetPoint("TOPLEFT")
            self:GetParent().main_frame:SetPoint("BOTTOMRIGHT", 0, 30)
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
