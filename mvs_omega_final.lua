local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("MVS VENEZUELA - OMEGA HUB", "Midnight")

local Players = game:GetService("Players")
local User = Players.LocalPlayer

-- ==========================================
-- SONIDO AUTOMÁTICO (LINDA MUJER)
-- ==========================================
local function TocarMusica()
    -- Borramos si existe uno viejo para que no se raye
    if game.SoundService:FindFirstChild("MusicaMVS") then
        game.SoundService.MusicaMVS:Destroy()
    end

    local s = Instance.new("Sound", game.SoundService)
    s.Name = "MusicaMVS"
    s.SoundId = "rbxassetid://9114156630" -- ID Bypass Activo
    s.Volume = 8 -- Volumen alto para el flow
    s.Looped = true
    s:Play()
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "MVS OMEGA ACTIVO",
        Text = "Linda mujer, ya tienes todo...",
        Duration = 5
    })
end

-- LA LLAMAMOS DE UNA VEZ
TocarMusica()

-- ==========================================
-- FUNCIONES DE COMBATE Y MOVIMIENTO
-- ==========================================
local function GetClosest()
    local target = nil
    local dist = math.huge
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= User and v.Character and v.Character:FindFirstChild("Head") then
            local d = (User.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
            if d < dist then target = v; dist = d end
        end
    end
    return target
end

-- TAB DE COMBATE
local Combat = Window:NewTab("Combate")
local CSec = Combat:NewSection("Aniquilación")

_G.SilentAim = true
CSec:NewToggle("Perfect Silent Aim", "Balas que nunca fallan", function(state) _G.SilentAim = state end)

_G.AutoKill = false
CSec:NewToggle("Auto Kill", "Dispara solo", function(state)
    _G.AutoKill = state
    task.spawn(function()
        while _G.AutoKill do
            task.wait(0.1)
            if GetClosest() and User.Character:FindFirstChildOfClass("Tool") then
                User.Character:FindFirstChildOfClass("Tool"):Activate()
            end
        end
    end)
end)

-- HOOK SILENT AIM
local old; old = hookmetamethod(game, "__index", function(self, k)
    if k == "Hit" and _G.SilentAim and not checkcaller() then
        local t = GetClosest()
        if t then return t.Character.Head.CFrame end
    end
    return old(self, k)
end)

-- TAB DE GHOST (INVISIBILIDAD)
local GhostTab = Window:NewTab("Invisible")
local GSec = GhostTab:NewSection("Modo Fantasma")

GSec:NewButton("Hacerse Invisible", "Los demás no te ven", function()
    local char = User.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency = 1 end
        end
        if char:FindFirstChild("Head") and char.Head:FindFirstChild("face") then
            char.Head.face:Destroy()
        end
    end
end)

-- TAB DE VISUALES (ESP)
local Visuals = Window:NewTab("Visuales")
local VSec = Visuals:NewSection("Wallhack")

_G.ESP = false
VSec:NewToggle("ESP Rojo", "Ves a todos", function(state)
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

-- TAB DE EVENTO (PASCUA - AUTO FARM)
local EventTab = Window:NewTab("Pascua")
local ESec = EventTab:NewSection("Auto Farm")

_G.AutoFarm = false
ESec:NewToggle("Auto Farm Huevos", "Recoge huevos solo", function(state)
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
