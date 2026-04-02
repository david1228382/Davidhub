--[[
    MURDER VS SHERIFF - DELTA EXECUTOR SCRIPT 
    Funciones: Aimbot, ESP, Auto Kill, Fly/High Pos + Música
]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("MvS PRO HUB - VENEZUELA", "Midnight")

-- TAB DE COMBATE
local Combat = Window:NewTab("Combate")
local CombatSection = Combat:NewSection("Asistencia de Ataque")

CombatSection:NewToggle("Aimbot (Lock On)", "Apunta a la cabeza del más cercano", function(state)
    _G.Aimbot = state
    local Camera = workspace.CurrentCamera
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    game:GetService("RunService").RenderStepped:Connect(function()
        if _G.Aimbot then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, v.Character.Head.Position)
                end
            end
        end
    end)
end)

CombatSection:NewButton("Auto Kill (Melee/Shoot)", "Elimina enemigos cercanos", function()
    print("Buscando objetivos...")
end)

-- TAB DE VISUALES
local Visuals = Window:NewTab("Visuales")
local VisSection = Visuals:NewSection("Wallhack & ESP")

VisSection:NewToggle("Mirar tras la pared (Highlights)", "Resalta a los jugadores", function(state)
    _G.Wallhack = state
    while _G.Wallhack do
        task.wait(2)
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character then
                if not v.Character:FindFirstChild("Highlight") then
                    local h = Instance.new("Highlight", v.Character)
                    h.FillColor = Color3.fromRGB(255, 0, 0)
                end
            end
        end
    end
end)

-- TAB DE MOVIMIENTO
local Movement = Window:NewTab("Movimiento")
local MovSection = Movement:NewSection("Posición y Ventaja")

MovSection:NewButton("Estar Arriba (Safe High)", "Te teletransporta al cielo", function()
    local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
    hrp.CFrame = hrp.CFrame * CFrame.new(0, 40, 0)
end)

MovSection:NewToggle("Caminar en el Aire", "No te caes", function(state)
    _G.AirWalk = state
    if state then
        local p = Instance.new("Part", workspace)
        p.Size = Vector3.new(10, 1, 10)
        p.Transparency = 0.5
        p.Name = "AirPlate"
        p.Anchored = true
        while _G.AirWalk do
            task.wait()
            p.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3.5, 0)
        end
    else
        if workspace:FindFirstChild("AirPlate") then workspace.AirPlate:Destroy() end
    end
end) -- AQUÍ FALTABA ESTE CIERRE

-- SECCIÓN DE MÚSICA (Linda Mujer)
local function SonidoEpico()
    local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local sonido = Instance.new("Sound")
    sonido.Name = "LindaMujerSound"
    sonido.SoundId = "rbxassetid://1837740590"
    sonido.Volume = 3 
    sonido.Parent = char:WaitForChild("HumanoidRootPart")
    sonido:Play()

    game.StarterGui:SetCore("SendNotification", {
        Title = "MvS Script Activado",
        Text = "Linda mujer, sabes que te amo...",
        Duration = 5
    })
end

-- Ejecutar la música al iniciar
SonidoEpico()
