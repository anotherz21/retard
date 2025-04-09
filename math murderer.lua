local lastQuestion = ""
local autoAnswer = false
local nra = false

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()

local Window = Library:CreateWindow({
    Title = "Math Murderer",
    Footer = "v1.0.0, by anotherz21",
    Size = UDim2.fromOffset(600, 480),
    Center = true,
    MobileButtonsSide = "Left"
})

local MainTab = Window:AddTab("Main")

local Math = MainTab:AddLeftGroupbox("Math")

Math:AddToggle("Auto Answer", {
    Text = "Auto Answer",
    Default = false,
    Callback = function(v)
        autoAnswer = v
    end
})

Math:AddToggle("Notify Right Answer", {
    Text = "Notify Right Answer",
    Default = false,
    Callback = function(v)
        nra = v
    end
})

local answ = Math:AddInput("Answer", {
    Text = "Answer",
    Default = "",
    Numeric = false,
    Finished = true, 
    Disabled = true,
    Placeholder = "Finding question...",
    Callback = function(Value)
    end
})

function CollectL()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    for _, letter in ipairs(workspace.Map.Functional.SpawnedLetters:GetChildren()) do
        local hitbox = letter:FindFirstChild("Hitbox", true)
        if hitbox and hitbox:IsA("BasePart") then
            firetouchinterest(hrp, hitbox, 0)
            firetouchinterest(hrp, hitbox, 1)
        end
    end
end

Math:AddButton({
    Text = "Collect Spawned Letters",
    Func = function()
        CollectL()
    end
})

game:GetService("RunService").RenderStepped:Connect(function()
    local questionText = workspace.Map.Functional.Screen.SurfaceGui.MainFrame.MainGameContainer.MainTxtContainer.QuestionText.Text

    if questionText ~= lastQuestion then
        lastQuestion = questionText
        local num1, operator, num2 = questionText:match("(%d+)%s*([%+%-x×/÷])%s*(%d+)")

        if num1 and num2 and operator then
            num1, num2 = tonumber(num1), tonumber(num2)
            local result
            if operator == "+" then
                result = num1 + num2
            elseif operator == "-" then
                result = num1 - num2
            elseif operator == "x" or operator == "×" then
                result = num1 * num2
            elseif operator == "/" or operator == "÷" then
                result = num1 / num2
            end

            if nra and not autoAnswer or nra and autoAnswer then
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = workspace.Map.Functional.Screen.SurfaceGui.MainFrame.MainGameContainer.DifficultyText.Text,
                    Text = questionText .. " " .. tostring(result),
                    Duration = 7
                })
            end
            answ:SetText(questionText)
            answ:SetValue(result)

            if autoAnswer and not nra or autoAnswer and nra then
                game:GetService("ReplicatedStorage").Events.GameEvent:FireServer("updateAnswer", tostring(result))
                game:GetService("ReplicatedStorage").Events.GameEvent:FireServer("submitAnswer", tostring(result))
            end
        end
    end
end)
