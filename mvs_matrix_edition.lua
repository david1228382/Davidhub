local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("MVS OMEGA - MATRIX EDITION", "Midnight")

local Players = game:GetService("Players")
local User = Players.LocalPlayer

-- ==========================================
-- EFECTO CMATRIX (VISUAL HACKER)
-- ==========================================
local function ActivarMatrix()
    local MatrixGui = Instance.new("ScreenGui", game.CoreGui)
    local Frame = Instance.new("Frame", MatrixGui)
    Frame.Size = UDim2.new(1, 0, 1, 0)
    Frame.BackgroundTransparency = 1

    task.spawn(function()
        while true do
            task.wait(0.1)
            local Label = Instance.new("TextLabel", Frame)
            Label.Text = string.char(math.random(33, 126))
            Label.TextColor3 = Color3.fromRGB(0, 255, 0)
            Label.BackgroundTransparency = 1
            Label.Position = UDim2.new(math.random(), 0, -0.1, 0)
            Label.FontSize = Enum.FontSize.Size18
            
            Label:TweenPosition(UDim2.new(Label.Position.X.Scale, 0, 1.1, 0), "Out", "Linear", 2)
            game:GetService("Debris"):AddItem(Label, 2)
        end
    end)
    
    -- Notificación de carga
    game.StarterGui:SetCore("SendNotification", {
        Title = "SYSTEM OVERRIDE",
        Text = "Matrix cargada... Linda mujer activa.",
        Duration = 5
    })
end

ActivarMatrix()

-- ==========================================
-- SISTEMA DE SONIDO Y MINIMIZAR (SIN BORRAR)
-- ==========================================
local Sound = Instance.new("Sound", game.Workspace)
Sound.Name = "MusicaVnzla"
Sound.SoundId = "rbxassetid://1837871067" 
Sound.Volume = 8
Sound.Looped = true
Sound:Play()

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainButton = Instance.new("TextButton", ScreenGui)
MainButton.Size = UDim2.new(0, 120, 0, 40)
MainButton.Position = UDim2.new(0, 10, 0, 50)
MainButton.Text = "MENU HACKER"
MainButton.BackgroundColor3 = Color3.fromRGB(0, 50, 0) -- Verde Matrix
MainButton.TextColor3 = Color3.fromRGB(0, 255, 0)
MainButton.Draggable = true

MainButton.MouseButton1Click:Connect(function()
    local gui = game.CoreGui:FindFirstChild("MVS OMEGA - MATRIX EDITION") or game.CoreGui:FindFirstChild("Library")
    if gui then
        gui.Enabled = not gui.Enabled
        MainButton.Text = gui.Enabled and "OCULTAR" or "MOSTRAR"
    end
end)

-- FUNCIÓN PARA BUSCAR AL MÁS CERCANO
local function GetClosest()
    local target = nil
    local dist = math.huge
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= User and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local d = (User.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
            if d < dist then target = v; dist = d end
        end
    end
    return target
end

-- ==========================================
-- TABS DEL MENÚ (TODO LO ANTERIOR)
-- ==========================================

-- 1. COMBATE
local Combat = Window:NewTab("Combate")
local CSec = Combat:NewSection("Aniquilación")

_G.SilentAim = true
CSec:NewToggle("Perfect Silent Aim", "No falla", function(state) _G.SilentAim = state end)

_G.AutoKill = false
CSec:NewToggle("AUTO KILL", "Mata solo", function(state)
    _G.AutoKill = state
    task.spawn(function()
        while _G.AutoKill do
            task.wait(0.1)
            local t = GetClosest()
            if t and User.Character:FindFirstChildOfClass("Tool") then
                User.Character:FindFirstChildOfClass("Tool"):Activate()
            end
        end
    end)
end)

-- 2. GHOST Y TP
local GhostTab = Window:NewTab("Ghost/TP")
local GSec = GhostTab:NewSection("Invisible y Teleport")

GSec:NewButton("MODO FANTASMA (GHOST)", "Nadie te ve", function()
    if User.Character then
        local torso = User.Character:FindFirstChild("LowerTorso") or User.Character:FindFirstChild("Torso")
        if torso then
            torso:BreakJoints()
            torso.Parent = nil
        end
    end
end)

GSec:NewButton("TELEPORT AL ENEMIGO", "Aparécele atrás", function()
    local t = GetClosest()
    if t and t.Character and User.Character then
        User.Character.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
    end
end)

-- 3. EXTRAS (ESP Y PASCUA)
local Misc = Window:NewTab("Extras")
local MSec = Misc:NewSection("ESP y Pascua")

_G.ESP = false
MSec:NewToggle("ESP Rojo", "Ves a todos", function(state)
    _G.ESP = state
    task.spawn(function()
        while _G.ESP do
            task.wait(1)
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= User and v.Character and not v.Character:FindFirstChild("Highlight") then
                    Instance.new("Highlight", v.Character).FillColor = Color3.fromRGB(255, 0, 0)
                end
            end
        end
    end)
end)

_G.AutoFarm = false
MSec:NewToggle("Auto Farm Pascua", "Recoge huevos", function(state)
    _G.AutoFarm = state
    task.spawn(function()
        while _G.AutoFarm do
            task.wait(0.3)
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("TouchTransmitter") and (v.Parent.Name:find("Egg") or v.Parent.Name:find("Huevo")) then
                    User.Character.HumanoidRootPart.CFrame = v.Parent.CFrame
                    break 
                end
            end
        end
    end)
end)

-- 4. AJUSTES (MÚSICA)
local Config = Window:NewTab("Ajustes")
local ConfSec = Config:NewSection("Sonido")
ConfSec:NewButton("Apagar/Prender Música", "Sonido Linda Mujer", function()
    if Sound.Playing then Sound:Stop() else Sound:Play() end
end)

-- HOOK SILENT AIM
local old; old = hookmetamethod(game, "__index", function(self, k)
    if k == "Hit" and _G.SilentAim and not checkcaller() then
        local t = GetClosest()
        if t then return t.Character.Head.CFrame end
    end
    return old(self, k)
end)
