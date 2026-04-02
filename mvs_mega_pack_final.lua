local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("MVS OMEGA - VENEZUELA EDITION", "Midnight")

local Players = game:GetService("Players")
local User = Players.LocalPlayer

-- ==========================================
-- SISTEMA DE SONIDO (CON INTERRUPTOR)
-- ==========================================
local Sound = Instance.new("Sound", game.Workspace)
Sound.Name = "MusicaVnzla"
Sound.SoundId = "rbxassetid://1837871067" 
Sound.Volume = 8
Sound.Looped = true
Sound:Play()

-- ==========================================
-- BOTÓN FLOTANTE PARA MINIMIZAR (ANDROID)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainButton = Instance.new("TextButton", ScreenGui)

MainButton.Size = UDim2.new(0, 100, 0, 40)
MainButton.Position = UDim2.new(0, 10, 0, 50)
MainButton.Text = "OCULTAR MENÚ"
MainButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainButton.Draggable = true

MainButton.MouseButton1Click:Connect(function()
    local gui = game.CoreGui:FindFirstChild("MVS OMEGA - VENEZUELA EDITION") or game.CoreGui:FindFirstChild("Library")
    if gui then
        gui.Enabled = not gui.Enabled
        MainButton.Text = gui.Enabled and "OCULTAR MENÚ" or "MOSTRAR MENÚ"
    end
end)

-- FUNCIÓN PARA BUSCAR AL MÁS CERCANO (PARA TODO EL SCRIPT)
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

-- 1. TAB DE COMBATE (SILENT + AUTO KILL)
local Combat = Window:NewTab("Combate")
local CSec = Combat:NewSection("Aniquilación")

_G.SilentAim = true
CSec:NewToggle("Perfect Silent Aim", "No falla", function(state) _G.SilentAim = state end)

_G.AutoKill = false
CSec:NewToggle("AUTO KILL", "Mata solo (Saca el arma)", function(state)
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

-- 2. TAB DE GHOST Y TP
local GhostTab = Window:NewTab("Ghost/TP")
local GSec = GhostTab:NewSection("Invisibilidad y Teleport")

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

-- 3. TAB DE VISUALES Y EVENTOS
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
MSec:NewToggle("Auto Farm Pascua", "Recoge huevos solo", function(state)
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

-- 4. TAB DE AJUSTES (PARA EL SONIDO)
local Config = Window:NewTab("Ajustes")
local ConfSec = Config:NewSection("Sonido")

ConfSec:NewButton("Apagar/Prender Música", "Detén el flow si quieres", function()
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
