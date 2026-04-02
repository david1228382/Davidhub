local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("MVS VENEZUELA - GOD MODE", "Midnight")

local Players = game:GetService("Players")
local User = Players.LocalPlayer

-- FUNCIÓN PARA BUSCAR AL MÁS CERCANO (PARA TP Y SILENT)
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

-- 1. TAB DE COMBATE (SILENT PISTOLA + CUCHILLO)
local Combat = Window:NewTab("Combate")
local CSec = Combat:NewSection("Bala y Cuchillo Mágico")

_G.SilentAim = true
CSec:NewToggle("Silent Aim (General)", "Balas y cuchillos persiguen solos", function(state)
    _G.SilentAim = state
end)

-- HOOK MAESTRO (Aquí se arregla la bala y el cuchillo)
local old; old = hookmetamethod(game, "__index", function(self, k)
    if k == "Hit" and _G.SilentAim and not checkcaller() then
        local t = GetClosest()
        if t and t.Character and t.Character:FindFirstChild("Head") then
            return t.Character.Head.CFrame
        end
    end
    return old(self, k)
end)

-- 2. TAB DE VISUALES (ESP / WALLHACK)
local Visuals = Window:NewTab("Visuales")
local VSec = Visuals:NewSection("Ver a través de paredes")

_G.ESP = false
VSec:NewToggle("Activar ESP (Rojo)", "Resalta a todos los jugadores", function(state)
    _G.ESP = state
    task.spawn(function()
        while _G.ESP do
            task.wait(1)
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= User and v.Character then
                    if not v.Character:FindFirstChild("Highlight") then
                        local h = Instance.new("Highlight", v.Character)
                        h.Name = "Highlight"
                        h.FillColor = Color3.fromRGB(255, 0, 0)
                        h.OutlineColor = Color3.fromRGB(255, 255, 255)
                    end
                elseif v == User and v.Character:FindFirstChild("Highlight") then
                    v.Character.Highlight:Destroy() -- Para no resaltarte a ti mismo
                end
            end
        end
    end)
end)

-- 3. TAB DE MOVIMIENTO (TP & VELOCIDAD)
local Mov = Window:NewTab("Movimiento")
local MSec = Mov:NewSection("Teleport y Velocidad")

MSec:NewButton("TP al más cercano", "Aparécele atrás al enemigo", function()
    local t = GetClosest()
    if t and t.Character and User.Character then
        User.Character.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
    end
end)

MSec:NewSlider("Velocidad Flash", "Corre más rápido", 500, 16, function(s)
    User.Character.Humanoid.WalkSpeed = s
end)

-- 4. TAB DE EVENTO (AUTO FARM PASCUA)
local EventTab = Window:NewTab("Pascua")
local ESec = EventTab:NewSection("Auto Farm Huevos")

_G.AutoFarm = false
ESec:NewToggle("Auto Farm Activo", "Recoge huevos solo", function(state)
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

-- SONIDO "LINDA MUJER" (VENEZUELA FLOW)
local function Musica()
    local s = Instance.new("Sound", game.SoundService)
    s.SoundId = "rbxassetid://9114156630" 
    s.Volume = 5
    s:Play()
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "MEGA HUB CARGADO",
        Text = "Linda mujer, ya tienes todo activado...",
        Duration = 5
    })
end

Musica()
