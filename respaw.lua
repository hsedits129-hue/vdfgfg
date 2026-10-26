-- Respawn + Die TP GUI (Fica permanente)
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

local deathPos = nil

-- Função pra criar a GUI
local function createGui()
	-- Remove qualquer GUI antiga
	pcall(function()
		player.PlayerGui:FindFirstChild("RespawnGui"):Destroy()
	end)

	local gui = Instance.new("ScreenGui")
	gui.Name = "RespawnGui"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.Parent = player.PlayerGui

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 210, 0, 130)
	frame.Position = UDim2.new(0.5, -105, 0.75, 0)
	frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	frame.BorderSizePixel = 0
	frame.Parent = gui
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

	local respawnBtn = Instance.new("TextButton")
	respawnBtn.Size = UDim2.new(1, -20, 0, 40)
	respawnBtn.Position = UDim2.new(0, 10, 0, 10)
	respawnBtn.Text = "Respawn"
	respawnBtn.TextScaled = true
	respawnBtn.Font = Enum.Font.GothamBold
	respawnBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
	respawnBtn.TextColor3 = Color3.new(1, 1, 1)
	respawnBtn.Parent = frame
	Instance.new("UICorner", respawnBtn).CornerRadius = UDim.new(0, 6)

	local tpBtn = Instance.new("TextButton")
	tpBtn.Size = UDim2.new(1, -20, 0, 40)
	tpBtn.Position = UDim2.new(0, 10, 0, 58)
	tpBtn.Text = "Die TP"
	tpBtn.TextScaled = true
	tpBtn.Font = Enum.Font.GothamBold
	tpBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
	tpBtn.TextColor3 = Color3.new(1, 1, 1)
	tpBtn.Parent = frame
	Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 6)

	local credit = Instance.new("TextLabel")
	credit.Size = UDim2.new(1, 0, 0, 20)
	credit.Position = UDim2.new(0, 0, 1, -22)
	credit.BackgroundTransparency = 1
	credit.Text = "Credits: Datuna_YT"
	credit.TextScaled = true
	credit.TextColor3 = Color3.fromRGB(180, 180, 180)
	credit.Parent = frame

	-- Funções dos botões
	respawnBtn.MouseButton1Click:Connect(function()
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			deathPos = player.Character.HumanoidRootPart.CFrame
			player.Character:BreakJoints()
		end
	end)

	tpBtn.MouseButton1Click:Connect(function()
		if deathPos and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			player.Character.HumanoidRootPart.CFrame = deathPos
		end
	end)

	-- Arrastar a GUI
	local dragging = false
	local dragStart, startPos

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)

	UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
end

-- Cria a GUI
createGui()

-- Se a GUI sumir por algum motivo, recria automaticamente
player.CharacterAdded:Connect(function()
	task.wait(0.5)
	if not player.PlayerGui:FindFirstChild("RespawnGui") then
		createGui()
	end
end)
