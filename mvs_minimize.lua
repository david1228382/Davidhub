local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
-- Creamos el Window (Aquí le metemos el nombre que quieras)
local Window = Library.CreateLib("MVS VENEZUELA - ANTIPANICO", "Midnight")

local Players = game:GetService("Players")
local User = Players.LocalPlayer

-- ==========================================
-- BOTÓN DE MINIMIZAR (PARA NO CERRARLO)
-- ==========================================
local Minimizado = false
local Bind = Instance.new("ScreenGui", game.CoreGui)
local Btn = Instance.new("TextButton", Bind)

Btn.Size = UDim2.new(0, 100, 0, 30)
Btn.Position = UDim2.new(0, 10, 0, 10) -- Esquina superior izquierda
Btn.Text = "ABRIR/CERRAR"
Btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn.Draggable = true -- Lo puedes mover por la pantalla si te estorba

Btn.MouseButton1Click:Connect(function()
    if Minimizado then
        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
        Minimizado = false
    else
        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
        Minimizado = true
    end
end)

-- ==========================================
-- MÚSICA AUTOMÁTICA
-- ==========================================
local function TocarMusica()
    local s = Instance.new("Sound", game.SoundService)
    s.SoundId = "rbxassetid://1837871067" 
    s.Volume = 8
    s.Looped = true
    s:Play()
end
task.spawn(TocarMusica)

-- ==========================================
-- EL COMBO (GHOST + AUTO KILL + TP)
-- ==========================================
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

-- TAB DE COMBATE
local Combat = Window:NewTab("Combate")
local CSec = Combat:NewSection("Aniquilación")

_G.SilentAim = true
CSec:NewToggle("Perfect Silent Aim", "No falla", function(state) _G.SilentAim = state end)

_G.AutoKill = false
CSec:NewToggle("AUTO KILL", "Dispara solo", function(state)
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

-- TAB DE MOVIMIENTO
local Mov = Window:NewTab("Movimiento")
local MSec = Mov:NewSection("Teleport")

MSec:NewButton("TELEPORT AL ENEMIGO", "Aparécele atrás", function()
    local t = GetClosest()
    if t and t.Character and User.Character then
        User.Character.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
    end
end)

-- TAB DE GHOST
local GhostTab = Window:NewTab("Ghost")
local GSec = GhostTab:NewSection("Invisible")

GSec:NewButton("MODO FANTASMA", "Nadie te ve", function()
    if User.Character then
        local root = User.Character:FindFirstChild("HumanoidRootPart")
        local torso = User.Character:FindFirstChild("LowerTorso") or User.Character:FindFirstChild("Torso")
        if torso and root then
            torso:BreakJoints()
            torso.Parent = nil
        end
    end
end)

-- TAB DE EXTRAS (ESP)
local Extra = Window:NewTab("Extras")
local ESec = Extra:NewSection("ESP")

_G.ESP = false
ESec:NewToggle("ESP Rojo", "Ves a todos", function(state)
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

-- HOOK SILENT AIM
local old; old = hookmetamethod(game, "__index", function(self, k)
    if k == "Hit" and _G.SilentAim and not checkcaller() then
        local t = GetClosest()
        if t then return t.Character.Head.CFrame end
    end
    return old(self, k)
end)
