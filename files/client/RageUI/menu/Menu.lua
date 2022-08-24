---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Dylan Malandain.
--- DateTime: 21/04/2019 21:20
---

local Menus = {}
local SubMenus = {}

---CreateMenu
---@param Title string
---@param Subtitle string
---@param X number
---@param Y number
---@param TextureDictionary string
---@param TextureName string
---@param R number
---@param G number
---@param B number
---@param A number
---@return UIMenu
---@public
function UIMenu:CreateMenu(Title, Subtitle, X, Y, TextureDictionary, TextureName, R, G, B, A)
    local self = {}
    setmetatable(self, {__index = UIMenu})

    self.Display = {};

    self.InstructionalButtons = {}

    self.Display.Header = true;
    self.Display.Glare = true;
    self.Display.Subtitle = true;
    self.Display.Background = true;
    self.Display.Navigation = true;
    self.Display.InstructionalButton = true;
    self.Display.PageCounter = false;

    self.Title = Title or ""
    self.TitleFont = 6
    self.TitleScale = 1.2
    self.Subtitle = string.upper(Subtitle) or nil
    self.SubtitleHeight = -37
    self.Description = nil
    self.DescriptionHeight = RageUI.Settings.Items.Description.Background.Height
    self.X = X or 0
    self.Y = Y or 0
    self.Parent = nil
    self.WidthOffset = RageUI.UI.Style[RageUI.UI.Current].Width
    self.Open = false
    self.Controls = RageUI.Settings.Controls
    self.Index = 1
    self.Sprite = { Dictionary = TextureDictionary or "commonmenu", Texture = TextureName or "interaction_bgd", Color = { R = R, G = G, B = B, A = A } }
    self.Rectangle = nil
    self.Pagination = { Minimum = 1, Maximum = 10, Total = 10 }
    self.Safezone = true
    self.SafeZoneSize = nil
    self.EnableMouse = false
    self.Options = 0
    self.Closable = true
    self.InstructionalScaleform = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
    self.CursorStyle = 1
    self.id = jLib.Utils.uuid("xx6xx-xxxxx")

    if string.starts(self.Subtitle, "~") then
        self.PageCounterColour = string.lower(string.sub(self.Subtitle, 1, 3))
    else
        self.PageCounterColour = ""
    end

    if self.Subtitle ~= "" then
        local SubtitleLineCount = GetLineCount(self.Subtitle, self.X + RageUI.Settings.Items.Subtitle.Text.X, self.Y + RageUI.Settings.Items.Subtitle.Text.Y, 0, RageUI.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255, nil, false, false, RageUI.Settings.Items.Subtitle.Background.Width + self.WidthOffset)

        if SubtitleLineCount > 1 then
            self.SubtitleHeight = 18 * SubtitleLineCount
        else
            self.SubtitleHeight = 0
        end
    end

    Citizen.CreateThread(function()
        if not HasScaleformMovieLoaded(self.InstructionalScaleform) then
            self.InstructionalScaleform = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
            while not HasScaleformMovieLoaded(self.InstructionalScaleform) do
                Citizen.Wait(0)
            end
        end
    end)

    Citizen.CreateThread(function()
        local ScaleformMovie = RequestScaleformMovie("MP_MENU_GLARE")
        while not HasScaleformMovieLoaded(ScaleformMovie) do
            Citizen.Wait(0)
        end
    end)

    Menus[self.id] = self
    SubMenus[self.id] = {}

    return self
end

---CreateMenu
---@param Title string
---@param Subtitle string
---@param X number
---@param Y number
---@param TextureDictionary string
---@param TextureName string
---@param R number
---@param G number
---@param B number
---@param A number
---@return UIMenu
---@public
function RageUI.CreateMenu(Title, Subtitle, X, Y, TextureDictionary, TextureName, R, G, B, A)
    return UIMenu:CreateMenu(Title, Subtitle, X, Y, TextureDictionary, TextureName, R, G, B, A)
end

---CreateSubMenu
---@param ParentMenu function
---@param Title string
---@param Subtitle string
---@param X number
---@param Y number
---@param TextureDictionary string
---@param TextureName string
---@param R number
---@param G number
---@param B number
---@param A number
---@return UIMenu
---@public
function RageUI.CreateSubMenu(ParentMenu, Title, Subtitle, X, Y, TextureDictionary, TextureName, R, G, B, A)
    if ParentMenu ~= nil then
        if ParentMenu then
            local Menu = RageUI.CreateMenu(Title or ParentMenu.Title, string.upper(Subtitle) or string.upper(ParentMenu.Subtitle), X or ParentMenu.X, Y or ParentMenu.Y)
            Menu.Parent = ParentMenu
            Menu.WidthOffset = ParentMenu.WidthOffset
            Menu.Safezone = ParentMenu.Safezone
            if ParentMenu.Sprite then
                Menu.Sprite = { Dictionary = TextureDictionary or ParentMenu.Sprite.Dictionary, Texture = TextureName or ParentMenu.Sprite.Texture, Color = { R = R or ParentMenu.Sprite.Color.R, G = G or ParentMenu.Sprite.Color.G, B = B or ParentMenu.Sprite.Color.B, A = A or ParentMenu.Sprite.Color.A } }
            else
                Menu.Rectangle = ParentMenu.Rectangle
            end
            table.insert(SubMenus[ParentMenu.id], Menu.id)
            return Menu
        else
            return nil
        end
    else
        return nil
    end
end

function UIMenu:DisplayHeader(boolean)
    self.Display.Header = boolean;
    return self.Display.Header;
end

function UIMenu:DisplayGlare(boolean)
    self.Display.Glare = boolean;
    return self.Display.Glare;
end

function UIMenu:DisplaySubtitle(boolean)
    self.Display.Subtitle = boolean;
    return self.Display.Subtitle;
end

function UIMenu:DisplayNavigation(boolean)
    self.Display.Navigation = boolean;
    return self.Display.Navigation;
end

function UIMenu:DisplayInstructionalButton(boolean)
    self.Display.InstructionalButton = boolean;
    return self.Display.InstructionalButton;
end

function UIMenu:DisplayPageCounter(boolean)
    self.Display.PageCounter= boolean;
    return self.Display.PageCounter;
end

---SetTitle
---@param Title string
---@return nil
---@public
function UIMenu:SetTitle(Title)
    self.Title = Title
end

function UIMenu:SetStyleSize(Value)
    local witdh
    if Value >= 0 and Value <= 100 then
        witdh = Value
    else
        witdh = 100
    end
    self.WidthOffset = witdh
end

---GetStyleSize
---@return any
---@public
function UIMenu:GetStyleSize()
    if (self.WidthOffset == 100) then
        return "RageUI"
    elseif (self.WidthOffset == 0) then
        return "NativeUI";
    else
        return self.WidthOffset;
    end
end

---SetStyleSize
---@param Int string
---@return void
---@public
function UIMenu:SetCursorStyle(Int)
    self.CursorStyle = Int or 1 or 0
    SetMouseCursorSprite(Int)
end

---ResetCursorStyle
---@return void
---@public
function UIMenu:ResetCursorStyle()
    self.CursorStyle = 1
    SetMouseCursorSprite(1)
end

---UpdateCursorStyle
---@return void
---@public
function UIMenu:UpdateCursorStyle()
    SetMouseCursorSprite(self.CursorStyle)
end

---RefreshIndex
---@return void
---@public
function UIMenu:RefreshIndex()
    self.Index = 1
end

---SetSubtitle
---@param Subtitle string
---@return nil
---@public
function UIMenu:SetSubtitle(Subtitle)

    self.Subtitle = string.upper(Subtitle) or string.upper(self.Subtitle)

    if string.starts(self.Subtitle, "~") then
        self.PageCounterColour = string.lower(string.sub(self.Subtitle, 1, 3))
    else
        self.PageCounterColour = ""
    end
    if self.Subtitle ~= "" then
        local SubtitleLineCount = GetLineCount(self.Subtitle, self.X + RageUI.Settings.Items.Subtitle.Text.X, self.Y + RageUI.Settings.Items.Subtitle.Text.Y, 0, RageUI.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255, nil, false, false, RageUI.Settings.Items.Subtitle.Background.Width + self.WidthOffset)

        if SubtitleLineCount > 1 then
            self.SubtitleHeight = 18 * SubtitleLineCount
        else
            self.SubtitleHeight = 0
        end

    else
        self.SubtitleHeight = -37
    end
end

---PageCounter
---@param Subtitle string
---@return nil
---@public
function UIMenu:SetPageCounter(Subtitle)
    self.PageCounter = Subtitle
end

---EditSpriteColor
---@param Colors table
---@return nil
---@public
function UIMenu:EditSpriteColor(R, G, B, A)
    if self.Sprite.Dictionary == "commonmenu" then
        self.Sprite.Color = { R = tonumber(R) or 255, G = tonumber(G) or 255, B = tonumber(B) or 255, A = tonumber(A) or 255 }
    end
end
---SetPosition
---@param X number
---@param Y number
---@return nil
---@public
function UIMenu:SetPosition(X, Y)
    self.X = tonumber(X) or self.X
    self.Y = tonumber(Y) or self.Y
end

---SetTotalItemsPerPage
---@param Value number
---@return nil
---@public
function UIMenu:SetTotalItemsPerPage(Value)
    self.Pagination.Total = tonumber(Value) or self.Pagination.Total
end

---SetRectangleBanner
---@param R number
---@param G number
---@param B number
---@param A number
---@return nil
---@public
function UIMenu:SetRectangleBanner(R, G, B, A)
    self.Rectangle = { R = tonumber(R) or 255, G = tonumber(G) or 255, B = tonumber(B) or 255, A = tonumber(A) or 255 }
    self.Sprite = nil
end

---SetSpriteBanner
---@param TextureDictionary string
---@param Texture string
---@return nil
---@public
function UIMenu:SetSpriteBanner(TextureDictionary, Texture)
    self.Sprite = { Dictionary = TextureDictionary or "commonmenu", Texture = Texture or "interaction_bgd" }
    self.Rectangle = nil
end

function UIMenu:Closable(boolean)
    if type(boolean) == "boolean" then
        self.Closable = boolean
    else
        error("Type is not boolean")
    end
end

function UIMenu:isClosable()
    return self.Closable;
end

---@return boolean
function UIMenu:isOpen()
    return self.Open;
end

---@param parent UIMenu
function UIMenu:setHasSubMenu(parent)
    table.insert(SubMenus[parent.id], self.id)
    self.Parent = parent
end

---PERFORM A CLEAN FOR OPTIMIZATION PURPOSE
function UIMenu:cleanParentSubMenu()
    if self.Parent ~= nil then
        for k, v in pairs(SubMenus[self.Parent.id]) do
            if v == self.id then
                table.remove(SubMenus[self.Parent.id], k)
                break
            end
        end
        self.Parent = nil
    end
end

function UIMenu:SetClosable(boolean)
    if type(boolean) == "boolean" then
        self.Closable = boolean
    else
        error("Type is not boolean")
    end
end

---@param Items fun(Items: Items)
---@param Panels fun(Panels: Panels)
---@param onClose function
function UIMenu:isVisible(Items, Panels, onClose)
    if type(Items) == "function" and ((Panels and type(Panels) == "function") or true) then
        self.func = Items
        self.panels = Panels
        self.Closed = onClose
    else
        error("Type is not function (Items or panels)")
    end
end

function UIMenu:getSubMenus()
    if #SubMenus[self.id] > 0 then
        for _, submenu in pairs(SubMenus[self.id]) do
            RageUI.IsVisible(Menus[submenu])
            Menus[submenu]:getSubMenus()
        end
    end
end

function UIMenu:open()
    CreateThread(function()
        while not jLib.player do Wait(0) end
        if RageUI.GetCurrentMenu() == nil 
            and not jLib.player.isDead() 
            and not IsPauseMenuActive()
        then
            --if player:canOpenMenu() then
                SetCurrentPedWeapon(jLib.player.getPed(), GetHashKey("WEAPON_UNARMED"), true)
                --OPEN
                local Audio = RageUI.Settings.Audio
                RageUI.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)
                RageUI.Visible(self, true)
                CreateThread(function()
                    while RageUI.CurrentMenu ~= nil do
                        RageUI.DisableControlsOnMenu()
                        RageUI.IsVisible(self)
                        self:getSubMenus()
                        Wait(1)
                    end
                end)
            --end
        end
    end)
end

function UIMenu:close()
    if RageUI.GetCurrentMenu() == self then
        --if self.Closed then self.Closed() end
        RageUI.Visible(self, false)
        self.Index = 1
        self.Pagination.Minimum = 1
        self.Pagination.Maximum = self.Pagination.Total
        RageUI.CurrentMenu = nil
        ResetScriptGfxAlign()
        local Audio = RageUI.Settings.Audio
        RageUI.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)
        return
    end
    if #SubMenus[self.id] > 0 then
        for _, submenu in pairs(SubMenus[self.id]) do
            if RageUI.GetCurrentMenu() ~= nil then
                Menus[submenu]:close()
            end
        end
    end
end

function UIMenu:toggle()
    CreateThread(function()
        while not jLib.player do Wait(0) end
        if RageUI.GetCurrentMenu() ~= nil then
            local Audio = RageUI.Settings.Audio
            RageUI.PlaySound(Audio[Audio.Use].Back.audioName, Audio[Audio.Use].Back.audioRef)
            RageUI.GetCurrentMenu():close()
        else
            if not jLib.player.isDead() then
                self:open()
            end
        end
    end)
end

---@param key string
---@param value any
function UIMenu:setData(key, value)
    self.data[key] = value
    return self.data[key]
end

---@param key string
function UIMenu:getData(key)
    return self.data[key]
end

function UIMenu:AddInstructionButton(button)
    if type(button) == "table" and #button == 2 then
        table.insert(self.InstructionalButtons, button)
        self.UpdateInstructionalButtons(true);
    end
end

function UIMenu:RemoveInstructionButton(button)
    if type(button) == "table" then
        for i = 1, #self.InstructionalButtons do
            if button == self.InstructionalButtons[i] then
                table.remove(self.InstructionalButtons, i)
                self.UpdateInstructionalButtons(true);
                break
            end
        end
    else
        if tonumber(button) then
            if self.InstructionalButtons[tonumber(button)] then
                table.remove(self.InstructionalButtons, tonumber(button))
                self.UpdateInstructionalButtons(true);
            end
        end
    end
end

function UIMenu:UpdateInstructionalButtons(Visible)

    if not Visible then
        return
    end

    BeginScaleformMovieMethod(self.InstructionalScaleform, "CLEAR_ALL")
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(self.InstructionalScaleform, "TOGGLE_MOUSE_BUTTONS")
    ScaleformMovieMethodAddParamInt(0)
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(self.InstructionalScaleform, "CREATE_CONTAINER")
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(self.InstructionalScaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(0)
    PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(2, 176, 0))
    PushScaleformMovieMethodParameterString(GetLabelText("HUD_INPUT2"))
    EndScaleformMovieMethod()

    if self.Closable then
        BeginScaleformMovieMethod(self.InstructionalScaleform, "SET_DATA_SLOT")
        ScaleformMovieMethodAddParamInt(1)
        PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(2, 177, 0))
        PushScaleformMovieMethodParameterString(GetLabelText("HUD_INPUT3"))
        EndScaleformMovieMethod()
    end

    local count = 2

    if (self.InstructionalButtons ~= nil) then
        for i = 1, #self.InstructionalButtons do
            if self.InstructionalButtons[i] then
                if #self.InstructionalButtons[i] == 2 then
                    BeginScaleformMovieMethod(self.InstructionalScaleform, "SET_DATA_SLOT")
                    ScaleformMovieMethodAddParamInt(count)
                    PushScaleformMovieMethodParameterButtonName(self.InstructionalButtons[i][1])
                    PushScaleformMovieMethodParameterString(self.InstructionalButtons[i][2])
                    EndScaleformMovieMethod()
                    count = count + 1
                end
            end
        end
    end

    BeginScaleformMovieMethod(self.InstructionalScaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    ScaleformMovieMethodAddParamInt(-1)
    EndScaleformMovieMethod()
end
