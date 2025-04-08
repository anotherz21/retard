local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()

local Window = WindUI:CreateWindow({
    Title = "Glass Bridge 2",
    Icon = "door-open",
    Author = "another21",
    Folder = "anot21",
    Size = UDim2.fromOffset(300, 300),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
    HasOutline = false,
})

Window:EditOpenButton({
    Title = "Open",
    Icon = "monitor",
    CornerRadius = UDim.new(0, 10),
    StrokeThickness = 2,
    Color = ColorSequence.new(Color3.fromHex("FF0F7B"), Color3.fromHex("F89B29")),
    Draggable = true,
})

local Tabs = {
    Main = Window:Tab({ Title = "Main", Icon = "mouse-pointer-2", Desc = "Main menu" }),
}

Window:SelectTab(1)

local chest = workspace.Finish.Chest
local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local head = character:WaitForChild("Head")

Tabs.Main:Button({
    Title = "Teleport to Chest",
    Desc = "Get +1 win and +15000 money",
    Callback = function()
        firetouchinterest(head, chest, 0)
        firetouchinterest(head, chest, 1)
    end,
})

Tabs.Main:Button({
    Title = "See unbreakable glass",
    Desc = "Unbreakable glass will be colored green",
    Callback = function()
        for i = 1, 500 do
            local segment = workspace.segmentSystem.Segments["Segment"..i]
            if segment and segment:FindFirstChild("Folder") then
                for _, part in pairs(segment.Folder:GetDescendants()) do
                    if part:IsA("BasePart") then
                        if part:FindFirstChild("breakable") then
                            part.Transparency = 1
                            part.CanCollide = false
                        else
                            part.BrickColor = BrickColor.new("Bright green")
                        end
                    end
                end
            end
        end
    end,
})

local running = false

Tabs.Main:Toggle({
    Title = "Auto Farm Chest",
    Default = false,
    Callback = function(state)
        running = state
    end,
})

game:GetService("RunService").RenderStepped:Connect(function()
    if running then
        firetouchinterest(head, chest, 0)
        firetouchinterest(head, chest, 1)
    end
end)
