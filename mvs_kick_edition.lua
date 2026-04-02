local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("MVS OMEGA - ADMIN EDITION", "Midnight")
local CoreGui = game:GetService("CoreGui")
local MainGui = CoreGui:FindFirstChild("MVS OMEGA - ADMIN EDITION") or CoreGui:FindFirstChild("Library")
if MainGui then MainGui.Enabled = false end

local Players = game:GetService("Players")
local User = Players.LocalPlayer

-- ==========================================
-- SONIDO Y INTRO MATRIX (5 SEGUNDOS)
-- ==========================================
local function IniciarTodo()
    local Sound = Instance.new("Sound", game.Workspace)
    Sound.Name = "MusicaVnzla"
    Sound.SoundId = "rbxassetid://1837871067" 
    Sound.Volume = 8
    Sound.Looped = true
    Sound:Play()

    local MatrixGui = Instance.new("ScreenGui", CoreGui)
    local Frame = Instance.new("Frame", MatrixGui)
    Frame.Size = UDim2.new(1, 0, 1, 0)
    Frame.BackgroundTransparency = 1

    task.spawn(function()
        local t = 0
        while t < 5 do
            task.wait(0.01)
            t = t + 0.01
            local Label = Instance.new("TextLabel", Frame)
            Label.Text = string.char(math.random(33, 126))
            Label.TextColor3 = Color3.fromRGB(0, 255, 0)
            Label.BackgroundTransparency = 1
            Label.Position = UDim2.new(math.random(), 0, -0.1, 0)
            Label:TweenPosition(UDim2.new(Label.Position.X.Scale, 0, 1.1, 0), "Out", "Linear", 1)
            game:GetService("Debris"):AddItem(Label, 1)
        end
        MatrixGui:Destroy()
        if MainGui then MainGui.Enabled = true end
    end)
end
task.spawn(IniciarTodo)

-- ==========================================
-- BOTÓN MINIMIZAR (FIXED)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui", CoreGui)
local MainButton = Instance.new("TextButton", ScreenGui)
MainButton.Size = UDim2.new(0, 120, 0, 40)
MainButton.Position = UDim2.new(0, 10, 0, 50)
MainButton.Text = "CERRAR MENÚ"
MainButton.BackgroundColor3 = Color3.fromRGB(0, 50, 0)
MainButton.TextColor3 = Color3.fromRGB(0, 255, 0)
MainButton.Draggable = true

MainButton.MouseButton1Click:Connect(function()
    if MainGui then
        MainGui.Enabled = not MainGui.Enabled
        MainButton.Text = MainGui.Enabled and "CERRAR MENÚ" or "ABRIR MENÚ"
    end
end)

-- ==========================================
-- TABS DEL MENÚ
-- ==========================================

-- 1. MODERACIÓN (KICK PLAYER) - ¡NUEVO!
local Admin = Window:NewTab("Moderación")
local ASec = Admin:NewSection("Expulsar Jugadores")

local SelectedPlayer = ""
ASec:NewTextBox("Nombre del Jugador", "Escribe el nombre (o parte)", function(txt)
    SelectedPlayer = txt
end)

ASec:NewButton("EJECUTAR KICK", "Saca al jugador del server", function()
    for _, v in pairs(Players:GetPlayers()) do
        if v.Name:lower():find(SelectedPlayer:lower()) and v ~= User then
            -- Método de Kick por desbordamiento de instancia
            v:Kick("Has sido expulsado por el Sistema Omega de Venezuela. ¡Maldito seas!")
        end
    end
end)

-- 2. COMBATE (SILENT + AUTO KILL)
local Combat = Window:NewTab("Combate")
local CSec = Combat:NewSection("Aniquilación")

_G.SilentAim = true
CSec:NewToggle("Silent Aim Perfecto", "No falla", function(state) _G.SilentAim = state end)

_G.AutoKill = false
CSec:NewToggle("AUTO KILL", "Mata solo", function(state)
    _G.AutoKill = state
    task.spawn(function()
        while _G.AutoKill do
            task.wait(0.1)
            local target = nil
            local dist = math.huge
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= User and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local d = (User.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).magnitude
                    if d < dist then target = p; dist = d end
                end
            end
            if target and User.Character:FindFirstChildOfClass("Tool") then
                User.Character:FindFirstChildOfClass("Tool"):Activate()
            end
        end
    end)
end)

-- 3. GHOST / TP
local GhostTab = Window:NewTab("Ghost/TP")
local GSec = GhostTab:NewSection("Invisibilidad")

GSec:NewButton("MODO FANTASMA (GHOST)", "Invisibilidad Real", function()
    if User.Character then
        local t = User.Character:FindFirstChild("LowerTorso") or User.Character:FindFirstChild("Torso")
        if t then t:BreakJoints() t.Parent = nil end
    end
end)

GSec:NewButton("TELEPORT ATRÁS", "TP al enemigo", function()
    local target = nil
    local dist = math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= User and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local d = (User.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).magnitude
            if d < dist then target = p; dist = d end
        end
    end
    if target then User.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3) end
end)

-- 4. AJUSTES (MÚSICA Y ESP)
local Config = Window:NewTab("Ajustes")
local ConfSec = Config:NewSection("Extras")

_G.ESP = false
ConfSec:NewToggle("ESP Rojo", "Ver paredes", function(state)
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

ConfSec:NewButton("Apagar Música", "Detén el sonido", function()
    local s = game.Workspace:FindFirstChild("MusicaVnzla")
    if s then if s.Playing then s:Pause() else s:Resume() end end
end)

-- HOOK SILENT AIM
local old; old = hookmetamethod(game, "__index", function(self, k)
    if k == "Hit" and _G.SilentAim and not checkcaller() then
        local target = nil
        local dist = math.huge
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= User and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local d = (User.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).magnitude
                if d < dist then target = p; dist = d end
            end
        end
        if target then return target.Character.Head.CFrame end
    end
    return old(self, k)
end)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("MVS OMEGA - VENEZUELA ADMIN", "Midnight")
local CoreGui = game:GetService("CoreGui")

-- Buscamos el menú para esconderlo durante la intro
local MainGui = CoreGui:FindFirstChild("MVS OMEGA - VENEZUELA ADMIN") or CoreGui:FindFirstChild("Library")
if MainGui then MainGui.Enabled = false end

local Players = game:GetService("Players")
local User = Players.LocalPlayer

-- ==========================================
-- SONIDO E INTRO MATRIX (5 SEGUNDOS)
-- ==========================================
local function IniciarTodo()
    -- Sonido Automático
    local Sound = Instance.new("Sound", game.Workspace)
    Sound.Name = "MusicaVnzla"
    Sound.SoundId = "rbxassetid://1837871067" 
    Sound.Volume = 8
    Sound.Looped = true
    Sound:Play()

    -- Lluvia de Matrix
    local MatrixGui = Instance.new("ScreenGui", CoreGui)
    local Frame = Instance.new("Frame", MatrixGui)
    Frame.Size = UDim2.new(1, 0, 1, 0)
    Frame.BackgroundTransparency = 1

    task.spawn(function()
        local t = 0
        while t < 5 do
            task.wait(0.01)
            t = t + 0.01
            local Label = Instance.new("TextLabel", Frame)
            Label.Text = string.char(math.random(33, 126))
            Label.TextColor3 = Color3.fromRGB(0, 255, 0)
            Label.BackgroundTransparency = 1
            Label.Position = UDim2.new(math.random(), 0, -0.1, 0)
            Label:TweenPosition(UDim2.new(Label.Position.X.Scale, 0, 1.1, 0), "Out", "Linear", 1)
            game:GetService("Debris"):AddItem(Label, 1)
        end
        MatrixGui:Destroy()
        if MainGui then MainGui.Enabled = true end
    end)
end
task.spawn(IniciarTodo)

-- ==========================================
-- BOTÓN MINIMIZAR (FLOTANTE)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui", CoreGui)
local MainButton = Instance.new("TextButton", ScreenGui)
MainButton.Size = UDim2.new(0, 120, 0, 40)
MainButton.Position = UDim2.new(0, 10, 0, 50)
MainButton.Text = "CERRAR MENÚ"
MainButton.BackgroundColor3 = Color3.fromRGB(0, 50, 0)
MainButton.TextColor3 = Color3.fromRGB(0, 255, 0)
MainButton.Draggable = true

MainButton.MouseButton1Click:Connect(function()
    if MainGui then
        MainGui.Enabled = not MainGui.Enabled
        MainButton.Text = MainGui.Enabled and "CERRAR MENÚ" or "ABRIR MENÚ"
    end
end)

-- ==========================================
-- TABS DEL MENÚ (TODO INTACTO)
-- ==========================================

-- 1. MODERACIÓN (KICK)
local Admin = Window:NewTab("Moderación")
local ASec = Admin:NewSection("Expulsar Jugadores")

local SelectedPlayer = ""
ASec:NewTextBox("Nombre del Jugador", "Escribe el nombre aquí", function(txt)
    SelectedPlayer = txt
end)

ASec:NewButton("EJECUTAR KICK", "Saca al bicho del server", function()
    for _, v in pairs(Players:GetPlayers()) do
        if v.Name:lower():find(SelectedPlayer:lower()) and v ~= User then
            v:Kick("Expulsado por el Sistema Omega. ¡Pa' fuera!")
        end
    end
end)

-- 2. COMBATE (AUTO KILL + SILENT)
local Combat = Window:NewTab("Combate")
local CSec = Combat:NewSection("Aniquilación")

_G.SilentAim = true
CSec:NewToggle("Silent Aim Perfecto", "Balas a la cabeza", function(state) _G.SilentAim = state end)

_G.AutoKill = false
CSec:NewToggle("AUTO KILL", "Mata solo (Saca el arma)", function(state)
    _G.AutoKill = state
    task.spawn(function()
        while _G.AutoKill do
            task.wait(0.1)
            local target = nil
            local dist = math.huge
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= User and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local d = (User.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).magnitude
                    if d < dist then target = p; dist = d end
                end
            end
            if target and User.Character:FindFirstChildOfClass("Tool") then
                User.Character:FindFirstChildOfClass("Tool"):Activate()
            end
        end
    end)
end)

-- 3. GHOST / TP
local GhostTab = Window:NewTab("Ghost/TP")
local GSec = GhostTab:NewSection("Invisibilidad")

GSec:NewButton("MODO FANTASMA (GHOST)", "Invisibilidad Real", function()
    if User.Character then
        local t = User.Character:FindFirstChild("LowerTorso") or User.Character:FindFirstChild("Torso")
        if t then t:BreakJoints() t.Parent = nil end
    end
end)

GSec:NewButton("TELEPORT ATRÁS", "TP al enemigo", function()
    local target = nil
    local dist = math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= User and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local d = (User.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).magnitude
            if d < dist then target = p; dist = d end
        end
    end
    if target then User.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3) end
end)

-- 4. AJUSTES (MÚSICA Y ESP)
local Config = Window:NewTab("Ajustes")
local ConfSec = Config:NewSection("Extras")

_G.ESP = false
ConfSec:NewToggle("ESP Rojo", "Ver paredes", function(state)
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

ConfSec:NewButton("Apagar Música", "Pausa el sonido", function()
    local s = game.Workspace:FindFirstChild("MusicaVnzla")
    if s then if s.Playing then s:Pause() else s:Resume() end end
end)

-- HOOK SILENT AIM (MAGIA)
local old; old = hookmetamethod(game, "__index", function(self, k)
    if k == "Hit" and _G.SilentAim and not checkcaller() then
        local target = nil
        local dist = math.huge
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= User and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local d = (User.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).magnitude
                if d < dist then target = p; dist = d end
            end
        end
        if target then return target.Character.Head.CFrame end
    end
    return old(self, k)
end)
