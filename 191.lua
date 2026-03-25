local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- ========== AMBIL REMOTE EVENTS ==========
local remotes = ReplicatedStorage:FindFirstChild("RemoteEvents")
local storePurchaseRE = remotes and remotes:FindFirstChild("StorePurchase")

-- Konfigurasi ukuran HP
local GUI_WIDTH = 420
local GUI_HEIGHT = 520
local TAB_HEIGHT = 35
local TITLE_HEIGHT = 45

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.Name = "TP_Hub_191"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

-- Main Frame
local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0,GUI_WIDTH,0,GUI_HEIGHT)
Frame.Position = UDim2.new(0.5,-GUI_WIDTH/2,0.5,-GUI_HEIGHT/2)
Frame.BackgroundColor3 = Color3.fromRGB(25,25,35)
Frame.BackgroundTransparency = 0.1
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.ClipsDescendants = true

local Corner = Instance.new("UICorner")
Corner.Parent = Frame
Corner.CornerRadius = UDim.new(0,12)

local Stroke = Instance.new("UIStroke")
Stroke.Parent = Frame
Stroke.Color = Color3.fromRGB(45,45,55)
Stroke.Thickness = 1

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Parent = Frame
TitleBar.Size = UDim2.new(1,0,0,TITLE_HEIGHT)
TitleBar.BackgroundColor3 = Color3.fromRGB(35,35,45)
TitleBar.BorderSizePixel = 0

local TitleCorner = Instance.new("UICorner")
TitleCorner.Parent = TitleBar
TitleCorner.CornerRadius = UDim.new(0,12)

local Title = Instance.new("TextLabel")
Title.Parent = TitleBar
Title.Size = UDim2.new(1,-60,0,25)
Title.Position = UDim2.new(0,8,0,2)
Title.BackgroundTransparency = 1
Title.Text = "191 STORE"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

local BillboardText = Instance.new("TextLabel")
BillboardText.Parent = TitleBar
BillboardText.Size = UDim2.new(1,-60,0,18)
BillboardText.Position = UDim2.new(0,8,0,24)
BillboardText.BackgroundTransparency = 1
BillboardText.Text = "Discord.gg/h5CWN2sP4y"
BillboardText.TextColor3 = Color3.fromRGB(100,200,255)
BillboardText.TextXAlignment = Enum.TextXAlignment.Left
BillboardText.Font = Enum.Font.Gotham
BillboardText.TextSize = 9

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TitleBar
CloseBtn.Size = UDim2.new(0,28,0,28)
CloseBtn.Position = UDim2.new(1,-34,0,8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold

local CloseCorner = Instance.new("UICorner")
CloseCorner.Parent = CloseBtn
CloseCorner.CornerRadius = UDim.new(0,6)

local MinBtn = Instance.new("TextButton")
MinBtn.Parent = TitleBar
MinBtn.Size = UDim2.new(0,28,0,28)
MinBtn.Position = UDim2.new(1,-62,0,8)
MinBtn.BackgroundColor3 = Color3.fromRGB(60,60,70)
MinBtn.Text = "−"
MinBtn.TextColor3 = Color3.fromRGB(255,255,255)
MinBtn.TextSize = 16
MinBtn.Font = Enum.Font.GothamBold

local MinCorner = Instance.new("UICorner")
MinCorner.Parent = MinBtn
MinCorner.CornerRadius = UDim.new(0,6)

-- Billboard changer
local billboardMessages = {
    {text = "Discord.gg/h5CWN2sP4y", color = Color3.fromRGB(100,200,255)},
    {text = "Saran? ke dc ajaa", color = Color3.fromRGB(255,255,100)},
    {text = "Bug? lapor di dc", color = Color3.fromRGB(255,150,200)}
}
local currentBillboard = 1

task.spawn(function()
    while true do
        task.wait(60)
        currentBillboard = (currentBillboard % #billboardMessages) + 1
        BillboardText.Text = billboardMessages[currentBillboard].text
        BillboardText.TextColor3 = billboardMessages[currentBillboard].color
    end
end)

-- Tab Buttons
local TabFrame = Instance.new("Frame")
TabFrame.Parent = Frame
TabFrame.Size = UDim2.new(1,0,0,TAB_HEIGHT)
TabFrame.Position = UDim2.new(0,0,0,TITLE_HEIGHT)
TabFrame.BackgroundColor3 = Color3.fromRGB(30,30,40)
TabFrame.BorderSizePixel = 0

local TPTabBtn = Instance.new("TextButton")
TPTabBtn.Parent = TabFrame
TPTabBtn.Size = UDim2.new(0.33,-2,1,-4)
TPTabBtn.Position = UDim2.new(0,2,0,2)
TPTabBtn.BackgroundColor3 = Color3.fromRGB(50,50,60)
TPTabBtn.Text = "🚀 TP"
TPTabBtn.TextColor3 = Color3.fromRGB(255,255,255)
TPTabBtn.Font = Enum.Font.GothamBold
TPTabBtn.TextSize = 11

local MSLoopTabBtn = Instance.new("TextButton")
MSLoopTabBtn.Parent = TabFrame
MSLoopTabBtn.Size = UDim2.new(0.33,-2,1,-4)
MSLoopTabBtn.Position = UDim2.new(0.33,0,0,2)
MSLoopTabBtn.BackgroundColor3 = Color3.fromRGB(40,40,50)
MSLoopTabBtn.Text = "🔄 MS"
MSLoopTabBtn.TextColor3 = Color3.fromRGB(200,200,200)
MSLoopTabBtn.Font = Enum.Font.GothamBold
MSLoopTabBtn.TextSize = 11

local MSSafetyTabBtn = Instance.new("TextButton")
MSSafetyTabBtn.Parent = TabFrame
MSSafetyTabBtn.Size = UDim2.new(0.33,-2,1,-4)
MSSafetyTabBtn.Position = UDim2.new(0.66,0,0,2)
MSSafetyTabBtn.BackgroundColor3 = Color3.fromRGB(40,40,50)
MSSafetyTabBtn.Text = "🛡️ SAFE"
MSSafetyTabBtn.TextColor3 = Color3.fromRGB(200,200,200)
MSSafetyTabBtn.Font = Enum.Font.GothamBold
MSSafetyTabBtn.TextSize = 11

-- Content Container
local Content = Instance.new("Frame")
Content.Parent = Frame
Content.Size = UDim2.new(1,0,1,-(TITLE_HEIGHT + TAB_HEIGHT))
Content.Position = UDim2.new(0,0,0,TITLE_HEIGHT + TAB_HEIGHT)
Content.BackgroundColor3 = Color3.fromRGB(25,25,35)
Content.BorderSizePixel = 0
Content.BackgroundTransparency = 0.1

local ContentCorner = Instance.new("UICorner")
ContentCorner.Parent = Content
ContentCorner.CornerRadius = UDim.new(0,12)

-- TP Tab Content
local TPContent = Instance.new("ScrollingFrame")
TPContent.Parent = Content
TPContent.Size = UDim2.new(1,0,1,0)
TPContent.BackgroundTransparency = 1
TPContent.Visible = true
TPContent.ScrollBarThickness = 4
TPContent.CanvasSize = UDim2.new(0,0,0,520)

-- MS Loop Tab Content
local MSLoopContent = Instance.new("ScrollingFrame")
MSLoopContent.Parent = Content
MSLoopContent.Size = UDim2.new(1,0,1,0)
MSLoopContent.BackgroundTransparency = 1
MSLoopContent.Visible = false
MSLoopContent.ScrollBarThickness = 4
MSLoopContent.CanvasSize = UDim2.new(0,0,0,480)

-- MS SAFETY TAB CONTENT (BYPASS SPEED)
local MSSafetyContent = Instance.new("ScrollingFrame")
MSSafetyContent.Parent = Content
MSSafetyContent.Size = UDim2.new(1,0,1,0)
MSSafetyContent.BackgroundTransparency = 1
MSSafetyContent.Visible = false
MSSafetyContent.ScrollBarThickness = 4
MSSafetyContent.CanvasSize = UDim2.new(0,0,0,300)

-- ========== BYPASS SPEED LIMIT SERVER (BUKAN WALKSPEED) ==========
-- Fitur ini mencegah kendaraan ditarik kembali oleh server saat teleport

local BypassSpeed = {
    enabled = false,
    originalLinearVelocity = nil,
    originalAngularVelocity = nil,
    loopConnection = nil,
    vehicleConnection = nil
}

-- Fungsi untuk membekukan kendaraan saat teleport agar tidak ditarik server
local function freezeVehicle(vehicle)
    if not vehicle then return end
    
    for _, part in ipairs(vehicle:GetDescendants()) do
        if part:IsA("BasePart") then
            pcall(function()
                -- Simpan velocity asli jika belum disimpan
                if BypassSpeed.originalLinearVelocity == nil then
                    BypassSpeed.originalLinearVelocity = part.AssemblyLinearVelocity
                    BypassSpeed.originalAngularVelocity = part.AssemblyAngularVelocity
                end
                -- Set velocity ke 0 agar server tidak bisa menarik
                part.AssemblyLinearVelocity = Vector3.zero
                part.AssemblyAngularVelocity = Vector3.zero
                -- Anchored sebentar agar server tidak bisa mengubah posisi
                part.Anchored = true
            end)
        end
    end
end

-- Fungsi untuk mengembalikan kendaraan normal
local function unfreezeVehicle(vehicle)
    if not vehicle then return end
    
    for _, part in ipairs(vehicle:GetDescendants()) do
        if part:IsA("BasePart") then
            pcall(function()
                part.Anchored = false
                if BypassSpeed.originalLinearVelocity then
                    part.AssemblyLinearVelocity = BypassSpeed.originalLinearVelocity
                    part.AssemblyAngularVelocity = BypassSpeed.originalAngularVelocity
                end
            end)
        end
    end
end

-- Loop untuk menjaga kendaraan tetap bebas dari tarikan server
local function startBypassLoop()
    if BypassSpeed.loopConnection then
        BypassSpeed.loopConnection:Disconnect()
    end
    
    BypassSpeed.loopConnection = RunService.Heartbeat:Connect(function()
        if BypassSpeed.enabled then
            local character = player.Character
            if character then
                local hum = character:FindFirstChildOfClass("Humanoid")
                if hum and hum.SeatPart then
                    local vehicle = hum.SeatPart:FindFirstAncestorOfClass("Model")
                    if vehicle then
                        -- Terus reset velocity agar server tidak bisa menarik
                        for _, part in ipairs(vehicle:GetDescendants()) do
                            if part:IsA("BasePart") and not part.Anchored then
                                pcall(function()
                                    -- Jika kecepatan terlalu tinggi (ditarik server), reset
                                    if part.AssemblyLinearVelocity.Magnitude > 50 then
                                        part.AssemblyLinearVelocity = Vector3.zero
                                        part.AssemblyAngularVelocity = Vector3.zero
                                    end
                                end)
                            end
                        end
                    end
                end
            end
        end
    end)
end

-- Fungsi untuk mengaktifkan bypass speed
local function enableBypassSpeed()
    if BypassSpeed.enabled then return end
    BypassSpeed.enabled = true
    startBypassLoop()
    
    -- Handle saat naik kendaraan
    BypassSpeed.vehicleConnection = player.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        if BypassSpeed.enabled then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum:GetPropertyChangedSignal("SeatPart"):Connect(function()
                    if BypassSpeed.enabled and hum.SeatPart then
                        local vehicle = hum.SeatPart:FindFirstAncestorOfClass("Model")
                        if vehicle then
                            freezeVehicle(vehicle)
                            task.wait(0.1)
                            unfreezeVehicle(vehicle)
                        end
                    end
                end)
            end
        end
    end)
end

-- Fungsi untuk menonaktifkan bypass speed
local function disableBypassSpeed()
    BypassSpeed.enabled = false
    
    if BypassSpeed.loopConnection then
        BypassSpeed.loopConnection:Disconnect()
        BypassSpeed.loopConnection = nil
    end
    
    if BypassSpeed.vehicleConnection then
        BypassSpeed.vehicleConnection:Disconnect()
        BypassSpeed.vehicleConnection = nil
    end
    
    -- Reset semua kendaraan yang mungkin terpengaruh
    local character = player.Character
    if character then
        local hum = character:FindFirstChildOfClass("Humanoid")
        if hum and hum.SeatPart then
            local vehicle = hum.SeatPart:FindFirstAncestorOfClass("Model")
            if vehicle then
                for _, part in ipairs(vehicle:GetDescendants()) do
                    if part:IsA("BasePart") then
                        pcall(function()
                            part.Anchored = false
                        end)
                    end
                end
            end
        end
    end
end

-- ========== BYPASS SPEED UI DI TAB SAFE ==========
local BypassFrame = Instance.new("Frame")
BypassFrame.Parent = MSSafetyContent
BypassFrame.Size = UDim2.new(1,-16,0,160)
BypassFrame.Position = UDim2.new(0,8,0,20)
BypassFrame.BackgroundColor3 = Color3.fromRGB(35,35,45)
BypassFrame.BorderSizePixel = 0
local BypassFrameCorner = Instance.new("UICorner")
BypassFrameCorner.Parent = BypassFrame
BypassFrameCorner.CornerRadius = UDim.new(0,12)

local BypassIcon = Instance.new("TextLabel")
BypassIcon.Parent = BypassFrame
BypassIcon.Size = UDim2.new(0,60,1,0)
BypassIcon.Position = UDim2.new(0,12,0,0)
BypassIcon.BackgroundTransparency = 1
BypassIcon.Text = "⚡"
BypassIcon.TextSize = 48
BypassIcon.TextColor3 = Color3.fromRGB(255,200,50)
BypassIcon.Font = Enum.Font.GothamBold

local BypassTitle = Instance.new("TextLabel")
BypassTitle.Parent = BypassFrame
BypassTitle.Size = UDim2.new(1,-85,0,28)
BypassTitle.Position = UDim2.new(0,75,0,12)
BypassTitle.BackgroundTransparency = 1
BypassTitle.Text = "SPEED LIMIT BYPASS"
BypassTitle.TextColor3 = Color3.fromRGB(255,100,100)
BypassTitle.TextXAlignment = Enum.TextXAlignment.Left
BypassTitle.Font = Enum.Font.GothamBold
BypassTitle.TextSize = 14

local BypassDesc = Instance.new("TextLabel")
BypassDesc.Parent = BypassFrame
BypassDesc.Size = UDim2.new(1,-85,0,40)
BypassDesc.Position = UDim2.new(0,75,0,40)
BypassDesc.BackgroundTransparency = 1
BypassDesc.Text = "Mencegah kendaraan ditarik server\nsaat teleport / disconnect"
BypassDesc.TextColor3 = Color3.fromRGB(160,160,180)
BypassDesc.TextXAlignment = Enum.TextXAlignment.Left
BypassDesc.Font = Enum.Font.Gotham
BypassDesc.TextSize = 10

local BypassStatusLabel = Instance.new("TextLabel")
BypassStatusLabel.Parent = BypassFrame
BypassStatusLabel.Size = UDim2.new(0.3,0,0,28)
BypassStatusLabel.Position = UDim2.new(0,75,0,85)
BypassStatusLabel.BackgroundTransparency = 1
BypassStatusLabel.Text = "STATUS:"
BypassStatusLabel.TextColor3 = Color3.fromRGB(200,200,200)
BypassStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
BypassStatusLabel.Font = Enum.Font.GothamBold
BypassStatusLabel.TextSize = 12

local BypassStatusValue = Instance.new("TextLabel")
BypassStatusValue.Parent = BypassFrame
BypassStatusValue.Size = UDim2.new(0.5,0,0,28)
BypassStatusValue.Position = UDim2.new(0.35,0,0,85)
BypassStatusValue.BackgroundTransparency = 1
BypassStatusValue.Text = "❌ OFF"
BypassStatusValue.TextColor3 = Color3.fromRGB(255,100,100)
BypassStatusValue.TextXAlignment = Enum.TextXAlignment.Left
BypassStatusValue.Font = Enum.Font.GothamBold
BypassStatusValue.TextSize = 12

local BypassEnableBtn = Instance.new("TextButton")
BypassEnableBtn.Parent = BypassFrame
BypassEnableBtn.Size = UDim2.new(0.4,-12,0,38)
BypassEnableBtn.Position = UDim2.new(0,75,0,118)
BypassEnableBtn.BackgroundColor3 = Color3.fromRGB(50,150,50)
BypassEnableBtn.Text = "✅ ENABLE"
BypassEnableBtn.TextColor3 = Color3.fromRGB(255,255,255)
BypassEnableBtn.Font = Enum.Font.GothamBold
BypassEnableBtn.TextSize = 12
local BypassEnableCorner = Instance.new("UICorner")
BypassEnableCorner.Parent = BypassEnableBtn
BypassEnableCorner.CornerRadius = UDim.new(0,6)

local BypassDisableBtn = Instance.new("TextButton")
BypassDisableBtn.Parent = BypassFrame
BypassDisableBtn.Size = UDim2.new(0.4,-12,0,38)
BypassDisableBtn.Position = UDim2.new(0.5,12,0,118)
BypassDisableBtn.BackgroundColor3 = Color3.fromRGB(150,50,50)
BypassDisableBtn.Text = "❌ DISABLE"
BypassDisableBtn.TextColor3 = Color3.fromRGB(255,255,255)
BypassDisableBtn.Font = Enum.Font.GothamBold
BypassDisableBtn.TextSize = 12
local BypassDisableCorner = Instance.new("UICorner")
BypassDisableCorner.Parent = BypassDisableBtn
BypassDisableCorner.CornerRadius = UDim.new(0,6)

BypassEnableBtn.MouseButton1Click:Connect(function()
    enableBypassSpeed()
    BypassStatusValue.Text = "✅ ON"
    BypassStatusValue.TextColor3 = Color3.fromRGB(100,255,100)
    BypassEnableBtn.BackgroundColor3 = Color3.fromRGB(80,180,80)
end)

BypassDisableBtn.MouseButton1Click:Connect(function()
    disableBypassSpeed()
    BypassStatusValue.Text = "❌ OFF"
    BypassStatusValue.TextColor3 = Color3.fromRGB(255,100,100)
    BypassEnableBtn.BackgroundColor3 = Color3.fromRGB(50,150,50)
end)

-- Info tambahan
local InfoFrame = Instance.new("Frame")
InfoFrame.Parent = MSSafetyContent
InfoFrame.Size = UDim2.new(1,-16,0,80)
InfoFrame.Position = UDim2.new(0,8,0,190)
InfoFrame.BackgroundColor3 = Color3.fromRGB(30,30,40)
InfoFrame.BorderSizePixel = 0
local InfoFrameCorner = Instance.new("UICorner")
InfoFrameCorner.Parent = InfoFrame
InfoFrameCorner.CornerRadius = UDim.new(0,8)

local InfoText = Instance.new("TextLabel")
InfoText.Parent = InfoFrame
InfoText.Size = UDim2.new(1,-16,1,0)
InfoText.Position = UDim2.new(0,8,0,8)
InfoText.BackgroundTransparency = 1
InfoText.Text = "⚠️ FITUR INI BERGUNA UNTUK:\n• Mencegah kendaraan tertarik server saat teleport\n• Mencegah kendaraan hilang saat disconnect\n• Bypass speed limit server (bukan walkspeed karakter)\n• Aktifkan SEBELUM teleport atau naik kendaraan"
InfoText.TextColor3 = Color3.fromRGB(200,200,100)
InfoText.TextXAlignment = Enum.TextXAlignment.Left
InfoText.TextYAlignment = Enum.TextYAlignment.Top
InfoText.Font = Enum.Font.Gotham
InfoText.TextSize = 10

-- ========== SEMUA LOKASI TELEPORT ==========
local LOCATIONS = {
    {name = "🏪 Dealer NPC",      pos = Vector3.new(770.992, 3.71, 433.75), desc = "Dealer Mobil"},
    {name = "🍬 NPC Marshmallow", pos = Vector3.new(510.061, 4.476, 600.548), desc = "Tempat Jual/Beli MS"},
    {name = "🏠 Apart 1",         pos = Vector3.new(1137.992, 9.932, 449.753), desc = "Apartemen 1"},
    {name = "🏠 Apart 2",         pos = Vector3.new(1139.174, 9.932, 420.556), desc = "Apartemen 2"},
    {name = "🏠 Apart 3",         pos = Vector3.new(984.856, 9.932, 247.280), desc = "Apartemen 3"},
    {name = "🏠 Apart 4",         pos = Vector3.new(988.311, 9.932, 221.664), desc = "Apartemen 4"},
    {name = "🏠 Apart 5",         pos = Vector3.new(923.954, 9.932, 42.202), desc = "Apartemen 5"},
    {name = "🏠 Apart 6",         pos = Vector3.new(895.721, 9.932, 41.928), desc = "Apartemen 6"},
    {name = "🎰 Casino",          pos = Vector3.new(1166.33, 3.36, -29.77), desc = "Casino"},
    {name = "🏥 Hospital",        pos = Vector3.new(1065.19, 28.47, 420.76), desc = "Rumah Sakit"},
    {name = "⚒️ Material Storage", pos = Vector3.new(521.32, 47.79, 617.25), desc = "Tempat Bahan"},
}

-- ========== TP FUNCTION DENGAN BYPASS INTEGRASI ==========
local function moveVehicle(vehicle, targetPos)
    local anchor = vehicle.PrimaryPart
        or vehicle:FindFirstChildOfClass("VehicleSeat")
        or vehicle:FindFirstChildOfClass("BasePart")
    if not anchor then return end
    
    local spawnPos = targetPos + Vector3.new(0,0.5,0)
    local newCF = CFrame.new(spawnPos, spawnPos + Vector3.new(0,0,1))
    
    -- FREEZE dengan bypass jika aktif
    for _,p in ipairs(vehicle:GetDescendants()) do
        if p:IsA("BasePart") then
            pcall(function()
                p.AssemblyLinearVelocity  = Vector3.zero
                p.AssemblyAngularVelocity = Vector3.zero
                p.Anchored = true
            end)
        end
    end
    task.wait(0.05)
    
    -- Pindahkan
    if vehicle.PrimaryPart then
        vehicle:SetPrimaryPartCFrame(newCF)
    else
        anchor.CFrame = newCF
    end
    task.wait(0.05)
    
    -- UNFREEZE
    for _,p in ipairs(vehicle:GetDescendants()) do
        if p:IsA("BasePart") then
            pcall(function()
                p.Anchored = false
                p.AssemblyLinearVelocity  = Vector3.zero
                p.AssemblyAngularVelocity = Vector3.zero
            end)
        end
    end
end

local function stepTeleport(targetPos)
    local character = player.Character
    local hum = character and character:FindFirstChildOfClass("Humanoid")
    if not character or not hum then return end
    
    local seatPart = hum.SeatPart
    if seatPart then
        local vehicle = seatPart:FindFirstAncestorOfClass("Model")
        if vehicle then
            moveVehicle(vehicle, targetPos)
        end
    else
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(targetPos)
        end
    end
end

-- Buat semua button TP
local tpLayout = Instance.new("UIListLayout")
tpLayout.Parent = TPContent
tpLayout.Padding = UDim.new(0, 6)
tpLayout.SortOrder = Enum.SortOrder.LayoutOrder

local tpPadding = Instance.new("UIPadding")
tpPadding.Parent = TPContent
tpPadding.PaddingLeft = UDim.new(0, 8)
tpPadding.PaddingRight = UDim.new(0, 8)
tpPadding.PaddingTop = UDim.new(0, 6)

for i, loc in ipairs(LOCATIONS) do
    local btn = Instance.new("TextButton")
    btn.Parent = TPContent
    btn.Size = UDim2.new(1, 0, 0, 55)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.Text = ""
    btn.BorderSizePixel = 0
    btn.LayoutOrder = i
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.Parent = btn
    btnCorner.CornerRadius = UDim.new(0, 8)
    
    local icon = Instance.new("TextLabel")
    icon.Parent = btn
    icon.Size = UDim2.new(0, 45, 1, 0)
    icon.Position = UDim2.new(0, 8, 0, 0)
    icon.BackgroundTransparency = 1
    icon.Text = loc.name:sub(1, 2)
    icon.TextSize = 26
    icon.Font = Enum.Font.GothamBold
    
    local title = Instance.new("TextLabel")
    title.Parent = btn
    title.Size = UDim2.new(1, -70, 0, 22)
    title.Position = UDim2.new(0, 55, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = loc.name
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Font = Enum.Font.GothamBold
    title.TextSize = 13
    
    local desc = Instance.new("TextLabel")
    desc.Parent = btn
    desc.Size = UDim2.new(1, -70, 0, 18)
    desc.Position = UDim2.new(0, 55, 0, 30)
    desc.BackgroundTransparency = 1
    desc.Text = loc.desc
    desc.TextColor3 = Color3.fromRGB(160, 160, 180)
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 10
    
    btn.MouseButton1Click:Connect(function()
        stepTeleport(loc.pos)
    end)
end

-- ========== MS LOOP CONTENT (SEDERHANA) ==========
local MSLoopTitle = Instance.new("TextLabel")
MSLoopTitle.Parent = MSLoopContent
MSLoopTitle.Size = UDim2.new(1,-16,0,28)
MSLoopTitle.Position = UDim2.new(0,8,0,10)
MSLoopTitle.BackgroundTransparency = 1
MSLoopTitle.Text = "🔄 MS LOOP (AUTO TOOLS)"
MSLoopTitle.TextColor3 = Color3.fromRGB(100,255,100)
MSLoopTitle.TextXAlignment = Enum.TextXAlignment.Left
MSLoopTitle.Font = Enum.Font.GothamBold
MSLoopTitle.TextSize = 14

local MSLoopStatus = Instance.new("TextLabel")
MSLoopStatus.Parent = MSLoopContent
MSLoopStatus.Size = UDim2.new(1,-16,0,40)
MSLoopStatus.Position = UDim2.new(0,8,0,45)
MSLoopStatus.BackgroundColor3 = Color3.fromRGB(40,40,50)
MSLoopStatus.Text = "⏹️ LOOP STOPPED"
MSLoopStatus.TextColor3 = Color3.fromRGB(255,100,100)
MSLoopStatus.Font = Enum.Font.GothamBold
MSLoopStatus.TextSize = 12
local MSLoopStatusCorner = Instance.new("UICorner")
MSLoopStatusCorner.Parent = MSLoopStatus
MSLoopStatusCorner.CornerRadius = UDim.new(0,6)

local MSLoopStartBtn = Instance.new("TextButton")
MSLoopStartBtn.Parent = MSLoopContent
MSLoopStartBtn.Size = UDim2.new(0.5,-8,0,40)
MSLoopStartBtn.Position = UDim2.new(0,8,0,100)
MSLoopStartBtn.BackgroundColor3 = Color3.fromRGB(50,150,50)
MSLoopStartBtn.Text = "▶️ START LOOP"
MSLoopStartBtn.TextColor3 = Color3.fromRGB(255,255,255)
MSLoopStartBtn.Font = Enum.Font.GothamBold
MSLoopStartBtn.TextSize = 12
local MSLoopStartCorner = Instance.new("UICorner")
MSLoopStartCorner.Parent = MSLoopStartBtn
MSLoopStartCorner.CornerRadius = UDim.new(0,6)

local MSLoopStopBtn = Instance.new("TextButton")
MSLoopStopBtn.Parent = MSLoopContent
MSLoopStopBtn.Size = UDim2.new(0.5,-8,0,40)
MSLoopStopBtn.Position = UDim2.new(0.5,4,0,100)
MSLoopStopBtn.BackgroundColor3 = Color3.fromRGB(150,50,50)
MSLoopStopBtn.Text = "⏹️ STOP LOOP"
MSLoopStopBtn.TextColor3 = Color3.fromRGB(255,255,255)
MSLoopStopBtn.Font = Enum.Font.GothamBold
MSLoopStopBtn.TextSize = 12
local MSLoopStopCorner = Instance.new("UICorner")
MSLoopStopCorner.Parent = MSLoopStopBtn
MSLoopStopCorner.CornerRadius = UDim.new(0,6)

-- Simple MS Loop Functions
local loopRunning = false

local function findTool(toolName)
    if player.Character then
        for _, child in pairs(player.Character:GetChildren()) do
            if child:IsA("Tool") and string.find(string.lower(child.Name), string.lower(toolName)) then
                return child
            end
        end
    end
    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        for _, child in pairs(backpack:GetChildren()) do
            if child:IsA("Tool") and string.find(string.lower(child.Name), string.lower(toolName)) then
                return child
            end
        end
    end
    return nil
end

local function equipTool(tool)
    if not tool or not player.Character then return false end
    if tool.Parent == player.Character then return true end
    if tool.Parent == player:FindFirstChild("Backpack") then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid:EquipTool(tool)
            task.wait(0.2)
            return tool.Parent == player.Character
        end
    end
    return false
end

local function pressE()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.1)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end

local function startMSLoop()
    if loopRunning then return end
    loopRunning = true
    MSLoopStatus.Text = "▶️ LOOP RUNNING"
    MSLoopStatus.TextColor3 = Color3.fromRGB(100,255,100)
    
    task.spawn(function()
        while loopRunning do
            local waterTool = findTool("water")
            if waterTool and equipTool(waterTool) then
                MSLoopStatus.Text = "🔧 WATER - 20s"
                pressE()
                task.wait(20)
            else
                break
            end
            
            task.wait(2)
            if not loopRunning then break end
            
            local sugarTool = findTool("sugar")
            if sugarTool and equipTool(sugarTool) then
                MSLoopStatus.Text = "🔧 SUGAR - 2s"
                pressE()
                task.wait(2)
            else
                break
            end
            
            task.wait(1)
            if not loopRunning then break end
            
            local gelatinTool = findTool("gelatin")
            if gelatinTool and equipTool(gelatinTool) then
                MSLoopStatus.Text = "🔧 GELATIN - 45s"
                pressE()
                task.wait(45)
            else
                break
            end
            
            task.wait(2)
            if not loopRunning then break end
            
            local emptyTool = findTool("empty") or findTool("bag")
            if emptyTool and equipTool(emptyTool) then
                MSLoopStatus.Text = "🔧 EMPTY BAG - 2s"
                pressE()
                task.wait(2)
            end
        end
        
        loopRunning = false
        MSLoopStatus.Text = "⏹️ LOOP STOPPED"
        MSLoopStatus.TextColor3 = Color3.fromRGB(255,100,100)
    end)
end

MSLoopStartBtn.MouseButton1Click:Connect(function()
    if not loopRunning then task.spawn(startMSLoop) end
end)
MSLoopStopBtn.MouseButton1Click:Connect(function() loopRunning = false end)

-- ========== CONNECT BUTTONS ==========
CloseBtn.MouseButton1Click:Connect(function()
    if loopRunning then loopRunning = false end
    disableBypassSpeed()
    ScreenGui:Destroy()
end)

-- Tab Switching
TPTabBtn.MouseButton1Click:Connect(function()
    TPContent.Visible = true
    MSLoopContent.Visible = false
    MSSafetyContent.Visible = false
    
    TPTabBtn.BackgroundColor3 = Color3.fromRGB(50,50,60)
    MSLoopTabBtn.BackgroundColor3 = Color3.fromRGB(40,40,50)
    MSSafetyTabBtn.BackgroundColor3 = Color3.fromRGB(40,40,50)
    
    TPTabBtn.TextColor3 = Color3.fromRGB(255,255,255)
    MSLoopTabBtn.TextColor3 = Color3.fromRGB(200,200,200)
    MSSafetyTabBtn.TextColor3 = Color3.fromRGB(200,200,200)
end)

MSLoopTabBtn.MouseButton1Click:Connect(function()
    TPContent.Visible = false
    MSLoopContent.Visible = true
    MSSafetyContent.Visible = false
    
    TPTabBtn.BackgroundColor3 = Color3.fromRGB(40,40,50)
    MSLoopTabBtn.BackgroundColor3 = Color3.fromRGB(50,50,60)
    MSSafetyTabBtn.BackgroundColor3 = Color3.fromRGB(40,40,50)
    
    TPTabBtn.TextColor3 = Color3.fromRGB(200,200,200)
    MSLoopTabBtn.TextColor3 = Color3.fromRGB(255,255,255)
    MSSafetyTabBtn.TextColor3 = Color3.fromRGB(200,200,200)
end)

MSSafetyTabBtn.MouseButton1Click:Connect(function()
    TPContent.Visible = false
    MSLoopContent.Visible = false
    MSSafetyContent.Visible = true
    
    TPTabBtn.BackgroundColor3 = Color3.fromRGB(40,40,50)
    MSLoopTabBtn.BackgroundColor3 = Color3.fromRGB(40,40,50)
    MSSafetyTabBtn.BackgroundColor3 = Color3.fromRGB(50,50,60)
    
    TPTabBtn.TextColor3 = Color3.fromRGB(200,200,200)
    MSLoopTabBtn.TextColor3 = Color3.fromRGB(200,200,200)
    MSSafetyTabBtn.TextColor3 = Color3.fromRGB(255,255,255)
end)

-- Minimize
local minimized = false
local openSize = UDim2.new(0,GUI_WIDTH,0,GUI_HEIGHT)
local closedSize = UDim2.new(0,GUI_WIDTH,0,TITLE_HEIGHT + 4)
local tweenInfo = TweenInfo.new(0.3)

MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        TPContent.Visible = false
        MSLoopContent.Visible = false
        MSSafetyContent.Visible = false
        TabFrame.Visible = false
        MinBtn.Text = "□"
        TweenService:Create(Frame, tweenInfo, {Size = closedSize}):Play()
    else
        TweenService:Create(Frame, tweenInfo, {Size = openSize}):Play()
        task.wait(0.3)
        TPContent.Visible = true
        TabFrame.Visible = true
        MinBtn.Text = "−"
    end
end)

UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.Z then
        minimized = not minimized
        if minimized then
            TPContent.Visible = false
            MSLoopContent.Visible = false
            MSSafetyContent.Visible = false
            TabFrame.Visible = false
            MinBtn.Text = "□"
            TweenService:Create(Frame, tweenInfo, {Size = closedSize}):Play()
        else
            TweenService:Create(Frame, tweenInfo, {Size = openSize}):Play()
            task.wait(0.3)
            TPContent.Visible = true
            TabFrame.Visible = true
            MinBtn.Text = "−"
        end
    end
end)

-- Initial Animation
Frame.Size = UDim2.new(0,0,0,0)
task.wait(0.1)
TweenService:Create(Frame, tweenInfo, {Size = openSize}):Play()
