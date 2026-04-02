local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("MVS OMEGA HUB - VENEZUELA", "Midnight")

local Players = game:GetService("Players")
local User = Players.LocalPlayer
local Mouse = User:GetMouse()
local Cam = workspace.CurrentCamera

-- FUNCIÓN PARA BUSCAR AL MÁS CERCANO (PARA TP Y SILENT)
local function GetClosest()
    local target = nil
    local dist = math.huge
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= User and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local d = (User.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
            if d < dist then
                target = v
                dist = d
            end
        end
    end
    return target
end

-- 1. TAB DE COMBATE (SILENT AIM REAL)
local Combat = Window:NewTab("Combate")
local CSec = Combat:NewSection("Bala Mágica")

_G.SilentAim = true
CSec:NewToggle("Activar Silent Aim", "Las balas persiguen al enemigo", function(state)
    _G.SilentAim = state
end)

-- Lógica de Redirección (Silent Aim)
local old; old = hookmetamethod(game, "__index", function(self, k)
    if k == "Hit" and _G.SilentAim and not checkcaller() then
        local t = GetClosest()
        if t and t.Character and t.Character:FindFirstChild("Head") then
            return t.Character.Head.CFrame
        end
    end
    return old(self, k)
end)

-- 2. TAB DE MOVIMIENTO (TELEPORT)
local Mov = Window:NewTab("Teleport")
local MSec = Mov:NewSection("Asalto Directo")

MSec:NewButton("TP al más cercano", "Aparécele atrás", function()
    local t = GetClosest()
    if t and t.Character and User.Character then
        User.Character.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
    end
end)

_G.AutoTP = false
MSec:NewToggle("Auto TP (Pegarse al enemigo)", "Te pega como un chicle", function(state)
    _G.AutoTP = state
    task.spawn(function()
        while _G.AutoTP do
            task.wait(0.1)
            local t = GetClosest()
            if t and t.Character and User.Character then
                User.Character.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
            end
        end
    end)
end)

-- 3. TAB DE EVENTO (AUTO FARM PASCUA)
local EventTab = Window:NewTab("Evento Pascua")
local ESec = EventTab:NewSection("Recolector Automático")

_G.AutoFarm = false
ESec:NewToggle("Auto Farm Huevos", "Teletransporta a los huevos", function(state)
    _G.AutoFarm = state
    task.spawn(function()
        while _G.AutoFarm do
            task.wait(0.3)
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("TouchTransmitter") and (v.Parent.Name:find("Egg") or v.Parent.Name:find("Huevo") or v.Parent.Name:find("Easter")) then
                    if User.Character and User.Character:FindFirstChild("HumanoidRootPart") then
                        User.Character.HumanoidRootPart.CFrame = v.Parent.CFrame
                        break 
                    end
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
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "MVS OMEGA CARGADO",
        Text = "Linda mujer, ya tienes todo...",
        Duration = 5
    })
end

Musica()
