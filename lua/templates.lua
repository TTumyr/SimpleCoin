-- coin widget template
function simplecoin_coin_widget(self, y_pos_inc, pad, line, in_font)
    -- pos variables
    local coin_font, padding
    local faction_tilesize = 20
    local fr_left = 0
    local fr_right = 0
    local fr_pos_y = 0
    local ic_left = -2
    local ic_pos_y = 3
    local txt_left = 14
    local txt_right = -4
    local txt_y = 0
    local text_pos_y = 0
    local y_inc
    coin_font = in_font or "GameFontNormalSmall"
    padding = pad or {-4, 0, -4, 0}
    y_inc = y_pos_inc or {22, 14, 14, 22, 14}
    function simplecoin_cw_increaseY(inc)
        fr_pos_y = fr_pos_y - inc
        --ic_pos_y = ic_pos_y - inc
        --text_pos_y = text_pos_y - inc
    end
    -- player
    self.player = CreateFrame("Frame", "$parent_Player", self, sc_AddonBackdropTemplate)
    self.player:SetWidth(self.player:GetParent():GetWidth())
    self.player:SetHeight(1)
    self.player:SetPoint("TOPLEFT", fr_left + padding[1], fr_pos_y + padding[1])
    simplecoin_set_resizable(self.player)
    -- player icon
    self.player.symbol = CreateFrame("Frame", "$parent_PlayerIcon", self.player, sc_AddonBackdropTemplate)
    self.player.symbol:SetPoint("TOPLEFT", ic_left + padding[4], ic_pos_y + padding[1])
    self.player.symbol:SetWidth(faction_tilesize)
    self.player.symbol:SetHeight(faction_tilesize)
    -- player text
    self.player.text = self.player:CreateFontString("$parent_PlayerText", "OVERLAY", coin_font)
    self.player.text:SetPoint("TOPLEFT", txt_left + padding[4], text_pos_y + padding[1])
    self.player.text:SetText("Player character")
    -- player copper
    self.player.copper = self.player:CreateFontString("$parent_PlayerCoins", "OVERLAY", coin_font)
    self.player.copper:SetPoint("TOPRIGHT", txt_right + padding[2], text_pos_y + padding[1])
    -- y increments
    simplecoin_cw_increaseY(y_inc[1])
    -- player faction
    self.player_faction = CreateFrame("Frame", "$parent_PlayerFactionIcon", self, sc_AddonBackdropTemplate)
    self.player_faction:SetWidth(self.player_faction:GetParent():GetWidth())
    self.player_faction:SetHeight(1)
    self.player_faction:SetPoint("TOPLEFT", fr_left + padding[1], fr_pos_y + padding[1])
    self.player_faction.symbol = CreateFrame("Frame", "$parent_PlayerFactionIcon", self.player_faction, sc_AddonBackdropTemplate)
    simplecoin_set_resizable(self.player_faction)
    -- player faction icon
    self.player_faction.symbol:SetPoint("TOPLEFT", ic_left + padding[4], ic_pos_y + padding[1])
    self.player_faction.symbol:SetWidth(faction_tilesize)
    self.player_faction.symbol:SetHeight(faction_tilesize)
    -- player faction text field
    self.player_faction.text = self.player_faction:CreateFontString("$parent_CoinsAllChars", "OVERLAY", coin_font)
    self.player_faction.copper = self.player_faction:CreateFontString("$parent_CoinsPlayer", "OVERLAY", coin_font)
    self.player_faction.text:SetPoint("TOPLEFT", txt_left + padding[4], text_pos_y + padding[1])
    -- player faction copper
    self.player_faction.copper:SetPoint("TOPRIGHT", txt_right + padding[2], text_pos_y + padding[1])
    -- y increments
    simplecoin_cw_increaseY(y_inc[2])
    -- opposite faction
    self.opposite_faction = CreateFrame("Frame", "$parent_CoinsOppositeIcon", self, sc_AddonBackdropTemplate)
    self.opposite_faction:SetWidth(self.opposite_faction:GetParent():GetWidth())
    self.opposite_faction:SetHeight(1)
    self.opposite_faction:SetPoint("TOPLEFT", fr_left + padding[1], fr_pos_y + padding[1])
    simplecoin_set_resizable(self.opposite_faction)
    -- opposite faction icon
    self.opposite_faction.symbol = CreateFrame("Frame", "$parent_CoinsOppositeIcon", self.opposite_faction, sc_AddonBackdropTemplate)
    self.opposite_faction.symbol:SetPoint("TOPLEFT", ic_left + padding[4], ic_pos_y + padding[1])
    self.opposite_faction.symbol:SetWidth(faction_tilesize)
    self.opposite_faction.symbol:SetHeight(faction_tilesize)
    -- opposite faction text field
    self.opposite_faction.text = self.opposite_faction:CreateFontString("$parent_CoinsAllChars", "OVERLAY", coin_font)
    self.opposite_faction.text:SetPoint("TOPLEFT", txt_left + padding[4], text_pos_y + padding[1])
    -- opposite faction copper
    self.opposite_faction.copper = self.opposite_faction:CreateFontString("$parent_CoinsPlayer", "OVERLAY", coin_font)

    -- y increments
    self.opposite_faction.copper:SetPoint("TOPRIGHT", txt_right + padding[2], text_pos_y + padding[1])
    simplecoin_cw_increaseY(y_inc[3])

    -- realm
    self.realm = CreateFrame("Frame", "$parent_Realm", self, sc_AddonBackdropTemplate)
    self.realm:SetWidth(self.realm:GetParent():GetWidth())
    self.realm:SetHeight(1)
    self.realm:SetPoint("TOPLEFT", fr_left + padding[1], fr_pos_y + padding[1])
    simplecoin_set_resizable(self.realm)
    self.realm.text = self.realm:CreateFontString("$parent_RealmText", "OVERLAY", coin_font)
    self.realm.text:SetPoint("TOPLEFT", txt_left + padding[2], text_pos_y + padding[1])
    self.realm.copper = self.realm:CreateFontString("$parent_RealmCoins", "OVERLAY", coin_font)
    self.realm.copper:SetPoint("TOPRIGHT", txt_right + padding[2], text_pos_y + padding[1])
    -- y increments
    simplecoin_cw_increaseY(y_inc[4])

    -- all realms
    self.all_realms = CreateFrame("Frame", "$parent_Realm", self, sc_AddonBackdropTemplate)
    self.all_realms:SetWidth(self.all_realms:GetParent():GetWidth())
    self.all_realms:SetHeight(1)
    self.all_realms:SetPoint("TOPLEFT", fr_left + padding[1], fr_pos_y + padding[1])
    simplecoin_set_resizable(self.all_realms)
    self.all_realms.text = self.all_realms:CreateFontString("$parent_CoinsPlayer", "OVERLAY", coin_font)
    self.all_realms.text:SetPoint("TOPLEFT", txt_left + padding[4], text_pos_y + padding[1])
    self.all_realms.copper = self.all_realms:CreateFontString("$parent_CoinsPlayer", "OVERLAY", coin_font)
    -- y increments
    self.all_realms.copper:SetPoint("TOPRIGHT", txt_right + padding[2], text_pos_y + padding[1])
    simplecoin_cw_increaseY(y_inc[5])
    -- draw deco lines
    function simplecoin_deco_line(self)
        local line = self:CreateLine()
        line:SetThickness(1)
        line:SetColorTexture(0.4, 0.4, 0.4, 1)
        line:SetStartPoint("TOPLEFT", 10, 0)
        line:SetEndPoint("TOPRIGHT", -2, 0)
    end
    if (line) then
        simplecoin_deco_line(self.player_faction)
        simplecoin_deco_line(self.all_realms)
    end
    -- set total height of coin widget
    self:SetHeight(abs(fr_pos_y) + abs(padding[1] + padding[3] * 2))
end

-- check boxes
function simplecoin_chk_box(self, box_name, box_label, box_point, text_point, toggle, hit_rect)
    -- default values
    local hitCoords = {4, 4, 4, 4}
    local hitRect = hit_rect or hitCoords
    -- checkbox
    self[box_name] = CreateFrame("CheckButton", "$parent_Check_dispWidg", self, "ChatConfigCheckButtonTemplate")
    self[box_name]:SetPoint(unpack(box_point))
    self[box_name].Text = self[box_name]:CreateFontString()
    self[box_name].Text:SetFontObject("GameFontNormalSmall")
    self[box_name].Text:SetText(box_label)
    self[box_name].Text:SetPoint(unpack(text_point))
    self[box_name]:SetScript("OnClick", toggle)
    self[box_name]:SetHitRectInsets(unpack(hitRect))
end
