-- AUTO FAVORITE / UNFAVORITE FRUITS HUB

-- UI
local Obsidian = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/FilteringEnabled/Obsidian/main/source.lua"
))()

local Window = Obsidian:CreateWindow({
    Title = "Fruit Automation",
    Footer = "Auto Fav / Unfav",
    Size = UDim2.fromOffset(520, 420),
    Theme = "Dark"
})

local Tab = Window:AddTab({ Title = "Automation", Icon = "star" })

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local Backpack = player:WaitForChild("Backpack")

-- Remote
local Favorite_Item = ReplicatedStorage
    :WaitForChild("GameEvents")
    :WaitForChild("Favorite_Item")

-- State
local autoFav = false
local delayBetween = 0.15

-- Core loop
local function autoFavoriteLoop()
    task.spawn(function()
        while autoFav do
            for _,tool in ipairs(Backpack:GetChildren()) do
                if not autoFav then break end
                if tool:IsA("Tool") then
                    pcall(function()
                        Favorite_Item:FireServer(tool)
                    end)
                    task.wait(delayBetween)
                end
            end
            task.wait(1)
        end
    end)
end

-- UI
Tab:AddToggle({
    Title = "Auto Favorite / Unfavorite Fruits",
    Default = false,
    Callback = function(v)
        autoFav = v
        if v then
            autoFavoriteLoop()
        end
    end
})

Tab:AddSlider({
    Title = "Delay Between Fruits",
    Min = 0.05,
    Max = 0.5,
    Default = 0.15,
    Callback = function(v)
        delayBetween = v
    end
})

Tab:AddButton({
    Title = "Favorite All Once",
    Callback = function()
        for _,tool in ipairs(Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                Favorite_Item:FireServer(tool)
                task.wait(delayBetween)
            end
        end
    end
})

Tab:AddButton({
    Title = "Unfavorite All Once",
    Callback = function()
        for _,tool in ipairs(Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                Favorite_Item:FireServer(tool)
                task.wait(delayBetween)
            end
        end
    end
})

Tab:AddButton({
    Title = "Unload Script",
    Callback = function()
        Window:Destroy()
    end
})
