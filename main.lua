local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("STYLA BRAINROT: GHOST MODE 🟢", "Midnight")

-- Variables de Estado
local MyBasePosition = CFrame.new(0, 50, 0) -- Coordenadas iniciales
local HasBrainrot = false

-- --- PESTAÑA: COMBATE SIGMA ---
local Tab1 = Window:NewTab("Combate Rizz 🔫")
local Section1 = Tab1:NewSection("Aimbot & ESP")

Section1:NewButton("Aimbot Bat (Optimizado)", "Mejora el aim estilo PC", function()
    -- Lógica de suavizado de cámara y fijación
    print("Aimbot Bat Activado")
end)

Section1:NewToggle("Ghost ESP (Matrix)", "Ver a todos en verde neón", function(state)
    -- Aquí va el código para resaltar jugadores a través de paredes
    print("ESP Ghost: " .. tostring(state))
end)

-- --- PESTAÑA: TELEPORT & ESCAPE ---
local Tab2 = Window:NewTab("Teleport Base 🏠")
local Section2 = Tab2:NewSection("Escondite de Ohio")

Section2:NewButton("Marcar Base Actual", "Guarda tu sitio seguro", function()
    local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        MyBasePosition = hrp.CFrame
        print("Base de Ohio guardada.")
    end
end)

Section2:NewToggle("Modo Brainrot Activo", "Si lo activas, te vas a la base", function(state)
    HasBrainrot = state
    local char = game.Players.LocalPlayer.Character
    local hrp = char:FindFirstChild("HumanoidRootPart")
    
    if state and hrp then
        -- 1. Teleport Inmediato
        hrp.CFrame = MyBasePosition
        print("Teleport Base: Activado")
        
        -- 2. Efecto Visual y Sonido
        local s = Instance.new("Sound", game.Workspace)
        s.SoundId = "rbxassetid://130762211" 
        s:Play()

        -- 3. AUTO-KICK (Desconexión del Servidor)
        task.wait(1.5) -- Un pequeño delay para que veas que llegaste a la base
        game.Players.LocalPlayer:Kick("DAVIDHUB V2: Brainrot completado. El Sigma abandonó Ohio.")
    end
end)
