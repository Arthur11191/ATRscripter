-- ATR Scripter X Brainrot - Script completo por arthurzin

local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local UIS = game:GetService("UserInputService")

local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "ATR_GUI"

-- === TELA DE KEY ===

local keyFrame = Instance.new("Frame", gui)
keyFrame.Size = UDim2.new(0, 300, 0, 150)
keyFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
keyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
keyFrame.Name = "KeyFrame"
keyFrame.AnchorPoint = Vector2.new(0.5, 0.5)

local title = Instance.new("TextLabel", keyFrame)
title.Size = UDim2.new(1,0,0.3,0)
title.BackgroundTransparency = 1
title.Text = "Script feito por ATR Scripter"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 20

local input = Instance.new("TextBox", keyFrame)
input.Size = UDim2.new(0.9,0,0.3,0)
input.Position = UDim2.new(0.05,0,0.4,0)
input.PlaceholderText = "Digite sua key aqui..."
input.Text = ""
input.TextSize = 18
input.BackgroundColor3 = Color3.fromRGB(40,40,40)
input.TextColor3 = Color3.new(1,1,1)

local btnVerify = Instance.new("TextButton", keyFrame)
btnVerify.Size = UDim2.new(0.9,0,0.25,0)
btnVerify.Position = UDim2.new(0.05,0,0.75,0)
btnVerify.Text = "Verificar Key"
btnVerify.BackgroundColor3 = Color3.fromRGB(50,100,200)
btnVerify.TextColor3 = Color3.new(1,1,1)
btnVerify.Font = Enum.Font.Gotham
btnVerify.TextSize = 18

local keyCorrect = "KeynovaRoubeumBrainrot" -- sua key correta

local function notify(text)
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "ATR Scripter",
            Text = text,
            Duration = 3
        })
    end)
end

-- === MENU PRINCIPAL ===

local menu = Instance.new("Frame", gui)
menu.Size = UDim2.new(0, 200, 0, 260)
menu.Position = UDim2.new(0.05, 0, 0.3, 0)
menu.BackgroundColor3 = Color3.fromRGB(25,25,25)
menu.Visible = false
menu.ClipsDescendants = true

local titleMenu = Instance.new("TextLabel", menu)
titleMenu.Size = UDim2.new(1,0,0,30)
titleMenu.Text = "MENU ATR Scripter X Brainrot"
titleMenu.TextColor3 = Color3.new(1,1,1)
titleMenu.Font = Enum.Font.GothamBold
titleMenu.TextSize = 16
titleMenu.BackgroundColor3 = Color3.fromRGB(40,40,40)

-- Label "Criado por arthurzin"
local labelAuthor = Instance.new("TextLabel", menu)
labelAuthor.Size = UDim2.new(1,0,0,20)
labelAuthor.Position = UDim2.new(0, 0, 1, -25)
labelAuthor.BackgroundTransparency = 1
labelAuthor.Text = "Criado por arthurzin"
labelAuthor.TextColor3 = Color3.new(1,1,1)
labelAuthor.Font = Enum.Font.GothamItalic
labelAuthor.TextSize = 14
labelAuthor.TextStrokeTransparency = 0.75
labelAuthor.TextYAlignment = Enum.TextYAlignment.Bottom

-- Botão minimizar azul e redondo
local btnMinimize = Instance.new("TextButton", menu)
btnMinimize.Size = UDim2.new(0, 30, 0, 30)
btnMinimize.Position = UDim2.new(1, -35, 0, 0)
btnMinimize.Text = "-"
btnMinimize.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
btnMinimize.TextColor3 = Color3.new(1,1,1)
btnMinimize.BorderSizePixel = 0
local cornerMin = Instance.new("UICorner", btnMinimize)
cornerMin.CornerRadius = UDim.new(0, 15)

-- Botão para abrir menu (fica oculto até minimizar)
local btnOpen = Instance.new("TextButton", gui)
btnOpen.Size = UDim2.new(0, 40, 0, 40)
btnOpen.Position = UDim2.new(1, -50, 0.5, -20)
btnOpen.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
btnOpen.Text = ">>"
btnOpen.TextColor3 = Color3.new(1,1,1)
btnOpen.BorderSizePixel = 0
btnOpen.Visible = false
local cornerOpen = Instance.new("UICorner", btnOpen)
cornerOpen.CornerRadius = UDim.new(0, 20)

-- Bolinha azul quando minimizado
local bolaAzul = Instance.new("Frame", gui)
bolaAzul.Size = UDim2.new(0, 20, 0, 20)
bolaAzul.Position = UDim2.new(1, -30, 0.5, -10)
bolaAzul.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
bolaAzul.Visible = false
bolaAzul.ZIndex = 2
bolaAzul.AnchorPoint = Vector2.new(0.5, 0.5)
local bolaCorner = Instance.new("UICorner", bolaAzul)
bolaCorner.CornerRadius = UDim.new(1, 0)

-- Funções toggle

local jumpActive = false
local jumpConnection = nil

local godActive = false
local godConnection = nil

local speedActive = false
local speedLoop = nil

local normalSpeed = 16
local boostedSpeed = 50

local function toggleJump()
    if not jumpActive then
        jumpActive = true
        notify("Jump infinito ativado!")
        jumpConnection = UIS.JumpRequest:Connect(function()
            local char = plr.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    else
        jumpActive = false
        notify("Jump infinito desativado!")
        if jumpConnection then
            jumpConnection:Disconnect()
            jumpConnection = nil
        end
    end
end

local function toggleGod()
    if not godActive then
        godActive = true
        notify("God Mode ativado!")
        local char = plr.Character or plr.CharacterAdded:Wait()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.Health = hum.MaxHealth
            godConnection = hum:GetPropertyChangedSignal("Health"):Connect(function()
                if hum.Health < hum.MaxHealth then
                    hum.Health = hum.MaxHealth
                end
            end)
        end
    else
        godActive = false
        notify("God Mode desativado!")
        if godConnection then
            godConnection:Disconnect()
            godConnection = nil
        end
    end
end

local function toggleSpeed()
    if not speedActive then
        speedActive = true
        notify("Speed ativado!")
        speedLoop = game:GetService("RunService").Stepped:Connect(function()
            local char = plr.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = boostedSpeed
            end
        end)
    else
        speedActive = false
        notify("Speed desativado!")
        if speedLoop then
            speedLoop:Disconnect()
            speedLoop = nil
        end
        if plr.Character and plr.Character:FindFirstChild("Humanoid") then
            plr.Character.Humanoid.WalkSpeed = normalSpeed
        end
    end
end

-- Detecta se o jogador está segurando o brainrot e aplica speed

game:GetService("RunService").RenderStepped:Connect(function()
    local char = plr.Character
    if char then
        local brainrot = char:FindFirstChild("brainrot")
        if speedActive then
            if brainrot then
                if char:FindFirstChild("Humanoid") then
                    char.Humanoid.WalkSpeed = boostedSpeed
                end
            else
                if char:FindFirstChild("Humanoid") then
                    char.Humanoid.WalkSpeed = boostedSpeed
                end
            end
        end
    end
end)

-- Função para criar botões no menu
local function criarBotao(nome, func, posY)
    local btn = Instance.new("TextButton", menu)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 18
    btn.Text = nome
    btn.AutoButtonColor = true
    btn.MouseButton1Click:Connect(func)
end

criarBotao("Jump Infinito", toggleJump, 40)
criarBotao("God Mode", toggleGod, 90)
criarBotao("Speed", toggleSpeed, 140)

-- Eventos dos botões

btnVerify.MouseButton1Click:Connect(function()
    if input.Text == keyCorrect then
        notify("Key correta! Bem-vindo.")
        keyFrame:Destroy()
        menu.Visible = true
    else
        notify("Key incorreta!")
        input.Text = ""
    end
end)

btnMinimize.MouseButton1Click:Connect(function()
    btnMinimize.Visible = false
    -- animação minimizar
    for i = 1, 20 do
        menu.Size = UDim2.new(0, 200 - 10 * i, 0, 260 - 13 * i)
        wait(0.01)
    end
    menu.Visible = false
    btnOpen.Visible = true
    bolaAzul.Visible = true
end)

btnOpen.MouseButton1Click:Connect(function()
    btnOpen.Visible = false
    menu.Visible = true
    bolaAzul.Visible = false
    -- animação restaurar
    for i = 20, 1, -1 do
        menu.Size = UDim2.new(0, 200 - 10 * i, 0, 260 - 13 * i)
        wait(0.01)
    end
    menu.Size = UDim2.new(0, 200, 0, 260)
    btnMinimize.Visible = true
end)

-- Tornar menu arrastável
local dragging = false
local dragInput
local dragStart
local startPos

menu.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = menu.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

menu.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        menu.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- EM BREVE MAIS FUNÇÕES
