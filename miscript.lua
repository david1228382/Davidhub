-- Mi primer script para Delta (Básico)
print("--- 🚀 SCRIPT CARGADO DESDE JUANGRIEGO ---")

local player = game.Players.LocalPlayer
print("Hola, " .. player.Name .. "! El sistema está activo.")

-- Ejemplo: Cambiar el color de tu personaje a Neón
local character = player.Character or player.CharacterAdded:Wait()
for _, part in pairs(character:GetDescendants()) do
    if part:IsA("BasePart") then
        part.Material = Enum.Material.Neon
        part.BrickColor = BrickColor.new("Bright red")
    end
end
