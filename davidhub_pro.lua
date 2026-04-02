-- ==========================================
--      DAVIDHUB V2 PRO - JUANGRIEGO
-- ==========================================
local p = game.Players.LocalPlayer
local char = p.Character or p.CharacterAdded:Wait()

-- Aviso de Bienvenida (El que confirma que sirve)
game.StarterGui:SetCore("SendNotification", {
    Title = "DAVIDHUB V2";
    Text = "¡Activo David! Juangriego en la casa.";
    Duration = 10;
})

print("--- Davidhub Pro Cargado con Éxito ---")

-- [MARCA PERSONAL] Poner al personaje en NEÓN AZUL
for _, part in pairs(char:GetDescendants()) do
    if part:IsA("BasePart") then
        part.Material = Enum.Material.Neon
        part.BrickColor = BrickColor.new("Electric blue")
    end
end

-- [MODULO COMBATE] Función para matar (Kill Aura básico)
function killAura()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= p and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (char.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
            if dist < 15 then
                print("Atacando a: " .. v.Name)
            end
        end
    end
end

-- [MODULO VUELO] Cargando Fly
local flying = false
print("Módulo Fly listo para configurar.")
