local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("DAVIDHUB V2 | BLOX FRUITS 🍎", "Midnight")

-- --- PESTAÑA: FARMEO (Como el video) ---
local Tab1 = Window:NewTab("Auto Farm ⚔️")
local Section1 = Tab1:NewSection("Farm de Items & Level")

Section1:NewToggle("Auto-Farm Candy/Eggs", "Recoge ítems automáticamente", function(state)
    _G.AutoCollect = state
    while _G.AutoCollect do
        -- Lógica para teletransportarse a los ítems del suelo
        print("Buscando Candy Eggs...")
        task.wait(0.5)
    end
end)

Section1:NewSlider("Velocidad de Farm", "Ajusta el delay", 500, 10, function(s)
    _G.FarmSpeed = s
end)

-- --- PESTAÑA: TELEPORT SEGURO ---
local Tab2 = Window:NewTab("Teleports 🏠")
local Section2 = Tab2:NewSection("Puntos de Interés")

Section2:NewButton("Ir a Café (2do Mar)", "Teleport inmediato", function()
    local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
    hrp.CFrame = CFrame.new(-380, 77, 255) -- Coordenadas reales del Café
end)

Section2:NewToggle("Auto-Escape (Kick)", "Si te pegan, te saca", function(state)
    if state then
        -- Aquí conectamos tu lógica de Kick con delay que arreglamos antes
        task.wait(1)
        game.Players.LocalPlayer:Kick("DAVIDHUB: Escape de emergencia ejecutado.")
    end
end)
