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
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["coin_overlay"]["switches"] = {true, true, true, true, true}
    end
    -- chat frame
    if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_player"] == nil) then
        data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_player"] = false
    end
    if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_allchars"] == nil) then
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
        SimpleCoin.char_list.data[realm][faction].Symbol:SetPoint("TOPLEFT", 30, charListy + 6)
        SimpleCoin.char_list.data[realm][faction].Symbol:SetWidth(20)
        SimpleCoin.char_list.data[realm][faction].Symbol:SetHeight(20)
        SimpleCoin.char_list.data[realm][faction].Symbol:SetBackdrop(
            {
                bgFile = "Interface\\addons\\SimpleCoin\\img\\Battleground-" .. faction,
                tile = 0,
                tileSize = faction_tilesize_list
            }
        )
        -- frame for faction characters display
        SimpleCoin.char_list.data[realm][faction].Text = SimpleCoin.char_list.data[realm]:CreateFontString()
        SimpleCoin.char_list.data[realm][faction].Text:SetFontObject("GameFontNormalSmall")
        SimpleCoin.char_list.data[realm][faction].Text:SetText(faction)
        SimpleCoin.char_list.data[realm][faction].Text:SetPoint("TOPLEFT", 50, charListy)
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
        local name = p_name or "no character"
        local faction = p_faction or sc_faction
        local char_path = data["realms"][realm][faction]["characters"]
        local class_color = colorTable[char_path[name]["class"]]

        -- character frame
        self[name] = CreateFrame("Frame", "$parent_" .. name, self, sc_AddonBackdropTemplate)
        self[name]:SetPoint("TOPLEFT", 40, charListy)
        self[name]:SetPoint("TOPRIGHT", -4, charListy)
        self[name]:SetHeight(cL_char_h)
        -- delete button
        if (name ~= sc_player) then
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
                            char_path[k] = nil
                        end
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
        self[p_type .. "_Copper"]:SetText(colorTable["White"] .. simplecoin_reformat_coinstring(GetCoinTextureString(char_path[name]["copper"])))
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

        for k, v in pairs(data["realms"][realm]) do
            if (k ~= "copper") then
                if table_length(data["realms"][realm][k]) > 0 then
                    create_faction_plate(tostring(k))
                    for kc, vc in pairs(data["realms"][realm][k]["characters"]) do
                        if (kc == sc_player) then
                            -- active character
                            player_found_in_data = true
                            create_character_string(SimpleCoin.char_list.data[realm][k], realm, k, "player", kc)
                        end
                        if (kc ~= sc_player) then
                            -- other characters on realm
                            create_character_string(SimpleCoin.char_list.data[realm][k], realm, k, "character", kc)
                        end
                    end
                end
            end
        end
        if (not player_found_in_data) then
            create_character_string(SimpleCoin.char_list.data[sc_realm][sc_faction], sc_realm, sc_faction, "player", sc_player)
        end
    end
    -- create realm display
    create_realm_plate()
    -- set char_list.data height based on amount of lines/characters
    SimpleCoin.char_list.data:SetHeight(math.abs(charListy))
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
        if (data["realms"][sc_realm][sc_faction]["characters"][sc_player] ~= nil) then
            simplecoin_copperchange()
        end
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
function simplecoin_reformat_coinstring(str)
    local separator = "%1" .. LARGE_NUMBER_SEPERATOR .. "%2"
    str = str:gsub("(%d)(%d%d%d)$", separator)
    repeat
        local rept
        str, rept = str:gsub("(%d)(%d%d%d%D)", separator)
    until rept <= 0
    return str
end
function simplecoin_update_display()
    function simplecoin_update_display_coin_frame(self)
        self.player.text:SetText(colorTable[UnitClass("player")] .. sc_player .. colorTable["White"] .. ":")
        self.player.copper:SetText(colorTable["White"] .. simplecoin_reformat_coinstring(GetCoinTextureString(getMoney)))
        self.player_faction.text:SetText(colorTable["Grey"] .. "(" .. colorTable[sc_faction] .. sc_faction .. colorTable["Grey"] .. ")|r " .. sc_coin_realm .. colorTable["White"] .. ":")
        self.player_faction.copper:SetText(colorTable["White"] .. simplecoin_reformat_coinstring(GetCoinTextureString(sc_faction_copper + getMoney)))
        self.opposite_faction.text:SetText(colorTable["Grey"] .. "(" .. colorTable[sc_opposite_faction] .. sc_opposite_faction .. colorTable["Grey"] .. ")|r " .. sc_coin_realm .. colorTable["White"] .. ":")
        self.opposite_faction.copper:SetText(colorTable["White"] .. simplecoin_reformat_coinstring(GetCoinTextureString(sc_opposite_faction_copper)))
        self.realm.text:SetText(sc_realm .. colorTable["White"] .. ":")
        self.realm.copper:SetText(colorTable["White"] .. simplecoin_reformat_coinstring(GetCoinTextureString(sc_realm_copper)))
        self.all_realms.text:SetText(colorTable["Bisque"] .. "All realms" .. colorTable["White"] .. ":")
        self.all_realms.copper:SetText(colorTable["White"] .. simplecoin_reformat_coinstring(GetCoinTextureString(sc_total_copper)))
    end
    -- set total copper on character list display
    if (SimpleCoin.char_list.data[sc_faction] ~= nil) then
        SimpleCoin.char_list.data[sc_faction].copper:SetText(colorTable["White"] .. simplecoin_reformat_coinstring(GetCoinTextureString(sc_faction_copper + getMoney)))
    end
    if (SimpleCoin.char_list.data[sc_faction] ~= nil) then
        SimpleCoin.char_list.data[sc_faction].player_Copper:SetText(colorTable["White"] .. simplecoin_reformat_coinstring(GetCoinTextureString(getMoney)))
    end
    -- chat display
    if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_player"]) then
        print(colorTable[UnitClass("player")] .. sc_player .. "|r: " .. simplecoin_reformat_coinstringsimplecoin_reformat_coinstring(GetCoinTextureString(getMoney)))
    end
    if (data["realms"][sc_realm][sc_faction]["characters"][sc_player]["settings"]["chatline_allchars"]) then
        print("Total on " .. colorTable[UnitClass("player")] .. sc_realm .. "|r: " .. simplecoin_reformat_coinstring(GetCoinTextureString(sc_faction_copper + getMoney)))
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
            self:GetParent().main_frame:ClearAllPoints()
            self:GetParent().main_frame:SetPoint("TOPLEFT")
            self:GetParent().main_frame:SetPoint("BOTTOMRIGHT", 0, 30)
            -- scrollchild points has to be reset after scrolling on resizing
            self:GetParent().char_list.data:ClearAllPoints()
            self:GetParent().char_list.data:SetPoint("TOPLEFT")
            self:GetParent().char_list.data:SetPoint("TOPRIGHT")
            self:GetParent():StartSizing("BOTTOMRIGHT")
        end
    )
    self:SetScript(
        "OnMouseUp",
        function(self, button)
            -- scrollchild width has to be set for correct scrolling
            self:GetParent().char_list.data:SetWidth(self:GetParent().char_list.data:GetParent():GetWidth())
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
