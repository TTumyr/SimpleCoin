-- main window
SimpleCoin = CreateFrame("Frame", "SimpleCoin", UIParent, sc_AddonBackdropTemplate)
SimpleCoin:SetWidth(460)
SimpleCoin:SetHeight(520)
SimpleCoin:ClearAllPoints()
SimpleCoin:SetPoint("CENTER", UIParent, "CENTER")
SimpleCoin.title = GetAddOnMetadata("SimpleCoin", "Title")
SimpleCoin.version = GetAddOnMetadata("SimpleCoin", "Version")
SimpleCoin:SetBackdrop(
	{
		bgFile = "Interface\\addons\\SimpleCoin\\img\\bg-marble",
		tile = false,
		tileSize = 256
	}
)
SimpleCoin:EnableMouse(true)
-- set movable and resizeable
simplecoin_set_resizable(SimpleCoin)
simplecoin_set_movable(SimpleCoin)
SimpleCoin:SetMinResize(310, 300)
SimpleCoin:SetMaxResize(900, 600)
SimpleCoin:SetFrameLevel(1)
-- main display frame
SimpleCoin.main_frame = CreateFrame("Frame", "$parent_MainFrame", SimpleCoin, sc_AddonBackdropTemplate)
SimpleCoin.main_frame:SetWidth(SimpleCoin.main_frame:GetParent():GetWidth())
SimpleCoin.main_frame:SetHeight(SimpleCoin.main_frame:GetParent():GetHeight() - 20)
SimpleCoin.main_frame:ClearAllPoints()
SimpleCoin.main_frame:SetPoint("TOPLEFT")
SimpleCoin.main_frame:SetPoint("TOPRIGHT")
SimpleCoin.main_frame:SetPoint("BOTTOMLEFT", 0, 30)
SimpleCoin.main_frame:SetPoint("BOTTOMRIGHT", 0, 30)
-- set movable and resizeable
simplecoin_set_resizable(SimpleCoin.main_frame)
simplecoin_set_movable(SimpleCoin.main_frame)
SimpleCoin.main_frame:RegisterForDrag("LeftButton")
SimpleCoin.main_frame:SetScript(
	"OnDragStart",
	function(self)
		self:GetParent().main_frame:ClearAllPoints()
		self:GetParent().main_frame:SetPoint("TOPLEFT")
		self:GetParent().main_frame:SetPoint("BOTTOMRIGHT", 0, 30)
		self:GetParent().char_list.data:ClearAllPoints()
		self:GetParent().char_list.data:SetPoint("TOPLEFT")
		self:GetParent().char_list.data:SetPoint("TOPRIGHT")
		self:GetParent():StartMoving()
	end
)
SimpleCoin.main_frame:SetScript(
	"OnDragStop",
	function(self)
		self:GetParent():StopMovingOrSizing()
	end
)
--
SimpleCoin.header = CreateFrame("Frame", "$parent_Header", SimpleCoin, sc_AddonBackdropTemplate)
SimpleCoin.header:SetWidth(SimpleCoin.header:GetParent():GetWidth())
SimpleCoin.header:SetHeight(28)
SimpleCoin.header:SetPoint("TOPLEFT", 0, 0)
SimpleCoin.header:SetPoint("TOPRIGHT", 0, 0)
SimpleCoin.header:SetBackdrop(
	{
		bgFile = "Interface\\addons\\SimpleCoin\\img\\Black-Background",
		tile = true,
		tileSize = 32
	}
)
SimpleCoin.header:SetBackdropColor(1, 1, 1, simplecoin_bg_heavy_opac)
-- header title
SimpleCoin.header_title = SimpleCoin.header:CreateFontString()
SimpleCoin.header_title:SetFont("Fonts\\FRIZQT__.TTF", 16, "OUTLINE", "THICKOUTLINE", "MONOCHROME")
SimpleCoin.header_title:SetFontObject("GameFontNormal")
SimpleCoin.header_title:SetPoint("TOPLEFT", 10, -6)
SimpleCoin.header_title:SetText(SimpleCoin.title)
-- header version
SimpleCoin.header_version = SimpleCoin.header:CreateFontString()
SimpleCoin.header_version:SetFont("Fonts\\FRIZQT__.TTF", 8)
SimpleCoin.header_version:SetPoint("TOPRIGHT", -28, -9)
SimpleCoin.header_version:SetText("v." .. SimpleCoin.version)
-- close button
SimpleCoin.close = CreateFrame("Button", "$parent_Close", SimpleCoin.header, "UIPanelCloseButton")
SimpleCoin.close:SetWidth(24)
SimpleCoin.close:SetHeight(24)
SimpleCoin.close:SetPoint("TOPRIGHT", -4, -1)
SimpleCoin.close:SetScript("OnClick", simplecoin_closemain)
SimpleCoin.main_frame:SetFrameLevel(2)
-- options button
SimpleCoin.btn_options = CreateFrame("Button", "$parent_options", SimpleCoin.header, sc_AddonBackdropTemplate)
SimpleCoin.btn_options:SetWidth(16)
SimpleCoin.btn_options:SetHeight(28)
SimpleCoin.btn_options:SetPoint("TOPRIGHT", -64, 5)
SimpleCoin.btn_options:SetNormalTexture("Interface\\addons\\SimpleCoin\\img\\UI-MicroButton-MainMenu-Up")
SimpleCoin.btn_options:SetPushedTexture("Interface\\addons\\SimpleCoin\\img\\UI-MicroButton-MainMenu-Disabled")
SimpleCoin.btn_options:SetHighlightTexture("Interface\\addons\\SimpleCoin\\img\\UI-MicroButton-MainMenu-Down")
SimpleCoin.btn_options:SetScript("OnClick", simplecoin_showoptions)
-- resetGUI button
--[[ SimpleCoin.btn_reset = CreateFrame("Button", "$parent_reset", SimpleCoin, "OptionsButtonTemplate")
SimpleCoin.btn_reset:SetWidth(60)
SimpleCoin.btn_reset:SetHeight(20)
SimpleCoin.btn_reset:SetPoint("BOTTOMRIGHT", -28, 10)
SimpleCoin.btn_reset:CreateTexture(nil, "ARTWORK")
SimpleCoin.btn_reset:SetNormalFontObject(GameFontNormalSmall)
SimpleCoin.btn_reset:SetHighlightFontObject(GameFontNormalSmall)
SimpleCoin.btn_reset:SetText("ResetGUI")
SimpleCoin.btn_reset:SetScript("OnClick", reset_windows) ]]
-- realm select button
-- SimpleCoin.realm_select = CreateFrame("Button", "$parent_RealmSelect", SimpleCoin.main_frame, "UIMenuButtonStretchTemplate")
SimpleCoin.realm_select = CreateFrame("Button", "$parent_RealmSelect", SimpleCoin.main_frame, "UIDropDownMenuTemplate")
simplecoin_set_resizable(SimpleCoin.realm_select)
UIDropDownMenu_SetWidth(SimpleCoin.realm_select, SimpleCoin.realm_select:GetParent():GetWidth() - 40)
UIDropDownMenu_JustifyText(SimpleCoin.realm_select, "LEFT")
SimpleCoin.realm_select:SetHeight(24)
SimpleCoin.realm_select:ClearAllPoints()
SimpleCoin.realm_select:SetPoint("TOPLEFT", -6, -32)
SimpleCoin.realm_select:SetPoint("TOPRIGHT", -10, -60)
SimpleCoin.realm_select:SetScript(
	"OnClick",
	function(self, button, down)
		PlaySound(799)
		ToggleDropDownMenu(1, nil, SimpleCoin.realm_select_menu, self.Button:GetName(), -242, 0)
	end
)
SimpleCoin.realm_select.Button:SetScript(
	"OnClick",
	function(self, button, down)
		--PlaySound(120)
		PlaySound(799)
		ToggleDropDownMenu(1, nil, SimpleCoin.realm_select_menu, self:GetName(), -242, 0)
	end
)
SimpleCoin.realm_select.realm_name = SimpleCoin.realm_select:CreateFontString()
SimpleCoin.realm_select.realm_name:SetPoint("TOPLEFT", 26, -8)
SimpleCoin.realm_select.realm_name:SetFontObject("GameFontNormal")
SimpleCoin.realm_select.realm_copper = SimpleCoin.realm_select:CreateFontString()
SimpleCoin.realm_select.realm_copper:SetPoint("TOPRIGHT", -32, -8)
SimpleCoin.realm_select.realm_copper:SetFontObject("GameFontNormal")
SimpleCoin.realm_select:RegisterForClicks("LeftButtonUp")
-- realm menu
SimpleCoin.realm_select_menu = CreateFrame("Frame", "$parent__RealmSelectMenu")
SimpleCoin.realm_select_menu.displayMode = "MENU"

-- character list
SimpleCoin.char_list = CreateFrame("Frame", "$parent_CharacterList", SimpleCoin.main_frame, sc_AddonBackdropTemplate)
SimpleCoin.char_list:ClearAllPoints()
SimpleCoin.char_list:SetPoint("TOPLEFT", 10, -60)
SimpleCoin.char_list:SetPoint("BOTTOMRIGHT", -10, 144)
SimpleCoin.char_list:SetBackdrop(
	{
		bgFile = "Interface\\addons\\SimpleCoin\\img\\Black-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border",
		tile = true,
		tileSize = 32,
		edgeSize = 16,
		insets = {left = 4, right = 4, top = 4, bottom = 4}
	}
)
SimpleCoin.char_list:SetBackdropColor(1, 1, 1, simplecoin_bg_heavy_med_opac)
SimpleCoin.char_list:SetAlpha(1)
-- scrollframe
SimpleCoin.char_list.scrollframe = CreateFrame("ScrollFrame", "$parent_scroll", SimpleCoin.char_list, "UIPanelScrollFrameTemplate")
SimpleCoin.char_list.scrollframe:ClearAllPoints()
SimpleCoin.char_list.scrollframe:SetAllPoints(SimpleCoin.char_list)
SimpleCoin.char_list.scrollframe:SetPoint("TOPLEFT", 0, -8)
SimpleCoin.char_list.scrollframe:SetPoint("BOTTOMRIGHT", -28, 6)
SimpleCoin.char_list.scrollframe:SetWidth(SimpleCoin.char_list.scrollframe:GetParent():GetWidth())
-- scroll child frame
SimpleCoin.char_list.data = CreateFrame("Frame", "$parent_Data", SimpleCoin.char_list, sc_AddonBackdropTemplate)
simplecoin_set_resizable(SimpleCoin.char_list.data)
SimpleCoin.char_list.scrollframe:SetScrollChild(SimpleCoin.char_list.data)
SimpleCoin.char_list.data:ClearAllPoints()
SimpleCoin.char_list.data:SetAllPoints(SimpleCoin.char_list.scrollframe)
SimpleCoin.char_list.data:SetWidth(SimpleCoin.char_list.scrollframe:GetWidth())
SimpleCoin.char_list.data:SetHeight(1)
-- coin widget
SimpleCoin.main_frame.coin_display = CreateFrame("Frame", "$parent_CoinWidget", SimpleCoin.main_frame, sc_AddonBackdropTemplate)
SimpleCoin.main_frame.coin_display:SetWidth(SimpleCoin.main_frame.coin_display:GetParent():GetWidth())
SimpleCoin.main_frame.coin_display:SetHeight(1)
simplecoin_set_resizable(SimpleCoin.main_frame.coin_display)
SimpleCoin.main_frame.coin_display:ClearAllPoints()
SimpleCoin.main_frame.coin_display:SetPoint("BOTTOM", 0, 0)
SimpleCoin.main_frame.coin_display:SetPoint("LEFT", 10, 0)
SimpleCoin.main_frame.coin_display:SetPoint("RIGHT", -10, 0)
SimpleCoin.main_frame.coin_display:SetBackdrop(
	{
		bgFile = "Interface\\addons\\SimpleCoin\\img\\Black-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border",
		tile = true,
		tileSize = 32,
		edgeSize = 16,
		insets = {left = 4, right = 4, top = 4, bottom = 4}
	}
)
SimpleCoin.main_frame.coin_display:SetBackdropColor(1, 1, 1, simplecoin_bg_heavy_med_opac)
simplecoin_coin_widget(SimpleCoin.main_frame.coin_display, nil, {-4, -4, -4, 4}, true)
-- Resize button
SimpleCoin.resize = CreateFrame("Button", "$parent_Move", SimpleCoin, sc_AddonBackdropTemplate)
SimpleCoin.resize:SetSize(16, 16)
SimpleCoin.resize:SetPoint("BOTTOMRIGHT", -10, 8)
SimpleCoin.resize:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
SimpleCoin.resize:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
SimpleCoin.resize:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
simplecoin_frame_resize(SimpleCoin.resize)
