local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()

local Window = WindUI:CreateWindow({
    Title = "Tower of Jump",
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

Tabs.Main:Button({
    Title = "Win",
    Desc = "Win without teleport.",
    Callback = function()
        local chr = game.Players.LocalPlayer.Character
        firetouchinterest(workspace.Storage.End.WinsBrick, chr.HumanoidRootPart, 0)
        task.wait()
        firetouchinterest(workspace.Storage.End.WinsBrick, chr.HumanoidRootPart, 1)
    end,
})

Tabs.Main:Button({
    Title = "Auto Win",
    Desc = "Wins Brick will follow you forever!",
    Callback = function()
        local p = game.Players.LocalPlayer
        local rs = game:GetService("RunService")
        local c = p.Character or p.CharacterAdded:Wait()
        local hrp = c:WaitForChild("HumanoidRootPart")
        local h = c:WaitForChild("Humanoid")
        local b = workspace.Storage.End.WinsBrick
        b.Transparency = 0.8
        b.CanCollide = false

        rs.RenderStepped:Connect(function()
            b.Size = c:GetExtentsSize()
            b.CFrame = hrp.CFrame
        end)
    end,
})

Tabs.Main:Toggle({
    Title = "Auto Farm Win",
    Default = false,
    Callback = function(state)
        task.spawn(function()
            while state and task.wait() do
                local text = game.Players.LocalPlayer.PlayerGui.TimerGui.Timer.Text
                if text:find("Starting in") or text:find("0:00") then
                    local chr = game.Players.LocalPlayer.Character
                    firetouchinterest(workspace.Storage.End.WinsBrick, chr.HumanoidRootPart, 0)
                    task.wait()
                    firetouchinterest(workspace.Storage.End.WinsBrick, chr.HumanoidRootPart, 1)
                end
            end
        end)
    end,
})

Tabs.Main:Button({
    Title = "Teleport to Top",
    Desc = "Teleport up (didn't win)",
    Callback = function()
        local chr = game.Players.LocalPlayer.Character
        chr.HumanoidRootPart.CFrame = workspace.Storage.End.StartPlatform.CFrame + Vector3.new(0, 5, 0)
    end,
})

Tabs.Main:Button({
    Title = "Teleport to Win Brick",
    Desc = "Win with teleport",
    Callback = function()
        local chr = game.Players.LocalPlayer.Character
        chr.HumanoidRootPart.CFrame = workspace.Storage.End.WinsBrick.CFrame
    end,
})
