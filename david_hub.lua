-- DAVID-HUB PRO: MOD MENU LUA
print("Mod Menu Cargado: David-Hub Pro")

local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()

-- 1. FLY (Pulsa 'F' para activar/desactivar)
local flying = false
mouse.KeyDown:Connect(function(key)
    if key == "f" then
        flying = not flying
        print("Fly: " .. tostring(flying))
    end
end)

-- 2. ESP (Ver a los enemigos por siempre)
function AddESP(p)
    if p ~= plr and p.Character then
        local box = Instance.new("BoxHandleAdornment", p.Character)
        box.Size = Vector3.new(4, 6, 0)
        box.Adornee = p.Character:FindFirstChild("HumanoidRootPart")
        box.AlwaysOnTop = true
        box.ZIndex = 10
        box.Color3 = Color3.new(0, 1, 0) -- Verde Hacker
    end
end

-- 3. AIMBOT (Apuntado automático suave)
game:GetService("RunService").RenderStepped:Connect(function()
    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= plr and v.Character and v.Character:FindFirstChild("Head") then
            -- Aquí va la lógica de apuntado
        end
    end
end)
