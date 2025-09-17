--Code by HikmatXD.
--Fuck you recode.
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "HikmatXD."
gui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", gui)
MainFrame.Size = UDim2.new(0, 260, 0, 420)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true

local Title = Instance.new("TextButton", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Text = "HikmatXD."
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 22
Title.AutoButtonColor = false 
Title.ZIndex = 2 

local dragging = false
local dragStartPos = nil
local dragMouseStartPos = nil

Title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragMouseStartPos = input.Position
		dragStartPos = MainFrame.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragMouseStartPos
		MainFrame.Position = UDim2.new(
			dragStartPos.X.Scale, dragStartPos.X.Offset + delta.X,
			dragStartPos.Y.Scale, dragStartPos.Y.Offset + delta.Y
		)
	end
end)

local buttonsToToggle = {}

local AutoClickBtn = Instance.new("TextButton", MainFrame)
AutoClickBtn.Size = UDim2.new(1, -20, 0, 40)
AutoClickBtn.Position = UDim2.new(0, 10, 0, 40)
AutoClickBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AutoClickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoClickBtn.Text = "AutoFarm: OFF"
AutoClickBtn.Font = Enum.Font.SourceSansBold
AutoClickBtn.TextSize = 20
table.insert(buttonsToToggle, AutoClickBtn)

local autoClick = false
AutoClickBtn.MouseButton1Click:Connect(function()
	autoClick = not autoClick
	AutoClickBtn.Text = "AutoFarm: " .. (autoClick and "ON" or "OFF")
end)

task.spawn(function()
	while true do
		task.wait(0)
		if autoClick then
			local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
			if tool and tool.Activate then
				pcall(function() tool:Activate() end)
			end
		end
	end
end)

local TPBuyBtn = Instance.new("TextButton", MainFrame)
TPBuyBtn.Size = UDim2.new(1, -20, 0, 40)
TPBuyBtn.Position = UDim2.new(0, 10, 0, 90)
TPBuyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TPBuyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TPBuyBtn.Text = "Open Buy GUI"
TPBuyBtn.Font = Enum.Font.SourceSansBold
TPBuyBtn.TextSize = 20
table.insert(buttonsToToggle, TPBuyBtn)

TPBuyBtn.MouseButton1Click:Connect(function()
	local gui = LocalPlayer:FindFirstChild("PlayerGui")
	if gui then
		local mainGui = gui:FindFirstChild("Main_Gui")
		if mainGui then
			local upgradeMenu = mainGui:FindFirstChild("UpgradeMenu_Frame")
			if upgradeMenu then
				upgradeMenu.Visible = true
			else
				warn("UpgradeMenu_Frame bulunamadı!")
			end
		else
			warn("Main_Gui bulunamadı!")
		end
	else
		warn("PlayerGui bulunamadı!")
	end
end)

local AutoSellBtn = Instance.new("TextButton", MainFrame)
AutoSellBtn.Size = UDim2.new(1, -20, 0, 40)
AutoSellBtn.Position = UDim2.new(0, 10, 0, 140)
AutoSellBtn.BackgroundColor3 = Color3.fromRGB(60, 30, 30)
AutoSellBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoSellBtn.Text = "AutoSell: OFF"
AutoSellBtn.Font = Enum.Font.SourceSansBold
AutoSellBtn.TextSize = 20
table.insert(buttonsToToggle, AutoSellBtn)

local autoSell = false
AutoSellBtn.MouseButton1Click:Connect(function()
	autoSell = not autoSell
	AutoSellBtn.Text = "Auto Sell: " .. (autoSell and "ON" or "OFF")
end)

task.spawn(function()
	while true do
		task.wait(0.7)
		if autoSell then
			local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
			local hrp = char:FindFirstChild("HumanoidRootPart")
			local target = workspace:FindFirstChild("EffectStorage")
			if target and target:FindFirstChild("Mark01") and hrp then
				hrp.CFrame = hrp.CFrame + Vector3.new(0, 0, 30)
				task.wait(0.5)
				hrp.CFrame = target.Mark01.CFrame + Vector3.new(0, 5, 0)
			end
		end
	end
end)

local BringSellBtn = Instance.new("TextButton", MainFrame)
BringSellBtn.Size = UDim2.new(1, -20, 0, 40)
BringSellBtn.Position = UDim2.new(0, 10, 0, 290)
BringSellBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
BringSellBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
BringSellBtn.Text = "Bring Sell Part: OFF"
BringSellBtn.Font = Enum.Font.SourceSansBold
BringSellBtn.TextSize = 20
table.insert(buttonsToToggle, BringSellBtn)

local bringSell = false
local originalCFrame = nil

BringSellBtn.MouseButton1Click:Connect(function()
	bringSell = not bringSell
	BringSellBtn.Text = "Bring Sell Part: " .. (bringSell and "ON" or "OFF")

	local effectStorage = workspace:FindFirstChild("EffectStorage")
	local mark01 = effectStorage and effectStorage:FindFirstChild("Mark01")
	local detector = mark01 and mark01:FindFirstChild("Detector")

	if detector then
		if originalCFrame == nil then
			originalCFrame = detector.CFrame
		end
		if not bringSell then
			detector.CFrame = originalCFrame
		end
	else
		warn("Detector bulunamadı!")
	end
end)

task.spawn(function()
	while true do
		task.wait(2.5)
		if bringSell then
			local char = LocalPlayer.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			local effectStorage = workspace:FindFirstChild("EffectStorage")
			local mark01 = effectStorage and effectStorage:FindFirstChild("Mark01")
			local detector = mark01 and mark01:FindFirstChild("Detector")
			if hrp and detector then
				detector.CFrame = hrp.CFrame + Vector3.new(0, 5, 0)
			end
		end
	end
end)

local BossBtn = Instance.new("TextButton", MainFrame)
BossBtn.Size = UDim2.new(1, -20, 0, 40)
BossBtn.Position = UDim2.new(0, 10, 0, 190)
BossBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
BossBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
BossBtn.Text = "Boss Area Teleporter"
BossBtn.Font = Enum.Font.SourceSansBold
BossBtn.TextSize = 20
table.insert(buttonsToToggle, BossBtn)

local SpeedBtn = Instance.new("TextButton", MainFrame)
SpeedBtn.Size = UDim2.new(1, -20, 0, 40)
SpeedBtn.Position = UDim2.new(0, 10, 0, 240)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 160)
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.Text = "Speed Changer"
SpeedBtn.Font = Enum.Font.SourceSansBold
SpeedBtn.TextSize = 20
table.insert(buttonsToToggle, SpeedBtn)

local BossFrame = Instance.new("Frame", gui)
BossFrame.Size = UDim2.new(0, 260, 0, 350)
BossFrame.Position = UDim2.new(0.35, 0, 0.1, 0)
BossFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
BossFrame.BorderSizePixel = 0
BossFrame.Visible = false
BossFrame.Active = true

local Scroll = Instance.new("ScrollingFrame", BossFrame)
Scroll.Size = UDim2.new(1, 0, 1, 0)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 600)
Scroll.ScrollBarThickness = 6
Scroll.BackgroundTransparency = 1

local draggingBoss, mousePosBoss, startPosBoss
BossFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingBoss = true
		mousePosBoss = input.Position
		startPosBoss = BossFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				draggingBoss = false
			end
		end)
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if draggingBoss and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - mousePosBoss
		BossFrame.Position = UDim2.new(
			startPosBoss.X.Scale, startPosBoss.X.Offset + delta.X,
			startPosBoss.Y.Scale, startPosBoss.Y.Offset + delta.Y
		)
	end
end)

BossBtn.MouseButton1Click:Connect(function()
	BossFrame.Visible = not BossFrame.Visible
end)

local BossIsland = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Boss_Island")

if BossIsland then
	for i = 1, 15 do
		local areaNum = i < 10 and "0"..i or tostring(i)
		local areaName = "Area"..areaNum
		local floorName = (i == 4 and "Floor05") or (i == 5 and "Floor04") or ("Floor"..areaNum)

		local btn = Instance.new("TextButton", Scroll)
		btn.Size = UDim2.new(1, -10, 0, 30)
		btn.Position = UDim2.new(0, 5, 0, (i-1)*35)
		btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.Font = Enum.Font.SourceSansBold
		btn.TextSize = 16
		btn.Text = "Teleport to Area "..i

		btn.MouseButton1Click:Connect(function()
			local area = BossIsland:FindFirstChild(areaName)
			if area then
				local floor = area:FindFirstChild(floorName)
				if floor then
					for _, obj in pairs(floor:GetDescendants()) do
						if obj:IsA("BasePart") then
							local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
							if hrp then
								hrp.CFrame = obj.CFrame + Vector3.new(0, 5, 0)
							end
							break
						end
					end
				end
			end
		end)
	end
else
	warn("Boss_Island bulunamadı!")
end

local SpeedFrame = Instance.new("Frame", gui)
SpeedFrame.Size = UDim2.new(0, 220, 0, 120)
SpeedFrame.Position = UDim2.new(0.35, 0, 0.55, 0)
SpeedFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
SpeedFrame.BorderSizePixel = 0
SpeedFrame.Visible = false
SpeedFrame.Active = true

local draggingSpeed, mousePosSpeed, startPosSpeed
SpeedFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingSpeed = true
		mousePosSpeed = input.Position
		startPosSpeed = SpeedFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				draggingSpeed = false
			end
		end)
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if draggingSpeed and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - mousePosSpeed
		SpeedFrame.Position = UDim2.new(
			startPosSpeed.X.Scale, startPosSpeed.X.Offset + delta.X,
			startPosSpeed.Y.Scale, startPosSpeed.Y.Offset + delta.Y
		)
	end
end)

local SpeedLabel = Instance.new("TextLabel", SpeedFrame)
SpeedLabel.Size = UDim2.new(1, 0, 0, 30)
SpeedLabel.Position = UDim2.new(0, 0, 0, 10)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Set Walk Speed:"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.TextSize = 18

local SpeedBox = Instance.new("TextBox", SpeedFrame)
SpeedBox.Size = UDim2.new(1, -20, 0, 40)
SpeedBox.Position = UDim2.new(0, 10, 0, 45)
SpeedBox.ClearTextOnFocus = false
SpeedBox.Text = "16"
SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedBox.Font = Enum.Font.SourceSans
SpeedBox.TextSize = 22
SpeedBox.PlaceholderText = "Enter speed number"

local ApplyBtn = Instance.new("TextButton", SpeedFrame)
ApplyBtn.Size = UDim2.new(1, -20, 0, 30)
ApplyBtn.Position = UDim2.new(0, 10, 0, 90)
ApplyBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
ApplyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplyBtn.Text = "Apply"
ApplyBtn.Font = Enum.Font.SourceSansBold
ApplyBtn.TextSize = 20

SpeedBtn.MouseButton1Click:Connect(function()
	SpeedFrame.Visible = not SpeedFrame.Visible
end)

local currentSpeed = 16
local speedEnabled = false

ApplyBtn.MouseButton1Click:Connect(function()
	local val = tonumber(SpeedBox.Text)
	if val and val > 0 then
		currentSpeed = val
		speedEnabled = true
	else
		speedEnabled = false
	end
end)

task.spawn(function()
	while true do
		task.wait(0)
		if speedEnabled then
			local char = LocalPlayer.Character
			if char then
				local humanoid = char:FindFirstChildOfClass("Humanoid")
				if humanoid and humanoid.WalkSpeed ~= currentSpeed then
					humanoid.WalkSpeed = currentSpeed
				end
			end
		end
	end
end)

local isMinimized = false
Title.MouseButton1Click:Connect(function()
	if dragging then return end
	
	if not isMinimized then
		local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local sizeTween = TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 260, 0, 30)})
		sizeTween:Play()
		
		for _, btn in pairs(buttonsToToggle) do
			btn.Visible = false
		end
		
		isMinimized = true
	else
		local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local sizeTween = TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 260, 0, 380)})
		sizeTween:Play()
		
		sizeTween.Completed:Connect(function()
			for _, btn in pairs(buttonsToToggle) do
				btn.Visible = true
			end
		end)
		
		isMinimized = false
	end
end) 

local FastAnimBtn = Instance.new("TextButton", MainFrame)
FastAnimBtn.Size = UDim2.new(1, -20, 0, 40)
FastAnimBtn.Position = UDim2.new(0, 10, 0, 340)
FastAnimBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 90)
FastAnimBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FastAnimBtn.Text = "Fast Animations: OFF"
FastAnimBtn.Font = Enum.Font.SourceSansBold
FastAnimBtn.TextSize = 20
table.insert(buttonsToToggle, FastAnimBtn)

local fastAnimEnabled = false

FastAnimBtn.MouseButton1Click:Connect(function()
	fastAnimEnabled = not fastAnimEnabled
	FastAnimBtn.Text = "Fast Animations: " .. (fastAnimEnabled and "ON" or "OFF")
end)

task.spawn(function()
	while true do
		task.wait(0)
		if fastAnimEnabled then
			local char = LocalPlayer.Character
			if not char then continue end

			local tool = char:FindFirstChildOfClass("Tool")
			if not tool then continue end

			local humanoid = char:FindFirstChildOfClass("Humanoid")
			if humanoid then
				for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
					if track and track.IsPlaying and track.Length > 0 and track.Speed ~= 2 then
						pcall(function()
							track:AdjustSpeed(2)
						end)
					end
				end
			end

			for _, obj in ipairs(tool:GetDescendants()) do
				if obj:IsA("NumberValue") or obj:IsA("IntValue") then
					if string.find(obj.Name:lower(), "cooldown") or string.find(obj.Name:lower(), "delay") then
						pcall(function()
							obj.Value = 0
						end)
					end
				end
			end
		end
	end
end)

local AutoKillBossBtn = Instance.new("TextButton", MainFrame)
AutoKillBossBtn.Size = UDim2.new(1, -20, 0, 40)
AutoKillBossBtn.Position = UDim2.new(0, 10, 0, 290) -- uygun pozisyon
AutoKillBossBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
AutoKillBossBtn.TextColor3 = Color3.new(1, 1, 1)
AutoKillBossBtn.Font = Enum.Font.SourceSansBold
AutoKillBossBtn.TextSize = 20
AutoKillBossBtn.Text = "Auto Kill Bosses"
table.insert(buttonsToToggle, AutoKillBossBtn)

local AutoKillBossPanel = Instance.new("ScrollingFrame", MainFrame)
AutoKillBossPanel.Size = UDim2.new(1, -20, 0, 110)  -- panel yüksekliği 110 px, istersen arttırabilirsin
AutoKillBossPanel.Position = UDim2.new(0, 10, 0, 335) -- butonun hemen altında
AutoKillBossPanel.Visible = false
AutoKillBossPanel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
AutoKillBossPanel.CanvasSize = UDim2.new(0, 0, 0, 2000)
AutoKillBossPanel.ScrollBarThickness = 6

AutoKillBossBtn.MouseButton1Click:Connect(function()
	AutoKillBossPanel.Visible = not AutoKillBossPanel.Visible
end)

local function bringBoss(spawnNames)
	local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local npcFolder = workspace:FindFirstChild("NPC")
	if not npcFolder then return end

	local offset = hrp.CFrame.RightVector * 20 + hrp.CFrame.LookVector * 20 + Vector3.new(0, 5, 0)
	local targetCFrame = CFrame.new(hrp.Position + offset)

	for _, name in ipairs(spawnNames) do
		local model = npcFolder:FindFirstChild(name)
		if model and model:IsA("Model") then
			for _, part in ipairs(model:GetDescendants()) do
				if part:IsA("BasePart") then
					part.Anchored = true
					part.CFrame = targetCFrame
				end
			end
		end
	end
end



local toggles = {}
local running = {}

local function createToggleButton(name, spawnNames, yPos)
	local btn = Instance.new("TextButton", AutoKillBossPanel)
	btn.Size = UDim2.new(1, -10, 0, 35)
	btn.Position = UDim2.new(0, 5, 0, yPos)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 18
	btn.Text = name .. ": OFF"

	toggles[name] = false

	btn.MouseButton1Click:Connect(function()
		toggles[name] = not toggles[name]
		btn.Text = name .. ": " .. (toggles[name] and "ON" or "OFF")

		if toggles[name] and not running[name] then
			running[name] = true
			task.spawn(function()
				while toggles[name] do
					bringBoss(spawnNames)
					task.wait(2.5)
				end
				running[name] = false
			end)
		end
	end)
end

createToggleButton("Auto Farm Boss 1", {
	"Demon_1_SpawnPart_1",
	"Demon_1_SpawnPart_2",
	"Angel_1_SpawnPart_1",
	"Angel_1_SpawnPart_2",
}, 0)

local y = 40
for i = 2, 15 do
	createToggleButton("Auto Farm Angel Boss "..i, {
		"Angel_"..i.."_SpawnPart_1",
		"Angel_"..i.."_SpawnPart_2"
	}, y)
	y += 40
	createToggleButton("Auto Farm Demon Boss "..i, {
		"Demon_"..i.."_SpawnPart_1",
		"Demon_"..i.."_SpawnPart_2"
	}, y)
	y += 40
end