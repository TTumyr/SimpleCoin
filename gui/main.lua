-- main window
SimpleCoin = CreateFrame("Frame", "SimpleCoin", UIParent, sc_AddonBackdropTemplate)
SimpleCoin:SetWidth(460)
SimpleCoin:SetHeight(460)
SimpleCoin:ClearAllPoints()
SimpleCoin:SetPoint("CENTER", UIParent, "CENTER")
SimpleCoin.title = GetAddOnMetadata("SimpleCoin", "Title")
SimpleCoin.version = GetAddOnMetadata("SimpleCoin", "Version")
SimpleCoin:SetBackdrop(
	{
		bgFile = "Interface\\addons\\SimpleCoin\\img\\UI-DialogBox-Background",
		edgeFile = "Interface\\addons\\SimpleCoin\\img\\UI-DialogBox-Border",
		tile = "true",
		tileSize = 32,
		edgeSize = 32,
		insets = {left = 11, right = 12, top = 12, bottom = 11}
	}
)

SimpleCoin:EnableMouse(true)
-- set movable and resizeable
simplecoin_set_resizable(SimpleCoin)
simplecoin_set_movable(SimpleCoin)
SimpleCoin:SetMinResize(260, 240)
SimpleCoin:SetMaxResize(900, 600)
SimpleCoin:SetFrameLevel(1)
-- main display frame
SimpleCoin.main_frame = CreateFrame("Frame", "$parent_MainFrame", SimpleCoin, sc_AddonBackdropTemplate)
SimpleCoin.main_frame:SetWidth(SimpleCoin.main_frame:GetParent():GetWidth())
SimpleCoin.main_frame:SetHeight(SimpleCoin.main_frame:GetParent():GetHeight() - 20)
SimpleCoin.main_frame:ClearAllPoints()
SimpleCoin.main_frame:SetPoint("TOPLEFT")
SimpleCoin.main_frame:SetPoint("TOPRIGHT")
SimpleCoin.main_frame:SetPoint("BOTTOMLEFT", 0, -30)
SimpleCoin.main_frame:SetPoint("BOTTOMRIGHT", 0, -30)
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
-- header title
SimpleCoin.header_title = SimpleCoin:CreateFontString()
SimpleCoin.header_title:SetFontObject("GameFontNormalSmall")
SimpleCoin.header_title:SetPoint("TOPLEFT", 12, -12)
SimpleCoin.header_title:SetText(SimpleCoin.title)
-- header version
SimpleCoin.header_version = SimpleCoin:CreateFontString()
SimpleCoin.header_version:SetFont("Fonts\\FRIZQT__.TTF", 8)
SimpleCoin.header_version:SetPoint("TOPRIGHT", -28, -14)
SimpleCoin.header_version:SetText("v" .. SimpleCoin.version)
-- close button
SimpleCoin.close = CreateFrame("Button", "$parent_Close", SimpleCoin.main_frame, "UIPanelCloseButton")
SimpleCoin.close:SetWidth(24)
SimpleCoin.close:SetHeight(24)
SimpleCoin.close:SetPoint("TOPRIGHT", -5, -5)
SimpleCoin.close:SetScript("OnClick", simplecoin_closemain)
SimpleCoin.main_frame:SetFrameLevel(2)
-- options button
SimpleCoin.btn_options = CreateFrame("Button", "$parent_options", SimpleCoin.main_frame, sc_AddonBackdropTemplate)
SimpleCoin.btn_options:SetWidth(16)
SimpleCoin.btn_options:SetHeight(28)
SimpleCoin.btn_options:SetPoint("TOPRIGHT", -54, 0)
SimpleCoin.btn_options:SetNormalTexture("Interface\\addons\\SimpleCoin\\img\\UI-MicroButton-MainMenu-Up")
SimpleCoin.btn_options:SetPushedTexture("Interface\\addons\\SimpleCoin\\img\\UI-MicroButton-MainMenu-Disabled")
SimpleCoin.btn_options:SetHighlightTexture("Interface\\addons\\SimpleCoin\\img\\UI-MicroButton-MainMenu-Down")
SimpleCoin.btn_options:SetScript("OnClick", simplecoin_showoptions)
-- resetGUI button
SimpleCoin.btn_reset = CreateFrame("Button", "$Parent_reset", SimpleCoin, "OptionsButtonTemplate")
SimpleCoin.btn_reset:SetWidth(60)
SimpleCoin.btn_reset:SetHeight(20)
SimpleCoin.btn_reset:SetPoint("BOTTOMRIGHT", -28, 10)
SimpleCoin.btn_reset:CreateTexture(nil, "ARTWORK")
SimpleCoin.btn_reset:SetNormalFontObject(GameFontNormalSmall)
SimpleCoin.btn_reset:SetHighlightFontObject(GameFontNormalSmall)
SimpleCoin.btn_reset:SetText("ResetGUI")
SimpleCoin.btn_reset:SetScript("OnClick", reset_windows)
-- realm menu
-- SimpleCoin.realm_select = CreateFrame("Frame", "Omen_TitleDropDownMenu")
-- SimpleCoin.realm_select.displayMode = "MENU"
-- SimpleCoin.realm_select.initialize = function(self, level) end
-- character list
SimpleCoin.char_list = CreateFrame("Frame", "$parent_CharacterList", SimpleCoin.main_frame, sc_AddonBackdropTemplate)
SimpleCoin.char_list:ClearAllPoints()
SimpleCoin.char_list:SetPoint("TOPLEFT", 10, -30)
SimpleCoin.char_list:SetPoint("BOTTOMRIGHT", -10, 144)
SimpleCoin.char_list:SetBackdrop(
	{
		bgFile = "Interface\\addons\\SimpleCoin\\img\\UI-DialogBox-Background",
		edgeFile = "Interface\\addons\\SimpleCoin\\img\\UI-DialogBox-Gold-Border",
		tile = "true",
		tileSize = 32,
		edgeSize = 16
	}
)
-- scrollframe
SimpleCoin.char_list.scrollframe = CreateFrame("ScrollFrame", "$parent_scroll", SimpleCoin.char_list, "UIPanelScrollFrameTemplate")
SimpleCoin.char_list.scrollframe:ClearAllPoints()
SimpleCoin.char_list.scrollframe:SetAllPoints(SimpleCoin.char_list)
SimpleCoin.char_list.scrollframe:SetPoint("TOPLEFT", -28, -8)
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
		bgFile = "Interface\\addons\\SimpleCoin\\img\\UI-DialogBox-Background",
		edgeFile = "Interface\\addons\\SimpleCoin\\img\\UI-DialogBox-Gold-Border",
		tile = "true",
		tileSize = 32,
		edgeSize = 16
	}
)
simplecoin_coin_widget(SimpleCoin.main_frame.coin_display, nil, {-4, -2, -4, 2}, true)
-- Resize button
SimpleCoin.resize = CreateFrame("Button", "$parent_Move", SimpleCoin, sc_AddonBackdropTemplate)
SimpleCoin.resize:SetSize(16, 16)
SimpleCoin.resize:SetPoint("BOTTOMRIGHT", -10, 8)
SimpleCoin.resize:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
SimpleCoin.resize:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
SimpleCoin.resize:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
simplecoin_frame_resize(SimpleCoin.resize)
