-- 1. BIENVENIDA PANTALLA COMPLETA
local Gui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", Gui)
Frame.Size = UDim2.new(1, 0, 1, 0)
Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
local Text = Instance.new("TextLabel", Frame)
Text.Size = UDim2.new(1, 0, 1, 0)
Text.Text = "BIENVENIDO AL SCRIPT DE DAVID\nEL SIGMA DE MARGARITA"
Text.TextColor3 = Color3.fromRGB(170, 0, 255)
Text.TextSize = 45
Text.BackgroundTransparency = 1
task.wait(4)
Gui:Destroy()

-- 2. LIBRERÍA Y MENÚ
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("DAVIDHUB | MURDER VS SHERIFF 🔫", "Midnight")

local Tab1 = Window:NewTab("Combate ⚔️")
local Sec1 = Tab1:NewSection("Wall Hacks & Kill")
Sec1:NewButton("Quitar Paredes Frente", "Atraviesa y dispara", function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:find("Wall") or obj.Name:find("Pared")) then
            obj.CanCollide = false
            obj.Transparency = 0.5
        end
    end
end)

local Tab2 = Window:NewTab("Trolleo 🤡")
local Sec2 = Tab2:NewSection("Funciones para Sacar Volando")
Sec2:NewButton("Fling (Sacar Volando)", "Gira para empujar gente", function()
    local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
    local velocity = Instance.new("BodyAngularVelocity", hrp)
    velocity.AngularVelocity = Vector3.new(0, 99999, 0)
    velocity.MaxTorque = Vector3.new(0, 99999, 0)
    task.wait(6)
    velocity:Destroy()
end)

local Tab3 = Window:NewTab("Config ⚙️")
local Sec3 = Tab3:NewSection("Música: DESACTIVADA")
Sec3:NewLabel("Script Limpio de Música")
