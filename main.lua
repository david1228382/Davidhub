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
Section2:NewToggle("Modo Brainrot Activo", "Escape de Ohio", function(state)
    if state then
        local char = game.Players.LocalPlayer.Character
        local hrp = char:FindFirstChild("HumanoidRootPart")

        if hrp then
            -- A) PRIMER SALTO: Te mueve a la base
            hrp.CFrame = MyBasePosition 
            
            -- B) ESPERA: Le da tiempo al internet de registrar tu posición
            task.wait(0.8) 
            
            -- C) SEGUNDO SALTO: Por si acaso hubo lag
            hrp.CFrame = MyBasePosition
            
            -- D) EL KICK: Ahora sí te saca, después de 1.5 segundos
            task.delay(1.5, function()
                game.Players.LocalPlayer:Kick("DAVIDHUB V2: Brainrot completado. El Sigma escapó.")
            end)
        end
    end
end)

        -- 3. AUTO-KICK (Desconexión del Servidor)
        task.wait(1.5) -- Un pequeño delay para que veas que llegaste a la base
        game.Players.LocalPlayer:Kick("DAVIDHUB V2: Brainrot completado. El Sigma abandonó Ohio.")
    end
end)
local MyBasePosition = CFrame.new(150, 25, -300) -- Cambia estos números por los de tu sitio seguro
