local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("MvS PASCUA - VENEZUELA", "Midnight")

local User = game.Players.LocalPlayer
local Cam = workspace.CurrentCamera

-- 1. TAB DE PASCUA (AUTO FARM)
local EventTab = Window:NewTab("Evento Pascua")
local EventSec = EventTab:NewSection("Recolector de Huevos")

_G.AutoFarm = false
EventSec:NewToggle("Auto Farm Huevos", "Busca y teletransporta a huevos", function(state)
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

-- 2. TAB DE COMBATE (SILENT AIM & KILL)
local Combat = Window:NewTab("Combate")
local CSec = Combat:NewSection("Balas Mágicas")

_G.SilentAim = true
CSec:NewToggle("Silent Aim", "Pega tiros mirando a cualquier lado", function(state)
    _G.SilentAim = state
end)

-- Hook para interceptar las balas (Aquí se arregla el Aimbot)
local old; old = hookmetamethod(game, "__index", function(self, k)
    if k == "Hit" and _G.SilentAim and not checkcaller() then
        local target = nil
        local dist = math.huge
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= User and v.Character and v.Character:FindFirstChild("Head") then
                local d = (User.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
                if d < dist then target = v; dist = d end
            end
        end
        if target then return target.Character.Head.CFrame end
    end
    return old(self, k)
end)

-- 3. SONIDO "LINDA MUJER" (ARREGLADO)
local function TocarMusica()
    local s = Instance.new("Sound", game.SoundService)
    s.Name = "MusicaMVS"
    s.SoundId = "rbxassetid://9114156630" -- ID Bypass activo
    s.Volume = 5
    s:Play()
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "MvS Script",
        Text = "Linda mujer, sabes que te amo...",
        Duration = 5
    })
end

TocarMusica()
