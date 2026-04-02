local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
-- Ocultamos la librería al principio para la intro
local Window = Library.CreateLib("MVS OMEGA - MATRIX INTRO", "Midnight")
local CoreGui = game:GetService("CoreGui")
local MainGui = CoreGui:FindFirstChild("MVS OMEGA - MATRIX INTRO") or CoreGui:FindFirstChild("Library")
if MainGui then MainGui.Enabled = false end

local Players = game:GetService("Players")
local User = Players.LocalPlayer

-- ==========================================
-- SISTEMA DE SONIDO (CON FIJACIÓN)
-- ==========================================
-- Limpieza de sonidos viejos
for _, v in pairs(game.Workspace:GetChildren()) do
    if v.Name == "MusicaVnzla" then v:Destroy() end
end

local Sound = Instance.new("Sound", game.Workspace)
Sound.Name = "MusicaVnzla"
Sound.SoundId = "rbxassetid://1837871067" 
Sound.Volume = 8
Sound.Looped = true
Sound:Play()

-- ==========================================
-- INTRO CMATRIX EXTREMA (SE QUITA SOLA)
-- ==========================================
local function IntroMatrix()
    local MatrixGui = Instance.new("ScreenGui", CoreGui)
    MatrixGui.Name = "MatrixIntro"
    local Frame = Instance.new("Frame", MatrixGui)
    Frame.Size = UDim2.new(1, 0, 1, 0)
    Frame.BackgroundTransparency = 1

    -- Notificación de hackeo
    game.StarterGui:SetCore("SendNotification", {
        Title = "SYSTEM OVERRIDE",
        Text = "CMatrix cargada... Linda mujer activa.",
        Duration = 5
    })

    -- Lluvia intensa de códigos
    task.spawn(function()
        local Finalizar = false
        -- Temporizador de 5 segundos
        task.delay(5, function() Finalizar = true end)

        while not Finalizar do
            task.wait(0.01) -- Velocidad ultra rápida
            local Label = Instance.new("TextLabel", Frame)
            Label.Text = string.char(math.random(33, 126))
            Label.TextColor3 = Color3.fromRGB(0, 255, 0)
            Label.BackgroundTransparency = 1
            Label.Position = UDim2.new(math.random(), 0, -0.1, 0)
            Label.FontSize = Enum.FontSize.Size18
            
            -- Movimiento rápido hacia abajo
            Label:TweenPosition(UDim2.new(Label.Position.X.Scale, 0, 1.1, 0), "Out", "Linear", 1.5)
            game:GetService("Debris"):AddItem(Label, 1.5)
        end
        
        -- Limpieza de la intro y activación del menú
        task.wait(1.5) -- Esperamos a que terminen de caer las últimas letras
        MatrixGui:Destroy()
        if MainGui then MainGui.Enabled = true end
    end)
end

IntroMatrix()

-- ==========================================
-- BOTÓN MINIMIZAR (FIXED)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui", CoreGui)
local MainButton = Instance.new("TextButton", ScreenGui)

MainButton.Size = UDim2.new(0, 120, 0, 40)
MainButton.Position = UDim2.new(0, 10, 0, 50)
MainButton.Text = "CERRAR MENÚ"
MainButton.BackgroundColor3 = Color3.fromRGB(0, 50, 0) -- Verde Matrix
MainButton.TextColor3 = Color3.fromRGB(0, 255, 0)
MainButton.Draggable = true

MainButton.MouseButton1Click:Connect(function()
    local targetGui = game.CoreGui:FindFirstChild("MVS OMEGA - MATRIX INTRO") or game.CoreGui:FindFirstChild("Library")
    if targetGui then
        targetGui.Enabled = not targetGui.Enabled
        MainButton.Text = targetGui.Enabled and "CERRAR MENÚ" or "ABRIR MENÚ"
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
-- TABS DEL MENÚ (SIN BORRAR NADA)
-- ==========================================

-- 1. COMBATE
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
            local t = GetClosest()
            if t and User.Character:FindFirstChildOfClass("Tool") then
                User.Character:FindFirstChildOfClass("Tool"):Activate()
            end
        end
    end)
end)

-- 2. GHOST / TP
local GhostTab = Window:NewTab("Ghost/TP")
local GSec = GhostTab:NewSection("Invisible")

GSec:NewButton("MODO FANTASMA (GHOST)", "Nadie te ve", function()
    if User.Character then
        local torso = User.Character:FindFirstChild("LowerTorso") or User.Character:FindFirstChild("Torso")
        if torso then torso:BreakJoints() torso.Parent = nil end
    end
end)

GSec:NewButton("TP AL ENEMIGO", "Aparécele atrás", function()
    local t = GetClosest()
    if t and t.Character and User.Character then
        User.Character.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
    end
end)

-- 3. AJUSTES (MÚSICA FIX)
local Config = Window:NewTab("Ajustes")
local ConfSec = Config:NewSection("Sonido")

ConfSec:NewButton("APAGAR/PRENDER MÚSICA", "Detén el sonido", function()
    if Sound.Playing then Sound:Pause() else Sound:Resume() end
end)

ConfSec:NewButton("ELIMINAR SONIDO (FIX)", "Borra el objeto por completo", function()
    Sound:Destroy()
end)

-- 4. EXTRAS (ESP)
local Misc = Window:NewTab("Extras")
local MSec = Misc:NewSection("Visuales")

_G.ESP = false
MSec:NewToggle("ESP Rojo", "Ver paredes", function(state)
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
