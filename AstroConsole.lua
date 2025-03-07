-- LocalScript for Dynamic Console with Categorized Commands

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create the base ScreenGui
local consoleGui = Instance.new("ScreenGui")
consoleGui.Parent = playerGui

-- Create the main frame that will hold everything
local baseFrame = Instance.new("Frame")
baseFrame.Size = UDim2.new(0, 400, 0, 300)
baseFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
baseFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
baseFrame.Parent = consoleGui

-- Create a ScrollingFrame for categories (Commands like Fly, Speed, etc.)
local categoriesFrame = Instance.new("ScrollingFrame")
categoriesFrame.Size = UDim2.new(0, 120, 1, 0)
categoriesFrame.Position = UDim2.new(0, 0, 0, 0)
categoriesFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
categoriesFrame.ScrollingEnabled = true
categoriesFrame.Parent = baseFrame

-- Create a Frame for content (commands and player list)
local categoryContentFrame = Instance.new("Frame")
categoryContentFrame.Size = UDim2.new(0, 280, 1, 0)
categoryContentFrame.Position = UDim2.new(0, 120, 0, 0)
categoryContentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
categoryContentFrame.Parent = baseFrame
local function openKickPlayerUI()
    -- Create a list of player buttons
    local kickUIFrame = Instance.new("Frame")
    kickUIFrame.Size = UDim2.new(0, 250, 0, 200)
    kickUIFrame.Position = UDim2.new(0.5, -125, 0.5, -100)
    kickUIFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    kickUIFrame.Parent = consoleGui

    local playerListLayout = Instance.new("UIListLayout")
    playerListLayout.Parent = kickUIFrame

    -- Create buttons for each player in the game
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player then  -- Skip the local player
            local playerButton = Instance.new("TextButton")
            playerButton.Size = UDim2.new(0, 200, 0, 30)
            playerButton.Text = p.Name
            playerButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            playerButton.Parent = kickUIFrame

            -- When a player button is clicked, kick that player
            playerButton.MouseButton1Click:Connect(function()
                p:Kick("You have been kicked from the game.")
                print(p.Name .. " has been kicked.")
                kickUIFrame:Destroy()  -- Close the UI
            end)
        end
    end
end
-- Commands for different categories
local commandCategories = {
    MovementCommands = {
        {Name = "Fly", Action = function()
            -- Enable fly mode (you can extend this)
            print("Fly command activated")
        end},
        {Name = "Speed", Action = function()
            -- Set speed
            player.Character:WaitForChild("Humanoid").WalkSpeed = 50
            print("Speed set to 50")
        end},
        {Name = "JumpPower", Action = function()
            -- Set jump power
            player.Character:WaitForChild("Humanoid").JumpPower = 100
            print("JumpPower set to 100")
        end}
    },
    
    PlayerActions = {
        {Name = "Kick Player", Action = function()
            -- Open player selection UI for kicking
            openKickPlayerUI()
        end}
    }
}

-- Create category buttons dynamically
local function createCategoryButton(categoryName, index)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 100, 0, 50)
    button.Position = UDim2.new(0, 0, 0, (index - 1) * 60)
    button.Text = categoryName
    button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    button.Parent = categoriesFrame

    -- When category button is clicked, update the content area with the commands of the category
    button.MouseButton1Click:Connect(function()
        -- Clear previous buttons
        for _, child in pairs(categoryContentFrame:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end

        -- Add command buttons for the selected category
        for _, command in pairs(commandCategories[categoryName]) do
            local commandButton = Instance.new("TextButton")
            commandButton.Size = UDim2.new(0, 200, 0, 40)
            commandButton.Position = UDim2.new(0, 20, 0, #categoryContentFrame:GetChildren() * 50)
            commandButton.Text = command.Name
            commandButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            commandButton.Parent = categoryContentFrame

            commandButton.MouseButton1Click:Connect(function()
                command.Action()
            end)
        end
    end)
end

-- Create category buttons dynamically for all categories
local categoryIndex = 1
for category, _ in pairs(commandCategories) do
    createCategoryButton(category, categoryIndex)
    categoryIndex = categoryIndex + 1
end

-- Player selection UI for kicking players

