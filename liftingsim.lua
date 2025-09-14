local UILibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/twink"))()

local MainUI = UILibrary.Load("lifting simulator script by HikmattXD.")
local FirstPage = MainUI.AddPage("Home")

FirstPage.AddToggle("auto lift", false, function(Value)
toggle = Value
while toggle do wait()
local ohTable1 = {
	[1] = "GainMuscle"
}
game:GetService("ReplicatedStorage").RemoteEvent:FireServer(ohTable1)
    end
end)
FirstPage.AddToggle("auto sell", false, function(Value)
    tog = Value
   while tog do wait()
local ohTable1 = {
	[1] = "SellMuscle"
}

game:GetService("ReplicatedStorage").RemoteEvent:FireServer(ohTable1)
    end
end)
FirstPage.AddButton("buy in gui menu", function()
    game:GetService("Players").LocalPlayer.PlayerGui["Main_Gui"]["UpgradeMenu_Frame"].Visible = true
end)