local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- ========== KONFIGURASI ==========
local GUI_WIDTH = 420
local GUI_HEIGHT = 480
local TAB_HEIGHT = 35
local TITLE_HEIGHT = 45

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.Name = "BypassHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0,GUI_WIDTH,0,GUI_HEIGHT)
Frame.Position = UDim2.new(0.5,-GUI_WIDTH/2,0.5,-GUI_HEIGHT/2)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,30)
Frame.BackgroundTransparency = 0.1
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local Corner = Instance.new("UICorner")
Corner.Parent = Frame
Corner.CornerRadius = UDim.new(0,12)

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Parent = Frame
TitleBar.Size = UDim2.new(1,0,0,TITLE_HEIGHT)
TitleBar.BackgroundColor3 = Color3.fromRGB(30,30,40)
TitleBar.BorderSizePixel = 0

local TitleCorner = Instance.new("UICorner")
TitleCorner.Parent = TitleBar
TitleCorner.CornerRadius = UDim.new(0,12)

local Title = Instance.new("TextLabel")
Title.Parent = TitleBar
Title.Size = UDim2.new(1,-60,0,25)
Title.Position = UDim2.new(0,8,0,2)
Title.BackgroundTransparency = 1
Title.Text = "SPEED BYPASS"
Title.TextColor3 = Color3.fromRGB(255,100,100)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

local SubTitle = Instance.new("TextLabel")
SubTitle.Parent = TitleBar
SubTitle.Size = UDim2.new(1,-60,0,18)
SubTitle.Position = UDim2.new(0,8,0,24)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Anti Tarik Server / Anti Snap"
SubTitle.TextColor3 = Color3.fromRGB(150,150,200)
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 9

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

-- Content
local Content = Instance.new("Frame")
Content.Parent = Frame
Content.Size = UDim2.new(1,0,1,-TITLE_HEIGHT)
Content.Position = UDim2.new(0,0,0,TITLE_HEIGHT)
Content.BackgroundColor3 = Color3.fromRGB(25,25,35)
Content.BorderSizePixel = 0

local ContentCorner = Instance.new("UICorner")
ContentCorner.Parent = Content
ContentCorner.CornerRadius = UDim.new(0,12)

-- ========== BYPASS SPEED LIMIT SERVER - METODE BARU ==========
-- Metode: Transfer Network Ownership + Force Anchor + Anti-Server-Snap

local Bypass = {
    enabled = false,
    activeVehicle = nil,
    heartbeatConnection = nil,
    renderConnection = nil,
    lastPosition = nil,
    lastCFrame = nil
}

-- Fungsi untuk mendapatkan kendaraan yang sedang dikendarai
local function getCurrentVehicle()
    local char = player.Character
    if not char then return nil end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum and hum.SeatPart then
        return hum.SeatPart:FindFirstAncestorOfClass("Model")
    end
    return nil
end

-- Fungsi untuk mengambil alih Network Ownership (biar server ga bisa kontrol)
local function takeNetworkOwnership(vehicle)
    if not vehicle then return end
    for _, part in ipairs(vehicle:GetDescendants()) do
        if part:IsA("BasePart") then
            pcall(function()
                -- Set Network Ownership ke client
                game:GetService("NetworkClient"):SetOwnership(part, Enum.PartOwnership.Manual)
                -- Reset velocity
                part.AssemblyLinearVelocity = Vector3.zero
                part.AssemblyAngularVelocity = Vector3.zero
            end)
        end
    end
end

-- Fungsi untuk memaksa kendaraan tetap di posisi (anti snap)
local function forceVehiclePosition(vehicle)
    if not vehicle or not Bypass.enabled then return end
    
    local char = player.Character
    if not char then return end
    
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or not hum.SeatPart then return end
    
    -- Ambil posisi yang diinginkan (posisi player saat ini)
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local targetCF = hrp.CFrame
    
    -- Pindahkan kendaraan ke posisi player
    if vehicle.PrimaryPart then
        vehicle:SetPrimaryPartCFrame(targetCF)
    else
        local seat = hum.SeatPart
        if seat then
            seat.CFrame = targetCF
        end
    end
    
    -- Freeze semua part sebentar
    for _, part in ipairs(vehicle:GetDescendants()) do
        if part:IsA("BasePart") then
            pcall(function()
                part.AssemblyLinearVelocity = Vector3.zero
                part.AssemblyAngularVelocity = Vector3.zero
            end)
        end
    end
end

-- Loop utama untuk mempertahankan kontrol
local function startBypass()
    if Bypass.heartbeatConnection then
        Bypass.heartbeatConnection:Disconnect()
    end
    if Bypass.renderConnection then
        Bypass.renderConnection:Disconnect()
    end
    
    -- Heartbeat: terus reset velocity dan ambil alih ownership
    Bypass.heartbeatConnection = RunService.Heartbeat:Connect(function()
        if not Bypass.enabled then return end
        
        local vehicle = getCurrentVehicle()
        if vehicle then
            Bypass.activeVehicle = vehicle
            
            -- Ambil alih ownership setiap saat
            for _, part in ipairs(vehicle:GetDescendants()) do
                if part:IsA("BasePart") then
                    pcall(function()
                        if part:GetNetworkOwner() ~= player then
                            game:GetService("NetworkClient"):SetOwnership(part, Enum.PartOwnership.Manual)
                        end
                        -- Reset velocity terus menerus
                        part.AssemblyLinearVelocity = Vector3.zero
                        part.AssemblyAngularVelocity = Vector3.zero
                    end)
                end
            end
        end
    end)
    
    -- RenderStepped: force posisi kendaraan agar tidak di-snap server
    Bypass.renderConnection = RunService.RenderStepped:Connect(function()
        if not Bypass.enabled then return end
        
        local vehicle = getCurrentVehicle()
        if not vehicle then 
            Bypass.activeVehicle = nil
            return 
        end
        
        local char = player.Character
        if not char then return end
        
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        -- Setiap frame, paksa kendaraan mengikuti posisi player
        local targetCF = hrp.CFrame
        
        if vehicle.PrimaryPart then
            local currentPos = vehicle.PrimaryPart.Position
            local targetPos = targetCF.Position
            local distance = (currentPos - targetPos).Magnitude
            
            -- Jika kendaraan mulai menjauh (disnap server), langsung paksa balik
            if distance > 5 then
                vehicle:SetPrimaryPartCFrame(targetCF)
                for _, part in ipairs(vehicle:GetDescendants()) do
                    if part:IsA("BasePart") then
                        pcall(function()
                            part.AssemblyLinearVelocity = Vector3.zero
                            part.AssemblyAngularVelocity = Vector3.zero
                        end)
                    end
                end
            end
        end
    end)
end

-- Fungsi untuk mengaktifkan bypass
local function enableBypass()
    if Bypass.enabled then return end
    Bypass.enabled = true
    startBypass()
    
    -- Handle saat naik kendaraan
    player.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        if Bypass.enabled then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum:GetPropertyChangedSignal("SeatPart"):Connect(function()
                    if Bypass.enabled and hum.SeatPart then
                        local vehicle = hum.SeatPart:FindFirstAncestorOfClass("Model")
                        if vehicle then
                            task.wait(0.1)
                            takeNetworkOwnership(vehicle)
                        end
                    end
                end)
            end
        end
    end)
    
    -- Langsung ambil kendaraan saat ini
    task.wait(0.5)
    local vehicle = getCurrentVehicle()
    if vehicle then
        takeNetworkOwnership(vehicle)
    end
end

-- Fungsi untuk menonaktifkan bypass
local function disableBypass()
    Bypass.enabled = false
    
    if Bypass.heartbeatConnection then
        Bypass.heartbeatConnection:Disconnect()
        Bypass.heartbeatConnection = nil
    end
    if Bypass.renderConnection then
        Bypass.renderConnection:Disconnect()
        Bypass.renderConnection = nil
    end
    
    Bypass.activeVehicle = nil
end

-- ========== UI BYPASS ==========
local MainFrame = Instance.new("Frame")
MainFrame.Parent = Content
MainFrame.Size = UDim2.new(1,-20,1,-20)
MainFrame.Position = UDim2.new(0,10,0,10)
MainFrame.BackgroundColor3 = Color3.fromRGB(30,30,40)
MainFrame.BorderSizePixel = 0
local MainCorner = Instance.new("UICorner")
MainCorner.Parent = MainFrame
MainCorner.CornerRadius = UDim.new(0,12)

-- Icon besar
local IconLabel = Instance.new("TextLabel")
IconLabel.Parent = MainFrame
IconLabel.Size = UDim2.new(0,80,0,80)
IconLabel.Position = UDim2.new(0.5,-40,0,25)
IconLabel.BackgroundTransparency = 1
IconLabel.Text = "⚡"
IconLabel.TextSize = 64
IconLabel.TextColor3 = Color3.fromRGB(255,150,50)
IconLabel.Font = Enum.Font.GothamBold

-- Title
local BypassTitle = Instance.new("TextLabel")
BypassTitle.Parent = MainFrame
BypassTitle.Size = UDim2.new(1,-40,0,30)
BypassTitle.Position = UDim2.new(0,20,0,110)
BypassTitle.BackgroundTransparency = 1
BypassTitle.Text = "SPEED LIMIT BYPASS"
BypassTitle.TextColor3 = Color3.fromRGB(255,100,100)
BypassTitle.TextXAlignment = Enum.TextXAlignment.Center
BypassTitle.Font = Enum.Font.GothamBold
BypassTitle.TextSize = 18

-- Description
local DescLabel = Instance.new("TextLabel")
DescLabel.Parent = MainFrame
DescLabel.Size = UDim2.new(1,-40,0,50)
DescLabel.Position = UDim2.new(0,20,0,145)
DescLabel.BackgroundTransparency = 1
DescLabel.Text = "Mencegah kendaraan ditarik server saat teleport\nMencegah kendaraan hilang saat disconnect\nAktifkan SEBELUM naik kendaraan / teleport"
DescLabel.TextColor3 = Color3.fromRGB(150,150,180)
DescLabel.TextXAlignment = Enum.TextXAlignment.Center
DescLabel.Font = Enum.Font.Gotham
DescLabel.TextSize = 11

-- Status Frame
local StatusFrame = Instance.new("Frame")
StatusFrame.Parent = MainFrame
StatusFrame.Size = UDim2.new(0.8,0,0,60)
StatusFrame.Position = UDim2.new(0.1,0,0,210)
StatusFrame.BackgroundColor3 = Color3.fromRGB(40,40,50)
StatusFrame.BorderSizePixel = 0
local StatusCorner = Instance.new("UICorner")
StatusCorner.Parent = StatusFrame
StatusCorner.CornerRadius = UDim.new(0,8)

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = StatusFrame
StatusLabel.Size = UDim2.new(0.4,0,1,0)
StatusLabel.Position = UDim2.new(0,15,0,0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "STATUS:"
StatusLabel.TextColor3 = Color3.fromRGB(200,200,200)
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextSize = 16

local StatusValue = Instance.new("TextLabel")
StatusValue.Parent = StatusFrame
StatusValue.Size = UDim2.new(0.5,0,1,0)
StatusValue.Position = UDim2.new(0.45,0,0,0)
StatusValue.BackgroundTransparency = 1
StatusValue.Text = "❌ OFF"
StatusValue.TextColor3 = Color3.fromRGB(255,100,100)
StatusValue.TextXAlignment = Enum.TextXAlignment.Left
StatusValue.Font = Enum.Font.GothamBold
StatusValue.TextSize = 16

-- Button Frame
local ButtonFrame = Instance.new("Frame")
ButtonFrame.Parent = MainFrame
ButtonFrame.Size = UDim2.new(0.8,0,0,50)
ButtonFrame.Position = UDim2.new(0.1,0,0,285)
ButtonFrame.BackgroundTransparency = 1

local EnableBtn = Instance.new("TextButton")
EnableBtn.Parent = ButtonFrame
EnableBtn.Size = UDim2.new(0.45,-10,1,0)
EnableBtn.Position = UDim2.new(0,0,0,0)
EnableBtn.BackgroundColor3 = Color3.fromRGB(50,150,50)
EnableBtn.Text = "✅ ENABLE"
EnableBtn.TextColor3 = Color3.fromRGB(255,255,255)
EnableBtn.Font = Enum.Font.GothamBold
EnableBtn.TextSize = 14
local EnableCorner = Instance.new("UICorner")
EnableCorner.Parent = EnableBtn
EnableCorner.CornerRadius = UDim.new(0,8)

local DisableBtn = Instance.new("TextButton")
DisableBtn.Parent = ButtonFrame
DisableBtn.Size = UDim2.new(0.45,-10,1,0)
DisableBtn.Position = UDim2.new(0.55,0,0,0)
DisableBtn.BackgroundColor3 = Color3.fromRGB(150,50,50)
DisableBtn.Text = "❌ DISABLE"
DisableBtn.TextColor3 = Color3.fromRGB(255,255,255)
DisableBtn.Font = Enum.Font.GothamBold
DisableBtn.TextSize = 14
local DisableCorner = Instance.new("UICorner")
DisableCorner.Parent = DisableBtn
DisableCorner.CornerRadius = UDim.new(0,8)

-- Info tambahan
local InfoFrame = Instance.new("Frame")
InfoFrame.Parent = MainFrame
InfoFrame.Size = UDim2.new(0.9,0,0,60)
InfoFrame.Position = UDim2.new(0.05,0,0,350)
InfoFrame.BackgroundColor3 = Color3.fromRGB(35,35,45)
InfoFrame.BorderSizePixel = 0
local InfoCorner = Instance.new("UICorner")
InfoCorner.Parent = InfoFrame
InfoCorner.CornerRadius = UDim.new(0,8)

local InfoText = Instance.new("TextLabel")
InfoText.Parent = InfoFrame
InfoText.Size = UDim2.new(1,-20,1,0)
InfoText.Position = UDim2.new(0,10,0,5)
InfoText.BackgroundTransparency = 1
InfoText.Text = "⚠️ CARA PAKAI:\n1. Aktifkan ENABLE SEBELUM naik kendaraan\n2. Naik kendaraan\n3. Teleport kemana saja - kendaraan tidak akan tertarik server"
InfoText.TextColor3 = Color3.fromRGB(255,200,100)
InfoText.TextXAlignment = Enum.TextXAlignment.Left
InfoText.TextYAlignment = Enum.TextYAlignment.Top
InfoText.Font = Enum.Font.Gotham
InfoText.TextSize = 10

-- Vehicle Status
local VehicleStatus = Instance.new("TextLabel")
VehicleStatus.Parent = MainFrame
VehicleStatus.Size = UDim2.new(0.9,0,0,25)
VehicleStatus.Position = UDim2.new(0.05,0,0,420)
VehicleStatus.BackgroundTransparency = 1
VehicleStatus.Text = "🚗 Kendaraan: -"
VehicleStatus.TextColor3 = Color3.fromRGB(150,150,200)
VehicleStatus.TextXAlignment = Enum.TextXAlignment.Center
VehicleStatus.Font = Enum.Font.Gotham
VehicleStatus.TextSize = 11

-- Update vehicle status
task.spawn(function()
    while true do
        task.wait(1)
        if Bypass.enabled then
            local vehicle = getCurrentVehicle()
            if vehicle then
                VehicleStatus.Text = "🚗 Kendaraan: TERDETEKSI (Bypass Aktif)"
                VehicleStatus.TextColor3 = Color3.fromRGB(100,255,100)
            else
                VehicleStatus.Text = "🚗 Kendaraan: TIDAK ADA"
                VehicleStatus.TextColor3 = Color3.fromRGB(150,150,200)
            end
        else
            VehicleStatus.Text = "🚗 Bypass: NONAKTIF"
            VehicleStatus.TextColor3 = Color3.fromRGB(200,100,100)
        end
    end
end)

-- Button actions
EnableBtn.MouseButton1Click:Connect(function()
    enableBypass()
    StatusValue.Text = "✅ ON"
    StatusValue.TextColor3 = Color3.fromRGB(100,255,100)
    EnableBtn.BackgroundColor3 = Color3.fromRGB(80,180,80)
    DisableBtn.BackgroundColor3 = Color3.fromRGB(150,50,50)
end)

DisableBtn.MouseButton1Click:Connect(function()
    disableBypass()
    StatusValue.Text = "❌ OFF"
    StatusValue.TextColor3 = Color3.fromRGB(255,100,100)
    EnableBtn.BackgroundColor3 = Color3.fromRGB(50,150,50)
    DisableBtn.BackgroundColor3 = Color3.fromRGB(150,50,50)
end)

CloseBtn.MouseButton1Click:Connect(function()
    disableBypass()
    ScreenGui:Destroy()
end)

-- Animasi awal
Frame.Size = UDim2.new(0,0,0,0)
task.wait(0.1)
TweenService:Create(Frame, TweenInfo.new(0.3), {Size = UDim2.new(0,GUI_WIDTH,0,GUI_HEIGHT)}):Play()
