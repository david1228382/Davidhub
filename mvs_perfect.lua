local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("MVS OMEGA - BALA MÁGICA", "Midnight")

local Players = game:GetService("Players")
local User = Players.LocalPlayer
local Mouse = User:GetMouse()

-- FUNCIÓN PARA BUSCAR AL ENEMIGO (PERFECT TARGET)
local function GetClosest()
    local target = nil
    local dist = math.huge
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= User and v.Character and v.Character:FindFirstChild("Head") then
            local pos, vis = workspace.CurrentCamera:WorldToViewportPoint(v.Character.Head.Position)
            if vis then
                local mag = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(pos.X, pos.Y)).magnitude
                if mag < dist then
                    target = v
                    dist = mag
                end
            end
        end
    end
    return target
end

-- 1. TAB DE COMBATE (EL SILENT QUE NUNCA FALLA)
local Combat = Window:NewTab("Combate")
local CSec = Combat:NewSection("Poder Divino")

_G.SilentAim = true
CSec:NewToggle("Perfect Silent Aim", "Las balas nacen en el enemigo", function(state)
    _G.SilentAim = state
end)

-- EL TRUCO PARA QUE NO FALLE NUNCA
local old; old = hookmetamethod(game, "__index", function(self, k)
    if k == "Hit" and _G.SilentAim and not checkcaller() then
        local t = GetClosest()
        if t then return t.Character.Head.CFrame end
    end
    return old(self, k)
end)

-- 2. TAB DE VISUALES (ESP)
local Visuals = Window:NewTab("Visuales")
local VSec = Visuals:NewSection("Wallhack")

_G.ESP = false
VSec:NewToggle("ESP Rojo", "Ves a todos tras paredes", function(state)
    _G.ESP = state
    task.spawn(function()
        while _G.ESP do
            task.wait(1)
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= User and v.Character and not v.Character:FindFirstChild("Highlight") then
                    local h = Instance.new("Highlight", v.Character)
                    h.FillColor = Color3.fromRGB(255, 0, 0)
                end
            end
        end
    end)
end)

-- 3. TAB DE EVENTO (PASCUA - SIN BORRAR)
local EventTab = Window:NewTab("Pascua")
local ESec = EventTab:NewSection("Auto Farm")

_G.AutoFarm = false
ESec:NewToggle("Auto Farm Activo", "Recoge huevos solo", function(state)
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

-- SONIDO "LINDA MUJER"
local function Musica()
    local s = Instance.new("Sound", game.SoundService)
    s.SoundId = "rbxassetid://9114156630" 
    s.Volume = 5
    s:Play()
end

Musica()
