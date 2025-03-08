-- Services
-- Ensure HttpService is enabled
local HttpService = game:GetService("HttpService")

-- Create the main UI frame
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 500)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
mainFrame.Parent = ScreenGui
mainFrame.Draggable = true
mainFrame.Active = true

-- UI Corner
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = mainFrame

-- Create the title bar
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.Text = "Astro Console V1.0"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 18
titleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleLabel.Parent = mainFrame

-- Speed Input
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0, 100, 0, 30)
speedLabel.Position = UDim2.new(0, 10, 0, 50)
speedLabel.Text = "Speed:"
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.TextSize = 18
speedLabel.BackgroundTransparency = 1
speedLabel.Parent = mainFrame

local speedInput = Instance.new("TextBox")
speedInput.Size = UDim2.new(0, 80, 0, 30)
speedInput.Position = UDim2.new(0, 120, 0, 50)
speedInput.PlaceholderText = "16"
speedInput.TextColor3 = Color3.fromRGB(0, 255, 0)
speedInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
speedInput.Parent = mainFrame

local speedButton = Instance.new("TextButton")
speedButton.Size = UDim2.new(0, 80, 0, 30)
speedButton.Position = UDim2.new(0, 210, 0, 50)
speedButton.Text = "Set"
speedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
speedButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
speedButton.Parent = mainFrame

-- JumpPower Input
local jumpLabel = Instance.new("TextLabel")
jumpLabel.Size = UDim2.new(0, 100, 0, 30)
jumpLabel.Position = UDim2.new(0, 10, 0, 90)
jumpLabel.Text = "JumpPower:"
jumpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpLabel.TextSize = 18
jumpLabel.BackgroundTransparency = 1
jumpLabel.Parent = mainFrame

local jumpInput = Instance.new("TextBox")
jumpInput.Size = UDim2.new(0, 80, 0, 30)
jumpInput.Position = UDim2.new(0, 120, 0, 90)
jumpInput.PlaceholderText = "50"
jumpInput.TextColor3 = Color3.fromRGB(255, 255, 0)
jumpInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
jumpInput.Parent = mainFrame

local jumpButton = Instance.new("TextButton")
jumpButton.Size = UDim2.new(0, 80, 0, 30)
jumpButton.Position = UDim2.new(0, 210, 0, 90)
jumpButton.Text = "Set"
jumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
jumpButton.Parent = mainFrame

-- Fly Button
local flyButton = Instance.new("TextButton")
flyButton.Size = UDim2.new(0, 280, 0, 40)
flyButton.Position = UDim2.new(0, 10, 0, 130)
flyButton.Text = "Fly (Toggle)"
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.TextSize = 18
flyButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
flyButton.Parent = mainFrame

-- Function to set speed
speedButton.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        local newSpeed = tonumber(speedInput.Text) or 16 -- Default speed is 16
        character.Humanoid.WalkSpeed = newSpeed
    end
end)

-- Function to set jump power
jumpButton.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        local newJump = tonumber(jumpInput.Text) or 50 -- Default jump power is 50
        character.Humanoid.JumpPower = newJump
    end
end)

-- Fly function
local flying = false
local function fly()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then return end

    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end

    local flyVelocity = Instance.new("BodyVelocity")
    flyVelocity.Velocity = Vector3.new(0, 50, 0) -- Float upward
    flyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    flyVelocity.Parent = humanoidRootPart

    local flyGyro = Instance.new("BodyGyro")
    flyGyro.CFrame = humanoidRootPart.CFrame
    flyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    flyGyro.Parent = humanoidRootPart

    return flyVelocity, flyGyro
end

-- Fly toggle
flyButton.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then return end

    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end

    if flying then
        -- Stop flying
        for _, obj in pairs(humanoidRootPart:GetChildren()) do
            if obj:IsA("BodyVelocity") or obj:IsA("BodyGyro") then
                obj:Destroy()
            end
        end
        flying = false
    else
        -- Start flying
        fly()
        flying = true
    end
end)
