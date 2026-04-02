-- Función para soltar el tema
local function SonidoEpico()
    local sonido = Instance.new("Sound")
    sonido.Name = "LindaMujerSound"
    -- ID de la canción (buscando uno que no esté borrado por copyright)
    sonido.SoundId = "rbxassetid://1837740590" -- Si este ID cae, hay que buscar otro activo
    sonido.Volume = 2
    sonido.Parent = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    sonido:Play()
    
    -- Mensaje en el chat local para que sepas que se activó
    game.StarterGui:SetCore("SendNotification", {
        Title = "MvS Script",
        Text = "Linda mujer, sabes que te amo...",
        Duration = 5
    })
end

-- Ejecutar el sonido al iniciar
SonidoEpico()
