-- pos variables
local coin_font, padding, faction_tilesize, fr_left, fr_right, fr_pos_y, ic_left, ic_pos_y, txt_left, txt_right, txt_y, text_pos_y, y_inc
-- Global functions
simplecoin_main_cw_height = 0
-- set variables for coinframe
function simplecoin_get_coinwidget_vars(p_y_pos_inc, p_pad, p_line, p_in_font, p_y_pos_inc)
    faction_tilesize = 20
    fr_left = 0
    fr_right = 0
    fr_pos_y = 0
    ic_left = -2
    ic_pos_y = 3
    txt_left = 14
    txt_right = -4
    txt_y = 0
    text_pos_y = 0
    coin_font = in_font or "GameFontNormalSmall"
    padding = p_pad or {-4, 0, -4, 0}
    y_inc = p_y_pos_inc or {20, 14, 14, 20, 14, 14, 14}
end
-- coin widget incremental Y position
function simplecoin_cw_increaseY(inc)
    fr_pos_y = fr_pos_y - inc
end
function simplecoin_coinwidget_unit(self, p_width, p_height)
    local width = p_width or self:GetParent():GetWidth()
    local height = p_height or 1
    self:SetWidth(self:GetParent():GetWidth())
    self:SetHeight(height)
    self:SetPoint("TOPLEFT", fr_left + padding[4], fr_pos_y + padding[1])
    self:SetPoint("TOPRIGHT", fr_right + padding[2], fr_pos_y + padding[1])
    simplecoin_set_resizable(self)
    -- icon
    self.symbol = CreateFrame("Frame", "$parent_Icon", self, sc_AddonBackdropTemplate)
    self.symbol:SetPoint("TOPLEFT", ic_left + padding[4], ic_pos_y + padding[1])
    self.symbol:SetWidth(faction_tilesize)
    self.symbol:SetHeight(faction_tilesize)
    -- text left
    self.text = self:CreateFontString("$parent_Text", "OVERLAY", coin_font)
    self.text:SetPoint("TOPLEFT", txt_left + padding[4], text_pos_y + padding[1])
    -- text right
    self.copper = self:CreateFontString("$parent_Coins", "OVERLAY", coin_font)
    self.copper:SetPoint("TOPRIGHT", txt_right + padding[2], text_pos_y + padding[1])
end
-- coin widget template
function simplecoin_coin_widget(self, p_y_pos_inc, p_pad, p_line, p_in_font)
    simplecoin_get_coinwidget_vars(p_y_pos_inc, p_pad, p_line, p_in_font)
    -- player
    self.player = CreateFrame("Frame", "$parent_Player", self, sc_AddonBackdropTemplate)
    simplecoin_coinwidget_unit(self.player, nil, 1)
    -- y increments
    simplecoin_cw_increaseY(y_inc[1])
    -- player faction
    self.player_faction = CreateFrame("Frame", "$parent_PlayerFaction", self, sc_AddonBackdropTemplate)
    simplecoin_coinwidget_unit(self.player_faction, nil, 1)
    -- y increments
    simplecoin_cw_increaseY(y_inc[2])
    -- opposite faction
    self.opposite_faction = CreateFrame("Frame", "$parent_COppositeFaction", self, sc_AddonBackdropTemplate)
    simplecoin_coinwidget_unit(self.opposite_faction, nil, 1)
    -- y increments
    simplecoin_cw_increaseY(y_inc[3])

    -- realm
    self.realm = CreateFrame("Frame", "$parent_Realm", self, sc_AddonBackdropTemplate)
    simplecoin_coinwidget_unit(self.realm, nil, 1)
    -- y increments
    simplecoin_cw_increaseY(y_inc[4])

    -- player faction total
    self.player_faction_total = CreateFrame("Frame", "$parent_Realm", self, sc_AddonBackdropTemplate)
    simplecoin_coinwidget_unit(self.player_faction_total, nil, 1)
    -- y increments
    simplecoin_cw_increaseY(y_inc[5])

    -- opposite faction total
    self.opposite_faction_total = CreateFrame("Frame", "$parent_Realm", self, sc_AddonBackdropTemplate)
    simplecoin_coinwidget_unit(self.opposite_faction_total, nil, 1)
    -- y increments
    simplecoin_cw_increaseY(y_inc[6])

    -- all realms
    self.all_realms = CreateFrame("Frame", "$parent_Realm", self, sc_AddonBackdropTemplate)
    simplecoin_coinwidget_unit(self.all_realms, nil, 1)
    -- y increments
    simplecoin_cw_increaseY(y_inc[7])
    -- draw deco lines
    function simplecoin_deco_line(self)
        local line = self:CreateLine()
        line:SetThickness(1)
        line:SetColorTexture(0.4, 0.4, 0.4, 0.3)
        line:SetStartPoint("TOPLEFT", 4, 0)
        line:SetEndPoint("TOPRIGHT", -4, 0)
    end
    if (p_line) then
        simplecoin_deco_line(self.player_faction)
        simplecoin_deco_line(self.player_faction_total)
    end
    -- set total height of coin widget
    self:SetHeight(abs(fr_pos_y) + abs(padding[1] + padding[3] * 2))
    if (self == SimpleCoin.main_frame.coin_display) then
        simplecoin_main_cw_height = abs(fr_pos_y) + abs(padding[1] + padding[3] * 2)
    end
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
