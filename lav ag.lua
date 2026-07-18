local windowLoadSuccess = false
local function StartWindowTimeoutCheck()
    task.spawn(function()
        local waitTime = 10
        local tickStart = os.clock()
        local RunService = game:GetService("RunService")
        local LocalPlayer = game:GetService("Players").LocalPlayer
        local CoreGui = game:GetService("CoreGui")
        while os.clock() - tickStart < waitTime do
            task.wait(0.1)
            local targetGui = nil
            if CoreGui:FindFirstChild("WindUI") then
                targetGui = CoreGui.WindUI
            elseif LocalPlayer.PlayerGui:FindFirstChild("WindUI") then
                targetGui = LocalPlayer.PlayerGui.WindUI
            elseif gethui and gethui():FindFirstChild("WindUI") then
                targetGui = gethui().WindUI
            end
            if targetGui and targetGui:IsDescendantOf(game) then
                windowLoadSuccess = true
                return
            end
        end
        warn("[加载超时] 解密动画播放完毕，20秒内未检测到WindUI悬浮窗口！网络/库链接异常")
        task.spawn(function()
            local retryCount = 0
            while retryCount < 10 do
                task.wait(0.5)
                if WindUI then
                    WindUI:Notify({
                        Title = "启动异常",
                        Content = "动画执行完成，但20秒未加载出脚本悬浮窗口，请检查网络或库链接",
                        Duration = 5
                    })
                    break
                end
                retryCount += 1
            end
        end)
    end)
end
local function SafeLoad(url, timeout)
    timeout = timeout or 3
    local suc, content = pcall(function()
        local conn = game:GetService("HttpService")
        conn.Timeout = timeout
        return conn:Get(url)
    end)
    if not suc then
        WindUI:Notify({
            Title="脚本加载失败",
            Content="网络超时/链接失效",
            Duration=2
        })
        return
    end
    local loadSuc, err = pcall(loadstring(content))
    if not loadSuc then
        WindUI:Notify({
            Title="脚本执行报错",
            Content=err,
            Duration=3
        })
    end
end
do
local ok, err = pcall(function()
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local function getParent()
local s, p = pcall(function()
if gethui then return gethui() end
return CoreGui
end)
if s and p then return p end
return LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui")
end
local old = getParent():FindFirstChild("ShaFuKeySystem")
if old then old:Destroy() end
local gui = Instance.new("ScreenGui")
gui.Name = "ShaFuKeySystem"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999999
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = getParent()
local function tw(obj, props, dur, style, dir)
style = style or Enum.EasingStyle.Quad
dir = dir or Enum.EasingDirection.Out
return TweenService:Create(obj, TweenInfo.new(dur, style, dir), props)
end
local function play(t) t:Play() end
local accent = Color3.fromRGB(0, 255, 160)
local bgDark = Color3.fromRGB(4, 6, 8)
local bgCard = Color3.fromRGB(12, 18, 24)
local bgInput = Color3.fromRGB(18, 26, 34)
local textMain = Color3.fromRGB(240, 255, 248)
local textSub = Color3.fromRGB(140, 180, 165)
local redAccent = Color3.fromRGB(255, 60, 60)
local yellowAccent = Color3.fromRGB(255, 200, 50)
local mainBg = Instance.new("Frame")
mainBg.Size = UDim2.new(1, 0, 1, 0)
mainBg.BackgroundColor3 = Color3.fromRGB(4, 6, 8)
mainBg.BackgroundTransparency = 0
mainBg.ZIndex = 1
mainBg.Parent = gui
local scanLine = Instance.new("Frame")
scanLine.Size = UDim2.new(1, 0, 0, 2)
scanLine.Position = UDim2.new(0, 0, -0.02, 0)
scanLine.BackgroundColor3 = accent
scanLine.BackgroundTransparency = 0.5
scanLine.ZIndex = 100
scanLine.Parent = mainBg
task.spawn(function()
while gui.Parent do
scanLine.Position = UDim2.new(0, 0, -0.02, 0)
play(tw(scanLine, {Position = UDim2.new(0, 0, 1.02, 0)}, 1.2, Enum.EasingStyle.Linear))
task.wait(1.25)
end
end)
local card = Instance.new("Frame")
card.Name = "KeyCard"
card.Size = UDim2.new(0, 420, 0, 320)
card.AnchorPoint = Vector2.new(0.5, 0.5)
card.Position = UDim2.new(0.5, 0, 0.5, 0)
card.BackgroundColor3 = bgCard
card.BackgroundTransparency = 1
card.BorderSizePixel = 0
card.ZIndex = 10
card.Parent = mainBg
Instance.new("UICorner", card).CornerRadius = UDim.new(0, 16)
local cardStroke = Instance.new("UIStroke", card)
cardStroke.Color = accent
cardStroke.Thickness = 1.5
cardStroke.Transparency = 0.2
local cardGlow = Instance.new("UIStroke", card)
cardGlow.Color = accent
cardGlow.Thickness = 6
cardGlow.Transparency = 0.85
local cardScale = Instance.new("UIScale")
cardScale.Scale = 0
cardScale.Parent = card
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 1)
topBar.BackgroundColor3 = accent
topBar.BackgroundTransparency = 0.3
topBar.BorderSizePixel = 0
topBar.ZIndex = 11
topBar.Parent = card
local logoLabel = Instance.new("TextLabel")
logoLabel.Size = UDim2.new(1, 0, 0, 50)
logoLabel.Position = UDim2.new(0, 0, 0, 30)
logoLabel.BackgroundTransparency = 1
logoLabel.Text = "△ 傻 福"
logoLabel.TextColor3 = accent
logoLabel.TextTransparency = 1
logoLabel.TextSize = 28
logoLabel.Font = Enum.Font.GothamBlack
logoLabel.TextXAlignment = Enum.TextXAlignment.Center
logoLabel.ZIndex = 12
logoLabel.Parent = card
local versionLabel = Instance.new("TextLabel")
versionLabel.Size = UDim2.new(1, 0, 0, 16)
versionLabel.Position = UDim2.new(0, 0, 0, 76)
versionLabel.BackgroundTransparency = 1
versionLabel.Text = "DELTA FORCE // KEY VERIFICATION"
versionLabel.TextColor3 = textSub
versionLabel.TextTransparency = 1
versionLabel.TextSize = 11
versionLabel.Font = Enum.Font.Code
versionLabel.TextXAlignment = Enum.TextXAlignment.Center
versionLabel.ZIndex = 12
versionLabel.Parent = card
local divider = Instance.new("Frame")
divider.Size = UDim2.new(0.85, 0, 0, 1)
divider.Position = UDim2.new(0.075, 0, 0, 100)
divider.BackgroundColor3 = accent
divider.BackgroundTransparency = 0.6
divider.BorderSizePixel = 0
divider.ZIndex = 12
divider.Parent = card
local keyLabel = Instance.new("TextLabel")
keyLabel.Size = UDim2.new(1, 0, 0, 20)
keyLabel.Position = UDim2.new(0, 0, 0, 115)
keyLabel.BackgroundTransparency = 1
keyLabel.Text = "请输入激活密钥"
keyLabel.TextColor3 = textMain
keyLabel.TextTransparency = 1
keyLabel.TextSize = 14
keyLabel.Font = Enum.Font.GothamMedium
keyLabel.TextXAlignment = Enum.TextXAlignment.Center
keyLabel.ZIndex = 12
keyLabel.Parent = card
local inputBox = Instance.new("TextBox")
inputBox.Name = "KeyInput"
inputBox.Size = UDim2.new(0.82, 0, 0, 42)
inputBox.Position = UDim2.new(0.09, 0, 0, 140)
inputBox.BackgroundColor3 = bgInput
inputBox.BackgroundTransparency = 1
inputBox.BorderSizePixel = 0
inputBox.PlaceholderText = "在此输入密钥..."
inputBox.PlaceholderColor3 = Color3.fromRGB(80, 110, 100)
inputBox.Text = ""
inputBox.TextColor3 = textMain
inputBox.TextTransparency = 1
inputBox.TextSize = 15
inputBox.Font = Enum.Font.Code
inputBox.ClearTextOnFocus = false
inputBox.ZIndex = 13
inputBox.Parent = card
Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 8)
local inputStroke = Instance.new("UIStroke", inputBox)
inputStroke.Color = Color3.fromRGB(0, 200, 130)
inputStroke.Thickness = 1
inputStroke.Transparency = 0.3
local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "Status"
statusLabel.Size = UDim2.new(1, 0, 0, 18)
statusLabel.Position = UDim2.new(0, 0, 0, 190)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = ""
statusLabel.TextColor3 = textSub
statusLabel.TextTransparency = 1
statusLabel.TextSize = 12
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextXAlignment = Enum.TextXAlignment.Center
statusLabel.ZIndex = 12
statusLabel.Parent = card
local btnFrame = Instance.new("Frame")
btnFrame.Size = UDim2.new(0.82, 0, 0, 40)
btnFrame.Position = UDim2.new(0.09, 0, 0, 218)
btnFrame.BackgroundTransparency = 1
btnFrame.ZIndex = 12
btnFrame.Parent = card
local confirmBtn = Instance.new("TextButton")
confirmBtn.Name = "Confirm"
confirmBtn.Size = UDim2.new(0.48, -5, 1, 0)
confirmBtn.Position = UDim2.new(0, 0, 0, 0)
confirmBtn.BackgroundColor3 = accent
confirmBtn.BackgroundTransparency = 1
confirmBtn.BorderSizePixel = 0
confirmBtn.Text = "激 活"
confirmBtn.TextColor3 = bgDark
confirmBtn.TextTransparency = 1
confirmBtn.TextSize = 14
confirmBtn.Font = Enum.Font.GothamBold
confirmBtn.ZIndex = 13
confirmBtn.Parent = btnFrame
Instance.new("UICorner", confirmBtn).CornerRadius = UDim.new(0, 8)
local cancelBtn = Instance.new("TextButton")
cancelBtn.Name = "Cancel"
cancelBtn.Size = UDim2.new(0.48, -5, 1, 0)
cancelBtn.Position = UDim2.new(0.52, 0, 0, 0)
cancelBtn.BackgroundColor3 = Color3.fromRGB(30, 42, 52)
cancelBtn.BackgroundTransparency = 1
cancelBtn.BorderSizePixel = 0
cancelBtn.Text = "取 消"
cancelBtn.TextColor3 = textSub
cancelBtn.TextTransparency = 1
cancelBtn.TextSize = 14
cancelBtn.Font = Enum.Font.GothamBold
cancelBtn.ZIndex = 13
cancelBtn.Parent = btnFrame
Instance.new("UICorner", cancelBtn).CornerRadius = UDim.new(0, 8)
local cornerTL = Instance.new("TextLabel")
cornerTL.Size = UDim2.new(0, 12, 0, 12)
cornerTL.Position = UDim2.new(0, 8, 0, 8)
cornerTL.BackgroundTransparency = 1
cornerTL.Text = "⌜"
cornerTL.TextColor3 = accent
cornerTL.TextTransparency = 1
cornerTL.TextSize = 12
cornerTL.Font = Enum.Font.GothamBlack
cornerTL.ZIndex = 14
cornerTL.Parent = card
local cornerTR = Instance.new("TextLabel")
cornerTR.Size = UDim2.new(0, 12, 0, 12)
cornerTR.Position = UDim2.new(1, -20, 0, 8)
cornerTR.BackgroundTransparency = 1
cornerTR.Text = "⌜"
cornerTR.TextColor3 = accent
cornerTR.TextTransparency = 1
cornerTR.TextSize = 12
cornerTR.Font = Enum.Font.GothamBlack
cornerTR.Rotation = 90
cornerTR.ZIndex = 14
cornerTR.Parent = card
local cornerBL = Instance.new("TextLabel")
cornerBL.Size = UDim2.new(0, 12, 0, 12)
cornerBL.Position = UDim2.new(0, 8, 1, -20)
cornerBL.BackgroundTransparency = 1
cornerBL.Text = "⌜"
cornerBL.TextColor3 = accent
cornerBL.TextTransparency = 1
cornerBL.TextSize = 12
cornerBL.Font = Enum.Font.GothamBlack
cornerBL.Rotation = -90
cornerBL.ZIndex = 14
cornerBL.Parent = card
local cornerBR = Instance.new("TextLabel")
cornerBR.Size = UDim2.new(0, 12, 0, 12)
cornerBR.Position = UDim2.new(1, -20, 1, -20)
cornerBR.BackgroundTransparency = 1
cornerBR.Text = "⌜"
cornerBR.TextColor3 = accent
cornerBR.TextTransparency = 1
cornerBR.TextSize = 12
cornerBR.Font = Enum.Font.GothamBlack
cornerBR.Rotation = 180
cornerBR.ZIndex = 14
cornerBR.Parent = card
play(tw(cardScale, {Scale = 1.0}, 0.5, Enum.EasingStyle.Back))
task.wait(0.15)
play(tw(card, {BackgroundTransparency = 0.08}, 0.3))
play(tw(logoLabel, {TextTransparency = 0}, 0.35))
play(tw(versionLabel, {TextTransparency = 0.15}, 0.4))
play(tw(keyLabel, {TextTransparency = 0}, 0.35))
play(tw(inputBox, {BackgroundTransparency = 0}, 0.3))
play(tw(inputBox, {TextTransparency = 0}, 0.3))
play(tw(statusLabel, {TextTransparency = 0.2}, 0.3))
play(tw(confirmBtn, {BackgroundTransparency = 0}, 0.3))
play(tw(confirmBtn, {TextTransparency = 0}, 0.3))
play(tw(cancelBtn, {BackgroundTransparency = 0}, 0.3))
play(tw(cancelBtn, {TextTransparency = 0}, 0.3))
for _, c in ipairs({cornerTL, cornerTR, cornerBL, cornerBR}) do
play(tw(c, {TextTransparency = 0.15}, 0.3))
end
local cancelOverlay = Instance.new("Frame")
cancelOverlay.Name = "CancelOverlay"
cancelOverlay.Size = UDim2.new(1, 0, 1, 0)
cancelOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
cancelOverlay.BackgroundTransparency = 1
cancelOverlay.ZIndex = 50
cancelOverlay.Visible = false
cancelOverlay.Parent = mainBg
local cancelCard = Instance.new("Frame")
cancelCard.Size = UDim2.new(0, 380, 0, 240)
cancelCard.AnchorPoint = Vector2.new(0.5, 0.5)
cancelCard.Position = UDim2.new(0.5, 0, 0.5, 0)
cancelCard.BackgroundColor3 = bgCard
cancelCard.BackgroundTransparency = 1
cancelCard.BorderSizePixel = 0
cancelCard.ZIndex = 52
cancelCard.Visible = false
cancelCard.Parent = cancelOverlay
Instance.new("UICorner", cancelCard).CornerRadius = UDim.new(0, 14)
local cancelCardStroke = Instance.new("UIStroke", cancelCard)
cancelCardStroke.Color = Color3.fromRGB(255, 200, 50)
cancelCardStroke.Thickness = 1.5
cancelCardStroke.Transparency = 0.25
local cancelIcon = Instance.new("TextLabel")
cancelIcon.Size = UDim2.new(1, 0, 0, 50)
cancelIcon.Position = UDim2.new(0, 0, 0, 25)
cancelIcon.BackgroundTransparency = 1
cancelIcon.Text = "⚠"
cancelIcon.TextColor3 = yellowAccent
cancelIcon.TextTransparency = 1
cancelIcon.TextSize = 36
cancelIcon.Font = Enum.Font.GothamBold
cancelIcon.TextXAlignment = Enum.TextXAlignment.Center
cancelIcon.ZIndex = 53
cancelIcon.Parent = cancelCard
local cancelTitle = Instance.new("TextLabel")
cancelTitle.Size = UDim2.new(0.9, 0, 0, 26)
cancelTitle.Position = UDim2.new(0.05, 0, 0, 80)
cancelTitle.BackgroundTransparency = 1
cancelTitle.Text = "请联系1040209982群管理员获取测试权限"
cancelTitle.TextColor3 = textMain
cancelTitle.TextTransparency = 1
cancelTitle.TextSize = 18
cancelTitle.Font = Enum.Font.GothamBold
cancelTitle.TextXAlignment = Enum.TextXAlignment.Center
cancelTitle.ZIndex = 53
cancelTitle.Parent = cancelCard
local cancelDesc = Instance.new("TextLabel")
cancelDesc.Size = UDim2.new(0.8, 0, 0, 50)
cancelDesc.Position = UDim2.new(0.1, 0, 0, 112)
cancelDesc.BackgroundTransparency = 1
cancelDesc.Text = "您尚未激活测试权限\n加入内部交流群联系管理员获取密钥"
cancelDesc.TextColor3 = textSub
cancelDesc.TextTransparency = 1
cancelDesc.TextSize = 13
cancelDesc.Font = Enum.Font.Gotham
cancelDesc.TextXAlignment = Enum.TextXAlignment.Center
cancelDesc.ZIndex = 53
cancelDesc.Parent = cancelCard
local cancelCloseBtn = Instance.new("TextButton")
cancelCloseBtn.Size = UDim2.new(0.6, 0, 0, 36)
cancelCloseBtn.Position = UDim2.new(0.2, 0, 0, 185)
cancelCloseBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
cancelCloseBtn.BackgroundTransparency = 1
cancelCloseBtn.BorderSizePixel = 0
cancelCloseBtn.Text = "了解了"
cancelCloseBtn.TextColor3 = bgDark
cancelCloseBtn.TextTransparency = 1
cancelCloseBtn.TextSize = 14
cancelCloseBtn.Font = Enum.Font.GothamBold
cancelCloseBtn.ZIndex = 54
cancelCloseBtn.Parent = cancelCard
Instance.new("UICorner", cancelCloseBtn).CornerRadius = UDim.new(0, 8)
local function showCancelOverlay()
cancelOverlay.Visible = true
cancelCard.Visible = true
play(tw(cancelOverlay, {BackgroundTransparency = 0.5}, 0.3))
play(tw(cancelCard, {BackgroundTransparency = 0.08}, 0.35, Enum.EasingStyle.Back))
play(tw(cancelIcon, {TextTransparency = 0}, 0.3))
play(tw(cancelTitle, {TextTransparency = 0}, 0.3))
play(tw(cancelDesc, {TextTransparency = 0}, 0.3))
play(tw(cancelCloseBtn, {BackgroundTransparency = 0}, 0.3))
play(tw(cancelCloseBtn, {TextTransparency = 0}, 0.3))
end
local function hideCancelOverlay()
play(tw(cancelOverlay, {BackgroundTransparency = 1}, 0.25))
play(tw(cancelCard, {BackgroundTransparency = 1}, 0.25))
play(tw(cancelIcon, {TextTransparency = 1}, 0.2))
play(tw(cancelTitle, {TextTransparency = 1}, 0.2))
play(tw(cancelDesc, {TextTransparency = 1}, 0.2))
play(tw(cancelCloseBtn, {BackgroundTransparency = 1}, 0.2))
play(tw(cancelCloseBtn, {TextTransparency = 1}, 0.2))
task.wait(0.3)
cancelOverlay.Visible = false
cancelCard.Visible = false
end
cancelCloseBtn.MouseButton1Click:Connect(function()
hideCancelOverlay()
end)
local successOverlay = Instance.new("Frame")
successOverlay.Name = "SuccessOverlay"
successOverlay.Size = UDim2.new(1, 0, 1, 0)
successOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
successOverlay.BackgroundTransparency = 1
successOverlay.ZIndex = 50
successOverlay.Visible = false
successOverlay.Parent = mainBg
local successCard = Instance.new("Frame")
successCard.Size = UDim2.new(0, 340, 0, 220)
successCard.AnchorPoint = Vector2.new(0.5, 0.5)
successCard.Position = UDim2.new(0.5, 0, 0.5, 0)
successCard.BackgroundColor3 = bgCard
successCard.BackgroundTransparency = 1
successCard.BorderSizePixel = 0
successCard.ZIndex = 52
successCard.Visible = false
successCard.Parent = successOverlay
Instance.new("UICorner", successCard).CornerRadius = UDim.new(0, 14)
local successStroke = Instance.new("UIStroke", successCard)
successStroke.Color = accent
successStroke.Thickness = 1.5
successStroke.Transparency = 0.2
local successGlow = Instance.new("UIStroke", successCard)
successGlow.Color = accent
successGlow.Thickness = 5
successGlow.Transparency = 0.8
local successCheckBg = Instance.new("Frame")
successCheckBg.Size = UDim2.new(0, 60, 0, 60)
successCheckBg.AnchorPoint = Vector2.new(0.5, 0.5)
successCheckBg.Position = UDim2.new(0.5, 0, 0, 50)
successCheckBg.BackgroundColor3 = accent
successCheckBg.BackgroundTransparency = 1
successCheckBg.BorderSizePixel = 0
successCheckBg.ZIndex = 53
successCheckBg.Parent = successCard
Instance.new("UICorner", successCheckBg).CornerRadius = UDim.new(1, 0)
local successCheckLabel = Instance.new("TextLabel")
successCheckLabel.Size = UDim2.new(1, 0, 1, 0)
successCheckLabel.BackgroundTransparency = 1
successCheckLabel.Text = "✓"
successCheckLabel.TextColor3 = bgDark
successCheckLabel.TextTransparency = 1
successCheckLabel.TextSize = 32
successCheckLabel.Font = Enum.Font.GothamBlack
successCheckLabel.ZIndex = 54
successCheckLabel.Parent = successCheckBg
local successTitle = Instance.new("TextLabel")
successTitle.Size = UDim2.new(0.9, 0, 0, 26)
successTitle.Position = UDim2.new(0.05, 0, 0, 95)
successTitle.BackgroundTransparency = 1
successTitle.Text = "激活成功"
successTitle.TextColor3 = accent
successTitle.TextTransparency = 1
successTitle.TextSize = 20
successTitle.Font = Enum.Font.GothamBlack
successTitle.TextXAlignment = Enum.TextXAlignment.Center
successTitle.ZIndex = 53
successTitle.Parent = successCard
local successExpire = Instance.new("TextLabel")
successExpire.Size = UDim2.new(0.9, 0, 0, 20)
successExpire.Position = UDim2.new(0.05, 0, 0, 125)
successExpire.BackgroundTransparency = 1
successExpire.Text = ""
successExpire.TextColor3 = textSub
successExpire.TextTransparency = 1
successExpire.TextSize = 13
successExpire.Font = Enum.Font.Gotham
successExpire.TextXAlignment = Enum.TextXAlignment.Center
successExpire.ZIndex = 53
successExpire.Parent = successCard
local successContinue = Instance.new("TextButton")
successContinue.Size = UDim2.new(0.6, 0, 0, 38)
successContinue.Position = UDim2.new(0.2, 0, 0, 165)
successContinue.BackgroundColor3 = accent
successContinue.BackgroundTransparency = 1
successContinue.BorderSizePixel = 0
successContinue.Text = "继 续"
successContinue.TextColor3 = bgDark
successContinue.TextTransparency = 1
successContinue.TextSize = 14
successContinue.Font = Enum.Font.GothamBold
successContinue.ZIndex = 54
successContinue.Parent = successCard
Instance.new("UICorner", successContinue).CornerRadius = UDim.new(0, 8)
local successParticles = {}
for i = 1, 25 do
local sp = Instance.new("Frame")
local sz = 3 + math.random(6)
sp.Size = UDim2.new(0, sz, 0, sz)
sp.BackgroundColor3 = math.random() > 0.5 and accent or Color3.fromRGB(180, 255, 220)
sp.BackgroundTransparency = 1
sp.BorderSizePixel = 0
sp.ZIndex = 55
sp.Visible = false
sp.Parent = successOverlay
Instance.new("UICorner", sp).CornerRadius = UDim.new(1, 0)
table.insert(successParticles, sp)
end
local function showSuccessAnim(expireText)
successOverlay.Visible = true
successCard.Visible = true
play(tw(successOverlay, {BackgroundTransparency = 0.5}, 0.3))
play(tw(successCard, {BackgroundTransparency = 0.08}, 0.35, Enum.EasingStyle.Back))
play(tw(successCheckBg, {BackgroundTransparency = 0}, 0.3))
play(tw(successCheckLabel, {TextTransparency = 0}, 0.3))
play(tw(successTitle, {TextTransparency = 0}, 0.35))
if expireText then
successExpire.Text = expireText
play(tw(successExpire, {TextTransparency = 0}, 0.35))
end
play(tw(successContinue, {BackgroundTransparency = 0}, 0.3))
play(tw(successContinue, {TextTransparency = 0}, 0.3))
task.spawn(function()
for _, sp in ipairs(successParticles) do
sp.Visible = true
local sx = 0.5 + math.random(-15, 15) / 100
local sy = 0.45 + math.random(-10, 10) / 100
sp.Position = UDim2.new(sx, 0, sy, 0)
local angle = math.random() * math.pi * 2
local dist = 0.08 + math.random(12) / 100
play(tw(sp, {
Position = UDim2.new(sx + math.cos(angle) * dist, 0, sy + math.sin(angle) * dist, 0),
BackgroundTransparency = 1,
Size = UDim2.new(0, sp.Size.X.Offset + 8, 0, sp.Size.Y.Offset + 8),
}, 0.6 + math.random(15) / 100, Enum.EasingStyle.Quad))
end
end)
end
local failOverlay = Instance.new("Frame")
failOverlay.Name = "FailOverlay"
failOverlay.Size = UDim2.new(1, 0, 1, 0)
failOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
failOverlay.BackgroundTransparency = 1
failOverlay.ZIndex = 50
failOverlay.Visible = false
failOverlay.Parent = mainBg
local failCard = Instance.new("Frame")
failCard.Size = UDim2.new(0, 340, 0, 200)
failCard.AnchorPoint = Vector2.new(0.5, 0.5)
failCard.Position = UDim2.new(0.5, 0, 0.5, 0)
failCard.BackgroundColor3 = bgCard
failCard.BackgroundTransparency = 1
failCard.BorderSizePixel = 0
failCard.ZIndex = 52
failCard.Visible = false
failCard.Parent = failOverlay
Instance.new("UICorner", failCard).CornerRadius = UDim.new(0, 14)
local failStroke = Instance.new("UIStroke", failCard)
failStroke.Color = redAccent
failStroke.Thickness = 1.5
failStroke.Transparency = 0.25
local failIcon = Instance.new("TextLabel")
failIcon.Size = UDim2.new(1, 0, 0, 44)
failIcon.Position = UDim2.new(0, 0, 0, 25)
failIcon.BackgroundTransparency = 1
failIcon.Text = "✕"
failIcon.TextColor3 = redAccent
failIcon.TextTransparency = 1
failIcon.TextSize = 30
failIcon.Font = Enum.Font.GothamBlack
failIcon.TextXAlignment = Enum.TextXAlignment.Center
failIcon.ZIndex = 53
failIcon.Parent = failCard
local failTitle = Instance.new("TextLabel")
failTitle.Size = UDim2.new(0.9, 0, 0, 26)
failTitle.Position = UDim2.new(0.05, 0, 0, 75)
failTitle.BackgroundTransparency = 1
failTitle.Text = "激活失败"
failTitle.TextColor3 = redAccent
failTitle.TextTransparency = 1
failTitle.TextSize = 20
failTitle.Font = Enum.Font.GothamBold
failTitle.TextXAlignment = Enum.TextXAlignment.Center
failTitle.ZIndex = 53
failTitle.Parent = failCard
local failDesc = Instance.new("TextLabel")
failDesc.Size = UDim2.new(0.8, 0, 0, 36)
failDesc.Position = UDim2.new(0.1, 0, 0, 107)
failDesc.BackgroundTransparency = 1
failDesc.Text = ""
failDesc.TextColor3 = textSub
failDesc.TextTransparency = 1
failDesc.TextSize = 13
failDesc.Font = Enum.Font.Gotham
failDesc.TextXAlignment = Enum.TextXAlignment.Center
failDesc.ZIndex = 53
failDesc.Parent = failCard
local failRetryBtn = Instance.new("TextButton")
failRetryBtn.Size = UDim2.new(0.6, 0, 0, 36)
failRetryBtn.Position = UDim2.new(0.2, 0, 0, 150)
failRetryBtn.BackgroundColor3 = redAccent
failRetryBtn.BackgroundTransparency = 1
failRetryBtn.BorderSizePixel = 0
failRetryBtn.Text = "重新输入"
failRetryBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
failRetryBtn.TextTransparency = 1
failRetryBtn.TextSize = 14
failRetryBtn.Font = Enum.Font.GothamBold
failRetryBtn.ZIndex = 54
failRetryBtn.Parent = failCard
Instance.new("UICorner", failRetryBtn).CornerRadius = UDim.new(0, 8)
local function showFailAnim(reason)
failOverlay.Visible = true
failCard.Visible = true
failDesc.Text = reason or "密钥无效或已过期"
play(tw(failOverlay, {BackgroundTransparency = 0.5}, 0.3))
play(tw(failCard, {BackgroundTransparency = 0.08}, 0.35, Enum.EasingStyle.Back))
play(tw(failIcon, {TextTransparency = 0}, 0.3))
play(tw(failTitle, {TextTransparency = 0}, 0.3))
play(tw(failDesc, {TextTransparency = 0}, 0.3))
play(tw(failRetryBtn, {BackgroundTransparency = 0}, 0.3))
play(tw(failRetryBtn, {TextTransparency = 0}, 0.3))
task.spawn(function()
for i = 1, 8 do
play(tw(failCard, {Position = UDim2.new(0.5, (math.random() > 0.5 and 1 or -1) * (6 - i), 0.5, 0)}, 0.04, Enum.EasingStyle.Quad))
task.wait(0.04)
play(tw(failCard, {Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.04, Enum.EasingStyle.Quad))
task.wait(0.04)
end
end)
end
local function hideFailAnim()
play(tw(failOverlay, {BackgroundTransparency = 1}, 0.25))
play(tw(failCard, {BackgroundTransparency = 1}, 0.25))
play(tw(failIcon, {TextTransparency = 1}, 0.2))
play(tw(failTitle, {TextTransparency = 1}, 0.2))
play(tw(failDesc, {TextTransparency = 1}, 0.2))
play(tw(failRetryBtn, {BackgroundTransparency = 1}, 0.2))
play(tw(failRetryBtn, {TextTransparency = 1}, 0.2))
task.wait(0.3)
failOverlay.Visible = false
failCard.Visible = false
end
failRetryBtn.MouseButton1Click:Connect(function()
hideFailAnim()
end)
local function shakeCard()
task.spawn(function()
for i = 1, 6 do
play(tw(card, {Position = UDim2.new(0.5, (math.random() > 0.5 and 1 or -1) * (5 - i * 0.5), 0.5, 0)}, 0.04, Enum.EasingStyle.Quad))
task.wait(0.04)
play(tw(card, {Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.04, Enum.EasingStyle.Quad))
task.wait(0.04)
end
end)
end
local remoteUrl = "https://share.weiyun.com/v7eQevUw"
local function cleanHTML(html)
if not html then return "" end
local article = html:match("<article(.-)</article>")
if article then html = article end
html = html:gsub("<[^>]+>", " ")
html = html:gsub("&nbsp;", " ")
html = html:gsub("&lt;", "<")
html = html:gsub("&gt;", ">")
html = html:gsub("&amp;", "&")
html = html:gsub("&quot;", '"')
html = html:gsub("&apos;", "'")
html = html:gsub("[ \t]+", " ")
return html
end
local function getField(text, name)
if not text then return nil end
local val = text:match(name .. "%s*【(.-)】")
if not val then
val = text:match(name .. "%s*【(.+)】")
if val then
val = val:gsub("最新版本%s*【.-】", "")
val = val:gsub("更新链接%s*【.-】", "")
val = val:gsub("软件大小%s*【.-】", "")
val = val:gsub("更新内容%s*【.-】", "")
val = val:gsub("公告图片%s*【.-】", "")
val = val:gsub("公告视频%s*【.-】", "")
val = val:gsub("公告%s*【.-】", "")
end
end
return val and val:match("^%s*(.-)%s*$") or nil
end
local function fetchRemoteKey()
local key = ""
pcall(function()
local success, content = pcall(function()
return game:HttpGet(remoteUrl, true)
end)
if success and content and content ~= "" then
local clean = cleanHTML(content)
local remoteKey = getField(clean, "卡密")
if remoteKey and remoteKey ~= "" then
key = remoteKey
end
end
end)
return key
end
local isVerifying = false
local function verifyKey(inputKey)
if isVerifying then return end
if not inputKey or #inputKey < 1 then
statusLabel.Text = "请输入密钥"
statusLabel.TextColor3 = yellowAccent
shakeCard()
return
end
isVerifying = true
confirmBtn.Text = "验证中..."
confirmBtn.Active = false
statusLabel.Text = "正在连接云端验证..."
statusLabel.TextColor3 = textSub
task.wait(0.3)
local remoteKey = fetchRemoteKey()
if remoteKey == "" then
showFailAnim("无法连接验证服务器，请检查网络")
confirmBtn.Text = "激 活"
confirmBtn.Active = true
isVerifying = false
return
end
if inputKey == remoteKey then
statusLabel.Text = "密钥验证通过"
statusLabel.TextColor3 = accent
task.wait(0.5)
showSuccessAnim("云端密钥验证通过")
isVerifying = false
else
statusLabel.Text = "密钥无效"
statusLabel.TextColor3 = redAccent
task.wait(0.3)
showFailAnim("密钥无效或已过期，请联系管理员")
confirmBtn.Text = "激 活"
confirmBtn.Active = true
isVerifying = false
end
end
local groupOverlay = Instance.new("Frame")
groupOverlay.Name = "GroupOverlay"
groupOverlay.Size = UDim2.new(1, 0, 1, 0)
groupOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
groupOverlay.BackgroundTransparency = 1
groupOverlay.ZIndex = 50
groupOverlay.Visible = false
groupOverlay.Parent = mainBg
local groupCard = Instance.new("Frame")
groupCard.Size = UDim2.new(0, 400, 0, 280)
groupCard.AnchorPoint = Vector2.new(0.5, 0.5)
groupCard.Position = UDim2.new(0.5, 0, 0.5, 0)
groupCard.BackgroundColor3 = bgCard
groupCard.BackgroundTransparency = 1
groupCard.BorderSizePixel = 0
groupCard.ZIndex = 52
groupCard.Visible = false
groupCard.Parent = groupOverlay
Instance.new("UICorner", groupCard).CornerRadius = UDim.new(0, 16)
local groupStroke = Instance.new("UIStroke", groupCard)
groupStroke.Color = accent
groupStroke.Thickness = 1.5
groupStroke.Transparency = 0.2
local groupGlow = Instance.new("UIStroke", groupCard)
groupGlow.Color = accent
groupGlow.Thickness = 6
groupGlow.Transparency = 0.85
local groupIcon = Instance.new("TextLabel")
groupIcon.Size = UDim2.new(1, 0, 0, 50)
groupIcon.Position = UDim2.new(0, 0, 0, 25)
groupIcon.BackgroundTransparency = 1
groupIcon.Text = "🐧"
groupIcon.TextTransparency = 1
groupIcon.TextSize = 36
groupIcon.Font = Enum.Font.Gotham
groupIcon.TextXAlignment = Enum.TextXAlignment.Center
groupIcon.ZIndex = 53
groupIcon.Parent = groupCard
local groupTitle = Instance.new("TextLabel")
groupTitle.Size = UDim2.new(0.9, 0, 0, 26)
groupTitle.Position = UDim2.new(0.05, 0, 0, 80)
groupTitle.BackgroundTransparency = 1
groupTitle.Text = "加入内部交流群"
groupTitle.TextColor3 = accent
groupTitle.TextTransparency = 1
groupTitle.TextSize = 20
groupTitle.Font = Enum.Font.GothamBlack
groupTitle.TextXAlignment = Enum.TextXAlignment.Center
groupTitle.ZIndex = 53
groupTitle.Parent = groupCard
local groupDesc = Instance.new("TextLabel")
groupDesc.Size = UDim2.new(0.8, 0, 0, 36)
groupDesc.Position = UDim2.new(0.1, 0, 0, 112)
groupDesc.BackgroundTransparency = 1
groupDesc.Text = "加入QQ群获取最新更新和反馈问题"
groupDesc.TextColor3 = textSub
groupDesc.TextTransparency = 1
groupDesc.TextSize = 13
groupDesc.Font = Enum.Font.Gotham
groupDesc.TextXAlignment = Enum.TextXAlignment.Center
groupDesc.ZIndex = 53
groupDesc.Parent = groupCard
local groupJoinBtn = Instance.new("TextButton")
groupJoinBtn.Size = UDim2.new(0.65, 0, 0, 40)
groupJoinBtn.Position = UDim2.new(0.175, 0, 0, 160)
groupJoinBtn.BackgroundColor3 = accent
groupJoinBtn.BackgroundTransparency = 1
groupJoinBtn.BorderSizePixel = 0
groupJoinBtn.Text = "加入QQ群 1040209982"
groupJoinBtn.TextColor3 = bgDark
groupJoinBtn.TextTransparency = 1
groupJoinBtn.TextSize = 14
groupJoinBtn.Font = Enum.Font.GothamBold
groupJoinBtn.ZIndex = 54
groupJoinBtn.Parent = groupCard
Instance.new("UICorner", groupJoinBtn).CornerRadius = UDim.new(0, 8)
local groupSkipBtn = Instance.new("TextButton")
groupSkipBtn.Size = UDim2.new(0.65, 0, 0, 36)
groupSkipBtn.Position = UDim2.new(0.175, 0, 0, 210)
groupSkipBtn.BackgroundColor3 = Color3.fromRGB(30, 42, 52)
groupSkipBtn.BackgroundTransparency = 1
groupSkipBtn.BorderSizePixel = 0
groupSkipBtn.Text = "跳过"
groupSkipBtn.TextColor3 = textSub
groupSkipBtn.TextTransparency = 1
groupSkipBtn.TextSize = 13
groupSkipBtn.Font = Enum.Font.GothamBold
groupSkipBtn.ZIndex = 54
groupSkipBtn.Parent = groupCard
Instance.new("UICorner", groupSkipBtn).CornerRadius = UDim.new(0, 8)
local groupStatus = Instance.new("TextLabel")
groupStatus.Size = UDim2.new(0.8, 0, 0, 18)
groupStatus.Position = UDim2.new(0.1, 0, 0, 248)
groupStatus.BackgroundTransparency = 1
groupStatus.Text = ""
groupStatus.TextColor3 = yellowAccent
groupStatus.TextTransparency = 1
groupStatus.TextSize = 11
groupStatus.Font = Enum.Font.Gotham
groupStatus.TextXAlignment = Enum.TextXAlignment.Center
groupStatus.ZIndex = 53
groupStatus.Parent = groupCard
local function copyToClipboard(text)
pcall(function()
if setclipboard then
setclipboard(text)
elseif SynWriteClipboard then
SynWriteClipboard(text)
elseif set_clipboard then
set_clipboard(text)
else
if LocalPlayer then
local cbGui = Instance.new("ScreenGui")
cbGui.Name = "CBTemp"
cbGui.Parent = getParent()
local tb = Instance.new("TextBox")
tb.Text = text
tb.Parent = cbGui
tb:SelectAllText()
tb:CopyToClipboard()
cbGui:Destroy()
end
end
end)
end
local groupJoined = false
groupJoinBtn.MouseButton1Click:Connect(function()
local url = "https://qun.qq.com/universal-share/share?ac=1&authKey=Q7%2BSBjYJDCa5wxN4J6bnC0n1CwakxILqr9zpRSxHWf9MVuMnOV%2FG6RqKLDm8B8kO&busi_data=eyJncm91cENvZGUiOiIxMDQwMjA5OTgyIiwidG9rZW4iOiJFYW1ja1VyZEYxaWtaY0xhSXhQek5qZ2VueGRKU1hJcVc1QkJ0bGlHTDI1aVFmbDZZYUV3Vlp0eCtmNjVpakxLIiwidWluIjoiMTQ2NTQ4Njg4NiJ9&data=ceEuTVPxpc3KUMeCPbKruD-9K4xNg50Xvk-TgWbkVMK9hFgoo8a91yi8nhgSCMudlywcY-J8JEAx2gjzmPJnDA&svctype=4&tempid=h5_group_info"
local jumped = false
pcall(function()
if syn and syn.request then
syn.request({Url = url, Method = "GET", Headers = {["User-Agent"] = "Roblox"}})
jumped = true
end
end)
if not jumped then
pcall(function()
if request then
request({Url = url, Method = "GET", Headers = {["User-Agent"] = "Roblox"}})
jumped = true
end
end)
end
if not jumped then
pcall(function()
if http_request then
http_request({Url = url, Method = "GET", Headers = {["User-Agent"] = "Roblox"}})
jumped = true
end
end)
end
copyToClipboard("1040209982")
groupStatus.Text = "已复制群号: 1040209982"
play(tw(groupStatus, {TextTransparency = 0}, 0.3))
groupJoined = true
end)
groupSkipBtn.MouseButton1Click:Connect(function()
getgenv().SCRIPT_KEY = ""loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/2edf8cfefd3f3a20006cb681a57e86ec4cb09a7002db56436a71feaee26afffe/download"))()
end)
local function hideKeyCard()
play(tw(cardScale, {Scale = 0}, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In))
play(tw(card, {BackgroundTransparency = 1}, 0.3))
play(tw(logoLabel, {TextTransparency = 1}, 0.2))
play(tw(versionLabel, {TextTransparency = 1}, 0.2))
play(tw(keyLabel, {TextTransparency = 1}, 0.2))
play(tw(inputBox, {BackgroundTransparency = 1}, 0.2))
play(tw(inputBox, {TextTransparency = 1}, 0.2))
play(tw(statusLabel, {TextTransparency = 1}, 0.2))
play(tw(confirmBtn, {BackgroundTransparency = 1}, 0.2))
play(tw(confirmBtn, {TextTransparency = 1}, 0.2))
play(tw(cancelBtn, {BackgroundTransparency = 1}, 0.2))
play(tw(cancelBtn, {TextTransparency = 1}, 0.2))
play(tw(divider, {BackgroundTransparency = 1}, 0.2))
play(tw(topBar, {BackgroundTransparency = 1}, 0.2))
for _, c in ipairs({cornerTL, cornerTR, cornerBL, cornerBR}) do
play(tw(c, {TextTransparency = 1}, 0.2))
end
task.wait(0.35)
card.Visible = false
end
local function hideSuccessOverlay()
play(tw(successOverlay, {BackgroundTransparency = 1}, 0.3))
play(tw(successCard, {BackgroundTransparency = 1}, 0.3))
play(tw(successCheckBg, {BackgroundTransparency = 1}, 0.2))
play(tw(successCheckLabel, {TextTransparency = 1}, 0.2))
play(tw(successTitle, {TextTransparency = 1}, 0.2))
play(tw(successExpire, {TextTransparency = 1}, 0.2))
play(tw(successContinue, {BackgroundTransparency = 1}, 0.2))
play(tw(successContinue, {TextTransparency = 1}, 0.2))
task.wait(0.35)
successOverlay.Visible = false
end
local function showGroupPrompt()
groupOverlay.Visible = true
groupCard.Visible = true
play(tw(groupOverlay, {BackgroundTransparency = 0.5}, 0.3))
play(tw(groupCard, {BackgroundTransparency = 0.08}, 0.4, Enum.EasingStyle.Back))
play(tw(groupIcon, {TextTransparency = 0}, 0.3))
play(tw(groupTitle, {TextTransparency = 0}, 0.35))
play(tw(groupDesc, {TextTransparency = 0}, 0.35))
play(tw(groupJoinBtn, {BackgroundTransparency = 0}, 0.3))
play(tw(groupJoinBtn, {TextTransparency = 0}, 0.3))
play(tw(groupSkipBtn, {BackgroundTransparency = 0}, 0.3))
play(tw(groupSkipBtn, {TextTransparency = 0}, 0.3))
end
local function hideGroupOverlay()
play(tw(groupOverlay, {BackgroundTransparency = 1}, 0.3))
play(tw(groupCard, {BackgroundTransparency = 1}, 0.3))
play(tw(groupIcon, {TextTransparency = 1}, 0.2))
play(tw(groupTitle, {TextTransparency = 1}, 0.2))
play(tw(groupDesc, {TextTransparency = 1}, 0.2))
play(tw(groupJoinBtn, {BackgroundTransparency = 1}, 0.2))
play(tw(groupJoinBtn, {TextTransparency = 1}, 0.2))
play(tw(groupSkipBtn, {BackgroundTransparency = 1}, 0.2))
play(tw(groupSkipBtn, {TextTransparency = 1}, 0.2))
play(tw(groupStatus, {TextTransparency = 1}, 0.2))
task.wait(0.35)
groupOverlay.Visible = false
end
confirmBtn.MouseButton1Click:Connect(function()
verifyKey(inputBox.Text)
end)
inputBox.FocusLost:Connect(function(enterPressed)
if enterPressed then
verifyKey(inputBox.Text)
end
end)
cancelBtn.MouseButton1Click:Connect(function()
showCancelOverlay()
end)
local function runBootAnimation()
local old = getParent():FindFirstChild("DeltaForceBoot")
if old then old:Destroy() end
local bootGui = Instance.new("ScreenGui")
bootGui.Name = "DeltaForceBoot"
bootGui.ResetOnSpawn = false
bootGui.IgnoreGuiInset = true
bootGui.DisplayOrder = 999999
bootGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
bootGui.Parent = getParent()
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(4, 6, 8)
bg.BackgroundTransparency = 1
bg.ZIndex = 1
bg.Parent = bootGui
local road = Instance.new("Frame")
road.Size = UDim2.new(1, 0, 0, 0)
road.Position = UDim2.new(0, 0, 1, 0)
road.BackgroundColor3 = Color3.fromRGB(10, 16, 22)
road.BackgroundTransparency = 1
road.BorderSizePixel = 0
road.ZIndex = 5
road.Parent = bg
local centerLine = Instance.new("Frame")
centerLine.Size = UDim2.new(0, 3, 1, 0)
centerLine.Position = UDim2.new(0.5, -1, 0, 0)
centerLine.BackgroundColor3 = Color3.fromRGB(0, 255, 160)
centerLine.BackgroundTransparency = 0.4
centerLine.ZIndex = 6
centerLine.Parent = road
local edgeTop = Instance.new("Frame")
edgeTop.Size = UDim2.new(1, 0, 0, 2)
edgeTop.BackgroundColor3 = Color3.fromRGB(0, 255, 160)
edgeTop.BackgroundTransparency = 0.5
edgeTop.ZIndex = 6
edgeTop.Parent = road
local car = Instance.new("Frame")
car.Name = "Car"
car.Size = UDim2.new(0, 380, 0, 120)
car.AnchorPoint = Vector2.new(0.5, 0.5)
car.Position = UDim2.new(0.5, 0, 0.32, 0)
car.BackgroundTransparency = 1
car.ZIndex = 10
car.Parent = bg
local bodyLow = Instance.new("Frame")
bodyLow.Size = UDim2.new(1, 0, 0, 44)
bodyLow.Position = UDim2.new(0, 0, 0.52, 0)
bodyLow.BackgroundColor3 = Color3.fromRGB(6, 12, 18)
bodyLow.BackgroundTransparency = 0.05
bodyLow.BorderSizePixel = 0
bodyLow.ZIndex = 11
bodyLow.Parent = car
Instance.new("UICorner", bodyLow).CornerRadius = UDim.new(0, 6)
local blS = Instance.new("UIStroke", bodyLow)
blS.Color = Color3.fromRGB(0, 255, 160)
blS.Thickness = 1
blS.Transparency = 0.15
local bodyGrad = Instance.new("UIGradient")
bodyGrad.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 60, 40)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 35, 25)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 15, 22)),
})
bodyGrad.Rotation = 90
bodyGrad.Parent = bodyLow
local bodyUp = Instance.new("Frame")
bodyUp.Size = UDim2.new(0, 155, 0, 34)
bodyUp.Position = UDim2.new(0.38, 0, 0, 18)
bodyUp.BackgroundColor3 = Color3.fromRGB(4, 20, 16)
bodyUp.BackgroundTransparency = 0.05
bodyUp.BorderSizePixel = 0
bodyUp.ZIndex = 12
bodyUp.Parent = car
Instance.new("UICorner", bodyUp).CornerRadius = UDim.new(0, 8)
local buS = Instance.new("UIStroke", bodyUp)
buS.Color = Color3.fromRGB(0, 255, 160)
buS.Thickness = 1
buS.Transparency = 0.1
local win = Instance.new("Frame")
win.Size = UDim2.new(0.9, 0, 0, 22)
win.Position = UDim2.new(0.05, 0, 0, 6)
win.BackgroundColor3 = Color3.fromRGB(0, 200, 140)
win.BackgroundTransparency = 0.45
win.ZIndex = 13
win.Parent = bodyUp
Instance.new("UICorner", win).CornerRadius = UDim.new(0, 5)
local hl = Instance.new("Frame")
hl.Size = UDim2.new(0, 4, 0, 22)
hl.Position = UDim2.new(1, 0, 0.52, 0)
hl.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
hl.BackgroundTransparency = 0.2
hl.ZIndex = 11
hl.Parent = car
local beam = Instance.new("Frame")
beam.Size = UDim2.new(0, 120, 0, 16)
beam.Position = UDim2.new(1, 3, 0.5, 0)
beam.BackgroundColor3 = Color3.fromRGB(0, 255, 180)
beam.BackgroundTransparency = 0.85
beam.ZIndex = 9
beam.Parent = car
local beamGrad = Instance.new("UIGradient")
beamGrad.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 180)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 180)),
})
beamGrad.Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0.6),
NumberSequenceKeypoint.new(1, 1),
})
beamGrad.Parent = beam
local tl = Instance.new("Frame")
tl.Size = UDim2.new(0, 4, 0, 20)
tl.Position = UDim2.new(0, -2, 0.52, 0)
tl.BackgroundColor3 = Color3.fromRGB(255, 40, 40)
tl.BackgroundTransparency = 0.2
tl.ZIndex = 11
tl.Parent = car
local function mkWheel(xp)
local w = Instance.new("Frame")
w.Size = UDim2.new(0, 28, 0, 28)
w.Position = xp
w.BackgroundColor3 = Color3.fromRGB(12, 18, 24)
w.BorderSizePixel = 0
w.ZIndex = 9
w.Parent = car
Instance.new("UICorner", w).CornerRadius = UDim.new(1, 0)
local ws = Instance.new("UIStroke", w)
ws.Color = Color3.fromRGB(0, 255, 160)
ws.Thickness = 1.5
ws.Transparency = 0.15
local hub = Instance.new("Frame")
hub.Size = UDim2.new(0, 10, 0, 10)
hub.Position = UDim2.new(0.5, -5, 0.5, -5)
hub.BackgroundColor3 = Color3.fromRGB(0, 200, 140)
hub.BackgroundTransparency = 0.3
hub.BorderSizePixel = 0
hub.ZIndex = 10
hub.Parent = w
Instance.new("UICorner", hub).CornerRadius = UDim.new(1, 0)
end
mkWheel(UDim2.new(0.13, -14, 0.82, -14))
mkWheel(UDim2.new(0.87, -14, 0.82, -14))
local underglow = Instance.new("Frame")
underglow.Size = UDim2.new(0.8, 0, 0, 6)
underglow.Position = UDim2.new(0.1, 0, 0.95, 0)
underglow.BackgroundColor3 = Color3.fromRGB(0, 255, 160)
underglow.BackgroundTransparency = 0.55
underglow.ZIndex = 8
underglow.Parent = car
Instance.new("UICorner", underglow).CornerRadius = UDim.new(1, 0)
local carScale = Instance.new("UIScale")
carScale.Scale = 0.15
car.Parent = bg
carScale.Parent = car
local particles = {}
for i = 1, 30 do
local p = Instance.new("Frame")
local sz = 2 + math.random(4)
p.Size = UDim2.new(0, sz, 0, sz)
if math.random() > 0.4 then
p.BackgroundColor3 = Color3.fromRGB(0, 255, 180)
else
p.BackgroundColor3 = Color3.fromRGB(220, 255, 240)
end
p.BackgroundTransparency = 0.15
p.BorderSizePixel = 0
p.ZIndex = 15
p.Visible = false
p.Parent = bg
Instance.new("UICorner", p).CornerRadius = UDim.new(1, 0)
table.insert(particles, p)
end
local smokes = {}
for i = 1, 18 do
local s = Instance.new("Frame")
local sz = 16 + math.random(24)
s.Size = UDim2.new(0, sz, 0, sz)
s.BackgroundColor3 = Color3.fromRGB(0, 255, 160)
s.BackgroundTransparency = 0.6
s.BorderSizePixel = 0
s.ZIndex = 7
s.Visible = false
s.Rotation = math.random(-45, 45)
s.Parent = bg
Instance.new("UICorner", s).CornerRadius = UDim.new(1, 0)
table.insert(smokes, s)
end
local logoBox = Instance.new("Frame")
logoBox.Name = "LogoBox"
logoBox.Size = UDim2.new(0, 520, 0, 340)
logoBox.AnchorPoint = Vector2.new(0.5, 0.5)
logoBox.Position = UDim2.new(0.5, 0, 0.44, 0)
logoBox.BackgroundTransparency = 1
logoBox.ZIndex = 20
logoBox.Visible = false
logoBox.Parent = bg
local panel = Instance.new("Frame")
panel.Size = UDim2.new(1, 0, 1, 0)
panel.BackgroundColor3 = Color3.fromRGB(4, 10, 8)
panel.BackgroundTransparency = 0.22
panel.BorderSizePixel = 0
panel.ZIndex = 21
panel.Parent = logoBox
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 22)
local pnS = Instance.new("UIStroke", panel)
pnS.Color = Color3.fromRGB(0, 255, 160)
pnS.Thickness = 1.5
pnS.Transparency = 0.18
local pnGlow = Instance.new("UIStroke")
pnGlow.Color = Color3.fromRGB(0, 255, 160)
pnGlow.Thickness = 5
pnGlow.Transparency = 0.9
pnGlow.Parent = panel
local logoScale = Instance.new("UIScale")
logoScale.Scale = 0
logoScale.Parent = logoBox
local triOuter = Instance.new("TextLabel")
triOuter.Size = UDim2.new(0, 100, 0, 100)
triOuter.Position = UDim2.new(0.5, -50, 0, 20)
triOuter.BackgroundTransparency = 1
triOuter.Text = "△"
triOuter.TextColor3 = Color3.fromRGB(0, 255, 160)
triOuter.TextTransparency = 1
triOuter.TextSize = 88
triOuter.Font = Enum.Font.GothamBlack
triOuter.ZIndex = 25
triOuter.Parent = logoBox
local triInner = Instance.new("TextLabel")
triInner.Size = UDim2.new(0, 50, 0, 50)
triInner.Position = UDim2.new(0.5, -25, 0, 46)
triInner.BackgroundTransparency = 1
triInner.Text = "▲"
triInner.TextColor3 = Color3.fromRGB(0, 255, 160)
triInner.TextTransparency = 1
triInner.TextSize = 42
triInner.Font = Enum.Font.GothamBlack
triInner.ZIndex = 26
triInner.Parent = logoBox
local titleL = Instance.new("TextLabel")
titleL.Size = UDim2.new(1, -40, 0, 42)
titleL.Position = UDim2.new(0, 20, 0, 130)
titleL.BackgroundTransparency = 1
titleL.Text = "三 角 洲 行 动"
titleL.TextColor3 = Color3.fromRGB(245, 255, 250)
titleL.TextTransparency = 1
titleL.TextSize = 32
titleL.Font = Enum.Font.GothamBlack
titleL.TextXAlignment = Enum.TextXAlignment.Center
titleL.ZIndex = 25
titleL.Parent = logoBox
local subL = Instance.new("TextLabel")
subL.Size = UDim2.new(1, -40, 0, 18)
subL.Position = UDim2.new(0, 20, 0, 174)
subL.BackgroundTransparency = 1
subL.Text = "DELTA FORCE // TACTICAL DRIFT"
subL.TextColor3 = Color3.fromRGB(0, 255, 160)
subL.TextTransparency = 1
subL.TextSize = 12
subL.Font = Enum.Font.GothamMedium
subL.TextXAlignment = Enum.TextXAlignment.Center
subL.ZIndex = 25
subL.Parent = logoBox
local pBack = Instance.new("Frame")
pBack.Size = UDim2.new(1, -80, 0, 6)
pBack.Position = UDim2.new(0, 40, 0, 218)
pBack.BackgroundColor3 = Color3.fromRGB(18, 36, 30)
pBack.BorderSizePixel = 0
pBack.ZIndex = 25
pBack.Parent = logoBox
Instance.new("UICorner", pBack).CornerRadius = UDim.new(1, 0)
local pFill = Instance.new("Frame")
pFill.Size = UDim2.new(0, 0, 1, 0)
pFill.BackgroundColor3 = Color3.fromRGB(0, 255, 160)
pFill.BorderSizePixel = 0
pFill.ZIndex = 26
pFill.Parent = pBack
Instance.new("UICorner", pFill).CornerRadius = UDim.new(1, 0)
local pGrad = Instance.new("UIGradient")
pGrad.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 120)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 255, 220)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 160)),
})
pGrad.Parent = pFill
local statL = Instance.new("TextLabel")
statL.Size = UDim2.new(1, -80, 0, 18)
statL.Position = UDim2.new(0, 40, 0, 232)
statL.BackgroundTransparency = 1
statL.Text = ""
statL.TextColor3 = Color3.fromRGB(200, 235, 225)
statL.TextTransparency = 1
statL.TextSize = 13
statL.Font = Enum.Font.Gotham
statL.TextXAlignment = Enum.TextXAlignment.Left
statL.ZIndex = 25
statL.Parent = logoBox
local corners = {}
for i, d in ipairs({
{UDim2.new(0, 0, 0, 10), UDim2.new(0, 12, 0, 12), 0},
{UDim2.new(0, 0, 0, 10), UDim2.new(1, -22, 0, 12), 90},
{UDim2.new(0, 0, 0, 10), UDim2.new(0, 12, 1, -20), -90},
{UDim2.new(0, 0, 0, 10), UDim2.new(1, -22, 1, -20), 180},
}) do
local m = Instance.new("TextLabel")
m.Size = d[1]; m.Position = d[2]
m.BackgroundTransparency = 1
m.Text = "⌜"
m.TextColor3 = Color3.fromRGB(0, 255, 160)
m.TextTransparency = 1
m.TextSize = 14
m.Font = Enum.Font.GothamBlack
m.Rotation = d[3]
m.ZIndex = 27
m.Parent = logoBox
table.insert(corners, m)
end
local topMark = Instance.new("TextLabel")
topMark.Size = UDim2.new(0, 100, 0, 14)
topMark.Position = UDim2.new(0, 16, 0, 14)
topMark.BackgroundTransparency = 1
topMark.Text = "BOOT v2.0 // DRIFT"
topMark.TextColor3 = Color3.fromRGB(0, 255, 160)
topMark.TextTransparency = 1
topMark.TextSize = 10
topMark.Font = Enum.Font.Code
topMark.TextXAlignment = Enum.TextXAlignment.Left
topMark.ZIndex = 25
topMark.Parent = logoBox
local botMark = Instance.new("TextLabel")
botMark.Size = UDim2.new(0, 110, 0, 14)
botMark.Position = UDim2.new(1, -126, 0, 14)
botMark.BackgroundTransparency = 1
botMark.Text = "SECURE // TACTICAL"
botMark.TextColor3 = Color3.fromRGB(0, 255, 160)
botMark.TextTransparency = 1
botMark.TextSize = 10
botMark.Font = Enum.Font.Code
botMark.TextXAlignment = Enum.TextXAlignment.Right
botMark.ZIndex = 25
botMark.Parent = logoBox
local bootScanLn = Instance.new("Frame")
bootScanLn.Size = UDim2.new(1, 0, 0, 2)
bootScanLn.Position = UDim2.new(0, 0, -0.02, 0)
bootScanLn.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
bootScanLn.BackgroundTransparency = 0.3
bootScanLn.ZIndex = 30
bootScanLn.Parent = bg
play(tw(bg, {BackgroundTransparency = 0}, 0.25))
task.wait(0.2)
road.Size = UDim2.new(1, 0, 0, 0)
road.BackgroundTransparency = 1
play(tw(road, {Size = UDim2.new(1, 0, 0, 180), BackgroundTransparency = 0}, 0.4, Enum.EasingStyle.Quint))
task.wait(0.3)
car.Rotation = -6
car.Position = UDim2.new(0.65, 80, 0.3, -40)
carScale.Scale = 0.12
play(tw(car, {
Position = UDim2.new(0.52, 20, 0.38, 10),
Rotation = -12,
}, 0.6, Enum.EasingStyle.Quint))
play(tw(carScale, {Scale = 0.75}, 0.6, Enum.EasingStyle.Quint))
task.wait(0.2)
for _, p in ipairs(particles) do p.Visible = true end
for _, s in ipairs(smokes) do s.Visible = true end
task.wait(0.25)
play(tw(car, {
Position = UDim2.new(0.5, 0, 0.42, 20),
Rotation = -18,
}, 0.35, Enum.EasingStyle.Cubic))
task.spawn(function()
for _, s in ipairs(smokes) do
local bx = 0.48 + math.random(-8, 8) / 100
local by = 0.52 + math.random(-5, 5) / 100
s.Position = UDim2.new(bx, 0, by, 0)
play(tw(s, {
Position = UDim2.new(bx - 0.08, 0, by + 0.06, 0),
Size = UDim2.new(0, s.Size.X.Offset + 35, 0, s.Size.Y.Offset + 35),
BackgroundTransparency = 1,
}, 0.7, Enum.EasingStyle.Quad))
end
end)
task.spawn(function()
for _, p in ipairs(particles) do
local sx = 0.46 + math.random(-10, 10) / 100
local sy = 0.42 + math.random(-12, 12) / 100
p.Position = UDim2.new(sx, 0, sy, 0)
play(tw(p, {
Position = UDim2.new(sx - 0.04, 0, sy + 0.02, 0),
BackgroundTransparency = 1,
}, 0.3 + math.random(15) / 100, Enum.EasingStyle.Quad))
end
end)
task.wait(0.25)
play(tw(car, {
Position = UDim2.new(0.5, 0, 0.44, 0),
Rotation = 0,
}, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out))
task.spawn(function()
local shakeCount = 0
while shakeCount < 6 and car.Parent do
local dx = (math.random() > 0.5 and 1 or -1) * (3 - shakeCount * 0.4)
local dy = (math.random() > 0.5 and 1 or -1) * (2 - shakeCount * 0.3)
car.Position = UDim2.new(0.5, dx, 0.44, dy)
task.wait(0.04)
car.Position = UDim2.new(0.5, 0, 0.44, 0)
task.wait(0.04)
shakeCount = shakeCount + 1
end
end)
task.wait(0.5)
for _, p in ipairs(particles) do p.Visible = false end
for _, s in ipairs(smokes) do s.Visible = false end
play(tw(bodyLow, {BackgroundTransparency = 0.3}, 0.15))
play(tw(bodyUp, {BackgroundTransparency = 0.3}, 0.15))
play(tw(underglow, {BackgroundTransparency = 0.2}, 0.15))
task.wait(0.15)
play(tw(bodyLow, {BackgroundTransparency = 0.05}, 0.15))
play(tw(bodyUp, {BackgroundTransparency = 0.05}, 0.15))
local carParts = car:GetChildren()
task.spawn(function()
for _, part in ipairs(carParts) do
if part:IsA("Frame") or part:IsA("UIStroke") or part:IsA("TextLabel") then
local destX = part.Position.X.Scale + (math.random() - 0.5) * 0.8
local destY = part.Position.Y.Scale + (math.random() - 0.5) * 0.8
play(tw(part, {
Position = UDim2.new(destX, 0, destY, 0),
BackgroundTransparency = 1,
}, 0.4 + math.random(10) / 100, Enum.EasingStyle.Quad))
if part:IsA("TextLabel") then
play(tw(part, {TextTransparency = 1}, 0.3))
end
if part:IsA("UIStroke") then
play(tw(part, {Transparency = 1}, 0.3))
end
end
end
end)
play(tw(carScale, {Scale = 0}, 0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In))
task.wait(0.3)
local burstParticles = {}
for i = 1, 20 do
local bp = Instance.new("Frame")
local sz = 4 + math.random(8)
bp.Size = UDim2.new(0, sz, 0, sz)
bp.BackgroundColor3 = Color3.fromRGB(0, 255, 180)
bp.BackgroundTransparency = 0.3
bp.BorderSizePixel = 0
bp.ZIndex = 19
bp.Position = UDim2.new(0.5, -sz/2, 0.44, -sz/2)
bp.Parent = bg
Instance.new("UICorner", bp).CornerRadius = UDim.new(1, 0)
table.insert(burstParticles, bp)
local angle = math.random() * math.pi * 2
local dist = 0.1 + math.random(15) / 100
play(tw(bp, {
Position = UDim2.new(0.5 + math.cos(angle) * dist, 0, 0.44 + math.sin(angle) * dist, 0),
BackgroundTransparency = 1,
Size = UDim2.new(0, sz + 10, 0, sz + 10),
}, 0.5 + math.random(15) / 100, Enum.EasingStyle.Quad))
end
task.wait(0.25)
car:Destroy()
task.delay(0.6, function()
for _, bp in ipairs(burstParticles) do
if bp and bp.Parent then bp:Destroy() end
end
end)
logoBox.Visible = true
logoScale.Scale = 0
play(tw(logoScale, {Scale = 1.04}, 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out))
task.wait(0.12)
play(tw(logoScale, {Scale = 1.0}, 0.12, Enum.EasingStyle.Quad))
play(tw(pnS, {Transparency = 0.18}, 0.3))
play(tw(pnGlow, {Transparency = 0.7}, 0.3))
play(tw(triOuter, {TextTransparency = 0.25}, 0.3))
play(tw(triInner, {TextTransparency = 0.05}, 0.25))
play(tw(titleL, {TextTransparency = 0}, 0.35))
play(tw(subL, {TextTransparency = 0.05}, 0.4))
play(tw(statL, {TextTransparency = 0.1}, 0.4))
play(tw(topMark, {TextTransparency = 0.15}, 0.3))
play(tw(botMark, {TextTransparency = 0.15}, 0.3))
for _, c in ipairs(corners) do
play(tw(c, {TextTransparency = 0.15}, 0.3))
end
task.wait(0.25)
local spinning = true
local spinConn
spinConn = RunService.RenderStepped:Connect(function(dt)
if not spinning or not triOuter.Parent then
if spinConn then spinConn:Disconnect() end
return
end
triOuter.Rotation = triOuter.Rotation + dt * 22
pGrad.Offset = Vector2.new((tick() % 1), 0)
end)
task.spawn(function()
while bootGui.Parent do
bootScanLn.Position = UDim2.new(0, 0, -0.02, 0)
play(tw(bootScanLn, {Position = UDim2.new(0, 0, 1.02, 0)}, 0.9, Enum.EasingStyle.Linear))
task.wait(0.95)
end
end)
local msgs = {
"引擎熄火，战术系统唤醒",
"建立加密通信链路",
"同步干员终端数据",
"校验三角洲行动主题",
"载入战术界面模块",
"漂移入场完成，准备出击",
}
for idx, msg in ipairs(msgs) do
statL.Text = "[" .. string.format("%02d", idx) .. "/06] " .. msg
play(tw(triInner, {
TextColor3 = Color3.fromRGB(180, 255, 220),
Size = UDim2.new(0, 58, 0, 58),
Position = UDim2.new(0.5, -29, 0, 42),
}, 0.1, Enum.EasingStyle.Quad))
task.wait(0.1)
play(tw(triInner, {
TextColor3 = Color3.fromRGB(0, 255, 160),
Size = UDim2.new(0, 50, 0, 50),
Position = UDim2.new(0.5, -25, 0, 46),
}, 0.18, Enum.EasingStyle.Quad))
play(tw(pFill, {Size = UDim2.new(idx / #msgs, 0, 1, 0)}, 0.32, Enum.EasingStyle.Quint))
task.wait(0.32)
end
statL.Text = "✔ 启动完成，正在打开三角洲行动面板"
play(tw(pFill, {Size = UDim2.new(1, 0, 1, 0)}, 0.2, Enum.EasingStyle.Quint))
task.wait(0.3)
spinning = false
play(tw(logoScale, {Scale = 0.85}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In))
play(tw(bg, {BackgroundTransparency = 1}, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In))
task.spawn(function()
for _, child in ipairs(bootGui:GetDescendants()) do
if child:IsA("TextLabel") or child:IsA("TextButton") then
pcall(function() tw(child, {TextTransparency = 1}, 0.25):Play() end)
elseif child:IsA("Frame") then
pcall(function() tw(child, {BackgroundTransparency = 1}, 0.25):Play() end)
elseif child:IsA("UIStroke") then
pcall(function() tw(child, {Transparency = 1}, 0.25):Play() end)
end
end
end)
task.wait(0.45)
if bootGui then bootGui:Destroy() end
end
successContinue.MouseButton1Click:Connect(function()
task.spawn(function()
hideSuccessOverlay()
hideKeyCard()
task.wait(0.4)
play(tw(mainBg, {BackgroundTransparency = 1}, 0.3))
play(tw(scanLine, {BackgroundTransparency = 1}, 0.3))
task.wait(0.35)
runBootAnimation()
task.wait(0.1)
showGroupPrompt()
task.spawn(function()
while not groupJoined and groupOverlay.Parent do
task.wait(0.1)
end
task.wait(0.3)
hideGroupOverlay()
task.wait(0.3)
if gui then gui:Destroy() end
end)
end)
end)
end)
if not ok then
warn("卡密系统加载失败：" .. tostring(err))
end
end

local function showErrorPopup(errorMessage)
    pcall(function()
        local coreGui = game:GetService("CoreGui")
        local playerGui = game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "JackErrorPopup"
        screenGui.ResetOnSpawn = false
        screenGui.IgnoreGuiInset = true
        screenGui.DisplayOrder = 999
        local ok2, err2 = pcall(function() screenGui.Parent = coreGui end)
        if not ok2 then screenGui.Parent = playerGui end

        local overlay = Instance.new("Frame")
        overlay.Name = "Overlay"
        overlay.Size = UDim2.new(1, 0, 1, 0)
        overlay.BackgroundColor3 = Color3.new(0, 0, 0)
        overlay.BackgroundTransparency = 0.5
        overlay.BorderSizePixel = 0
        overlay.ZIndex = 100
        overlay.Parent = screenGui

        local mainCard = Instance.new("Frame")
        mainCard.Name = "Card"
        mainCard.Size = UDim2.new(0, 440, 0, 380)
        mainCard.AnchorPoint = Vector2.new(0.5, 0.5)
        mainCard.Position = UDim2.new(0.5, 0, 0.5, 0)
        mainCard.BackgroundColor3 = Color3.fromRGB(22, 24, 28)
        mainCard.BorderSizePixel = 0
        mainCard.ZIndex = 101
        mainCard.Parent = screenGui
        local mainCorner = Instance.new("UICorner")
        mainCorner.CornerRadius = UDim.new(0, 12)
        mainCorner.Parent = mainCard
        local mainStroke = Instance.new("UIStroke")
        mainStroke.Color = Color3.fromRGB(80, 85, 90)
        mainStroke.Thickness = 1
        mainStroke.Parent = mainCard

        local titleBar = Instance.new("Frame")
        titleBar.Name = "TitleBar"
        titleBar.Size = UDim2.new(1, 0, 0, 38)
        titleBar.BackgroundColor3 = Color3.fromRGB(160, 50, 30)
        titleBar.BorderSizePixel = 0
        titleBar.ZIndex = 102
        titleBar.Parent = mainCard
        local titleCorner = Instance.new("UICorner")
        titleCorner.CornerRadius = UDim.new(0, 12)
        titleCorner.Parent = titleBar
        local titleFix = Instance.new("Frame")
        titleFix.Size = UDim2.new(1, 0, 0, 12)
        titleFix.Position = UDim2.new(0, 0, 1, -12)
        titleFix.BackgroundColor3 = Color3.fromRGB(160, 50, 30)
        titleFix.BorderSizePixel = 0
        titleFix.ZIndex = 102
        titleFix.Parent = titleBar

        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, -50, 1, 0)
        titleLabel.Position = UDim2.new(0, 15, 0, 0)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = "脚本执行出错"
        titleLabel.TextColor3 = Color3.new(1, 1, 1)
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextSize = 16
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.ZIndex = 103
        titleLabel.Parent = titleBar

        local closeBtn = Instance.new("TextButton")
        closeBtn.Name = "CloseBtn"
        closeBtn.Size = UDim2.new(0, 30, 0, 30)
        closeBtn.Position = UDim2.new(1, -35, 0, 4)
        closeBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 40)
        closeBtn.Text = "X"
        closeBtn.TextColor3 = Color3.new(1, 1, 1)
        closeBtn.Font = Enum.Font.GothamBold
        closeBtn.TextSize = 14
        closeBtn.AutoButtonColor = true
        closeBtn.ZIndex = 103
        closeBtn.Parent = titleBar
        local closeBtnCorner = Instance.new("UICorner")
        closeBtnCorner.CornerRadius = UDim.new(0, 6)
        closeBtnCorner.Parent = closeBtn

        local solutionHeader = Instance.new("TextLabel")
        solutionHeader.Name = "SolutionHeader"
        solutionHeader.Size = UDim2.new(1, -30, 0, 22)
        solutionHeader.Position = UDim2.new(0, 15, 0, 45)
        solutionHeader.BackgroundTransparency = 1
        solutionHeader.Text = "参考此处解决:"
        solutionHeader.TextColor3 = Color3.fromRGB(220, 180, 50)
        solutionHeader.Font = Enum.Font.GothamBold
        solutionHeader.TextSize = 14
        solutionHeader.TextXAlignment = Enum.TextXAlignment.Left
        solutionHeader.ZIndex = 102
        solutionHeader.Parent = mainCard

        local solutionText = Instance.new("TextLabel")
        solutionText.Name = "SolutionText"
        solutionText.Size = UDim2.new(1, -30, 0, 60)
        solutionText.Position = UDim2.new(0, 15, 0, 67)
        solutionText.BackgroundTransparency = 1
        solutionText.TextWrapped = true
        solutionText.TextColor3 = Color3.fromRGB(180, 185, 190)
        solutionText.Font = Enum.Font.Gotham
        solutionText.TextSize = 13
        solutionText.TextXAlignment = Enum.TextXAlignment.Left
        solutionText.TextYAlignment = Enum.TextYAlignment.Top
        solutionText.ZIndex = 102
        solutionText.Parent = mainCard

        local errorLabel = Instance.new("TextLabel")
        errorLabel.Name = "ErrorHeader"
        errorLabel.Size = UDim2.new(1, -30, 0, 18)
        errorLabel.Position = UDim2.new(0, 15, 0, 132)
        errorLabel.BackgroundTransparency = 1
        errorLabel.Text = "报错原文:"
        errorLabel.TextColor3 = Color3.fromRGB(220, 60, 50)
        errorLabel.Font = Enum.Font.GothamBold
        errorLabel.TextSize = 13
        errorLabel.TextXAlignment = Enum.TextXAlignment.Left
        errorLabel.ZIndex = 102
        errorLabel.Parent = mainCard

        local errorBox = Instance.new("Frame")
        errorBox.Name = "ErrorBox"
        errorBox.Size = UDim2.new(1, -30, 0, 80)
        errorBox.Position = UDim2.new(0, 15, 0, 152)
        errorBox.BackgroundColor3 = Color3.fromRGB(15, 16, 20)
        errorBox.BorderSizePixel = 0
        errorBox.ZIndex = 102
        errorBox.Parent = mainCard
        local errorBoxCorner = Instance.new("UICorner")
        errorBoxCorner.CornerRadius = UDim.new(0, 8)
        errorBoxCorner.Parent = errorBox

        local errorText = Instance.new("TextLabel")
        errorText.Name = "ErrorContent"
        errorText.Size = UDim2.new(1, -16, 1, -8)
        errorText.Position = UDim2.new(0, 8, 0, 4)
        errorText.BackgroundTransparency = 1
        errorText.TextWrapped = true
        errorText.TextColor3 = Color3.fromRGB(230, 80, 70)
        errorText.Font = Enum.Font.Code
        errorText.TextSize = 12
        errorText.TextXAlignment = Enum.TextXAlignment.Left
        errorText.TextYAlignment = Enum.TextYAlignment.Top
        errorText.ZIndex = 103
        errorText.Text = errorMessage
        errorText.Parent = errorBox

        local btnFrame = Instance.new("Frame")
        btnFrame.Name = "Buttons"
        btnFrame.Size = UDim2.new(1, -30, 0, 36)
        btnFrame.Position = UDim2.new(0, 15, 0, 240)
        btnFrame.BackgroundTransparency = 1
        btnFrame.ZIndex = 102
        btnFrame.Parent = mainCard

        local killBtn = Instance.new("TextButton")
        killBtn.Name = "KillScript"
        killBtn.Size = UDim2.new(0.3, 0, 1, 0)
        killBtn.Position = UDim2.new(0, 0, 0, 0)
        killBtn.BackgroundColor3 = Color3.fromRGB(160, 45, 30)
        killBtn.Text = "关闭脚本"
        killBtn.TextColor3 = Color3.new(1, 1, 1)
        killBtn.Font = Enum.Font.GothamBold
        killBtn.TextSize = 13
        killBtn.AutoButtonColor = true
        killBtn.ZIndex = 103
        killBtn.Parent = btnFrame
        Instance.new("UICorner", killBtn).CornerRadius = UDim.new(0, 8)

        local copyBtn = Instance.new("TextButton")
        copyBtn.Name = "CopyError"
        copyBtn.Size = UDim2.new(0.3, 0, 1, 0)
        copyBtn.Position = UDim2.new(0.35, 0, 0, 0)
        copyBtn.BackgroundColor3 = Color3.fromRGB(60, 65, 70)
        copyBtn.Text = "复制原文"
        copyBtn.TextColor3 = Color3.new(1, 1, 1)
        copyBtn.Font = Enum.Font.GothamBold
        copyBtn.TextSize = 13
        copyBtn.AutoButtonColor = true
        copyBtn.ZIndex = 103
        copyBtn.Parent = btnFrame
        Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 8)

        local reloadBtn = Instance.new("TextButton")
        reloadBtn.Name = "Reload"
        reloadBtn.Size = UDim2.new(0.3, 0, 1, 0)
        reloadBtn.Position = UDim2.new(0.7, 0, 0, 0)
        reloadBtn.BackgroundColor3 = Color3.fromRGB(40, 90, 140)
        reloadBtn.Text = "重新加载"
        reloadBtn.TextColor3 = Color3.new(1, 1, 1)
        reloadBtn.Font = Enum.Font.GothamBold
        reloadBtn.TextSize = 13
        reloadBtn.AutoButtonColor = true
        reloadBtn.ZIndex = 103
        reloadBtn.Parent = btnFrame
        Instance.new("UICorner", reloadBtn).CornerRadius = UDim.new(0, 8)

        local footer = Instance.new("TextLabel")
        footer.Name = "Footer"
        footer.Size = UDim2.new(1, -30, 0, 18)
        footer.Position = UDim2.new(0, 0, 1, -20)
        footer.BackgroundColor3 = Color3.fromRGB(28, 30, 35)
        footer.BorderSizePixel = 0
        footer.ZIndex = 102
        footer.Parent = mainCard
        local footerCorner = Instance.new("UICorner")
        footerCorner.CornerRadius = UDim.new(0, 0, 0, 12)
        footerCorner.Parent = footer
        footer.Text = "如无法解决请联系群管理员 1465486886"
        footer.TextColor3 = Color3.fromRGB(120, 125, 130)
        footer.Font = Enum.Font.Gotham
        footer.TextSize = 11
        footer.ZIndex = 103

        local errorMsg = errorMessage or "未知错误"

        local solutions = {
            {match = "Unload.*Connect", text = "当前UI库版本不支持窗口卸载事件，这不影响脚本正常使用，可以忽略此错误。"},
            {match = "FindFirstChild.*table", text = "代码对WindUI控件使用了错误的Roblox实例方法。控件是table而非Instance，不支持FindFirstChild/GetChildren等。"},
            {match = "fetchAnnounce", text = "公告模块未加载。这是复制粘贴残留代码，不影响任何功能。"},
            {match = "HttpError.*ConnectFail", text = "外部图片加载失败（网络不通）。检查网络连接，图片不显示不影响脚本功能。"},
            {match = "attempt to index nil", text = "某个对象为nil（未创建或路径错误）。可能WindUI未成功加载，或游戏对象尚未生成。"},
            {match = "loadstring", text = "远程库加载失败。检查网络连接，确认库链接有效。"},
            {match = "GetService", text = "服务获取失败。确认游戏服务存在且拼写正确。"},
            {match = "invalid key", text = "WindUI主题名称无效。检查SetTheme参数是否正确。"},
            {match = "Stack", text = "栈溢出，可能存在无限递归。请重新加载脚本。"},
        }

        local foundSolution = "未知错误，请联系群管理员获取帮助"
        for _, s in ipairs(solutions) do
            if errorMsg:lower():find(s.match:lower()) then
                foundSolution = s.text
                break
            end
        end
        solutionText.Text = foundSolution

        local function destroyAll()
            screenGui:Destroy()
        end

        closeBtn.MouseButton1Click:Connect(function()
            destroyAll()
        end)

        killBtn.MouseButton1Click:Connect(function()
            destroyAll()
            pcall(function()
                game:GetService("CoreGui"):FindFirstChild("WindUI"):Destroy()
            end)
            pcall(function()
                game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("WindUI"):Destroy()
            end)
        end)

        copyBtn.MouseButton1Click:Connect(function()
            pcall(function()
                if setclipboard then
                    setclipboard(errorMsg)
                else
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "已复制",
                        Text = "报错原文已复制到剪贴板",
                        Duration = 2
                    })
                end
            end)
        end)

        reloadBtn.MouseButton1Click:Connect(function()
            destroyAll()
            pcall(function()
                game:GetService("CoreGui"):FindFirstChild("WindUI"):Destroy()
            end)
            pcall(function()
                game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("WindUI"):Destroy()
            end)
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "重新加载",
                Text = "请重新执行脚本",
                Duration = 3
            })
        end)
    end)
end

local WindUI = nil
local mainScriptSuccess, mainScriptError = pcall(function()
WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/yuihghghg/RJ/refs/heads/main/ui.lua"))()
WindUI:Notify({
    Title = "欢迎使用",
    Content = "delta force 脚本中心",
    Duration = 3,
    Position = "Left"
})
WindUI:Notify({
    Title = "QQ群",
    Content = "🐧1040209982",
    Duration = 9,
})
WindUI:Notify({
    Title = "delta force 脚本中心",
    Content = "感谢你的使用",
    Duration = 9,
})
WindUI:Notify({
    Title = "更新",
    Content = "修复自然灾害少侠飞行无效",
    Duration = 9,
})
WindUI:Notify({
    Title = "紧急通知",
    Content = "优化了GUI渲染闪退问题",
    Duration = 11,
})
WindUI:Notify({
    Title = "作者飞机号",
    Content = "@you25801",
    Duration = 15,
})

local authorIds = {"yuihghghg"}
local authorSonIds = {"ghj8453"}
local playerGui = game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local function createAnimatedDetection(isAuthor)
    local sg = Instance.new("ScreenGui")
    sg.Name = "DeltaForceDetect"
    sg.ResetOnSpawn = false
    sg.IgnoreGuiInset = true
    sg.DisplayOrder = 999
    sg.Parent = playerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 380, 0, 100)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0)
    mainFrame.Position = UDim2.new(0.5, 0, 0.08, 0)
    mainFrame.BackgroundTransparency = 1
    mainFrame.ZIndex = 100
    mainFrame.Parent = sg

    local avatar = Instance.new("ImageLabel")
    avatar.Size = UDim2.new(0, 38, 0, 38)
    avatar.Position = UDim2.new(0, -80, 0.5, -19)
    avatar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    avatar.BackgroundTransparency = 1
    avatar.BorderSizePixel = 0
    avatar.ZIndex = 102
    avatar.Parent = mainFrame
    Instance.new("UICorner", avatar).CornerRadius = UDim.new(1, 0)
    local avatarBorder = Instance.new("UIStroke")
    avatarBorder.Color = Color3.fromRGB(220, 50, 50)
    avatarBorder.Thickness = 1.5
    avatarBorder.Transparency = 1
    avatarBorder.Parent = avatar
    local targetName = isAuthor and "yuihghghg" or "ghj8453"
    pcall(function()
        local userId = game:GetService("Players"):GetUserIdFromNameAsync(targetName)
        if userId then
            avatar.Image = game:GetService("Players"):GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
        end
    end)

    local strip = Instance.new("Frame")
    strip.Size = UDim2.new(0, 3, 0, 72)
    strip.Position = UDim2.new(0, -25, 0.5, -36)
    strip.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
    strip.BackgroundTransparency = 1
    strip.BorderSizePixel = 0
    strip.ZIndex = 102
    strip.Parent = mainFrame

    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 5, 0, 5)
    indicator.Position = UDim2.new(0, -18, 0.5, -3)
    indicator.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
    indicator.BackgroundTransparency = 1
    indicator.ZIndex = 102
    indicator.Parent = mainFrame
    Instance.new("UICorner", indicator).CornerRadius = UDim.new(1, 0)

    local nameL = Instance.new("TextLabel")
    nameL.Size = UDim2.new(0, 80, 0, 15)
    nameL.Position = UDim2.new(0, 10, 0, 12)
    nameL.BackgroundTransparency = 1
    nameL.Text = isAuthor and "yuihghghg" or "ghj8453"
    nameL.TextColor3 = Color3.fromRGB(230, 70, 70)
    nameL.Font = Enum.Font.GothamBold
    nameL.TextSize = 11
    nameL.TextXAlignment = Enum.TextXAlignment.Left
    nameL.TextTransparency = 1
    nameL.ZIndex = 103
    nameL.Parent = mainFrame

    local tagL = Instance.new("TextLabel")
    tagL.Size = UDim2.new(0, 90, 0, 11)
    tagL.Position = UDim2.new(0, 10, 0, 27)
    tagL.BackgroundTransparency = 1
    tagL.Text = isAuthor and "[ 脚本作者 ]" or "[ 作者儿子 ]"
    tagL.TextColor3 = Color3.fromRGB(160, 100, 100)
    tagL.Font = Enum.Font.Gotham
    tagL.TextSize = 9
    tagL.TextXAlignment = Enum.TextXAlignment.Left
    tagL.TextTransparency = 1
    tagL.ZIndex = 103
    tagL.Parent = mainFrame

    local titleL = Instance.new("TextLabel")
    titleL.Size = UDim2.new(0, 220, 0, 15)
    titleL.Position = UDim2.new(0, 65, 0, 12)
    titleL.BackgroundTransparency = 1
    titleL.Text = "核心反应堆功率"
    titleL.TextColor3 = Color3.fromRGB(215, 210, 210)
    titleL.Font = Enum.Font.GothamBold
    titleL.TextSize = 11
    titleL.TextXAlignment = Enum.TextXAlignment.Left
    titleL.TextTransparency = 1
    titleL.ZIndex = 103
    titleL.Parent = mainFrame

    local subL = Instance.new("TextLabel")
    subL.Size = UDim2.new(0, 220, 0, 10)
    subL.Position = UDim2.new(0, 65, 0, 27)
    subL.BackgroundTransparency = 1
    subL.Text = "DELTA FORCE NUCLEAR DETECTION SYSTEM"
    subL.TextColor3 = Color3.fromRGB(120, 85, 85)
    subL.Font = Enum.Font.Gotham
    subL.TextSize = 7.5
    subL.TextXAlignment = Enum.TextXAlignment.Left
    subL.TextTransparency = 1
    subL.ZIndex = 103
    subL.Parent = mainFrame

    local powerL = Instance.new("TextLabel")
    powerL.Size = UDim2.new(0, 260, 0, 28)
    powerL.Position = UDim2.new(0, 65, 0, 48)
    powerL.BackgroundTransparency = 1
    powerL.Text = ""
    powerL.TextColor3 = Color3.fromRGB(255, 60, 60)
    powerL.TextStrokeColor3 = Color3.fromRGB(180, 30, 30)
    powerL.TextStrokeTransparency = 0.3
    powerL.Font = Enum.Font.GothamBold
    powerL.TextScaled = true
    powerL.TextXAlignment = Enum.TextXAlignment.Left
    powerL.TextYAlignment = Enum.TextYAlignment.Center
    powerL.TextTransparency = 1
    powerL.ZIndex = 103
    powerL.Parent = mainFrame

    local mwL = Instance.new("TextLabel")
    mwL.Size = UDim2.new(0, 28, 0, 20)
    mwL.Position = UDim2.new(0, 330, 0, 52)
    mwL.BackgroundTransparency = 1
    mwL.Text = "MW"
    mwL.TextColor3 = Color3.fromRGB(150, 100, 100)
    mwL.TextStrokeColor3 = Color3.fromRGB(120, 50, 50)
    mwL.TextStrokeTransparency = 0.5
    mwL.Font = Enum.Font.GothamBold
    mwL.TextSize = 10
    mwL.TextTransparency = 1
    mwL.ZIndex = 103
    mwL.Parent = mainFrame

    local glowLine = Instance.new("Frame")
    glowLine.Size = UDim2.new(0, 295, 0, 2)
    glowLine.Position = UDim2.new(0, 65, 0, 78)
    glowLine.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    glowLine.BackgroundTransparency = 1
    glowLine.BorderSizePixel = 0
    glowLine.ZIndex = 101
    glowLine.Parent = mainFrame

    local targetText = isAuthor and "作者同服" or "儿子同服"
    local scanRunning = true

    task.spawn(function()
        task.wait(0.3)

        for i = 0, 22 do
            local t = i / 22
            local ease = 1 - (1 - t) * (1 - t)
            avatar.Position = UDim2.new(0, -80 + ease * 88, 0.5, -19)
            avatar.BackgroundTransparency = 1 - ease
            avatarBorder.Transparency = 1 - ease
            strip.Position = UDim2.new(0, -25 + ease * 80, 0.5, -36)
            strip.BackgroundTransparency = 1 - ease
            indicator.Position = UDim2.new(0, -18 + ease * 73, 0.5, -3)
            indicator.BackgroundTransparency = 1 - ease * 0.5
            task.wait(0.028)
        end

        for i = 0, 10 do
            local t = i / 10
            nameL.TextTransparency = 1 - t
            tagL.TextTransparency = 1 - t
            task.wait(0.03)
        end

        for i = 0, 14 do
            local t = i / 14
            local ease = t * t * (3 - 2 * t)
            titleL.TextTransparency = 1 - ease
            subL.TextTransparency = 1 - ease
            powerL.TextTransparency = 1 - ease
            mwL.TextTransparency = 1 - ease * 0.5
            glowLine.BackgroundTransparency = 1 - ease * 0.6
            task.wait(0.022)
        end

        powerL.Text = "00000"
        powerL.TextTransparency = 0

        task.wait(0.2)

        task.spawn(function()
            while scanRunning do
                for i = 0, 30 do
                    if not scanRunning then break end
                    glowLine.Size = UDim2.new(i / 30 * 0.95 + 0.05, 0, 0, 2)
                    glowLine.BackgroundTransparency = 0.5 + math.sin(i / 30 * math.pi) * 0.35
                    task.wait(0.02)
                end
                task.wait(0.3)
                glowLine.Size = UDim2.new(0.295 / 0.38, 0, 0, 2)
            end
        end)

        local totalCycles = 16
        local charsToShow = math.min(5, #targetText)
        for cycle = 1, totalCycles do
            local result = ""
            for c = 1, charsToShow do
                if cycle > totalCycles - charsToShow + c then
                    result = result .. string.sub(targetText, c, c)
                else
                    result = result .. tostring(math.random(0, 9))
                end
            end
            powerL.Text = result
            local speed = 0.04 + (cycle / totalCycles) * 0.08
            task.wait(speed)
        end
        powerL.Text = targetText

        task.spawn(function()
            while scanRunning do
                for b = 1, 3 do
                    if not scanRunning then break end
                    indicator.BackgroundTransparency = 0
                    task.wait(0.15)
                    indicator.BackgroundTransparency = 0.7
                    task.wait(0.15)
                end
                task.wait(0.5)
            end
        end)

        for p = 0, 39 do
            local wave = math.sin(p * math.pi / 10) * 0.5 + 0.5
            glowLine.BackgroundTransparency = 0.4 - wave * 0.25
            avatarBorder.Color = Color3.fromRGB(220 - wave * 40, 50, 50)
            strip.BackgroundColor3 = Color3.fromRGB(220 - wave * 40, 60, 60)
            powerL.TextColor3 = Color3.fromRGB(255, 60 + wave * 30, 60 + wave * 30)
            task.wait(0.25)
        end

        scanRunning = false
        glowLine.BackgroundTransparency = 1

        for i = 0, 20 do
            local t = i / 20
            local ease = t * t
            avatar.Position = UDim2.new(0, 8 - ease * 88, 0.5, -19)
            avatar.BackgroundTransparency = ease
            avatarBorder.Transparency = ease
            strip.Position = UDim2.new(0, 55 - ease * 80, 0.5, -36)
            strip.BackgroundTransparency = ease
            indicator.BackgroundTransparency = 1
            nameL.TextTransparency = ease
            tagL.TextTransparency = ease
            titleL.TextTransparency = ease
            subL.TextTransparency = ease
            powerL.TextTransparency = ease
            mwL.TextTransparency = ease
            glowLine.BackgroundTransparency = 0.15 + ease * 0.85
            task.wait(0.022)
        end

        task.wait(0.1)
        sg:Destroy()
    end)
end

local function checkPlayersInServer()
    task.spawn(function()
        task.wait(3)
        local players = game:GetService("Players"):GetPlayers()
        local detected = false
        for _, player in ipairs(players) do
            for _, aid in ipairs(authorIds) do
                if player.Name == aid then
                    createAnimatedDetection(true)
                    detected = true
                    break
                end
            end
            if detected then break end
            for _, sid in ipairs(authorSonIds) do
                if player.Name == sid then
                    createAnimatedDetection(false)
                    detected = true
                    break
                end
            end
            if detected then break end
        end
        game:GetService("Players").PlayerAdded:Connect(function(player)
            task.wait(1)
            for _, aid in ipairs(authorIds) do
                if player.Name == aid then
                    createAnimatedDetection(true)
                    return
                end
            end
            for _, sid in ipairs(authorSonIds) do
                if player.Name == sid then
                    createAnimatedDetection(false)
                    return
                end
            end
        end)
    end)
end

checkPlayersInServer()

local techGreen = Color3.fromRGB(0, 255, 160)
local black = Color3.fromRGB(255, 255, 255)
local brightGray = Color3.fromRGB(240, 240, 245)
WindUI:AddTheme({
    Name = "DeltaForce",
    WindowTopbarTitle = techGreen,
    WindowTopbarAuthor = techGreen,
    TabTitle = techGreen,
    ElementTitle = black,
    ButtonText = black,
    PopupTitle = black,
    DialogTitle = black,
    ElementDesc = brightGray,
    PopupContent = black,
    DialogContent = black ,
    PlaceholderText = techGreen,
    Icon = techGreen,
    TooltipText = black,
    TooltipSecondaryText = black,
})
WindUI:SetTheme("DeltaForce")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Window = WindUI:CreateWindow({
    Title = "delta force 脚本中心",
    Author = "User",
    Folder = "MyHub",
    Transparent = true, 
    Theme = "DeltaForce",
    SideBarWidth = 130,
    HideSearchBar = false,
    ScrollBarEnabled = true,
    Background = "https://i.postimg.cc/rsyX02W1/mmexport1783823900262.jpg",
    BackgroundImageTransparency = 0.7,
    User = { Enabled = true },
    ToggleKey = Enum.KeyCode.F,
})
print("✅ 窗口已创建，主题 DeltaForce 已应用")
 local SubTitleTag = Window:Tag({
     Title = "版本 V2.0 | ⚠︎死于2024复活2026",
     Color = Color3.fromHex("#cccccc")
 })
 local SubTitleTag = Window:Tag({
     Title = "作者 | LowPaol",
     Color = Color3.fromHex("#ff007f")
 })
local sjzIcon = "https://i.postimg.cc/d1sH5qJN/1781878127576.png"
local Tabs = {
    gonggao = Window:Tab({ Title = "公告", Icon = sjzIcon }),
    zho = Window:Tab({ Title = "通用", Icon = sjzIcon }),
    fe = Window:Tab({ Title = "🔞动作fe🔞", Icon = sjzIcon }),
    feFx = Window:Tab({ Title = "FE粒子特效", Icon = sjzIcon }),
    ESP = Window:Tab({ Title = "ESP", Icon = sjzIcon }),
    bot = Window:Tab({ Title = "HOOK自瞄", Icon = sjzIcon }),
    Lemon = Window:Tab({ Title = "柠檬脚本", Icon = sjzIcon }),
    Lucky = Window:Tab({ Title = "踢幸运方块", Icon = sjzIcon }),
    MiniWar = Window:Tab({ Title = "迷你战争", Icon = sjzIcon }),
    doors = Window:Tab({ Title = "doors", Icon = sjzIcon }),
    dao = Window:Tab({ Title = "刀刃球", Icon = sjzIcon }),
    shen99 = Window:Tab({ Title = "森林中的99夜", Icon = sjzIcon }),
    mosha = Window:Tab({ Title = "谋杀悬疑2", Icon = sjzIcon })
}
Tabs.fwq = Window:Tab({ Title = "✳️服务器✳️", Icon = sjzIcon })
Tabs.JiSuChuanQi = Window:Tab({ Title = "极速传奇", Icon = sjzIcon })
Tabs.QiCheYingXiao = Window:Tab({ Title = "汽车营销大亨", Icon = sjzIcon })
Tabs.ChengWeiQiGai = Window:Tab({ Title = "成为乞丐", Icon = sjzIcon })
Tabs.ZaiChaoShi = Window:Tab({ Title = "在超市生活一周", Icon = sjzIcon })
Tabs.YuanSuLiLiang = Window:Tab({ Title = "元素力量大亨", Icon = sjzIcon })
Tabs.JianZaoJiDi = Window:Tab({ Title = "建造你的基地", Icon = sjzIcon })
Tabs.ZhengZaiXunQiu = Window:Tab({ Title = "正在寻求", Icon = sjzIcon })
Tabs.ZhongZhiHuaYuan = Window:Tab({ Title = "种植花园", Icon = sjzIcon })
Tabs.ZiRanZaiHai = Window:Tab({ Title = "自然灾害", Icon = sjzIcon })
Tabs.ZuiQiangZhanChang = Window:Tab({ Title = "最强战场", Icon = sjzIcon})
Tabs.tp = Window:Tab({ Title = "躲避", Icon = sjzIcon})
Tabs.zw = Window:Tab({ Title = "植物大战脑红❌可能没效果", Icon = sjzIcon})
Tabs.kg = Window:Tab({ Title = "矿井", Icon = sjzIcon})
Tabs.dw = Window:Tab({ Title = "动物医院（异常） 🧪", Icon = sjzIcon})
Tabs.NiuFu = Window:Tab({ Title = "🎵牛福", Icon = sjzIcon})
Tabs.Emote = Window:Tab({ Title = "🎭动作包", Icon = sjzIcon})
Tabs.Prison = Window:Tab({ Title = "监狱人生 🏚️", Icon = sjzIcon})

Tabs.ShouQiangJingJiChang = Window:Tab({ Title = "🔫手枪竞技场", Icon = sjzIcon })

local sqSec1 = Tabs.ShouQiangJingJiChang:Section({ Title = "Low Paol 独家" })

sqSec1:Button({
    Title = "全图爆头杀戮",
    Desc = "Low Paol独家 | 自动锁定全图敌人头部进行爆头击杀",
    Callback = function()
        task.spawn(function()
            local Players = game:GetService("Players")
            local player = Players.LocalPlayer
            repeat task.wait(1) until player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local Remote = ReplicatedStorage:WaitForChild("SystemResources"):WaitForChild("BufferCache"):WaitForChild("RequestActionSync")
            local attackIndex = 1
            local function GetCharacter()
                local character = player.Character
                if character then
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    return character, rootPart
                end
                return nil, nil
            end
            local function GetAllTargets()
                local targets = {}
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= player then
                        local char = plr.Character
                        if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
                            local humanoid = char.Humanoid
                            if humanoid.Health > 0 then
                                local hrp = char.HumanoidRootPart
                                local targetPart = char:FindFirstChild("Head") or hrp
                                table.insert(targets, {
                                    character = char,
                                    hrp = hrp,
                                    humanoid = humanoid,
                                    targetPart = targetPart
                                })
                            end
                        end
                    end
                end
                return targets
            end
            local function PerformAttack()
                local char, rp = GetCharacter()
                if not char or not rp then return end
                local targets = GetAllTargets()
                if #targets == 0 then
                    attackIndex = 1
                    return
                end
                if attackIndex > #targets then
                    attackIndex = 1
                end
                local target = targets[attackIndex]
                if not target then return end
                local targetHrp = target.hrp
                local targetHumanoid = target.humanoid
                local targetPart = target.targetPart
                if targetHrp and targetHumanoid and targetPart then
                    local args = {
                        {
                            direction = (targetHrp.Position - rp.Position).Unit,
                            hitPosition = targetPart.Position,
                            origin = rp.Position,
                            hitInstance = targetPart,
                            hitHumanoid = targetHumanoid,
                            IsHeadshot = (targetPart.Name == "Head")
                        }
                    }
                    Remote:FireServer(unpack(args))
                end
                attackIndex = attackIndex + 1
                if attackIndex > #targets then
                    attackIndex = 1
                end
            end
            while task.wait(1.5) do
                PerformAttack()
            end
        end)
    end
})

local function getCharacter()
    if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        return LocalPlayer.Character
    end
    return nil
end
local musicSection = Tabs.NiuFu:Section({ Title = "牛福" })
local niuFuSound = nil
local niuFuPlaying = false
local niuFuVisualizer = false
local niuFuVizParts = {}
local niuFuVizConn = nil
local niuFuCurrentId = "116704489332329"
local niuFuVolume = 10
local niuFuSpeed = 1
local niuFuReady = false
local function cleanId(raw)
local s = tostring(raw)
if s:sub(1,1) == "a" then s = s:sub(2) end
return s
end
local function stopNiuFuVisualizer()
if niuFuVizConn then pcall(function() niuFuVizConn:Disconnect() end) niuFuVizConn = nil end
for _, p in ipairs(niuFuVizParts) do pcall(function() p:Destroy() end) end
niuFuVizParts = {}
end
local function stopNiuFuMusic()
niuFuPlaying = false
if niuFuSound then pcall(function() niuFuSound:Stop() niuFuSound:Destroy() end) niuFuSound = nil end
end
local function playNiuFuMusic(soundId)
stopNiuFuMusic()
local id = cleanId(soundId)
niuFuSound = Instance.new("Sound")
niuFuSound.SoundId = "rbxassetid://" .. id
niuFuSound.Volume = niuFuVolume
niuFuSound.PlaybackSpeed = niuFuSpeed
niuFuSound.Looped = true
niuFuSound.Parent = game:GetService("SoundService")
pcall(function() niuFuSound:Play() niuFuPlaying = true end)
if not niuFuPlaying then
    delay(3, function()
        pcall(function()
            if niuFuSound and not niuFuPlaying then
                niuFuSound:Play()
                niuFuPlaying = true
            end
        end)
    end)
end
niuFuCurrentId = id
end
musicSection:Button({
    Title = "▶️ 播放音乐",
    Desc = "播放当前选中的歌曲",
    Callback = function()
playNiuFuMusic(niuFuCurrentId)
end
})
musicSection:Button({
    Title = "⏹️ 停止音乐",
    Desc = "停止当前播放的音乐",
    Callback = function()
stopNiuFuMusic()
end
})
musicSection:Slider({
    Title = "🔊 音量",
    Value = { Min = 0, Max = 10, Default = 10 },
    Callback = function(value)
niuFuVolume = value
if niuFuSound then niuFuSound.Volume = value end
end,
    Step = 0.5,
})
musicSection:Slider({
    Title = "⚡ 播放速度",
    Value = { Min = 0.25, Max = 4, Default = 1 },
    Callback = function(value)
niuFuSpeed = value
if niuFuSound then niuFuSound.PlaybackSpeed = value end
end,
    Step = 0.25,
})
musicSection:Toggle({
    Callback = function(state)
niuFuVisualizer = state
if state then
    stopNiuFuVisualizer()
    local player = LocalPlayer
    local RunService = game:GetService("RunService")
    local container = Instance.new("Model")
    container.Name = "NiuFuVisualizer"
    container.Parent = workspace.CurrentCamera
    local barCount = 32
    for i = 1, barCount do
        local bar = Instance.new("Part")
        bar.Material = Enum.Material.Neon
        bar.CanCollide = false
        bar.Anchored = true
        bar.Shape = Enum.PartType.Block
        bar.Size = Vector3.new(0.15, 0.5, 0.15)
        bar.Transparency = 0
        bar.Color = Color3.fromHSV(i / barCount, 0.8, 1)
        bar.Parent = container
        table.insert(niuFuVizParts, bar)
    end
    niuFuVizConn = RunService.RenderStepped:Connect(function(dt)
        local character = player.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then return end
        local hrp = character.HumanoidRootPart
        for i, bar in ipairs(niuFuVizParts) do
            local t = (i - 1) / barCount
            local angle = t * math.pi * 2 + tick() * 1.5
            local baseR = 2.0
            local height = 0.5
            if niuFuSound and niuFuPlaying then
                local pos = niuFuSound.TimePosition
                height = 0.3 + math.abs(math.sin(pos * 4 + i * 0.8)) * 3.5
                local bass = math.abs(math.sin(pos * 2)) * 0.5
                height = height + bass * 1.5
            else
                height = 0.3 + math.sin(tick() * 2 + i * 0.5) * 0.3
            end
            local x = math.cos(angle) * baseR
            local z = math.sin(angle) * baseR
            bar.CFrame = hrp.CFrame * CFrame.new(x, height * 0.5 + 0.2, z)
            bar.Size = Vector3.new(0.15, height, 0.15)
            local hue = ((tick() * 0.1 + i / barCount) % 1)
            bar.Color = Color3.fromHSV(hue, 0.75, 1)
        end
    end)
else
    stopNiuFuVisualizer()
end
end,
    Title = "🌈 彩虹可视化器",
    Desc = "显示音乐节奏条",
})
niuFuReady = true
musicSection:Space()
musicSection:Dropdown({
    Callback = function(option)
niuFuCurrentId = option
end,
    Values = {
        [1] = "116704489332329",
    },
    Title = "🎧 选择歌曲",
    Desc = "选择一首歌曲播放",
    Value = "116704489332329",
})
musicSection:Space()
musicSection:Input({
    Callback = function(text)
if text and text ~= "" and text ~= "0" then
    niuFuCurrentId = text
    playNiuFuMusic(text)
end
end,
    Title = "📞 输入音乐ID",
    Desc = "输入Roblox音频ID播放自定义歌曲",
    Placeholder = "输入Roblox音乐ID...",
    Default = "116704489332329",
})
local fxS1 = Tabs.feFx:Section({ Title = "FE粒子特效" })
local feFx_active1 = nil
local feFx_conn1 = nil
local feFx_model1 = nil
local function feFx_stop1()
if feFx_conn1 then
pcall(function() feFx_conn1:Disconnect() end)
feFx_conn1 = nil
end
if feFx_model1 then
pcall(function() feFx_model1:Destroy() end)
feFx_model1 = nil
end
feFx_active1 = nil
end
fxS1:Button({
    Title = "关闭所有特效",
    Desc = "清除身上所有粒子效果",
    Callback = function()
feFx_stop1()
end
})
fxS1:Button({
    Title = "🌈 彩虹光环",
    Desc = "头顶旋转的彩虹光环",
    Callback = function()
feFx_stop1()
local player = LocalPlayer
local RunService = game:GetService("RunService")
local haloModel = Instance.new("Model")
haloModel.Name = "ClientHalo3D"
haloModel.Parent = workspace.CurrentCamera
local centerPart = Instance.new("Part")
centerPart.Size = Vector3.new(0.1, 0.1, 0.1)
centerPart.Transparency = 1
centerPart.CanCollide = false
centerPart.Anchored = true
centerPart.Parent = haloModel
haloModel.PrimaryPart = centerPart
local haloParts = {}
local jointParts = {}
local segments = 64
for i = 1, segments do
local p = Instance.new("Part")
p.Material = Enum.Material.Neon
p.CanCollide = false
p.Anchored = true
p.Shape = Enum.PartType.Cylinder
p.Parent = haloModel
table.insert(haloParts, p)
local s = Instance.new("Part")
s.Material = Enum.Material.Neon
s.CanCollide = false
s.Anchored = true
s.Shape = Enum.PartType.Ball
s.Parent = haloModel
table.insert(jointParts, s)
end
local currentRotation = 0
feFx_model1 = haloModel
feFx_active1 = "rainbow"
feFx_conn1 = RunService.RenderStepped:Connect(function(dt)
local character = player.Character
if not character or not character:FindFirstChild("Head") then return end
local head = character.Head
if not haloModel or not haloModel.Parent then return end
currentRotation = (currentRotation + dt * 1.5) % (math.pi * 2)
local yOffset = 2.2 + math.sin(tick() * 2.5) * 0.08
centerPart.CFrame = head.CFrame * CFrame.new(0, yOffset, 0) * CFrame.Angles(0, currentRotation, 0)
local positions = {}
local colors = {}
for i = 1, segments + 1 do
local angle = (i / segments) * math.pi * 2
local x = math.cos(angle) * 1.2
local z = math.sin(angle) * 1.2
local localWave = math.sin(tick() * 3 + angle * 2) * 0.05
local partColor = Color3.fromHSV((tick() * 0.15 + i / segments) % 1, 1, 1)
local worldPos = Vector3.new(x, localWave, z)
table.insert(positions, centerPart.CFrame * worldPos)
table.insert(colors, partColor)
end
for i = 1, segments do
local p = haloParts[i]
local s = jointParts[i]
local pos1 = positions[i]
local pos2 = positions[i + 1]
s.Size = Vector3.new(0.26, 0.26, 0.26)
s.CFrame = CFrame.new(pos1)
s.Color = colors[i]
local distance = (pos2 - pos1).Magnitude
p.Size = Vector3.new(distance + 0.01, 0.22, 0.22)
p.CFrame = CFrame.lookAt(pos1:Lerp(pos2, 0.5), pos2) * CFrame.Angles(0, math.rad(90), 0)
p.Color = colors[i]
end
end)
end
})
fxS1:Button({
    Title = "🔥 烈焰光环",
    Desc = "头顶燃烧的火焰光环",
    Callback = function()
feFx_stop1()
local player = LocalPlayer
local RunService = game:GetService("RunService")
local haloModel = Instance.new("Model")
haloModel.Name = "ClientHalo3D"
haloModel.Parent = workspace.CurrentCamera
local centerPart = Instance.new("Part")
centerPart.Size = Vector3.new(0.1, 0.1, 0.1)
centerPart.Transparency = 1
centerPart.CanCollide = false
centerPart.Anchored = true
centerPart.Parent = haloModel
haloModel.PrimaryPart = centerPart
local haloParts = {}
local jointParts = {}
local segments = 64
for i = 1, segments do
local p = Instance.new("Part")
p.Material = Enum.Material.Neon
p.CanCollide = false
p.Anchored = true
p.Shape = Enum.PartType.Cylinder
p.Parent = haloModel
table.insert(haloParts, p)
local s = Instance.new("Part")
s.Material = Enum.Material.Neon
s.CanCollide = false
s.Anchored = true
s.Shape = Enum.PartType.Ball
s.Parent = haloModel
table.insert(jointParts, s)
end
local currentRotation = 0
feFx_model1 = haloModel
feFx_active1 = "fire"
feFx_conn1 = RunService.RenderStepped:Connect(function(dt)
local character = player.Character
if not character or not character:FindFirstChild("Head") then return end
local head = character.Head
if not haloModel or not haloModel.Parent then return end
currentRotation = (currentRotation + dt * 2) % (math.pi * 2)
local yOffset = 2.0 + math.sin(tick() * 3) * 0.1
centerPart.CFrame = head.CFrame * CFrame.new(0, yOffset, 0) * CFrame.Angles(0, currentRotation, 0)
local positions = {}
local colors = {}
for i = 1, segments + 1 do
local angle = (i / segments) * math.pi * 2
local x = math.cos(angle) * 1.1
local z = math.sin(angle) * 1.1
local fireHue = 0.02 + (math.sin(tick() * 4 + angle * 4) * 0.04)
local partColor = Color3.fromHSV(fireHue, 0.95, 1)
local localWave = math.sin(tick() * 6 + angle * 4) * 0.12
local worldPos = Vector3.new(x, localWave, z)
table.insert(positions, centerPart.CFrame * worldPos)
table.insert(colors, partColor)
end
for i = 1, segments do
local p = haloParts[i]
local s = jointParts[i]
local pos1 = positions[i]
local pos2 = positions[i + 1]
s.Size = Vector3.new(0.28, 0.28, 0.28)
s.CFrame = CFrame.new(pos1)
s.Color = colors[i]
local distance = (pos2 - pos1).Magnitude
p.Size = Vector3.new(distance + 0.01, 0.24, 0.24)
p.CFrame = CFrame.lookAt(pos1:Lerp(pos2, 0.5), pos2) * CFrame.Angles(0, math.rad(90), 0)
p.Color = colors[i]
end
end)
end
})
fxS1:Button({
    Title = "👼 天使光环",
    Desc = "金色神圣的天使光环",
    Callback = function()
feFx_stop1()
local player = LocalPlayer
local RunService = game:GetService("RunService")
local haloModel = Instance.new("Model")
haloModel.Name = "ClientHalo3D"
haloModel.Parent = workspace.CurrentCamera
local centerPart = Instance.new("Part")
centerPart.Size = Vector3.new(0.1, 0.1, 0.1)
centerPart.Transparency = 1
centerPart.CanCollide = false
centerPart.Anchored = true
centerPart.Parent = haloModel
haloModel.PrimaryPart = centerPart
local haloParts = {}
local jointParts = {}
local segments = 64
for i = 1, segments do
local p = Instance.new("Part")
p.Material = Enum.Material.Neon
p.CanCollide = false
p.Anchored = true
p.Shape = Enum.PartType.Cylinder
p.Parent = haloModel
table.insert(haloParts, p)
local s = Instance.new("Part")
s.Material = Enum.Material.Neon
s.CanCollide = false
s.Anchored = true
s.Shape = Enum.PartType.Ball
s.Parent = haloModel
table.insert(jointParts, s)
end
local currentRotation = 0
feFx_model1 = haloModel
feFx_active1 = "angel"
feFx_conn1 = RunService.RenderStepped:Connect(function(dt)
local character = player.Character
if not character or not character:FindFirstChild("Head") then return end
local head = character.Head
if not haloModel or not haloModel.Parent then return end
currentRotation = (currentRotation + dt * 0.8) % (math.pi * 2)
local yOffset = 2.4 + math.sin(tick() * 1.5) * 0.06
centerPart.CFrame = head.CFrame * CFrame.new(0, yOffset, 0) * CFrame.Angles(0, currentRotation, 0)
local positions = {}
local colors = {}
for i = 1, segments + 1 do
local angle = (i / segments) * math.pi * 2
local x = math.cos(angle) * 1.3
local z = math.sin(angle) * 1.3
local localWave = math.sin(tick() * 1.2 + angle) * 0.02
local brightness = 0.85 + math.sin(tick() * 2 + angle * 3) * 0.15
local partColor = Color3.fromRGB(255 * brightness, 235 * brightness, 140 * brightness)
local worldPos = Vector3.new(x, localWave, z)
table.insert(positions, centerPart.CFrame * worldPos)
table.insert(colors, partColor)
end
for i = 1, segments do
local p = haloParts[i]
local s = jointParts[i]
local pos1 = positions[i]
local pos2 = positions[i + 1]
s.Size = Vector3.new(0.22, 0.22, 0.22)
s.CFrame = CFrame.new(pos1)
s.Color = colors[i]
local distance = (pos2 - pos1).Magnitude
p.Size = Vector3.new(distance + 0.01, 0.18, 0.18)
p.CFrame = CFrame.lookAt(pos1:Lerp(pos2, 0.5), pos2) * CFrame.Angles(0, math.rad(90), 0)
p.Color = colors[i]
end
end)
end
})
fxS1:Button({
    Title = "❄️ 冰霜光环",
    Desc = "蓝色冰晶光环",
    Callback = function()
feFx_stop1()
local player = LocalPlayer
local RunService = game:GetService("RunService")
local haloModel = Instance.new("Model")
haloModel.Name = "ClientHalo3D"
haloModel.Parent = workspace.CurrentCamera
local centerPart = Instance.new("Part")
centerPart.Size = Vector3.new(0.1, 0.1, 0.1)
centerPart.Transparency = 1
centerPart.CanCollide = false
centerPart.Anchored = true
centerPart.Parent = haloModel
haloModel.PrimaryPart = centerPart
local haloParts = {}
local jointParts = {}
local segments = 64
for i = 1, segments do
local p = Instance.new("Part")
p.Material = Enum.Material.Neon
p.CanCollide = false
p.Anchored = true
p.Shape = Enum.PartType.Cylinder
p.Parent = haloModel
table.insert(haloParts, p)
local s = Instance.new("Part")
s.Material = Enum.Material.Neon
s.CanCollide = false
s.Anchored = true
s.Shape = Enum.PartType.Ball
s.Parent = haloModel
table.insert(jointParts, s)
end
local currentRotation = 0
feFx_model1 = haloModel
feFx_active1 = "ice"
feFx_conn1 = RunService.RenderStepped:Connect(function(dt)
local character = player.Character
if not character or not character:FindFirstChild("Head") then return end
local head = character.Head
if not haloModel or not haloModel.Parent then return end
currentRotation = (currentRotation + dt * 1.0) % (math.pi * 2)
local yOffset = 2.2 + math.sin(tick() * 1.8) * 0.07
centerPart.CFrame = head.CFrame * CFrame.new(0, yOffset, 0) * CFrame.Angles(0, currentRotation, 0)
local positions = {}
local colors = {}
for i = 1, segments + 1 do
local angle = (i / segments) * math.pi * 2
local x = math.cos(angle) * 1.2
local z = math.sin(angle) * 1.2
local shimmer = math.sin(tick() * 4 + angle * 3) * 0.15
local localWave = math.sin(tick() * 2.5 + angle * 2) * 0.04
local partColor = Color3.fromRGB(100 + shimmer * 155, 200 + shimmer * 55, 255)
local worldPos = Vector3.new(x, localWave, z)
table.insert(positions, centerPart.CFrame * worldPos)
table.insert(colors, partColor)
end
for i = 1, segments do
local p = haloParts[i]
local s = jointParts[i]
local pos1 = positions[i]
local pos2 = positions[i + 1]
s.Size = Vector3.new(0.24, 0.24, 0.24)
s.CFrame = CFrame.new(pos1)
s.Color = colors[i]
local distance = (pos2 - pos1).Magnitude
p.Size = Vector3.new(distance + 0.01, 0.2, 0.2)
p.CFrame = CFrame.lookAt(pos1:Lerp(pos2, 0.5), pos2) * CFrame.Angles(0, math.rad(90), 0)
p.Color = colors[i]
end
end)
end
})
fxS1:Button({
    Title = "💀 暗影漩涡",
    Desc = "紫色暗影旋转漩涡光环",
    Callback = function()
feFx_stop1()
local player = LocalPlayer
local RunService = game:GetService("RunService")
local haloModel = Instance.new("Model")
haloModel.Name = "ClientHalo3D"
haloModel.Parent = workspace.CurrentCamera
local centerPart = Instance.new("Part")
centerPart.Size = Vector3.new(0.1, 0.1, 0.1)
centerPart.Transparency = 1
centerPart.CanCollide = false
centerPart.Anchored = true
centerPart.Parent = haloModel
haloModel.PrimaryPart = centerPart
local haloParts = {}
local jointParts = {}
local segments = 64
for i = 1, segments do
local p = Instance.new("Part")
p.Material = Enum.Material.Neon
p.CanCollide = false
p.Anchored = true
p.Shape = Enum.PartType.Cylinder
p.Parent = haloModel
table.insert(haloParts, p)
local s = Instance.new("Part")
s.Material = Enum.Material.Neon
s.CanCollide = false
s.Anchored = true
s.Shape = Enum.PartType.Ball
s.Parent = haloModel
table.insert(jointParts, s)
end
local currentRotation = 0
feFx_model1 = haloModel
feFx_active1 = "shadow"
feFx_conn1 = RunService.RenderStepped:Connect(function(dt)
local character = player.Character
if not character or not character:FindFirstChild("Head") then return end
local head = character.Head
if not haloModel or not haloModel.Parent then return end
currentRotation = (currentRotation + dt * 2.5) % (math.pi * 2)
local yOffset = 2.0 + math.sin(tick() * 3.5) * 0.1
centerPart.CFrame = head.CFrame * CFrame.new(0, yOffset, 0) * CFrame.Angles(0, currentRotation, 0)
local positions = {}
local colors = {}
for i = 1, segments + 1 do
local angle = (i / segments) * math.pi * 2
local x = math.cos(angle) * 1.15
local z = math.sin(angle) * 1.15
local pulse = math.sin(tick() * 5 + angle * 5) * 0.1
local localWave = pulse * 0.15
local hue = 0.75 + math.sin(tick() * 0.8 + i / segments * math.pi * 2) * 0.1
local partColor = Color3.fromHSV(hue % 1, 0.9, 0.8 + pulse)
local worldPos = Vector3.new(x, localWave, z)
table.insert(positions, centerPart.CFrame * worldPos)
table.insert(colors, partColor)
end
for i = 1, segments do
local p = haloParts[i]
local s = jointParts[i]
local pos1 = positions[i]
local pos2 = positions[i + 1]
s.Size = Vector3.new(0.24, 0.24, 0.24)
s.CFrame = CFrame.new(pos1)
s.Color = colors[i]
local distance = (pos2 - pos1).Magnitude
p.Size = Vector3.new(distance + 0.01, 0.2, 0.2)
p.CFrame = CFrame.lookAt(pos1:Lerp(pos2, 0.5), pos2) * CFrame.Angles(0, math.rad(90), 0)
p.Color = colors[i]
end
end)
end
})
fxS1:Button({
    Title = "⚡ 闪电光环",
    Desc = "电光闪烁的黄色闪电光环",
    Callback = function()
feFx_stop1()
local player = LocalPlayer
local RunService = game:GetService("RunService")
local haloModel = Instance.new("Model")
haloModel.Name = "ClientHalo3D"
haloModel.Parent = workspace.CurrentCamera
local centerPart = Instance.new("Part")
centerPart.Size = Vector3.new(0.1, 0.1, 0.1)
centerPart.Transparency = 1
centerPart.CanCollide = false
centerPart.Anchored = true
centerPart.Parent = haloModel
haloModel.PrimaryPart = centerPart
local haloParts = {}
local jointParts = {}
local segments = 64
for i = 1, segments do
local p = Instance.new("Part")
p.Material = Enum.Material.Neon
p.CanCollide = false
p.Anchored = true
p.Shape = Enum.PartType.Cylinder
p.Parent = haloModel
table.insert(haloParts, p)
local s = Instance.new("Part")
s.Material = Enum.Material.Neon
s.CanCollide = false
s.Anchored = true
s.Shape = Enum.PartType.Ball
s.Parent = haloModel
table.insert(jointParts, s)
end
local currentRotation = 0
feFx_model1 = haloModel
feFx_active1 = "lightning"
feFx_conn1 = RunService.RenderStepped:Connect(function(dt)
local character = player.Character
if not character or not character:FindFirstChild("Head") then return end
local head = character.Head
if not haloModel or not haloModel.Parent then return end
currentRotation = (currentRotation + dt * 3.5) % (math.pi * 2)
local yOffset = 2.1 + math.sin(tick() * 6) * 0.05
centerPart.CFrame = head.CFrame * CFrame.new(0, yOffset, 0) * CFrame.Angles(0, currentRotation, 0)
local positions = {}
local colors = {}
local flicker = (math.random() > 0.15) and 1 or 0.3
for i = 1, segments + 1 do
local angle = (i / segments) * math.pi * 2
local x = math.cos(angle) * 1.2
local z = math.sin(angle) * 1.2
local localWave = math.sin(tick() * 8 + angle * 6) * 0.03
local partColor = Color3.fromRGB(255 * flicker, 255 * flicker, 50 * flicker)
local worldPos = Vector3.new(x, localWave, z)
table.insert(positions, centerPart.CFrame * worldPos)
table.insert(colors, partColor)
end
for i = 1, segments do
local p = haloParts[i]
local s = jointParts[i]
local pos1 = positions[i]
local pos2 = positions[i + 1]
s.Size = Vector3.new(0.22, 0.22, 0.22)
s.CFrame = CFrame.new(pos1)
s.Color = colors[i]
local distance = (pos2 - pos1).Magnitude
p.Size = Vector3.new(distance + 0.01, 0.16, 0.16)
p.CFrame = CFrame.lookAt(pos1:Lerp(pos2, 0.5), pos2) * CFrame.Angles(0, math.rad(90), 0)
p.Color = colors[i]
end
end)
end
})
fxS1:Button({
    Title = "🌿 自然光环",
    Desc = "绿色自然清新光环",
    Callback = function()
feFx_stop1()
local player = LocalPlayer
local RunService = game:GetService("RunService")
local haloModel = Instance.new("Model")
haloModel.Name = "ClientHalo3D"
haloModel.Parent = workspace.CurrentCamera
local centerPart = Instance.new("Part")
centerPart.Size = Vector3.new(0.1, 0.1, 0.1)
centerPart.Transparency = 1
centerPart.CanCollide = false
centerPart.Anchored = true
centerPart.Parent = haloModel
haloModel.PrimaryPart = centerPart
local haloParts = {}
local jointParts = {}
local segments = 64
for i = 1, segments do
local p = Instance.new("Part")
p.Material = Enum.Material.Neon
p.CanCollide = false
p.Anchored = true
p.Shape = Enum.PartType.Cylinder
p.Parent = haloModel
table.insert(haloParts, p)
local s = Instance.new("Part")
s.Material = Enum.Material.Neon
s.CanCollide = false
s.Anchored = true
s.Shape = Enum.PartType.Ball
s.Parent = haloModel
table.insert(jointParts, s)
end
local currentRotation = 0
feFx_model1 = haloModel
feFx_active1 = "nature"
feFx_conn1 = RunService.RenderStepped:Connect(function(dt)
local character = player.Character
if not character or not character:FindFirstChild("Head") then return end
local head = character.Head
if not haloModel or not haloModel.Parent then return end
currentRotation = (currentRotation + dt * 0.6) % (math.pi * 2)
local yOffset = 2.3 + math.sin(tick() * 1.0) * 0.05
centerPart.CFrame = head.CFrame * CFrame.new(0, yOffset, 0) * CFrame.Angles(0, currentRotation, 0)
local positions = {}
local colors = {}
for i = 1, segments + 1 do
local angle = (i / segments) * math.pi * 2
local x = math.cos(angle) * 1.25
local z = math.sin(angle) * 1.25
local sway = math.sin(tick() * 1.5 + angle * 1.5) * 0.03
local hue = 0.28 + math.sin(tick() * 0.3 + i / segments) * 0.08
local partColor = Color3.fromHSV(hue, 0.8, 0.9)
local worldPos = Vector3.new(x, sway, z)
table.insert(positions, centerPart.CFrame * worldPos)
table.insert(colors, partColor)
end
for i = 1, segments do
local p = haloParts[i]
local s = jointParts[i]
local pos1 = positions[i]
local pos2 = positions[i + 1]
s.Size = Vector3.new(0.22, 0.22, 0.22)
s.CFrame = CFrame.new(pos1)
s.Color = colors[i]
local distance = (pos2 - pos1).Magnitude
p.Size = Vector3.new(distance + 0.01, 0.18, 0.18)
p.CFrame = CFrame.lookAt(pos1:Lerp(pos2, 0.5), pos2) * CFrame.Angles(0, math.rad(90), 0)
p.Color = colors[i]
end
end)
end
})
local fxS12 = Tabs.feFx:Section({ Title = "FE粒子特效V2" })
local activeParticle = nil
local feFx_pConns = {}
local feFx_pModel = nil
local function feFx_stopP()
for _, conn in ipairs(feFx_pConns) do
pcall(function() conn:Disconnect() end)
end
feFx_pConns = {}
if feFx_pModel then
pcall(function() feFx_pModel:Destroy() end)
feFx_pModel = nil
end
activeParticle = nil
end
fxS1:Button({
    Title = "关闭V2特效",
    Desc = "清除所有飘散粒子效果",
    Callback = function()
feFx_stopP()
end
})
fxS12:Button({
    Title = "👼 天使",
    Desc = "金色羽毛飘落效果",
    Callback = function()
feFx_stopP()
local player = LocalPlayer
local RunService = game:GetService("RunService")
local container = Instance.new("Model")
container.Name = "ClientFX_V2"
container.Parent = workspace.CurrentCamera
feFx_pModel = container
activeParticle = "angel_feather"
local featherPool = {}
for i = 1, 40 do
local feather = Instance.new("Part")
feather.Material = Enum.Material.Neon
feather.CanCollide = false
feather.Anchored = true
feather.Size = Vector3.new(0.08, 0.3, 0.15)
feather.Color = Color3.fromRGB(255, 230, 130)
feather.Transparency = 0
feather.Parent = container
local billboard = Instance.new("BillboardGui")
billboard.Size = UDim2.new(0, 2, 0, 2)
billboard.Adornee = feather
billboard.AlwaysOnTop = false
local icon = Instance.new("TextLabel")
icon.Size = UDim2.new(1, 0, 1, 0)
icon.BackgroundTransparency = 1
icon.Text = "🪶"
icon.TextScaled = true
icon.Parent = billboard
billboard.Parent = feather
table.insert(featherPool, {part = feather, phase = math.random() * math.pi * 2, speed = 0.3 + math.random() * 0.5, drift = 0.5 + math.random() * 1.5, rotSpeed = math.random() * 2})
end
local conn = RunService.RenderStepped:Connect(function(dt)
local character = player.Character
if not character or not character:FindFirstChild("HumanoidRootPart") then return end
local hrp = character.HumanoidRootPart
if not container or not container.Parent then return end
for _, data in ipairs(featherPool) do
data.phase = data.phase + dt * data.speed
local t = data.phase % (math.pi * 2)
local life = (math.sin(t) + 1) / 2
local angle = tick() * data.rotSpeed + data.drift * 5
local radius = 1.5 + data.drift * 0.8
local x = math.cos(angle) * radius * life
local z = math.sin(angle) * radius * life
local y = 3.5 - life * 5
local brightness = 0.7 + math.sin(t * 2) * 0.3
data.part.Color = Color3.fromRGB(255 * brightness, 230 * brightness, 130 * brightness)
data.part.CFrame = hrp.CFrame * CFrame.new(x, y, z) * CFrame.Angles(math.sin(tick() * 2 + data.drift) * 0.5, tick() * data.rotSpeed, math.cos(tick() * 1.5 + data.drift) * 0.3)
data.part.Transparency = life > 0.85 and (life - 0.85) / 0.15 or 0
end
end)
table.insert(feFx_pConns, conn)
end
})
fxS12:Button({
    Title = "✨ 星光",
    Desc = "闪烁星光环绕飘散",
    Callback = function()
feFx_stopP()
local player = LocalPlayer
local RunService = game:GetService("RunService")
local container = Instance.new("Model")
container.Name = "ClientFX_V2"
container.Parent = workspace.CurrentCamera
feFx_pModel = container
activeParticle = "starlight"
local starPool = {}
for i = 1, 50 do
local star = Instance.new("Part")
star.Material = Enum.Material.Neon
star.CanCollide = false
star.Anchored = true
star.Shape = Enum.PartType.Ball
star.Size = Vector3.new(0.12, 0.12, 0.12)
star.Color = Color3.fromRGB(255, 255, 200)
star.Transparency = 0
star.Parent = container
local billboard = Instance.new("BillboardGui")
billboard.Size = UDim2.new(0, 2, 0, 2)
billboard.Adornee = star
billboard.AlwaysOnTop = false
local icon = Instance.new("TextLabel")
icon.Size = UDim2.new(1, 0, 1, 0)
icon.BackgroundTransparency = 1
icon.Text = "✦"
icon.TextScaled = true
icon.TextColor3 = Color3.fromRGB(255, 255, 180)
icon.Parent = billboard
billboard.Parent = star
table.insert(starPool, {part = star, phase = math.random() * math.pi * 2, orbitSpeed = 0.5 + math.random() * 1.5, orbitRadius = 1.0 + math.random() * 2.0, yOffset = math.random() * 3, twinkle = math.random() * 5})
end
local conn = RunService.RenderStepped:Connect(function(dt)
local character = player.Character
if not character or not character:FindFirstChild("HumanoidRootPart") then return end
local hrp = character.HumanoidRootPart
if not container or not container.Parent then return end
for _, data in ipairs(starPool) do
data.phase = data.phase + dt * data.orbitSpeed
local angle = data.phase
local r = data.orbitRadius + math.sin(tick() * 1.5 + data.twinkle) * 0.3
local x = math.cos(angle) * r
local z = math.sin(angle) * r
local baseY = data.yOffset + math.sin(tick() * 2 + data.twinkle) * 0.3
local flicker = 0.4 + math.sin(tick() * data.twinkle * 2) * 0.4 + 0.2
data.part.Size = Vector3.new(0.08 + flicker * 0.08, 0.08 + flicker * 0.08, 0.08 + flicker * 0.08)
data.part.CFrame = hrp.CFrame * CFrame.new(x, baseY, z)
local hue = (tick() * 0.05 + data.twinkle * 0.1) % 1
data.part.Color = Color3.fromHSV(hue, 0.3, 1)
data.part.Transparency = 1 - flicker
end
end)
table.insert(feFx_pConns, conn)
end
})
fxS12:Button({
    Title = "☁️ 天堂",
    Desc = "圣洁光柱上升效果",
    Callback = function()
feFx_stopP()
local player = LocalPlayer
local RunService = game:GetService("RunService")
local container = Instance.new("Model")
container.Name = "ClientFX_V2"
container.Parent = workspace.CurrentCamera
feFx_pModel = container
activeParticle = "heaven"
local lightPool = {}
for i = 1, 35 do
local beam = Instance.new("Part")
beam.Material = Enum.Material.Neon
beam.CanCollide = false
beam.Anchored = true
beam.Shape = Enum.PartType.Ball
beam.Size = Vector3.new(0.3, 0.3, 0.3)
beam.Color = Color3.fromRGB(255, 245, 220)
beam.Transparency = 0
beam.Parent = container
local glow = Instance.new("Part")
glow.Material = Enum.Material.Neon
glow.CanCollide = false
glow.Anchored = true
glow.Shape = Enum.PartType.Ball
glow.Size = Vector3.new(0.8, 0.8, 0.8)
glow.Color = Color3.fromRGB(255, 250, 230)
glow.Transparency = 0.5
glow.Parent = container
local billboard = Instance.new("BillboardGui")
billboard.Size = UDim2.new(0, 3, 0, 3)
billboard.Adornee = beam
billboard.AlwaysOnTop = false
local icon = Instance.new("TextLabel")
icon.Size = UDim2.new(1, 0, 1, 0)
icon.BackgroundTransparency = 1
icon.Text = "😇"
icon.TextScaled = true
icon.Parent = billboard
billboard.Parent = beam
table.insert(lightPool, {part = beam, glow = glow, phase = math.random() * math.pi * 2, riseSpeed = 1.5 + math.random() * 2, drift = math.random() * 1.5, size = 0.15 + math.random() * 0.25})
end
local conn = RunService.RenderStepped:Connect(function(dt)
local character = player.Character
if not character or not character:FindFirstChild("HumanoidRootPart") then return end
local hrp = character.HumanoidRootPart
if not container or not container.Parent then return end
for _, data in ipairs(lightPool) do
data.phase = data.phase + dt * data.riseSpeed
local life = (data.phase % 4) / 4
local x = math.sin(tick() * 0.5 + data.drift * 3) * (0.5 + data.drift * 0.3)
local z = math.cos(tick() * 0.7 + data.drift * 2) * (0.5 + data.drift * 0.3)
local y = life * 6 - 1
local s = data.size * (1 - life * 0.5)
data.part.Size = Vector3.new(s, s, s)
data.part.CFrame = hrp.CFrame * CFrame.new(x, y, z)
data.glow.Size = Vector3.new(s * 3, s * 3, s * 3)
data.glow.CFrame = data.part.CFrame
local alpha = life < 0.15 and life / 0.15 or (life > 0.8 and (1 - life) / 0.2 or 1)
data.part.Transparency = 1 - alpha * 0.7
data.glow.Transparency = 0.5 + (1 - alpha) * 0.5
end
end)
table.insert(feFx_pConns, conn)
end
})
fxS12:Button({
    Title = "🎀 丝带",
    Desc = "彩色丝带环绕飘舞",
    Callback = function()
feFx_stopP()
local player = LocalPlayer
local RunService = game:GetService("RunService")
local container = Instance.new("Model")
container.Name = "ClientFX_V2"
container.Parent = workspace.CurrentCamera
feFx_pModel = container
activeParticle = "ribbon"
local ribbonPool = {}
for i = 1, 30 do
local ribbon = Instance.new("Part")
ribbon.Material = Enum.Material.Neon
ribbon.CanCollide = false
ribbon.Anchored = true
ribbon.Size = Vector3.new(0.04, 0.04, 1.2)
ribbon.Transparency = 0
ribbon.Parent = container
table.insert(ribbonPool, {part = ribbon, phase = math.random() * math.pi * 2, orbitSpeed = 0.3 + math.random() * 0.8, radius = 1.2 + math.random() * 1.0, heightOffset = math.random() * 2.5, hueOffset = math.random()})
end
local conn = RunService.RenderStepped:Connect(function(dt)
local character = player.Character
if not character or not character:FindFirstChild("HumanoidRootPart") then return end
local hrp = character.HumanoidRootPart
if not container or not container.Parent then return end
for _, data in ipairs(ribbonPool) do
data.phase = data.phase + dt * data.orbitSpeed
local angle = data.phase
local r = data.radius + math.sin(tick() * 1.2 + data.phase * 2) * 0.3
local x = math.cos(angle) * r
local z = math.sin(angle) * r
local y = data.heightOffset + math.sin(tick() * 1.5 + data.phase) * 0.5
local nextAngle = angle + 0.15
local nx = math.cos(nextAngle) * r
local nz = math.sin(nextAngle) * r
local ny = data.heightOffset + math.sin(tick() * 1.5 + data.phase + 0.15) * 0.5
local pos1 = hrp.CFrame * CFrame.new(x, y, z)
local pos2 = hrp.CFrame * CFrame.new(nx, ny, nz)
local dist = (pos2.Position - pos1.Position).Magnitude
data.part.Size = Vector3.new(0.04, 0.04, math.max(0.1, dist))
data.part.CFrame = CFrame.lookAt(pos1.Position, pos2.Position)
local hue = (tick() * 0.1 + data.hueOffset) % 1
data.part.Color = Color3.fromHSV(hue, 0.8, 1)
data.part.Transparency = 0.1 + math.sin(tick() * 2 + data.phase) * 0.1
end
end)
table.insert(feFx_pConns, conn)
end
})
fxS12:Button({
    Title = "🌸 樱花",
    Desc = "粉色樱花花瓣飘落",
    Callback = function()
feFx_stopP()
local player = LocalPlayer
local RunService = game:GetService("RunService")
local container = Instance.new("Model")
container.Name = "ClientFX_V2"
container.Parent = workspace.CurrentCamera
feFx_pModel = container
activeParticle = "sakura"
local petalPool = {}
for i = 1, 45 do
local petal = Instance.new("Part")
petal.Material = Enum.Material.Neon
petal.CanCollide = false
petal.Anchored = true
petal.Shape = Enum.PartType.Ball
petal.Size = Vector3.new(0.15, 0.15, 0.08)
petal.Color = Color3.fromRGB(255, 180, 200)
petal.Transparency = 0
petal.Parent = container
local billboard = Instance.new("BillboardGui")
billboard.Size = UDim2.new(0, 2, 0, 2)
billboard.Adornee = petal
billboard.AlwaysOnTop = false
local icon = Instance.new("TextLabel")
icon.Size = UDim2.new(1, 0, 1, 0)
icon.BackgroundTransparency = 1
icon.Text = "🌸"
icon.TextScaled = true
icon.Parent = billboard
billboard.Parent = petal
table.insert(petalPool, {part = petal, phase = math.random() * math.pi * 2, fallSpeed = 0.8 + math.random() * 1.2, driftX = (math.random() - 0.5) * 2, driftZ = (math.random() - 0.5) * 2, spinSpeed = 1 + math.random() * 3, startDelay = math.random() * 5})
end
local conn = RunService.RenderStepped:Connect(function(dt)
local character = player.Character
if not character or not character:FindFirstChild("HumanoidRootPart") then return end
local hrp = character.HumanoidRootPart
if not container or not container.Parent then return end
for _, data in ipairs(petalPool) do
data.phase = data.phase + dt * data.fallSpeed
local t = (data.phase + data.startDelay) % 6
local life = t / 6
local spread = life * 2
local x = math.sin(tick() * data.spinSpeed + data.driftX * 3) * spread + math.sin(tick() * 0.5 + data.driftX) * 0.5
local z = math.cos(tick() * data.spinSpeed * 0.7 + data.driftZ * 3) * spread + math.cos(tick() * 0.3 + data.driftZ) * 0.5
local y = 4 - life * 7
local pinkVar = 0.85 + math.sin(tick() + data.driftX * 2) * 0.15
data.part.Color = Color3.fromRGB(255 * pinkVar, 180 * pinkVar, 200 * pinkVar)
data.part.CFrame = hrp.CFrame * CFrame.new(x, y, z) * CFrame.Angles(math.sin(tick() * data.spinSpeed) * 1.5, tick() * data.spinSpeed * 0.5, math.cos(tick() * data.spinSpeed * 0.8) * 0.8)
data.part.Transparency = life > 0.85 and (life - 0.85) / 0.15 or 0.05
end
end)
table.insert(feFx_pConns, conn)
end
})
fxS12:Button({
    Title = "🌬️ 风",
    Desc = "风元素旋转气流效果",
    Callback = function()
feFx_stopP()
local player = LocalPlayer
local RunService = game:GetService("RunService")
local container = Instance.new("Model")
container.Name = "ClientFX_V2"
container.Parent = workspace.CurrentCamera
feFx_pModel = container
activeParticle = "wind"
local windPool = {}
for i = 1, 40 do
local w = Instance.new("Part")
w.Material = Enum.Material.Neon
w.CanCollide = false
w.Anchored = true
w.Shape = Enum.PartType.Ball
w.Size = Vector3.new(0.1, 0.1, 0.1)
w.Color = Color3.fromRGB(180, 220, 255)
w.Transparency = 0
w.Parent = container
local trail = Instance.new("Part")
trail.Material = Enum.Material.Neon
trail.CanCollide = false
trail.Anchored = true
trail.Shape = Enum.PartType.Ball
trail.Size = Vector3.new(0.2, 0.2, 0.2)
trail.Color = Color3.fromRGB(200, 235, 255)
trail.Transparency = 0.5
trail.Parent = container
table.insert(windPool, {part = w, trail = trail, phase = math.random() * math.pi * 2, speed = 2 + math.random() * 3, radius = 0.5 + math.random() * 1.5, heightBase = math.random() * 3, spiralSpeed = 1 + math.random() * 2})
end
local conn = RunService.RenderStepped:Connect(function(dt)
local character = player.Character
if not character or not character:FindFirstChild("HumanoidRootPart") then return end
local hrp = character.HumanoidRootPart
if not container or not container.Parent then return end
for _, data in ipairs(windPool) do
data.phase = data.phase + dt * data.spiralSpeed
local t = data.phase % (math.pi * 6)
local spiral = t / (math.pi * 6)
local angle = t
local r = data.radius * spiral
local x = math.cos(angle) * r
local z = math.sin(angle) * r
local y = data.heightBase + math.sin(t * 0.5) * 1.5
data.part.CFrame = hrp.CFrame * CFrame.new(x, y, z)
data.trail.CFrame = hrp.CFrame * CFrame.new(x * 0.8, y - 0.2, z * 0.8)
local alpha = spiral < 0.2 and spiral / 0.2 or (spiral > 0.8 and (1 - spiral) / 0.2 or 1)
data.part.Transparency = 1 - alpha * 0.6
data.trail.Transparency = 0.4 + (1 - alpha) * 0.6
local cyan = 0.85 + math.sin(tick() * 3 + data.phase) * 0.15
data.part.Color = Color3.fromRGB(180 * cyan, 220 * cyan, 255 * cyan)
end
end)
table.insert(feFx_pConns, conn)
end
})
fxS12:Button({
    Title = "🌊 流",
    Desc = "水流环绕涌动效果",
    Callback = function()
feFx_stopP()
local player = LocalPlayer
local RunService = game:GetService("RunService")
local container = Instance.new("Model")
container.Name = "ClientFX_V2"
container.Parent = workspace.CurrentCamera
feFx_pModel = container
activeParticle = "flow"
local flowPool = {}
for i = 1, 50 do
local drop = Instance.new("Part")
drop.Material = Enum.Material.Neon
drop.CanCollide = false
drop.Anchored = true
drop.Shape = Enum.PartType.Ball
drop.Size = Vector3.new(0.12, 0.12, 0.12)
drop.Color = Color3.fromRGB(60, 150, 255)
drop.Transparency = 0
drop.Parent = container
local glow = Instance.new("Part")
glow.Material = Enum.Material.Neon
glow.CanCollide = false
glow.Anchored = true
glow.Shape = Enum.PartType.Ball
glow.Size = Vector3.new(0.25, 0.25, 0.25)
glow.Color = Color3.fromRGB(100, 180, 255)
glow.Transparency = 0.6
glow.Parent = container
table.insert(flowPool, {part = drop, glow = glow, phase = math.random() * math.pi * 2, flowSpeed = 1 + math.random() * 2, orbitRadius = 1.0 + math.random() * 1.5, waveAmp = 0.3 + math.random() * 0.8, waveFreq = 1 + math.random() * 2, hueShift = math.random()})
end
local conn = RunService.RenderStepped:Connect(function(dt)
local character = player.Character
if not character or not character:FindFirstChild("HumanoidRootPart") then return end
local hrp = character.HumanoidRootPart
if not container or not container.Parent then return end
for _, data in ipairs(flowPool) do
data.phase = data.phase + dt * data.flowSpeed
local angle = data.phase
local r = data.orbitRadius + math.sin(tick() * data.waveFreq + data.phase) * data.waveAmp
local x = math.cos(angle) * r
local z = math.sin(angle) * r
local y = 1.5 + math.sin(tick() * data.waveFreq * 1.5 + data.phase * 2) * 0.8
data.part.CFrame = hrp.CFrame * CFrame.new(x, y, z)
data.glow.CFrame = data.part.CFrame
local pulse = 0.5 + math.sin(tick() * 3 + data.phase * 3) * 0.5
data.part.Size = Vector3.new(0.08 + pulse * 0.06, 0.08 + pulse * 0.06, 0.08 + pulse * 0.06)
data.glow.Size = Vector3.new(0.2 + pulse * 0.1, 0.2 + pulse * 0.1, 0.2 + pulse * 0.1)
local hue = (0.55 + math.sin(tick() * 0.3 + data.hueShift) * 0.1) % 1
data.part.Color = Color3.fromHSV(hue, 0.8, 0.9 + pulse * 0.1)
data.glow.Color = Color3.fromHSV(hue, 0.5, 0.7 + pulse * 0.3)
data.part.Transparency = 0.1 + pulse * 0.2
data.glow.Transparency = 0.5 + pulse * 0.3
end
end)
table.insert(feFx_pConns, conn)
end
})
local fxS13 = Tabs.feFx:Section({ Title = "FE翅膀与手持" })
local feFx_wModel = nil
local feFx_wConns = {}
local feFx_hModel = nil
local feFx_hConns = {}
local function feFx_stopW()
for _, c in ipairs(feFx_wConns) do pcall(function() c:Disconnect() end) end
feFx_wConns = {}
if feFx_wModel then pcall(function() feFx_wModel:Destroy() end) feFx_wModel = nil end
end
local function feFx_stopH()
for _, c in ipairs(feFx_hConns) do pcall(function() c:Disconnect() end) end
feFx_hConns = {}
if feFx_hModel then pcall(function() feFx_hModel:Destroy() end) feFx_hModel = nil end
end
fxS13:Button({
    Title = "关闭翅膀",
    Desc = "移除背部翅膀",
    Callback = function()
feFx_stopW()
end
})
fxS13:Button({
    Title = "关闭手持",
    Desc = "移除手持特效",
    Callback = function()
feFx_stopH()
end
})
fxS13:Button({
    Title = "👼 天使翅膀",
    Desc = "背部展开大粉色天使翅膀，缓慢扇动",
    Callback = function()
feFx_stopW()
local player = LocalPlayer
local RunService = game:GetService("RunService")
local container = Instance.new("Model")
container.Name = "ClientWings"
container.Parent = workspace.CurrentCamera
feFx_wModel = container
local leftWing = {}
local rightWing = {}
local featherCount = 16
local pinkLight = Color3.fromRGB(255, 200, 220)
local pinkMain = Color3.fromRGB(255, 150, 185)
local pinkDark = Color3.fromRGB(240, 100, 155)
local pinkGlow = Color3.fromRGB(255, 170, 200)
for i = 1, featherCount do
local fL = Instance.new("Part")
fL.Material = Enum.Material.Neon
fL.CanCollide = false
fL.Anchored = true
fL.Shape = Enum.PartType.Block
local t = (i - 1) / (featherCount - 1)
local len = 4.0 * (1 - t * 0.6)
local width = 1.0 * (1 - t * 0.45)
fL.Size = Vector3.new(width, 0.04, len)
fL.Color = pinkLight:Lerp(pinkDark, t)
fL.Transparency = 0.08 + t * 0.2
fL.Parent = container
table.insert(leftWing, {part = fL, index = i, total = featherCount})
local fR = fL:Clone()
fR.Color = pinkLight:Lerp(pinkDark, t)
fR.Parent = container
table.insert(rightWing, {part = fR, index = i, total = featherCount})
end
local topFeathers_L = {}
local topFeathers_R = {}
for i = 1, 10 do
local fL = Instance.new("Part")
fL.Material = Enum.Material.Neon
fL.CanCollide = false
fL.Anchored = true
fL.Shape = Enum.PartType.Block
local t = (i - 1) / 9
local len = 3.0 * (1 - t * 0.55)
local width = 0.6 * (1 - t * 0.4)
fL.Size = Vector3.new(width, 0.03, len)
fL.Color = pinkLight:Lerp(pinkMain, t)
fL.Transparency = 0.2 + t * 0.3
fL.Parent = container
table.insert(topFeathers_L, {part = fL, index = i, total = 10})
local fR = fL:Clone()
fR.Parent = container
table.insert(topFeathers_R, {part = fR, index = i, total = 10})
end
for i = 1, 5 do
local spike = Instance.new("Part")
spike.Material = Enum.Material.Neon
spike.CanCollide = false
spike.Anchored = true
spike.Color = pinkGlow
spike.Shape = Enum.PartType.Block
spike.Size = Vector3.new(0.06, 0.3, 0.06)
spike.Transparency = 0.3
spike.Parent = container
spike.Name = "Spike_L_" .. i
local spikeR = spike:Clone()
spikeR.Parent = container
spikeR.Name = "Spike_R_" .. i
end
local glowL = Instance.new("Part")
glowL.Material = Enum.Material.Neon
glowL.CanCollide = false
glowL.Anchored = true
glowL.Shape = Enum.PartType.Ball
glowL.Size = Vector3.new(2.5, 2, 0.6)
glowL.Color = Color3.fromRGB(255, 160, 195)
glowL.Transparency = 0.7
glowL.Parent = container
local glowR = glowL:Clone()
glowR.Color = Color3.fromRGB(255, 140, 180)
glowR.Parent = container
local conn = RunService.RenderStepped:Connect(function(dt)
local character = player.Character
if not character or not character:FindFirstChild("HumanoidRootPart") then return end
local hrp = character.HumanoidRootPart
if not container or not container.Parent then return end
local baseCFrame = hrp.CFrame * CFrame.new(0, 1.0, -0.2)
local flapAngle = math.sin(tick() * 2.0) * 0.35
local breathAngle = math.sin(tick() * 0.8) * 0.04
for _, data in ipairs(leftWing) do
local t = data.index / data.total
local outDist = t * 4.0
local backDist = t * 1.2
local upOffset = t * 0.3
local droop = t * 0.35
local wingCF = baseCFrame * CFrame.new(-0.5 - outDist, upOffset + 0.2 - droop, -backDist)
local rotZ = (flapAngle + breathAngle) * (0.2 + t * 0.6)
local rotX = -droop * 0.15
wingCF = wingCF * CFrame.Angles(rotX, math.rad(10), rotZ)
data.part.CFrame = wingCF
local shimmer = 0.9 + math.sin(tick() * 1.8 + data.index * 0.4) * 0.1
data.part.Color = (pinkLight:Lerp(pinkDark, t)) * shimmer
end
for _, data in ipairs(rightWing) do
local t = data.index / data.total
local outDist = t * 4.0
local backDist = t * 1.2
local upOffset = t * 0.3
local droop = t * 0.35
local wingCF = baseCFrame * CFrame.new(0.5 + outDist, upOffset + 0.2 - droop, -backDist)
local rotZ = -(flapAngle + breathAngle) * (0.2 + t * 0.6)
local rotX = -droop * 0.15
wingCF = wingCF * CFrame.Angles(rotX, math.rad(-10), rotZ)
data.part.CFrame = wingCF
local shimmer = 0.9 + math.sin(tick() * 1.8 + data.index * 0.4 + 2) * 0.1
data.part.Color = (pinkLight:Lerp(pinkDark, t)) * shimmer
end
for _, data in ipairs(topFeathers_L) do
local t = data.index / data.total
local outDist = t * 3.5
local backDist = t * 1.0
local upOffset = t * 0.2
local wingCF = baseCFrame * CFrame.new(-0.5 - outDist, upOffset + 0.35, -backDist)
local rotZ = (flapAngle + breathAngle) * (0.15 + t * 0.5)
wingCF = wingCF * CFrame.Angles(-0.08, math.rad(8), rotZ)
data.part.CFrame = wingCF
end
for _, data in ipairs(topFeathers_R) do
local t = data.index / data.total
local outDist = t * 3.5
local backDist = t * 1.0
local upOffset = t * 0.2
local wingCF = baseCFrame * CFrame.new(0.5 + outDist, upOffset + 0.35, -backDist)
local rotZ = -(flapAngle + breathAngle) * (0.15 + t * 0.5)
wingCF = wingCF * CFrame.Angles(-0.08, math.rad(-8), rotZ)
data.part.CFrame = wingCF
end
for i = 1, 5 do
local sL = container:FindFirstChild("Spike_L_" .. i)
local sR = container:FindFirstChild("Spike_R_" .. i)
if sL and sR then
local t = i / 5
sL.CFrame = baseCFrame * CFrame.new(-0.5 - t * 4.0 - 0.3, 0.2 - t * 0.35 + 0.1, -t * 1.2 - 0.2) * CFrame.Angles(math.sin(tick() * 2 + i) * 0.15, math.rad(8), 0)
sR.CFrame = baseCFrame * CFrame.new(0.5 + t * 4.0 + 0.3, 0.2 - t * 0.35 + 0.1, -t * 1.2 - 0.2) * CFrame.Angles(math.sin(tick() * 2 + i) * 0.15, math.rad(-8), 0)
end
end
glowL.CFrame = baseCFrame * CFrame.new(-2.5, 0.5, -1.2) * CFrame.Angles(0, math.rad(8), 0.2 + flapAngle * 0.15)
glowR.CFrame = baseCFrame * CFrame.new(2.5, 0.5, -1.2) * CFrame.Angles(0, math.rad(-8), -0.2 - flapAngle * 0.15)
local g = 0.6 + math.sin(tick() * 1.5) * 0.1
glowL.Transparency = 0.7 - g * 0.15
glowR.Transparency = 0.7 - g * 0.15
end)
table.insert(feFx_wConns, conn)
end
})
fxS13:Button({
    Title = "😈 恶魔翅膀",
    Desc = "背部展开暗红恶魔翅膀，快速扇动",
    Callback = function()
feFx_stopW()
local player = LocalPlayer
local RunService = game:GetService("RunService")
local container = Instance.new("Model")
container.Name = "ClientWings"
container.Parent = workspace.CurrentCamera
feFx_wModel = container
local leftWing = {}
local rightWing = {}
local boneCount = 10
local mainBone_L = Instance.new("Part")
mainBone_L.Size = Vector3.new(0.05, 0.05, 0.05)
mainBone_L.Transparency = 1
mainBone_L.CanCollide = false
mainBone_L.Anchored = true
mainBone_L.Parent = container
local mainBone_R = Instance.new("Part")
mainBone_R.Size = Vector3.new(0.05, 0.05, 0.05)
mainBone_R.Transparency = 1
mainBone_R.CanCollide = false
mainBone_R.Anchored = true
mainBone_R.Parent = container
for i = 1, boneCount do
local bL = Instance.new("Part")
bL.Material = Enum.Material.Neon
bL.CanCollide = false
bL.Anchored = true
bL.Color = Color3.fromRGB(180, 30, 30)
bL.Shape = Enum.PartType.Block
local len = 3.0 - i * 0.15
local width = 0.6 - i * 0.03
bL.Size = Vector3.new(width, 0.03, len)
bL.Transparency = 0.1 + i * 0.025
bL.Parent = container
table.insert(leftWing, {part = bL, index = i, total = boneCount})
local bR = bL:Clone()
bR.Color = Color3.fromRGB(200, 20, 20)
bR.Parent = container
table.insert(rightWing, {part = bR, index = i, total = boneCount})
end
for i = 1, 6 do
local spike = Instance.new("Part")
spike.Material = Enum.Material.Neon
spike.CanCollide = false
spike.Anchored = true
spike.Color = Color3.fromRGB(255, 50, 30)
spike.Shape = Enum.PartType.Block
spike.Size = Vector3.new(0.08, 0.4, 0.08)
spike.Transparency = 0.2
spike.Parent = container
spike.Name = "Spike_L_" .. i
local spikeR = spike:Clone()
spikeR.Parent = container
spikeR.Name = "Spike_R_" .. i
end
local glowL = Instance.new("Part")
glowL.Material = Enum.Material.Neon
glowL.CanCollide = false
glowL.Anchored = true
glowL.Shape = Enum.PartType.Ball
glowL.Size = Vector3.new(2, 2.5, 0.4)
glowL.Color = Color3.fromRGB(255, 40, 20)
glowL.Transparency = 0.75
glowL.Parent = container
local glowR = glowL:Clone()
glowR.Color = Color3.fromRGB(255, 30, 10)
glowR.Parent = container
local conn = RunService.RenderStepped:Connect(function(dt)
local character = player.Character
if not character or not character:FindFirstChild("HumanoidRootPart") then return end
local hrp = character.HumanoidRootPart
if not container or not container.Parent then return end
local baseCFrame = hrp.CFrame * CFrame.new(0, 0.3, 0)
local flapAngle = math.sin(tick() * 4) * 0.5
mainBone_L.CFrame = baseCFrame * CFrame.new(-0.3, 0, 0) * CFrame.Angles(0, math.rad(15), flapAngle + 0.15)
mainBone_R.CFrame = baseCFrame * CFrame.new(0.3, 0, 0) * CFrame.Angles(0, math.rad(-15), -flapAngle - 0.15)
for _, data in ipairs(leftWing) do
local t = data.index / data.total
local outDist = t * 3.0
local backDist = t * 1.0
local upOffset = t * 0.2
local droop = t * 0.4
local wingCF = baseCFrame * CFrame.new(-0.3 - outDist, upOffset + 0.3 - droop, -backDist) * CFrame.Angles(-droop * 0.2 + flapAngle * t * 0.5, math.rad(15), flapAngle * t * 0.2)
data.part.CFrame = wingCF
local pulse = 0.7 + math.sin(tick() * 5 + data.index) * 0.3
data.part.Color = Color3.fromRGB(180 * pulse, 30 * pulse, 30 * pulse)
end
for _, data in ipairs(rightWing) do
local t = data.index / data.total
local outDist = t * 3.0
local backDist = t * 1.0
local upOffset = t * 0.2
local droop = t * 0.4
local wingCF = baseCFrame * CFrame.new(0.3 + outDist, upOffset + 0.3 - droop, -backDist) * CFrame.Angles(-droop * 0.2 - flapAngle * t * 0.5, math.rad(-15), -flapAngle * t * 0.2)
data.part.CFrame = wingCF
local pulse = 0.7 + math.sin(tick() * 5 + data.index) * 0.3
data.part.Color = Color3.fromRGB(200 * pulse, 20 * pulse, 20 * pulse)
end
for i = 1, 6 do
local sL = container:FindFirstChild("Spike_L_" .. i)
local sR = container:FindFirstChild("Spike_R_" .. i)
if sL and sR then
local t = i / 6
sL.CFrame = baseCFrame * CFrame.new(-0.3 - t * 3.0 - 0.2, 0.3 - t * 0.4, -t * 1.0 - 0.3) * CFrame.Angles(math.sin(tick() * 3 + i) * 0.2, math.rad(15), 0)
sR.CFrame = baseCFrame * CFrame.new(0.3 + t * 3.0 + 0.2, 0.3 - t * 0.4, -t * 1.0 - 0.3) * CFrame.Angles(math.sin(tick() * 3 + i) * 0.2, math.rad(-15), 0)
end
end
glowL.CFrame = baseCFrame * CFrame.new(-2.0, 0.8, -1.0) * CFrame.Angles(0, math.rad(10), 0.3 + flapAngle * 0.2)
glowR.CFrame = baseCFrame * CFrame.new(2.0, 0.8, -1.0) * CFrame.Angles(0, math.rad(-10), -0.3 - flapAngle * 0.2)
local g = 0.6 + math.sin(tick() * 4) * 0.15
glowL.Transparency = 0.75 - g * 0.2
glowR.Transparency = 0.75 - g * 0.2
end)
table.insert(feFx_wConns, conn)
end
})
fxS13:Button({
    Title = "🔥 风火轮(右手)",
    Desc = "右手持旋转风火轮",
    Callback = function()
feFx_stopH()
local player = LocalPlayer
local RunService = game:GetService("RunService")
local container = Instance.new("Model")
container.Name = "ClientHeld"
container.Parent = workspace.CurrentCamera
feFx_hModel = container
local ringParts = {}
local segCount = 48
local ringRadius = 0.6
for i = 1, segCount do
local seg = Instance.new("Part")
seg.Material = Enum.Material.Neon
seg.CanCollide = false
seg.Anchored = true
seg.Shape = Enum.PartType.Cylinder
seg.Size = Vector3.new(0.15, 0.04, 0.04)
seg.Transparency = 0
seg.Parent = container
table.insert(ringParts, seg)
end
local fireParts = {}
for i = 1, 20 do
local fp = Instance.new("Part")
fp.Material = Enum.Material.Neon
fp.CanCollide = false
fp.Anchored = true
fp.Shape = Enum.PartType.Ball
fp.Size = Vector3.new(0.12, 0.12, 0.12)
fp.Color = Color3.fromRGB(255, 150, 30)
fp.Transparency = 0
fp.Parent = container
local bb = Instance.new("BillboardGui")
bb.Size = UDim2.new(0, 2, 0, 2)
bb.Adornee = fp
bb.AlwaysOnTop = false
local lbl = Instance.new("TextLabel")
lbl.Size = UDim2.new(1, 0, 1, 0)
lbl.BackgroundTransparency = 1
lbl.Text = "🔥"
lbl.TextScaled = true
lbl.Parent = bb
bb.Parent = fp
table.insert(fireParts, {part = fp, phase = math.random() * math.pi * 2, speed = 2 + math.random() * 3, dist = 0.3 + math.random() * 0.5})
end
local windParts = {}
for i = 1, 15 do
local wp = Instance.new("Part")
wp.Material = Enum.Material.Neon
wp.CanCollide = false
wp.Anchored = true
wp.Shape = Enum.PartType.Ball
wp.Size = Vector3.new(0.08, 0.08, 0.08)
wp.Color = Color3.fromRGB(100, 200, 255)
wp.Transparency = 0.3
wp.Parent = container
table.insert(windParts, {part = wp, phase = math.random() * math.pi * 2, speed = 3 + math.random() * 4, dist = 0.2 + math.random() * 0.6})
end
local conn = RunService.RenderStepped:Connect(function(dt)
local character = player.Character
if not character or not character:FindFirstChild("Right Arm") then return end
local rArm = character["Right Arm"]
if not container or not container.Parent then return end
local handCFrame = rArm.CFrame * CFrame.new(0, -1.2, 0)
local spinAngle = tick() * 8
for i = 1, segCount do
local a1 = (i / segCount) * math.pi * 2 + spinAngle
local a2 = ((i + 1) / segCount) * math.pi * 2 + spinAngle
local p1 = handCFrame * CFrame.new(math.cos(a1) * ringRadius, math.sin(a1) * ringRadius, 0)
local p2 = handCFrame * CFrame.new(math.cos(a2) * ringRadius, math.sin(a2) * ringRadius, 0)
local dist = (p2.Position - p1.Position).Magnitude
ringParts[i].Size = Vector3.new(dist + 0.01, 0.04, 0.04)
ringParts[i].CFrame = CFrame.lookAt(p1.Position, p2.Position) * CFrame.Angles(0, math.rad(90), 0)
local hue = (tick() * 0.3 + i / segCount) % 1
ringParts[i].Color = Color3.fromHSV(hue < 0.15 and hue or (hue < 0.3 and 0.15 - (hue - 0.15) * 3 or 0), 1, 1)
end
for _, data in ipairs(fireParts) do
data.phase = data.phase + dt * data.speed
local a = data.phase % (math.pi * 2)
local r = data.dist + math.sin(tick() * 5 + data.phase) * 0.1
local x = math.cos(a) * r
local y = math.sin(a) * r
data.part.CFrame = handCFrame * CFrame.new(x, y, -0.1 - math.random() * 0.05)
local flicker = 0.6 + math.random() * 0.4
data.part.Color = Color3.fromRGB(255 * flicker, 100 + math.random() * 100, 20)
data.part.Transparency = 0.2 + math.random() * 0.3
end
for _, data in ipairs(windParts) do
data.phase = data.phase + dt * data.speed
local a = data.phase % (math.pi * 4)
local life = a / (math.pi * 4)
local r = data.dist * (1 - life)
local x = math.cos(a) * r
local y = math.sin(a) * r
data.part.CFrame = handCFrame * CFrame.new(x, y, 0.1 + life * 0.3)
data.part.Transparency = life * 0.8
data.part.Color = Color3.fromRGB(100 + life * 100, 200 - life * 80, 255)
end
end)
table.insert(feFx_hConns, conn)
end
})
fxS13:Button({
    Title = "🔥 风火轮(左手)",
    Desc = "左手持旋转风火轮",
    Callback = function()
feFx_stopH()
local player = LocalPlayer
local RunService = game:GetService("RunService")
local container = Instance.new("Model")
container.Name = "ClientHeld"
container.Parent = workspace.CurrentCamera
feFx_hModel = container
local ringParts = {}
local segCount = 48
local ringRadius = 0.6
for i = 1, segCount do
local seg = Instance.new("Part")
seg.Material = Enum.Material.Neon
seg.CanCollide = false
seg.Anchored = true
seg.Shape = Enum.PartType.Cylinder
seg.Size = Vector3.new(0.15, 0.04, 0.04)
seg.Transparency = 0
seg.Parent = container
table.insert(ringParts, seg)
end
local fireParts = {}
for i = 1, 20 do
local fp = Instance.new("Part")
fp.Material = Enum.Material.Neon
fp.CanCollide = false
fp.Anchored = true
fp.Shape = Enum.PartType.Ball
fp.Size = Vector3.new(0.12, 0.12, 0.12)
fp.Color = Color3.fromRGB(255, 150, 30)
fp.Transparency = 0
fp.Parent = container
local bb = Instance.new("BillboardGui")
bb.Size = UDim2.new(0, 2, 0, 2)
bb.Adornee = fp
bb.AlwaysOnTop = false
local lbl = Instance.new("TextLabel")
lbl.Size = UDim2.new(1, 0, 1, 0)
lbl.BackgroundTransparency = 1
lbl.Text = "🔥"
lbl.TextScaled = true
lbl.Parent = bb
bb.Parent = fp
table.insert(fireParts, {part = fp, phase = math.random() * math.pi * 2, speed = 2 + math.random() * 3, dist = 0.3 + math.random() * 0.5})
end
local windParts = {}
for i = 1, 15 do
local wp = Instance.new("Part")
wp.Material = Enum.Material.Neon
wp.CanCollide = false
wp.Anchored = true
wp.Shape = Enum.PartType.Ball
wp.Size = Vector3.new(0.08, 0.08, 0.08)
wp.Color = Color3.fromRGB(100, 200, 255)
wp.Transparency = 0.3
wp.Parent = container
table.insert(windParts, {part = wp, phase = math.random() * math.pi * 2, speed = 3 + math.random() * 4, dist = 0.2 + math.random() * 0.6})
end
local conn = RunService.RenderStepped:Connect(function(dt)
local character = player.Character
if not character or not character:FindFirstChild("Left Arm") then return end
local lArm = character["Left Arm"]
if not container or not container.Parent then return end
local handCFrame = lArm.CFrame * CFrame.new(0, -1.2, 0)
local spinAngle = -tick() * 8
for i = 1, segCount do
local a1 = (i / segCount) * math.pi * 2 + spinAngle
local a2 = ((i + 1) / segCount) * math.pi * 2 + spinAngle
local p1 = handCFrame * CFrame.new(math.cos(a1) * ringRadius, math.sin(a1) * ringRadius, 0)
local p2 = handCFrame * CFrame.new(math.cos(a2) * ringRadius, math.sin(a2) * ringRadius, 0)
local dist = (p2.Position - p1.Position).Magnitude
ringParts[i].Size = Vector3.new(dist + 0.01, 0.04, 0.04)
ringParts[i].CFrame = CFrame.lookAt(p1.Position, p2.Position) * CFrame.Angles(0, math.rad(90), 0)
local hue = (tick() * 0.3 + i / segCount) % 1
ringParts[i].Color = Color3.fromHSV(hue < 0.15 and hue or (hue < 0.3 and 0.15 - (hue - 0.15) * 3 or 0), 1, 1)
end
for _, data in ipairs(fireParts) do
data.phase = data.phase + dt * data.speed
local a = data.phase % (math.pi * 2)
local r = data.dist + math.sin(tick() * 5 + data.phase) * 0.1
local x = math.cos(a) * r
local y = math.sin(a) * r
data.part.CFrame = handCFrame * CFrame.new(x, y, -0.1 - math.random() * 0.05)
local flicker = 0.6 + math.random() * 0.4
data.part.Color = Color3.fromRGB(255 * flicker, 100 + math.random() * 100, 20)
data.part.Transparency = 0.2 + math.random() * 0.3
end
for _, data in ipairs(windParts) do
data.phase = data.phase + dt * data.speed
local a = data.phase % (math.pi * 4)
local life = a / (math.pi * 4)
local r = data.dist * (1 - life)
local x = math.cos(a) * r
local y = math.sin(a) * r
data.part.CFrame = handCFrame * CFrame.new(x, y, 0.1 + life * 0.3)
data.part.Transparency = life * 0.8
data.part.Color = Color3.fromRGB(100 + life * 100, 200 - life * 80, 255)
end
end)
table.insert(feFx_hConns, conn)
end
})
local fxS14 = Tabs.feFx:Section({ Title = "鬼灭之刃特效" })
local feFx_knyModel = nil
local feFx_knyConns = {}
local function feFx_stopKNY()
for _, c in ipairs(feFx_knyConns) do pcall(function() c:Disconnect() end) end
feFx_knyConns = {}
if feFx_knyModel then pcall(function() feFx_knyModel:Destroy() end) feFx_knyModel = nil end
end
fxS14:Button({
    Title = "🔥关闭鬼灭特效",
    Desc = "清除所有鬼灭之刃特效",
    Callback = function()
feFx_stopKNY()
end
})
fxS14:Button({
    Title = "🩸 日之呼吸·辉轮剑",
    Desc = "日之呼吸第一型，金色火焰旋风环绕全身",
    Callback = function()
feFx_stopKNY()
local player = LocalPlayer
local RunService = game:GetService("RunService")
local container = Instance.new("Model")
container.Name = "KNY_SunBreath"
container.Parent = workspace.CurrentCamera
feFx_knyModel = container
local bladeParts = {}
local segments = 80
for i = 1, segments do
local p = Instance.new("Part")
p.Material = Enum.Material.Neon
p.CanCollide = false
p.Anchored = true
p.Shape = Enum.PartType.Cylinder
p.Size = Vector3.new(0.15, 0.15, 0.15)
p.Transparency = 0
p.Parent = container
table.insert(bladeParts, p)
end
local innerParts = {}
for i = 1, 40 do
local p = Instance.new("Part")
p.Material = Enum.Material.Neon
p.CanCollide = false
p.Anchored = true
p.Shape = Enum.PartType.Ball
p.Size = Vector3.new(0.2, 0.2, 0.2)
p.Transparency = 0
p.Parent = container
table.insert(innerParts, p)
end
local fireParticles = {}
for i = 1, 25 do
local fp = Instance.new("Part")
fp.Material = Enum.Material.Neon
fp.CanCollide = false
fp.Anchored = true
fp.Shape = Enum.PartType.Ball
fp.Size = Vector3.new(0.12, 0.12, 0.12)
fp.Transparency = 0.3
fp.Parent = container
table.insert(fireParticles, {
    part = fp,
    angle = math.random() * math.pi * 2,
    radius = 1.0 + math.random() * 0.5,
    height = math.random() * 3,
    speed = 2 + math.random() * 3,
    phase = math.random() * math.pi * 2
})
end
local conn = RunService.RenderStepped:Connect(function(dt)
local character = player.Character
if not character or not character:FindFirstChild("HumanoidRootPart") then return end
local hrp = character.HumanoidRootPart
if not container or not container.Parent then return end
local baseCF = hrp.CFrame * CFrame.new(0, 1.5, 0)
local rot = tick() * 3
local rot2 = -tick() * 5
local radius = 1.8 + math.sin(tick() * 2) * 0.2
for i = 1, segments do
local angle1 = (i / segments) * math.pi * 2 + rot
local angle2 = ((i + 1) / segments) * 2 * math.pi + rot
local wave = math.sin(tick() * 6 + angle1 * 3) * 0.3
local r = radius + wave
local h = math.sin(angle1 * 2 + tick() * 4) * 0.8
local pos1 = baseCF * CFrame.new(math.cos(angle1) * r, h, math.sin(angle1) * r)
local pos2 = baseCF * CFrame.new(math.cos(angle2) * r, h + math.sin(tick() * 6 + angle2 * 3) * 0.3, math.sin(angle2) * r)
local dist = (pos2.Position - pos1.Position).Magnitude
bladeParts[i].Size = Vector3.new(dist + 0.02, 0.14, 0.14)
bladeParts[i].CFrame = CFrame.lookAt(pos1.Position, pos2.Position) * CFrame.Angles(0, math.rad(90), 0)
local hue = (tick() * 0.2 + i / segments) % 1
local gold = Color3.fromHSV(0.1 + hue * 0.05, 0.9, 1)
bladeParts[i].Color = gold
local flicker = 0.6 + math.sin(tick() * 8 + i * 0.5) * 0.4
bladeParts[i].Transparency = 0.2 + (1 - flicker) * 0.3
end
for i = 1, 40 do
local angle = (i / 40) * math.pi * 2 + rot2
local r = 0.8 + math.sin(tick() * 3 + i) * 0.15
local h = math.sin(tick() * 2 + i * 0.3) * 0.4
innerParts[i].CFrame = baseCF * CFrame.new(math.cos(angle) * r, h, math.sin(angle) * r)
local bright = 0.8 + math.sin(tick() * 5 + i) * 0.2
innerParts[i].Color = Color3.fromRGB(255 * bright, 220 * bright, 50 * bright)
innerParts[i].Size = Vector3.new(0.18 + math.sin(tick() * 4 + i) * 0.05, 0.18 + math.sin(tick() * 4 + i) * 0.05, 0.18 + math.sin(tick() * 4 + i) * 0.05)
innerParts[i].Transparency = 0.1 + math.sin(tick() * 6 + i) * 0.15
end
for _, data in ipairs(fireParticles) do
data.phase = data.phase + dt * data.speed
local life = (data.phase % 3) / 3
local a = data.angle + tick() * 1.5
local r = data.radius * (1 - life * 0.3)
local h = life * 3.5
data.part.CFrame = baseCF * CFrame.new(math.cos(a) * r, h, math.sin(a) * r)
local alpha = 1 - life
local goldR = 255 * alpha
local goldG = (200 - life * 120) * alpha
local goldB = (50 - life * 50) * alpha
data.part.Color = Color3.fromRGB(goldR, goldG, math.max(0, goldB))
data.part.Transparency = 0.2 + life * 0.6
data.part.Size = Vector3.new(0.15 * (1 - life * 0.5), 0.15 * (1 - life * 0.5), 0.15 * (1 - life * 0.5))
end
end)
table.insert(feFx_knyConns, conn)
end
})
fxS14:Button({
    Title = "🌊 水之呼吸·水流斩",
    Desc = "水之呼吸第十型，蓝色水流环绕攻击",
    Callback = function()
feFx_stopKNY()
local player = LocalPlayer
local RunService = game:GetService("RunService")
local container = Instance.new("Model")
container.Name = "KNY_WaterBreath"
container.Parent = workspace.CurrentCamera
feFx_knyModel = container
local waterParts = {}
local segments = 72
for i = 1, segments do
local p = Instance.new("Part")
p.Material = Enum.Material.Neon
p.CanCollide = false
p.Anchored = true
p.Shape = Enum.PartType.Cylinder
p.Size = Vector3.new(0.12, 0.12, 0.12)
p.Transparency = 0
p.Parent = container
table.insert(waterParts, p)
end
local splashParts = {}
for i = 1, 20 do
local sp = Instance.new("Part")
sp.Material = Enum.Material.Neon
sp.CanCollide = false
sp.Anchored = true
sp.Shape = Enum.PartType.Ball
sp.Size = Vector3.new(0.1, 0.1, 0.1)
sp.Color = Color3.fromRGB(100, 200, 255)
sp.Transparency = 0.3
sp.Parent = container
table.insert(splashParts, {
    part = sp,
    angle = math.random() * math.pi * 2,
    phase = math.random() * math.pi * 2,
    speed = 2 + math.random() * 3,
    radius = 1.2 + math.random() * 0.8
})
end
local conn = RunService.RenderStepped:Connect(function(dt)
local character = player.Character
if not character or not character:FindFirstChild("HumanoidRootPart") then return end
local hrp = character.HumanoidRootPart
if not container or not container.Parent then return end
local baseCF = hrp.CFrame * CFrame.new(0, 1.0, 0)
local rot = tick() * 2.5
local mainRadius = 2.0 + math.sin(tick() * 1.5) * 0.3
for i = 1, segments do
local angle1 = (i / segments) * math.pi * 2 + rot
local angle2 = ((i + 1) / segments) * math.pi * 2 + rot
local wave1 = math.sin(tick() * 4 + angle1 * 3) * 0.25
local wave2 = math.sin(tick() * 4 + angle2 * 3) * 0.25
local r1 = mainRadius + wave1
local r2 = mainRadius + wave2
local h1 = math.sin(tick() * 3 + angle1 * 2) * 0.6
local h2 = math.sin(tick() * 3 + angle2 * 2) * 0.6
local pos1 = baseCF * CFrame.new(math.cos(angle1) * r1, h1, math.sin(angle1) * r1)
local pos2 = baseCF * CFrame.new(math.cos(angle2) * r2, h2, math.sin(angle2) * r2)
local dist = (pos2.Position - pos1.Position).Magnitude
waterParts[i].Size = Vector3.new(dist + 0.01, 0.1, 0.1)
waterParts[i].CFrame = CFrame.lookAt(pos1.Position, pos2.Position) * CFrame.Angles(0, math.rad(90), 0)
local blueT = (math.sin(tick() * 2 + angle1) + 1) * 0.5
local waterBlue = Color3.fromRGB(80 + blueT * 80, 180 + blueT * 40, 255)
waterParts[i].Color = waterBlue
waterParts[i].Transparency = 0.1 + math.sin(tick() * 5 + i * 0.3) * 0.15
end
for _, data in ipairs(splashParts) do
data.phase = data.phase + dt * data.speed
local life = (data.phase % 2.5) / 2.5
local a = data.angle + tick()
local r = data.radius * (1 + math.sin(data.phase * 2) * 0.2)
local h = life * 2.5
data.part.CFrame = baseCF * CFrame.new(math.cos(a) * r, h, math.sin(a) * r)
data.part.Color = Color3.fromRGB(120 + (1 - life) * 80, 200, 255)
data.part.Transparency = 0.15 + life * 0.65
local s = 0.12 * (1 - life * 0.6)
data.part.Size = Vector3.new(s, s, s)
end
end)
table.insert(feFx_knyConns, conn)
end
})
fxS14:Button({
    Title = "💥 爆之呼吸·轰",
    Desc = "爆之呼吸，红色爆炸火焰脉冲",
    Callback = function()
feFx_stopKNY()
local player = LocalPlayer
local RunService = game:GetService("RunService")
local container = Instance.new("Model")
container.Name = "KNY_ExplosionBreath"
container.Parent = workspace.CurrentCamera
feFx_knyModel = container
local blastParts = {}
for ring = 1, 3 do
local count = 48 + ring * 12
for i = 1, count do
local p = Instance.new("Part")
p.Material = Enum.Material.Neon
p.CanCollide = false
p.Anchored = true
p.Shape = Enum.PartType.Cylinder
p.Size = Vector3.new(0.12, 0.12, 0.12)
p.Transparency = 0
p.Parent = container
table.insert(blastParts, {part = p, ring = ring, index = i, total = count})
end
end
local debris = {}
for i = 1, 18 do
local d = Instance.new("Part")
d.Material = Enum.Material.Neon
d.CanCollide = false
d.Anchored = true
d.Shape = Enum.PartType.Block
d.Size = Vector3.new(0.15, 0.15, 0.15)
d.Transparency = 0.2
d.Parent = container
table.insert(debris, {
    part = d,
    angle = math.random() * math.pi * 2,
    upAngle = math.random() * math.pi * 0.5,
    speed = 3 + math.random() * 4,
    phase = math.random() * 10
})
end
local conn = RunService.RenderStepped:Connect(function(dt)
local character = player.Character
if not character or not character:FindFirstChild("HumanoidRootPart") then return end
local hrp = character.HumanoidRootPart
if not container or not container.Parent then return end
local baseCF = hrp.CFrame * CFrame.new(0, 1.2, 0)
local pulse = (math.sin(tick() * 4) + 1) * 0.5
for _, data in ipairs(blastParts) do
local ringT = (data.ring - 1) / 2
local ringPhase = (tick() * 3 + ringT * 2) % 3 / 3
local ringRadius = 0.5 + ringPhase * 3.0 + ringT * 0.8
local ringH = math.sin(ringPhase * math.pi) * (1.5 - ringT * 0.3)
local rot = tick() * (6 - ringT * 2) * (data.ring % 2 == 0 and 1 or -1)
local angle1 = (data.index / data.total) * math.pi * 2 + rot
local angle2 = ((data.index + 1) / data.total) * math.pi * 2 + rot
local wobble = math.sin(tick() * 8 + angle1 * 4) * 0.1
local r1 = ringRadius + wobble
local r2 = ringRadius + wobble
local pos1 = baseCF * CFrame.new(math.cos(angle1) * r1, ringH, math.sin(angle1) * r1)
local pos2 = baseCF * CFrame.new(math.cos(angle2) * r2, ringH + math.sin(tick() * 6 + angle2) * 0.05, math.sin(angle2) * r2)
local dist = (pos2.Position - pos1.Position).Magnitude
data.part.Size = Vector3.new(dist + 0.01, 0.08 + pulse * 0.06, 0.08 + pulse * 0.06)
data.part.CFrame = CFrame.lookAt(pos1.Position, pos2.Position) * CFrame.Angles(0, math.rad(90), 0)
local fireHue = 0.02 + math.sin(tick() * 6 + data.index * 0.3) * 0.03
data.part.Color = Color3.fromHSV(fireHue, 0.95, 0.8 + pulse * 0.2)
data.part.Transparency = 0.15 + ringPhase * 0.6 + (1 - pulse) * 0.1
end
for _, data in ipairs(debris) do
data.phase = data.phase + dt * data.speed
local life = (data.phase % 1.5) / 1.5
local dist = life * 4
local h = life * 3
local a = data.angle + life * 2
local up = data.upAngle * life
data.part.CFrame = baseCF * CFrame.new(math.cos(a) * dist, h * (1 - up), math.sin(a) * dist)
local alpha = 1 - life
data.part.Color = Color3.fromRGB(255 * alpha, (120 - life * 80) * alpha, (30 - life * 30) * alpha)
data.part.Transparency = 0.1 + life * 0.7
local s = 0.15 * (1 - life * 0.7)
data.part.Size = Vector3.new(s, s, s)
data.part.Rotation = Vector3.new(tick() * 200 + data.phase * 50, tick() * 150, 0)
end
end)
table.insert(feFx_knyConns, conn)
end
})
fxS14:Button({
    Title = "🌙 雷之呼吸·霹雳一闪",
    Desc = "雷之呼吸，紫色闪电环绕爆发",
    Callback = function()
feFx_stopKNY()
local player = LocalPlayer
local RunService = game:GetService("RunService")
local container = Instance.new("Model")
container.Name = "KNY_ThunderBreath"
container.Parent = workspace.CurrentCamera
feFx_knyModel = container
local boltParts = {}
for i = 1, 12 do
local p = Instance.new("Part")
p.Material = Enum.Material.Neon
p.CanCollide = false
p.Anchored = true
p.Shape = Enum.PartType.Cylinder
p.Size = Vector3.new(0.08, 0.08, 0.08)
p.Color = Color3.fromRGB(180, 130, 255)
p.Transparency = 0
p.Parent = container
table.insert(boltParts, p)
end
local ringParts = {}
local segments = 60
for i = 1, segments do
local p = Instance.new("Part")
p.Material = Enum.Material.Neon
p.CanCollide = false
p.Anchored = true
p.Shape = Enum.PartType.Cylinder
p.Size = Vector3.new(0.1, 0.1, 0.1)
p.Color = Color3.fromRGB(200, 160, 255)
p.Transparency = 0
p.Parent = container
table.insert(ringParts, p)
end
local sparkParts = {}
for i = 1, 30 do
local sp = Instance.new("Part")
sp.Material = Enum.Material.Neon
sp.CanCollide = false
sp.Anchored = true
sp.Shape = Enum.PartType.Ball
sp.Size = Vector3.new(0.08, 0.08, 0.08)
sp.Color = Color3.fromRGB(220, 200, 255)
sp.Transparency = 0.3
sp.Parent = container
table.insert(sparkParts, {
    part = sp,
    angle = math.random() * math.pi * 2,
    radius = 1.5 + math.random() * 1.0,
    height = math.random() * 2.5,
    phase = math.random() * math.pi * 2,
    speed = 3 + math.random() * 5
})
end
local function generateBolt(startPos, endPos, jitter)
local points = {startPos}
local steps = 8
for s = 1, steps do
local t = s / steps
local base = startPos:Lerp(endPos, t)
local jx = (math.random() - 0.5) * jitter
local jy = (math.random() - 0.5) * jitter * 0.5
local jz = (math.random() - 0.5) * jitter
table.insert(points, base + Vector3.new(jx, jy, jz))
end
table.insert(points, endPos)
return points
end
local boltTimer = 0
local conn = RunService.RenderStepped:Connect(function(dt)
local character = player.Character
if not character or not character:FindFirstChild("HumanoidRootPart") then return end
local hrp = character.HumanoidRootPart
if not container or not container.Parent then return end
local baseCF = hrp.CFrame * CFrame.new(0, 1.5, 0)
boltTimer = boltTimer + dt
if boltTimer > 0.15 then
boltTimer = 0
local boltCount = 4
local bolts = {}
for b = 1, boltCount do
local angle = (b / boltCount) * math.pi * 2 + tick() * 2
local topPoint = baseCF.Position + Vector3.new(math.cos(angle) * 0.3, 2, math.sin(angle) * 0.3)
local endAngle = angle + math.pi * 0.5
local endR = 2.5 + math.random() * 1.0
local endH = math.random() * 1.5
local endP = baseCF.Position + Vector3.new(math.cos(endAngle) * endR, endH, math.sin(endAngle) * endR)
local pts = generateBolt(topPoint, endP, 1.5)
table.insert(bolts, pts)
end
for idx, bp in ipairs(boltParts) do
local bIdx = math.ceil(idx / (#boltParts / #bolts))
local pIdx = ((idx - 1) % math.ceil(#boltParts / #bolts)) + 1
if bIdx <= #bolts and pIdx < #bolts[bIdx] then
local p1 = bolts[bIdx][pIdx]
local p2 = bolts[bIdx][pIdx + 1]
local dist = (p2 - p1).Magnitude
bp.Size = Vector3.new(dist + 0.01, 0.08, 0.08)
bp.CFrame = CFrame.lookAt(p1, p2)
local flash = 0.5 + math.random() * 0.5
bp.Color = Color3.fromRGB(180 * flash, 130 * flash, 255 * flash)
bp.Transparency = 0.1 + math.random() * 0.3
bp.Parent = container
else
bp.Transparency = 1
end
end
end
local ringRot = tick() * 8
local ringRadius = 1.8 + math.sin(tick() * 5) * 0.3
for i = 1, segments do
local angle1 = (i / segments) * math.pi * 2 + ringRot
local angle2 = ((i + 1) / segments) * math.pi * 2 + ringRot
local crackle = math.sin(tick() * 12 + i * 2) * 0.3
local r1 = ringRadius + crackle
local r2 = ringRadius + math.sin(tick() * 12 + (i+1) * 2) * 0.3
local h = math.sin(tick() * 7 + i * 0.5) * 0.4
local pos1 = baseCF * CFrame.new(math.cos(angle1) * r1, h, math.sin(angle1) * r1)
local pos2 = baseCF * CFrame.new(math.cos(angle2) * r2, h, math.sin(angle2) * r2)
local dist = (pos2.Position - pos1.Position).Magnitude
ringParts[i].Size = Vector3.new(dist + 0.01, 0.06, 0.06)
ringParts[i].CFrame = CFrame.lookAt(pos1.Position, pos2.Position) * CFrame.Angles(0, math.rad(90), 0)
local flash = math.random() > 0.1 and 1 or 0.3
ringParts[i].Color = Color3.fromRGB(200 * flash, 160 * flash, 255 * flash)
ringParts[i].Transparency = 0.15 + (1 - flash) * 0.5
end
for _, data in ipairs(sparkParts) do
data.phase = data.phase + dt * data.speed
local life = (data.phase % 0.8) / 0.8
local a = data.angle + tick() * 3
local r = data.radius * (0.5 + life * 0.5)
local h = data.height * (1 - life * 0.5) + math.sin(data.phase * 5) * 0.2
data.part.CFrame = baseCF * CFrame.new(math.cos(a) * r, h, math.sin(a) * r)
data.part.Color = Color3.fromRGB(220, 200, 255)
data.part.Transparency = 0.2 + life * 0.6
local s = 0.1 * (1 - life * 0.7)
data.part.Size = Vector3.new(s, s, s)
end
end)
table.insert(feFx_knyConns, conn)
end
})
fxS14:Button({
    Title = "🍁 霞の呼吸·幻日虹",
    Desc = "霞之呼吸，橙粉渐变彩虹光环缓慢旋转",
    Callback = function()
feFx_stopKNY()
local player = LocalPlayer
local RunService = game:GetService("RunService")
local container = Instance.new("Model")
container.Name = "KNY_MistBreath"
container.Parent = workspace.CurrentCamera
feFx_knyModel = container
local haloParts = {}
local segments = 72
for i = 1, segments do
local p = Instance.new("Part")
p.Material = Enum.Material.Neon
p.CanCollide = false
p.Anchored = true
p.Shape = Enum.PartType.Cylinder
p.Size = Vector3.new(0.12, 0.12, 0.12)
p.Transparency = 0
p.Parent = container
table.insert(haloParts, p)
end
local mistParts = {}
for i = 1, 20 do
local mp = Instance.new("Part")
mp.Material = Enum.Material.Neon
mp.CanCollide = false
mp.Anchored = true
mp.Shape = Enum.PartType.Ball
mp.Size = Vector3.new(0.12, 0.12, 0.12)
mp.Transparency = 0.3
mp.Parent = container
table.insert(mistParts, {
    part = mp,
    angle = math.random() * math.pi * 2,
    radius = 1.5 + math.random() * 1.0,
    height = math.random() * 2.0,
    speed = 0.5 + math.random() * 1.5,
    phase = math.random() * math.pi * 2
})
end
local conn = RunService.RenderStepped:Connect(function(dt)
local character = player.Character
if not character or not character:FindFirstChild("HumanoidRootPart") then return end
local hrp = character.HumanoidRootPart
if not container or not container.Parent then return end
local baseCF = hrp.CFrame * CFrame.new(0, 2.5, 0)
local rot = tick() * 0.8
local radius = 1.6 + math.sin(tick() * 1.2) * 0.15
for i = 1, segments do
local angle1 = (i / segments) * math.pi * 2 + rot
local angle2 = ((i + 1) / segments) * math.pi * 2 + rot
local wave = math.sin(tick() * 2 + angle1 * 2) * 0.08
local pos1 = baseCF * CFrame.new(math.cos(angle1) * (radius + wave), wave * 0.5, math.sin(angle1) * (radius + wave))
local pos2 = baseCF * CFrame.new(math.cos(angle2) * (radius + wave), wave * 0.5, math.sin(angle2) * (radius + wave))
local dist = (pos2.Position - pos1.Position).Magnitude
haloParts[i].Size = Vector3.new(dist + 0.01, 0.1, 0.1)
haloParts[i].CFrame = CFrame.lookAt(pos1.Position, pos2.Position) * CFrame.Angles(0, math.rad(90), 0)
local hue = ((tick() * 0.08 + i / segments) % 1)
if hue < 0.08 then
hue = 0.08
elseif hue > 0.9 then
hue = 0.9
end
haloParts[i].Color = Color3.fromHSV(hue, 0.7, 1)
haloParts[i].Transparency = 0.08 + math.sin(tick() * 3 + i * 0.4) * 0.08
end
for _, data in ipairs(mistParts) do
data.phase = data.phase + dt * data.speed
local a = data.angle + tick() * 0.5
local r = data.radius + math.sin(data.phase) * 0.3
local h = data.height * (0.5 + math.sin(data.phase * 0.7) * 0.5)
data.part.CFrame = baseCF * CFrame.new(math.cos(a) * r, h - 1.2, math.sin(a) * r)
local hue = ((tick() * 0.08 + a / (math.pi * 2)) % 1)
data.part.Color = Color3.fromHSV(math.max(0.05, math.min(0.9, hue)), 0.6, 0.9)
data.part.Transparency = 0.25 + math.sin(data.phase * 2) * 0.15
end
end)
table.insert(feFx_knyConns, conn)
end
})
local NoticeConfig = {
    TitleText = "📢 delta force 脚本中心 V1.0",
    MainContent = [[
更新内容清单：
1、全部UI界面移除折叠分区，所有功能直接平铺显示
2、修复行走速度、跳跃高度滑块变成按钮的bug
3、优化UI侧边栏宽度，文字显示更清晰
4、优化主题配色，弹窗文字对比度提升
5、快捷键F一键隐藏/显示菜单，无冲突
使用须知：
张怀民不是民😛😋！
]],
    NoticeImg = "https://i.postimg.cc/V6V2qKMd/1000026520.jpg",
    StatusTip = "公告加载完成，当前为离线静态公告",
    IsLoadFinish = true,
    GroupNum = "1040209982"
}
local noticeTitle = Tabs.gonggao:Paragraph({
    Title = NoticeConfig.TitleText,
    Desc = "",
    Image = "bell",
    ImageSize = 40,
    ThumbnailSize = 0
})
local noticeContent = Tabs.gonggao:Paragraph({
    Title = "缝合脚本作者😔😔😔",
    Desc = NoticeConfig.MainContent,
    ImageSize = 0
})
local noticeImage = Tabs.gonggao:Image({
    Image = NoticeConfig.NoticeImg,
    AspectRatio = "16:9",
    Radius = 14
})
Tabs.feFx:Divider()
local noticeStatus = Tabs.gonggao:Paragraph({
    Title = "",
    Desc = NoticeConfig.StatusTip
})
Tabs.feFx:Divider()
local copyGroupBtn = Tabs.gonggao:Button({
    Title = "点击复制交流群号",
    Desc = "一键复制群号加群",
    Callback = function()
        setclipboard(NoticeConfig.GroupNum)
        Tabs.feFx:Notification({
            Title = "复制成功",
            Desc = "1040209982 " .. NoticeConfig.GroupNum .. " 已复制到剪贴板！"
        })
    end
})
Tabs.feFx:Divider()
local function getCharacter()
    if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        return LocalPlayer.Character
    end
    return nil
end
local isInfiniteJumpEnabled = false
UserInputService.JumpRequest:Connect(function()
    if isInfiniteJumpEnabled then
        local character = getCharacter()
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)
Tabs.zho:Paragraph({
    Title = "通用:",
    Desc = "",
    Image = "https://i.postimg.cc/d1sH5qJN/1781878127576.png",
    ImageSize = 20,
    ThumbnailSize = 120
})
Tabs.zho:Button({
    Title = "2024年远古脚本HB零度网络💔",
    Callback = function()
        loadstring(game:HttpGet(utf8.char((function() return table.unpack({104,116,116,112,115,58,47,47,112,97,115,116,101,98,105,110,46,99,111,109,47,114,97,119,47,82,66,119,107,107,117,55,49})end)())))()
    end
})

-- 飞车功能
local flySpeed = 80
local flyActive = false
local flyBV = nil
local flyBG = nil
local flyConn = nil
local flyGui = nil

local function createFlyGUI()
    if flyGui then flyGui:Destroy() end
    local sg = Instance.new("ScreenGui")
    sg.Name = "PrisonFlyGUI"
    sg.ResetOnSpawn = false
    sg.Parent = game:GetService("CoreGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 220)
    frame.Position = UDim2.new(0.5, -100, 0.5, -110)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.Parent = sg
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    local frameStroke = Instance.new("UIStroke")
    frameStroke.Color = Color3.fromRGB(80, 80, 80)
    frameStroke.Thickness = 1
    frameStroke.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundColor3 = Color3.fromRGB(0, 120, 80)
    title.BackgroundTransparency = 0.3
    title.Text = "飞车控制"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 13
    title.Parent = frame
    Instance.new("UICorner", title).CornerRadius = UDim.new(0, 8)

    local function makeBtn(text, yPos, cb)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.8, 0, 0, 32)
        btn.Position = UDim2.new(0.1, 0, 0, yPos)
        btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(220, 220, 220)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11
        btn.BorderSizePixel = 0
        btn.AutoButtonColor = true
        btn.Parent = frame
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
        btn.MouseButton1Click:Connect(cb)
        return btn
    end

    makeBtn("起飞 (WASD控制)", 38, function()
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        hrp.Anchored = false
        if flyBV then flyBV:Destroy() end
        if flyBG then flyBG:Destroy() end
        flyBV = Instance.new("BodyVelocity", hrp)
        flyBV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        flyBV.Velocity = Vector3.new(0, 0, 0)
        flyBG = Instance.new("BodyGyro", hrp)
        flyBG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        flyBG.D = 5000
        flyBG.P = 50000
        flyBG.CFrame = Camera.CFrame
        flyActive = true
        if flyConn then flyConn:Disconnect() end
        flyConn = game:GetService("RenderStepped"):Connect(function()
            if not flyActive then return end
            local hrp2 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not hrp2 then flyActive = false; return end
            if flyBG then flyBG.CFrame = Camera.CFrame end
            local camCF = Camera.CFrame
            local dir = Vector3.new(0, 0, 0)
            local UIS = game:GetService("UserInputService")
            if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + camCF.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - camCF.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - camCF.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + camCF.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0, 1, 0) end
            if dir.Magnitude > 0 then
                dir = dir.Unit * flySpeed
            end
            if flyBV then flyBV.Velocity = dir end
        end)
    end)

    makeBtn("停止飞行", 78, function()
        flyActive = false
        if flyConn then flyConn:Disconnect(); flyConn = nil end
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            if flyBV then flyBV:Destroy(); flyBV = nil end
            if flyBG then flyBG:Destroy(); flyBG = nil end
        end
    end)

    makeBtn("定住(冻结)", 118, function()
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.Anchored = true end
    end)

    makeBtn("解除定住", 152, function()
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.Anchored = false end
    end)

    makeBtn("关闭面板", 188, function()
        flyActive = false
        if flyConn then flyConn:Disconnect(); flyConn = nil end
        if flyBV then flyBV:Destroy(); flyBV = nil end
        if flyBG then flyBG:Destroy(); flyBG = nil end
        sg:Destroy()
        flyGui = nil
    end)

    flyGui = sg
end

Tabs.zho:Button({
    Title = "飞车",
    Desc = "打开飞车控制面板（WASD+空格/Shift）",
    Callback = function()
        if flyGui then flyGui:Destroy(); flyGui = nil end
        flyActive = false
        if flyConn then flyConn:Disconnect(); flyConn = nil end
        if flyBV then flyBV:Destroy(); flyBV = nil end
        if flyBG then flyBG:Destroy(); flyBG = nil end
        createFlyGUI()
    end
})

-- 飞车手机版功能
local mflySpeed = 60
local mflyActive = false
local mflyBV = nil
local mflyBG = nil
local mflyConn = nil
local mflyGui = nil
local mflyDir = Vector3.new(0, 0, 0)

local function createMobileFlyGUI()
    if mflyGui then mflyGui:Destroy() end
    local sg = Instance.new("ScreenGui")
    sg.Name = "MobileFlyGUI"
    sg.ResetOnSpawn = false
    sg.Parent = game:GetService("CoreGui")

    -- 方向键背景面板（左下角）
    local dirFrame = Instance.new("Frame")
    dirFrame.Size = UDim2.new(0, 160, 0, 160)
    dirFrame.Position = UDim2.new(0, 20, 1, -180)
    dirFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    dirFrame.BackgroundTransparency = 0.3
    dirFrame.BorderSizePixel = 0
    dirFrame.Parent = sg
    Instance.new("UICorner", dirFrame).CornerRadius = UDim.new(0, 12)
    local dirStroke = Instance.new("UIStroke")
    dirStroke.Color = Color3.fromRGB(60, 60, 60)
    dirStroke.Thickness = 1
    dirStroke.Parent = dirFrame

    local dirLabel = Instance.new("TextLabel")
    dirLabel.Size = UDim2.new(1, 0, 0, 18)
    dirLabel.Position = UDim2.new(0, 0, 0, 2)
    dirLabel.BackgroundTransparency = 1
    dirLabel.Text = "方向控制"
    dirLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
    dirLabel.Font = Enum.Font.GothamBold
    dirLabel.TextSize = 9
    dirLabel.Parent = dirFrame

    local function makeDirBtn(text, posX, posY, keyCode)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 46, 0, 46)
        btn.Position = UDim2.new(0, posX, 0, posY)
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        btn.BackgroundTransparency = 0.2
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 18
        btn.BorderSizePixel = 0
        btn.Parent = dirFrame
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        btn.MouseButton1Down:Connect(function()
            if keyCode == "up" then mflyDir = mflyDir + Camera.CFrame.LookVector
            elseif keyCode == "down" then mflyDir = mflyDir - Camera.CFrame.LookVector
            elseif keyCode == "left" then mflyDir = mflyDir - Camera.CFrame.RightVector
            elseif keyCode == "right" then mflyDir = mflyDir + Camera.CFrame.RightVector
            end
        end)
        btn.MouseButton1Up:Connect(function()
            if keyCode == "up" then mflyDir = mflyDir - Camera.CFrame.LookVector
            elseif keyCode == "down" then mflyDir = mflyDir + Camera.CFrame.LookVector
            elseif keyCode == "left" then mflyDir = mflyDir + Camera.CFrame.RightVector
            elseif keyCode == "right" then mflyDir = mflyDir - Camera.CFrame.RightVector
            end
        end)
        return btn
    end

    makeDirBtn("W", 57, 24, "up")
    makeDirBtn("S", 57, 108, "down")
    makeDirBtn("A", 8, 66, "left")
    makeDirBtn("D", 106, 66, "right")

    -- 高度控制按钮（右下角）
    local heightFrame = Instance.new("Frame")
    heightFrame.Size = UDim2.new(0, 70, 0, 120)
    heightFrame.Position = UDim2.new(1, -90, 1, -140)
    heightFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    heightFrame.BackgroundTransparency = 0.3
    heightFrame.BorderSizePixel = 0
    heightFrame.Parent = sg
    Instance.new("UICorner", heightFrame).CornerRadius = UDim.new(0, 12)
    local hStroke = Instance.new("UIStroke")
    hStroke.Color = Color3.fromRGB(60, 60, 60)
    hStroke.Thickness = 1
    hStroke.Parent = heightFrame

    local upBtn = Instance.new("TextButton")
    upBtn.Size = UDim2.new(0, 50, 0, 50)
    upBtn.Position = UDim2.new(0, 10, 0, 8)
    upBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 60)
    upBtn.BackgroundTransparency = 0.3
    upBtn.Text = "^"
    upBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    upBtn.Font = Enum.Font.GothamBold
    upBtn.TextSize = 22
    upBtn.BorderSizePixel = 0
    upBtn.Parent = heightFrame
    Instance.new("UICorner", upBtn).CornerRadius = UDim.new(0, 8)
    upBtn.MouseButton1Down:Connect(function() mflyDir = mflyDir + Vector3.new(0, 1, 0) end)
    upBtn.MouseButton1Up:Connect(function() mflyDir = mflyDir - Vector3.new(0, 1, 0) end)

    local downBtn = Instance.new("TextButton")
    downBtn.Size = UDim2.new(0, 50, 0, 50)
    downBtn.Position = UDim2.new(0, 10, 0, 66)
    downBtn.BackgroundColor3 = Color3.fromRGB(100, 40, 0)
    downBtn.BackgroundTransparency = 0.3
    downBtn.Text = "v"
    downBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    downBtn.Font = Enum.Font.GothamBold
    downBtn.TextSize = 22
    downBtn.BorderSizePixel = 0
    downBtn.Parent = heightFrame
    Instance.new("UICorner", downBtn).CornerRadius = UDim.new(0, 8)
    downBtn.MouseButton1Down:Connect(function() mflyDir = mflyDir - Vector3.new(0, 1, 0) end)
    downBtn.MouseButton1Up:Connect(function() mflyDir = mflyDir + Vector3.new(0, 1, 0) end)

    -- 主控制面板（居中上方）
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 200, 0, 100)
    mainFrame.Position = UDim2.new(0.5, -100, 0, 60)
    mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    mainFrame.BackgroundTransparency = 0.15
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = sg
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)
    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = Color3.fromRGB(0, 120, 80)
    mainStroke.Thickness = 1.5
    mainStroke.Parent = mainFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 24)
    titleLabel.BackgroundColor3 = Color3.fromRGB(0, 100, 70)
    titleLabel.BackgroundTransparency = 0.3
    titleLabel.Text = "飞车手机版"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 12
    titleLabel.Parent = mainFrame
    Instance.new("UICorner", titleLabel).CornerRadius = UDim.new(0, 10)

    local function makeMainBtn(text, posX, posY, color, cb)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 88, 0, 32)
        btn.Position = UDim2.new(0, posX, 0, posY)
        btn.BackgroundColor3 = color
        btn.BackgroundTransparency = 0.3
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(230, 230, 230)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11
        btn.BorderSizePixel = 0
        btn.AutoButtonColor = true
        btn.Parent = mainFrame
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        btn.MouseButton1Click:Connect(cb)
        return btn
    end

    makeMainBtn("起飞", 8, 30, Color3.fromRGB(0, 120, 80), function()
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        hrp.Anchored = false
        if mflyBV then mflyBV:Destroy() end
        if mflyBG then mflyBG:Destroy() end
        mflyBV = Instance.new("BodyVelocity", hrp)
        mflyBV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        mflyBV.Velocity = Vector3.new(0, 0, 0)
        mflyBG = Instance.new("BodyGyro", hrp)
        mflyBG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        mflyBG.D = 5000
        mflyBG.P = 50000
        mflyBG.CFrame = Camera.CFrame
        mflyActive = true
        if mflyConn then mflyConn:Disconnect() end
        mflyConn = game:GetService("RenderStepped"):Connect(function()
            if not mflyActive then return end
            local hrp2 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not hrp2 then mflyActive = false; return end
            if mflyBG then mflyBG.CFrame = Camera.CFrame end
            local dir = mflyDir
            if dir.Magnitude > 0 then
                dir = dir.Unit * mflySpeed
            end
            if mflyBV then mflyBV.Velocity = dir end
        end)
    end)

    makeMainBtn("降落", 104, 30, Color3.fromRGB(120, 80, 0), function()
        mflyActive = false
        mflyDir = Vector3.new(0, 0, 0)
        if mflyConn then mflyConn:Disconnect(); mflyConn = nil end
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            if mflyBV then mflyBV:Destroy(); mflyBV = nil end
            if mflyBG then mflyBG:Destroy(); mflyBG = nil end
        end
    end)

    makeMainBtn("定住", 8, 66, Color3.fromRGB(80, 0, 100), function()
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.Anchored = true end
    end)

    makeMainBtn("关闭", 104, 66, Color3.fromRGB(120, 30, 30), function()
        mflyActive = false
        mflyDir = Vector3.new(0, 0, 0)
        if mflyConn then mflyConn:Disconnect(); mflyConn = nil end
        if mflyBV then mflyBV:Destroy(); mflyBV = nil end
        if mflyBG then mflyBG:Destroy(); mflyBG = nil end
        sg:Destroy()
        mflyGui = nil
    end)

    mflyGui = sg
end

Tabs.zho:Button({
    Title = "飞车手机版",
    Desc = "触摸按钮控制飞车（适配手机）",
    Callback = function()
        if mflyGui then mflyGui:Destroy(); mflyGui = nil end
        mflyActive = false
        mflyDir = Vector3.new(0, 0, 0)
        if mflyConn then mflyConn:Disconnect(); mflyConn = nil end
        if mflyBV then mflyBV:Destroy(); mflyBV = nil end
        if mflyBG then mflyBG:Destroy(); mflyBG = nil end
        createMobileFlyGUI()
    end
})
Tabs.zho:Slider({
    Title = "行走速度（默认16）",
    Desc = "调整角色的行走速度",
    Value = { Min = 1, Max = 400, Default = 16 },
    Step = 1,
    IsTextbox = true,
    Callback = function(value)
        local char = getCharacter()
        if char then char.Humanoid.WalkSpeed = value end
    end
})
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local speedConn = nil
local currentSpeed = 1
local speedConn = nil
local currentSpeed = 1
local function updateChar()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if speedConn then
        speedConn:Disconnect()
        speedConn = nil
    end
    if not hum or currentSpeed <= 1 then return end
    speedConn = RunService.Heartbeat:Connect(function()
        if not LocalPlayer.Character then
            speedConn:Disconnect()
            speedConn = nil
            return
        end
        local h = LocalPlayer.Character.Humanoid
        if h.MoveDirection.Magnitude > 0 then
            LocalPlayer.Character:TranslateBy(h.MoveDirection * currentSpeed / 10)
        end
    end)
end
LocalPlayer.CharacterAdded:Connect(updateChar)
task.spawn(updateChar)
Tabs.zho:Slider({
    Title = "超级快跑",
    Desc = "1=正常速度",
    Value = {Min = 1, Max = 200, Default = 1},
    Step = 1,
    IsTextbox = true,
    Callback = function(val)
        currentSpeed = val
        updateChar()
    end
})
Tabs.zho:Slider({
    Title = "跳跃高度（默认50）",
    Desc = "调整角色的跳跃高度",
    Value = { Min = 0, Max = 400, Default = 50 },
    Step = 1,
    IsTextbox = true,
    Callback = function(value)
        local char = getCharacter()
        if char then char.Humanoid.JumpPower = value end
    end
})
Tabs.zho:Slider({
    Title = "设置缩放焦距(正常70)",
    Desc = "",
    Value = { Min = 0.1, Max = 250, Default = 70 },
    Step = 0.1,
    IsTextbox = true,
    Callback = function(fieldOfView)
        workspace.CurrentCamera.FieldOfView = fieldOfView
    end
})
Tabs.zho:Slider({
    Title = "设置血量",
    Desc = "",
    Value = { Min = 100, Max = 10000, Default = 100 },
    Step = 1,
    IsTextbox = true,
    Callback = function(health)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.Health = health
        end
    end
})
Tabs.zho:Slider({
    Title = "设置帧率FPS",
    Desc = "",
    Value = { Min = 300, Max = 100000, Default = 300 },
    Step = 1,
    IsTextbox = true,
    Callback = function(fps)
        setfpscap(fps)
    end
})
Tabs.zho:Toggle({
    Title = "无限跳",
    Desc = "开启后可在空中连续跳跃",
    Value = false,
    Callback = function(state)
        isInfiniteJumpEnabled = state
    end
})
Tabs.zho:Toggle({
    Title = "人物显示",
    Desc = "",
    Value = false,
    Callback = function(enabled)
        getgenv().enabled = enabled
        getgenv().filluseteamcolor = true
        getgenv().outlineuseteamcolor = true
        getgenv().fillcolor = Color3.new(1, 0, 0)
        getgenv().outlinecolor = Color3.new(1, 1, 1)
        getgenv().filltrans = 0.5
        getgenv().outlinetrans = 0.5
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/RobloxScripts/main/Highlight-ESP.lua"))()
    end
})
local autoInteract = false
local interactLoop = nil
Tabs.zho:Toggle({
     Title = "自动互动",
     Desc = "",
     Value = false,
     Callback = function(enabled)
         autoInteract = enabled
         if interactLoop then
             interactLoop:Disconnect()
             interactLoop = nil
         end
         if enabled then
             interactLoop = task.spawn(function()
                 while autoInteract and task.wait(0.4) do
                     local parts = workspace:GetDescendants()
                     for _, obj in ipairs(parts) do
                         if obj:IsA("ProximityPrompt") then
                             fireproximityprompt(obj)
                         end
                     end
                 end
             end)
         end
     end
})
local clipConn = nil
Tabs.zho:Toggle({
    Title = "穿墙",
    Desc = "",
    Value = false,
    Callback = function(enabled)
        if clipConn then
            clipConn:Disconnect()
            clipConn = nil
        end
        if enabled then
            Clipon = true
            clipConn = RunService.Stepped:Connect(function()
                local char = workspace:FindFirstChild(LocalPlayer.Name)
                if not char then return end
                for _, part in ipairs(char:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end)
        else
            Clipon = false
        end
    end
})
Tabs.zho:Toggle({
    Title = "获取所有玩家背包",
    Desc = "部分服务器没效果",
    Value = false,
    Callback = function(enabled)
        spawn(function()
            while enabled and task.wait() do
                for _, player in pairs(game.Players:GetPlayers()) do
                    for _, tool in pairs(player.Backpack:GetChildren()) do
                        tool.Parent = game.Players.LocalPlayer.Backpack
                        task.wait()
                    end
                end
            end
        end)
    end
})
Tabs.zho:Button({
    Title = "获取当前道具",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/3FU05Dyt/raw"))()
    end
})
Tabs.zho:Button({
    Title = "装备全部道具",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/uBqVR9JC/raw"))()
    end
})
Tabs.zho:Button({
    Title = "删除道具",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/r4LHK4p0/raw"))()
    end
})
Tabs.zho:Button({
    Title = "删除所有道具",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/8HB71Lbj/raw"))()
    end
})
Tabs.zho:Button({
    Title = "快速互动",
    Callback = function()
        game.ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
            prompt.HoldDuration = 0
        end)
    end
})
Tabs.zho:Button({
    Title = "随机传送",
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/skid123skidlol/cd0d2dce51b3f20ad1aac941da06a1a1/raw/f58b98cce7d51e53ade94e7bb460e4f24fb7e0ff/%257BFE%257D%2520Invisible%2520Tool%2520(can%2520hold%2520tools)", true))()
    end
})
Tabs.zho:Button({
    Title = "TX翻译",
    Callback = function()
        TX = "TX Script"
Script = "全自动翻译"
loadstring(game:HttpGet("https://raw.githubusercontent.com/JsYb666/Item/refs/heads/main/Auto-language"))()
    end
})
Tabs.zho:Button({
     Title = "飞行fly",
     Callback = function()
         pcall(function()
             local url = "https://raw.githubusercontent.com/rodan-demirali/RobloxUI/refs/heads/main/flyUIscript"
             local code = game:HttpGet(url)
             loadstring(code)()
         end, function(err)
             WindUI:Notify({Title="加载失败", Content="网络错误，脚本无法加载", Duration=3})
         end)
     end
 })
Tabs.zho:Button({
    Title = "甩飞所有人",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/zqyDSUWX"))()
    end
})
Tabs.zho:Button({
    Title = "死亡笔记1",
    Callback = function()
        loadstring(game:HttpGet([[https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/1_1.txt_2024-08-08_153358.OTed.lua]]))()
    end
})
Tabs.zho:Button({
    Title = "传送至玩家身边",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Infinity2346/Tect-Menu/main/Teleport%20Gui.lua"))()
    end
})
Tabs.zho:Button({
    Title = "指令",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})
Tabs.zho:Button({
    Title = "死亡笔记2",
    Callback = function()
local Handle = Instance.new('Part')
local Mesh = Instance.new('SpecialMesh')
local Death = Instance.new('Tool')
Death.Name = "Death Note"
Handle.Name = "Handle"
Death.Parent = game.Players.LocalPlayer.Backpack
Death.GripForward = Vector3.new(0.331, -0.766, 0.551)
Death.GripPos = Vector3.new(-0.8, 0, -0.8)
Death.GripRight = Vector3.new(-0.943, -0.297, 0.152)
Death.GripUp = Vector3.new(-0.048, 0.57, 0.82)
Death.ToolTip = "Kill your fucking rival"
Handle.Parent = Death
Mesh.Parent = Handle
Mesh.MeshId = "http://www.roblox.com/asset/?id=1136139"
Mesh.TextureId = "http://www.roblox.com/asset/?id=18276952"
Mesh.Scale = Vector3.new(0.55, 0.174, 0.6)
Handle.Rotation = Vector3.new(0,-90,0)
Death.Equipped:connect(function(mouse)
local Bounce = Enum.EasingStyle.Bounce
local Quad = Enum.EasingStyle.Quad
local Normal = Enum.EasingStyle.Linear
local ScreenGui = Instance.new("ScreenGui", game.Players["LocalPlayer"].PlayerGui)
ScreenGui.Name = "Death Note"
local open = Instance.new("ImageButton", ScreenGui)
open.Position = UDim2.new(1, -110, 1, 500)
open.Size = UDim2.new(0, 100,0, 150)
open.Image = "rbxassetid://18536731"
open:TweenPosition(UDim2.new(1, -110, 1, -150), "In", Bounce, 0.8, true)
local Note = Instance.new("Frame", ScreenGui)
Note.Active = true
Note.Position = UDim2.new(1, -321, 1, 500)
Note.Size = UDim2.new(0, 320,0, 250)
Note.Visible = false
Note.Draggable = true
open.MouseButton1Down:connect(function()
open:TweenPosition(UDim2.new(open.Position.X.Scale,open.Position.X.Offset, 1, 500), "Out", Normal, 0.8, true)
wait(0.30)
open.Visible = false
Note.Visible = true
Note.Position = UDim2.new(1, -321, 1, 500)
Note:TweenPosition(UDim2.new(1, -321, 1, -251), "In", Normal, 0.5, true)
end)
local bg = Instance.new("Frame", Note)
bg.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
bg.Size = UDim2.new(0, 160,0, 250)
bg.ZIndex = 2
local close = Instance.new("TextButton", bg)
close.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
close.BackgroundTransparency = 1
close.Position = UDim2.new(0, 8,0, 10)
close.Size = UDim2.new(0, 10,0, 10)
close.ZIndex = 4
close.Font = "Cartoon"
close.Text = "X"
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.TextSize = "17"
close.MouseButton1Down:connect(function()
Note:TweenPosition(UDim2.new(Note.Position.X.Scale,Note.Position.X.Offset,1, 500), "Out", Normal, 0.5, true)
wait(0.30)
Note.Visible = false
open.Visible = true
open:TweenPosition(UDim2.new(1, -110, 1, -150), "In", Normal, 0.8, true)
end)
local image1 = Instance.new("ImageLabel", bg)
image1.BackgroundTransparency = 1
image1.Size = UDim2.new(1, 0,1, 0)
image1.ZIndex = 3
image1.Image = "rbxassetid://18528551"
local title = Instance.new("TextLabel", bg)
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 0,0, 30)
title.Size = UDim2.new(1, 0,0, 30)
title.ZIndex = 4
title.Font = "Bodoni"
title.Text = "DEATH NOTE"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = "18"
local body = Instance.new("TextLabel", bg)
body.BackgroundTransparency = 1
body.Position = UDim2.new(0, 15,0, 65)
body.Size = UDim2.new(0, 134,0, 40)
body.ZIndex = 4
body.Font = "Garamond"
body.Text = "Type in somebody's name to kill them."
body.TextColor3 = Color3.fromRGB(255, 255, 255)
body.TextSize = "19"
body.TextWrapped = true
body.TextXAlignment = "Left"
body.TextYAlignment = "Top"
local line = Instance.new("TextLabel", body)
line.BackgroundTransparency = 1
line.Position = UDim2.new(0, 0,0, 50)
line.Size = UDim2.new(0, 130,0, 40)
line.ZIndex = 4
line.Font = "Garamond"
line.Text = "________________"
line.TextColor3 = Color3.fromRGB(255, 255, 255)
line.TextSize = "19"
line.TextWrapped = true
line.TextXAlignment = "Left"
line.TextYAlignment = "Top"
local text = Instance.new("TextLabel", body)
text.BackgroundTransparency = 1
text.Position = UDim2.new(0, 0,0, 100)
text.Size = UDim2.new(0, 134,0, 40)
text.ZIndex = 4
text.Font = "Garamond"
text.Text = "This was made by RcDZ."
text.TextColor3 = Color3.fromRGB(255, 255, 255)
text.TextSize = "19"
text.TextWrapped = true
text.TextXAlignment = "Left"
text.TextYAlignment = "Top"
local page = Instance.new("Frame", Note)
page.BackgroundColor3 = Color3.fromRGB(236, 236, 236)
page.Position = UDim2.new(0, 160,0, 0)
page.Size = UDim2.new(0, 160,0, 250)
page.ZIndex = 2
local list = Instance.new("TextBox", page)
list.BackgroundTransparency = 1
list.Position = UDim2.new(0, 25,0, 20)
list.Size = UDim2.new(0.8, 5,0, 230)
list.ZIndex = 4
list.Font = "Antique"
list.Text = ""
list.TextColor3 = Color3.fromRGB(0, 0, 0)
list.TextSize = "23"
list.TextWrapped = true
list.TextXAlignment = "Left"
list.TextYAlignment = "Top"
local image2 = Instance.new("ImageLabel", page)
image2.BackgroundTransparency = 1
image2.Size = UDim2.new(1, 0,1, 0)
image2.ZIndex = 3
image2.Image = "rbxassetid://170279713"
image2.Transparency = 0.2
while true do
repeat wait() until game.Workspace:FindFirstChild(list.Text)
if game.Workspace[list.Text]:FindFirstChild("Humanoid") then
game.Workspace[list.Text].Humanoid.PlatformStand = true
game.Workspace[list.Text].Humanoid.Health = 0
elseif game.Workspace[list.Text]:FindFirstChild("Zombie") then
game.Workspace[list.Text].Zombie.PlatformStand = true
game.Workspace[list.Text].Zombie.Health = 0
end
end
end)
Death.Unequipped:connect(function(mouse)
game.Players.LocalPlayer.PlayerGui["Death Note"]:remove()
end)
    end
})
Tabs.zho:Button({
    Title = "魂魄跟随",
    Callback = function()
    end
})
Tabs.zho:Button({
    Title = "显示FPS",
    Callback = function()
        local FpsGui = Instance.new("ScreenGui") local FpsXS = Instance.new("TextLabel") FpsGui.Name = "FPSGui" FpsGui.ResetOnSpawn = false FpsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling FpsXS.Name = "FpsXS" FpsXS.Size = UDim2.new(0, 100, 0, 50) FpsXS.Position = UDim2.new(0, 10, 0, 10) FpsXS.BackgroundTransparency = 1 FpsXS.Font = Enum.Font.SourceSansBold FpsXS.Text = "FPS: 0" FpsXS.TextSize = 20 FpsXS.TextColor3 = Color3.new(1, 1, 1) FpsXS.Parent = FpsGui function updateFpsXS() local fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait()) FpsXS.Text = "FPS: " .. fps end game:GetService("RunService").RenderStepped:Connect(updateFpsXS) FpsGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    end
})
Tabs.zho:Button({
    Title = "ESP",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wa0101/Roblox-ESP/refs/heads/main/esp.lua"))()
    end
})
Tabs.zho:Button({
    Title = "穿墙",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/sandakovandrej23-art/ROBLOXNOCLIPGUI/refs/heads/main/Noclipgui.lua"))()
    end
})
Tabs.zho:Button({
    Title = "踏空行走",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float'))()
    end
})
Tabs.zho:Button({
    Title = "修改移速",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tiger-v1/RobloxSpeedJump.GUI/refs/heads/main/SpeedJumpGUI.lua"))()
    end
})
Tabs.zho:Button({
    Title = "🔴esp🔴",
    Callback = function()
        local Workspace, RunService, Players, CoreGui, Lighting = cloneref(game:GetService("Workspace")), cloneref(game:GetService("RunService")), cloneref(game:GetService("Players")), game:GetService("CoreGui"), cloneref(game:GetService("Lighting"))
local ESP = {
    Enabled = true,
    TeamCheck = true,
    MaxDistance = 200,
    FontSize = 11,
    FadeOut = {
        OnDistance = true,
        OnDeath = false,
        OnLeave = false,
    },
    Options = { 
        Teamcheck = false, TeamcheckRGB = Color3.fromRGB(0, 255, 0),
        Friendcheck = true, FriendcheckRGB = Color3.fromRGB(0, 255, 0),
        Highlight = false, HighlightRGB = Color3.fromRGB(255, 0, 0),
    },
    Drawing = {
        Chams = {
            Enabled  = true,
            Thermal = true,
            FillRGB = Color3.fromRGB(119, 120, 255),
            Fill_Transparency = 100,
            OutlineRGB = Color3.fromRGB(119, 120, 255),
            Outline_Transparency = 100,
            VisibleCheck = true,
        },
        Names = {
            Enabled = true,
            RGB = Color3.fromRGB(255, 255, 255),
        },
        Flags = {
            Enabled = true,
        },
        Distances = {
            Enabled = true, 
            Position = "Text",
            RGB = Color3.fromRGB(255, 255, 255),
        },
        Weapons = {
            Enabled = true, WeaponTextRGB = Color3.fromRGB(119, 120, 255),
            Outlined = false,
            Gradient = false,
            GradientRGB1 = Color3.fromRGB(255, 255, 255), GradientRGB2 = Color3.fromRGB(119, 120, 255),
        },
        Healthbar = {
            Enabled = true,  
            HealthText = true, Lerp = false, HealthTextRGB = Color3.fromRGB(119, 120, 255),
            Width = 2.5,
            Gradient = true, GradientRGB1 = Color3.fromRGB(200, 0, 0), GradientRGB2 = Color3.fromRGB(60, 60, 125), GradientRGB3 = Color3.fromRGB(119, 120, 255), 
        },
        Boxes = {
            Animate = true,
            RotationSpeed = 300,
            Gradient = false, GradientRGB1 = Color3.fromRGB(119, 120, 255), GradientRGB2 = Color3.fromRGB(0, 0, 0), 
            GradientFill = true, GradientFillRGB1 = Color3.fromRGB(119, 120, 255), GradientFillRGB2 = Color3.fromRGB(0, 0, 0), 
            Filled = {
                Enabled = true,
                Transparency = 0.75,
                RGB = Color3.fromRGB(0, 0, 0),
            },
            Full = {
                Enabled = true,
                RGB = Color3.fromRGB(255, 255, 255),
            },
            Corner = {
                Enabled = true,
                RGB = Color3.fromRGB(255, 255, 255),
            },
        };
    };
    Connections = {
        RunService = RunService;
    };
    Fonts = {};
}
local Euphoria = ESP.Connections;
local lplayer = Players.LocalPlayer;
local camera = game.Workspace.CurrentCamera;
local Cam = Workspace.CurrentCamera;
local RotationAngle, Tick = -45, tick();
local Weapon_Icons = {
    ["Wooden Bow"] = "http://www.roblox.com/asset/?id=17677465400",
    ["Crossbow"] = "http://www.roblox.com/asset/?id=17677473017",
    ["Salvaged SMG"] = "http://www.roblox.com/asset/?id=17677463033",
    ["Salvaged AK47"] = "http://www.roblox.com/asset/?id=17677455113",
    ["Salvaged AK74u"] = "http://www.roblox.com/asset/?id=17677442346",
    ["Salvaged M14"] = "http://www.roblox.com/asset/?id=17677444642",
    ["Salvaged Python"] = "http://www.roblox.com/asset/?id=17677451737",
    ["Military PKM"] = "http://www.roblox.com/asset/?id=17677449448",
    ["Military M4A1"] = "http://www.roblox.com/asset/?id=17677479536",
    ["Bruno's M4A1"] = "http://www.roblox.com/asset/?id=17677471185",
    ["Military Barrett"] = "http://www.roblox.com/asset/?id=17677482998",
    ["Salvaged Skorpion"] = "http://www.roblox.com/asset/?id=17677459658",
    ["Salvaged Pump Action"] = "http://www.roblox.com/asset/?id=17677457186",
    ["Military AA12"] = "http://www.roblox.com/asset/?id=17677475227",
    ["Salvaged Break Action"] = "http://www.roblox.com/asset/?id=17677468751",
    ["Salvaged Pipe Rifle"] = "http://www.roblox.com/asset/?id=17677468751",
    ["Salvaged P250"] = "http://www.roblox.com/asset/?id=17677447257",
    ["Nail Gun"] = "http://www.roblox.com/asset/?id=17677484756"
};
local Functions = {}
do
    function Functions:Create(Class, Properties)
        local _Instance = typeof(Class) == 'string' and Instance.new(Class) or Class
        for Property, Value in pairs(Properties) do
            _Instance[Property] = Value
        end
        return _Instance;
    end
    function Functions:FadeOutOnDist(element, distance)
        local transparency = math.max(0.1, 1 - (distance / ESP.MaxDistance))
        if element:IsA("TextLabel") then
            element.TextTransparency = 1 - transparency
        elseif element:IsA("ImageLabel") then
            element.ImageTransparency = 1 - transparency
        elseif element:IsA("UIStroke") then
            element.Transparency = 1 - transparency
        elseif element:IsA("Frame") and (element == Healthbar or element == BehindHealthbar) then
            element.BackgroundTransparency = 1 - transparency
        elseif element:IsA("Frame") then
            element.BackgroundTransparency = 1 - transparency
        elseif element:IsA("Highlight") then
            element.FillTransparency = 1 - transparency
            element.OutlineTransparency = 1 - transparency
        end;
    end;  
end;
do
    local ScreenGui = Functions:Create("ScreenGui", {
        Parent = CoreGui,
        Name = "ESPHolder",
    });
    local DupeCheck = function(plr)
        if ScreenGui:FindFirstChild(plr.Name) then
            ScreenGui[plr.Name]:Destroy()
        end
    end
    local ESP = function(plr)
        coroutine.wrap(DupeCheck)(plr)
        local Name = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(0.5, 0, 0, -11), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0), RichText = true})
        local Distance = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(0.5, 0, 0, 11), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0), RichText = true})
        local Weapon = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(0.5, 0, 0, 31), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0), RichText = true})
        local Box = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.75, BorderSizePixel = 0})
        local Gradient1 = Functions:Create("UIGradient", {Parent = Box, Enabled = ESP.Drawing.Boxes.GradientFill, Color = ColorSequence.new{ColorSequenceKeypoint.new(0, ESP.Drawing.Boxes.GradientFillRGB1), ColorSequenceKeypoint.new(1, ESP.Drawing.Boxes.GradientFillRGB2)}})
        local Outline = Functions:Create("UIStroke", {Parent = Box, Enabled = ESP.Drawing.Boxes.Gradient, Transparency = 0, Color = Color3.fromRGB(255, 255, 255), LineJoinMode = Enum.LineJoinMode.Miter})
        local Gradient2 = Functions:Create("UIGradient", {Parent = Outline, Enabled = ESP.Drawing.Boxes.Gradient, Color = ColorSequence.new{ColorSequenceKeypoint.new(0, ESP.Drawing.Boxes.GradientRGB1), ColorSequenceKeypoint.new(1, ESP.Drawing.Boxes.GradientRGB2)}})
        local Healthbar = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0})
        local BehindHealthbar = Functions:Create("Frame", {Parent = ScreenGui, ZIndex = -1, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0})
        local HealthbarGradient = Functions:Create("UIGradient", {Parent = Healthbar, Enabled = ESP.Drawing.Healthbar.Gradient, Rotation = -90, Color = ColorSequence.new{ColorSequenceKeypoint.new(0, ESP.Drawing.Healthbar.GradientRGB1), ColorSequenceKeypoint.new(0.5, ESP.Drawing.Healthbar.GradientRGB2), ColorSequenceKeypoint.new(1, ESP.Drawing.Healthbar.GradientRGB3)}})
        local HealthText = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(0.5, 0, 0, 31), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0)})
        local Chams = Functions:Create("Highlight", {Parent = ScreenGui, FillTransparency = 1, OutlineTransparency = 0, OutlineColor = Color3.fromRGB(119, 120, 255), DepthMode = "AlwaysOnTop"})
        local WeaponIcon = Functions:Create("ImageLabel", {Parent = ScreenGui, BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(0, 40, 0, 40)})
        local Gradient3 = Functions:Create("UIGradient", {Parent = WeaponIcon, Rotation = -90, Enabled = ESP.Drawing.Weapons.Gradient, Color = ColorSequence.new{ColorSequenceKeypoint.new(0, ESP.Drawing.Weapons.GradientRGB1), ColorSequenceKeypoint.new(1, ESP.Drawing.Weapons.GradientRGB2)}})
        local LeftTop = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
        local LeftSide = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
        local RightTop = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
        local RightSide = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
        local BottomSide = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
        local BottomDown = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
        local BottomRightSide = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
        local BottomRightDown = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
        local Flag1 = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(1, 0, 0, 0), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0)})
        local Flag2 = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(1, 0, 0, 0), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0)})
        local Updater = function()
            local Connection;
            local function HideESP()
                Box.Visible = false;
                Name.Visible = false;
                Distance.Visible = false;
                Weapon.Visible = false;
                Healthbar.Visible = false;
                BehindHealthbar.Visible = false;
                HealthText.Visible = false;
                WeaponIcon.Visible = false;
                LeftTop.Visible = false;
                LeftSide.Visible = false;
                BottomSide.Visible = false;
                BottomDown.Visible = false;
                RightTop.Visible = false;
                RightSide.Visible = false;
                BottomRightSide.Visible = false;
                BottomRightDown.Visible = false;
                Flag1.Visible = false;
                Chams.Enabled = false;
                Flag2.Visible = false;
                if not plr then
                    ScreenGui:Destroy();
                    Connection:Disconnect();
                end
            end
            Connection = Euphoria.RunService.RenderStepped:Connect(function()
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local HRP = plr.Character.HumanoidRootPart
                    local Humanoid = plr.Character:WaitForChild("Humanoid");
                    local Pos, OnScreen = Cam:WorldToScreenPoint(HRP.Position)
                    local Dist = (Cam.CFrame.Position - HRP.Position).Magnitude / 3.5714285714
                    if OnScreen and Dist <= ESP.MaxDistance then
                        local Size = HRP.Size.Y
                        local scaleFactor = (Size * Cam.ViewportSize.Y) / (Pos.Z * 2)
                        local w, h = 3 * scaleFactor, 4.5 * scaleFactor
                        if ESP.FadeOut.OnDistance then
                            Functions:FadeOutOnDist(Box, Dist)
                            Functions:FadeOutOnDist(Outline, Dist)
                            Functions:FadeOutOnDist(Name, Dist)
                            Functions:FadeOutOnDist(Distance, Dist)
                            Functions:FadeOutOnDist(Weapon, Dist)
                            Functions:FadeOutOnDist(Healthbar, Dist)
                            Functions:FadeOutOnDist(BehindHealthbar, Dist)
                            Functions:FadeOutOnDist(HealthText, Dist)
                            Functions:FadeOutOnDist(WeaponIcon, Dist)
                            Functions:FadeOutOnDist(LeftTop, Dist)
                            Functions:FadeOutOnDist(LeftSide, Dist)
                            Functions:FadeOutOnDist(BottomSide, Dist)
                            Functions:FadeOutOnDist(BottomDown, Dist)
                            Functions:FadeOutOnDist(RightTop, Dist)
                            Functions:FadeOutOnDist(RightSide, Dist)
                            Functions:FadeOutOnDist(BottomRightSide, Dist)
                            Functions:FadeOutOnDist(BottomRightDown, Dist)
                            Functions:FadeOutOnDist(Chams, Dist)
                            Functions:FadeOutOnDist(Flag1, Dist)
                            Functions:FadeOutOnDist(Flag2, Dist)
                        end
                        if ESP.TeamCheck and plr ~= lplayer and ((lplayer.Team ~= plr.Team and plr.Team) or (not lplayer.Team and not plr.Team)) and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid") then
                            do
                                Chams.Adornee = plr.Character
                                Chams.Enabled = ESP.Drawing.Chams.Enabled
                                Chams.FillColor = ESP.Drawing.Chams.FillRGB
                                Chams.OutlineColor = ESP.Drawing.Chams.OutlineRGB
                                do
                                    if ESP.Drawing.Chams.Thermal then
                                        local breathe_effect = math.atan(math.sin(tick() * 2)) * 2 / math.pi
                                        Chams.FillTransparency = ESP.Drawing.Chams.Fill_Transparency * breathe_effect * 0.01
                                        Chams.OutlineTransparency = ESP.Drawing.Chams.Outline_Transparency * breathe_effect * 0.01
                                    end
                                end
                                if ESP.Drawing.Chams.VisibleCheck then
                                    Chams.DepthMode = "Occluded"
                                else
                                    Chams.DepthMode = "AlwaysOnTop"
                                end
                            end;
                            do
                                LeftTop.Visible = ESP.Drawing.Boxes.Corner.Enabled
                                LeftTop.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y - h / 2)
                                LeftTop.Size = UDim2.new(0, w / 5, 0, 1)
                                LeftSide.Visible = ESP.Drawing.Boxes.Corner.Enabled
                                LeftSide.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y - h / 2)
                                LeftSide.Size = UDim2.new(0, 1, 0, h / 5)
                                BottomSide.Visible = ESP.Drawing.Boxes.Corner.Enabled
                                BottomSide.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y + h / 2)
                                BottomSide.Size = UDim2.new(0, 1, 0, h / 5)
                                BottomSide.AnchorPoint = Vector2.new(0, 5)
                                BottomDown.Visible = ESP.Drawing.Boxes.Corner.Enabled
                                BottomDown.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y + h / 2)
                                BottomDown.Size = UDim2.new(0, w / 5, 0, 1)
                                BottomDown.AnchorPoint = Vector2.new(0, 1)
                                RightTop.Visible = ESP.Drawing.Boxes.Corner.Enabled
                                RightTop.Position = UDim2.new(0, Pos.X + w / 2, 0, Pos.Y - h / 2)
                                RightTop.Size = UDim2.new(0, w / 5, 0, 1)
                                RightTop.AnchorPoint = Vector2.new(1, 0)
                                RightSide.Visible = ESP.Drawing.Boxes.Corner.Enabled
                                RightSide.Position = UDim2.new(0, Pos.X + w / 2 - 1, 0, Pos.Y - h / 2)
                                RightSide.Size = UDim2.new(0, 1, 0, h / 5)
                                RightSide.AnchorPoint = Vector2.new(0, 0)
                                BottomRightSide.Visible = ESP.Drawing.Boxes.Corner.Enabled
                                BottomRightSide.Position = UDim2.new(0, Pos.X + w / 2, 0, Pos.Y + h / 2)
                                BottomRightSide.Size = UDim2.new(0, 1, 0, h / 5)
                                BottomRightSide.AnchorPoint = Vector2.new(1, 1)
                                BottomRightDown.Visible = ESP.Drawing.Boxes.Corner.Enabled
                                BottomRightDown.Position = UDim2.new(0, Pos.X + w / 2, 0, Pos.Y + h / 2)
                                BottomRightDown.Size = UDim2.new(0, w / 5, 0, 1)
                                BottomRightDown.AnchorPoint = Vector2.new(1, 1)                                                            
                            end
                            do
                                Box.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y - h / 2)
                                Box.Size = UDim2.new(0, w, 0, h)
                                Box.Visible = ESP.Drawing.Boxes.Full.Enabled;
                                if ESP.Drawing.Boxes.Filled.Enabled then
                                    Box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                    if ESP.Drawing.Boxes.GradientFill then
                                        Box.BackgroundTransparency = ESP.Drawing.Boxes.Filled.Transparency;
                                    else
                                        Box.BackgroundTransparency = 1
                                    end
                                    Box.BorderSizePixel = 1
                                else
                                    Box.BackgroundTransparency = 1
                                end
                                RotationAngle = RotationAngle + (tick() - Tick) * ESP.Drawing.Boxes.RotationSpeed * math.cos(math.pi / 4 * tick() - math.pi / 2)
                                if ESP.Drawing.Boxes.Animate then
                                    Gradient1.Rotation = RotationAngle
                                    Gradient2.Rotation = RotationAngle
                                else
                                    Gradient1.Rotation = -45
                                    Gradient2.Rotation = -45
                                end
                                Tick = tick()
                            end
                            do  
                                local health = Humanoid.Health / Humanoid.MaxHealth;
                                Healthbar.Visible = ESP.Drawing.Healthbar.Enabled;
                                Healthbar.Position = UDim2.new(0, Pos.X - w / 2 - 6, 0, Pos.Y - h / 2 + h * (1 - health))  
                                Healthbar.Size = UDim2.new(0, ESP.Drawing.Healthbar.Width, 0, h * health)  
                                BehindHealthbar.Visible = ESP.Drawing.Healthbar.Enabled;
                                BehindHealthbar.Position = UDim2.new(0, Pos.X - w / 2 - 6, 0, Pos.Y - h / 2)  
                                BehindHealthbar.Size = UDim2.new(0, ESP.Drawing.Healthbar.Width, 0, h)
                                do
                                    if ESP.Drawing.Healthbar.HealthText then
                                        local healthPercentage = math.floor(Humanoid.Health / Humanoid.MaxHealth * 100)
                                        HealthText.Position = UDim2.new(0, Pos.X - w / 2 - 6, 0, Pos.Y - h / 2 + h * (1 - healthPercentage / 100) + 3)
                                        HealthText.Text = tostring(healthPercentage)
                                        HealthText.Visible = Humanoid.Health < Humanoid.MaxHealth
                                        if ESP.Drawing.Healthbar.Lerp then
                                            local color = health >= 0.75 and Color3.fromRGB(0, 255, 0) or health >= 0.5 and Color3.fromRGB(255, 255, 0) or health >= 0.25 and Color3.fromRGB(255, 170, 0) or Color3.fromRGB(255, 0, 0)
                                            HealthText.TextColor3 = color
                                        else
                                            HealthText.TextColor3 = ESP.Drawing.Healthbar.HealthTextRGB
                                        end
                                    end                        
                                end
                            end
                            do
                                Name.Visible = ESP.Drawing.Names.Enabled
                                if ESP.Options.Friendcheck and lplayer:IsFriendsWith(plr.UserId) then
                                    Name.Text = string.format('(<font color="rgb(%d, %d, %d)">F</font>) %s', ESP.Options.FriendcheckRGB.R * 255, ESP.Options.FriendcheckRGB.G * 255, ESP.Options.FriendcheckRGB.B * 255, plr.Name)
                                else
                                    Name.Text = string.format('(<font color="rgb(%d, %d, %d)">E</font>) %s', 255, 0, 0, plr.Name)
                                end
                                Name.Position = UDim2.new(0, Pos.X, 0, Pos.Y - h / 2 - 9)
                            end
                            do
                                if ESP.Drawing.Distances.Enabled then
                                    if ESP.Drawing.Distances.Position == "Bottom" then
                                        Weapon.Position = UDim2.new(0, Pos.X, 0, Pos.Y + h / 2 + 18)
                                        WeaponIcon.Position = UDim2.new(0, Pos.X - 21, 0, Pos.Y + h / 2 + 15);
                                        Distance.Position = UDim2.new(0, Pos.X, 0, Pos.Y + h / 2 + 7)
                                        Distance.Text = string.format("%d meters", math.floor(Dist))
                                        Distance.Visible = true
                                    elseif ESP.Drawing.Distances.Position == "Text" then
                                        Weapon.Position = UDim2.new(0, Pos.X, 0, Pos.Y + h / 2 + 8)
                                        WeaponIcon.Position = UDim2.new(0, Pos.X - 21, 0, Pos.Y + h / 2 + 5);
                                        Distance.Visible = false
                                        if ESP.Options.Friendcheck and lplayer:IsFriendsWith(plr.UserId) then
                                            Name.Text = string.format('(<font color="rgb(%d, %d, %d)">F</font>) %s [%d]', ESP.Options.FriendcheckRGB.R * 255, ESP.Options.FriendcheckRGB.G * 255, ESP.Options.FriendcheckRGB.B * 255, plr.Name, math.floor(Dist))
                                        else
                                            Name.Text = string.format('(<font color="rgb(%d, %d, %d)">E</font>) %s [%d]', 255, 0, 0, plr.Name, math.floor(Dist))
                                        end
                                        Name.Visible = ESP.Drawing.Names.Enabled
                                    end
                                end
                            end
                            do
                                Weapon.Text = "none"
                                Weapon.Visible = ESP.Drawing.Weapons.Enabled
                            end                            
                        else
                            HideESP();
                        end
                    else
                        HideESP();
                    end
                else
                    HideESP();
                end
            end)
        end
        coroutine.wrap(Updater)();
    end
    do
        for _, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v.Name ~= lplayer.Name then
                coroutine.wrap(ESP)(v)
            end      
        end
        game:GetService("Players").PlayerAdded:Connect(function(v)
            coroutine.wrap(ESP)(v)
        end);
    end;
end;
    end
})
Tabs.zho:Button({
    Title = "2d名片",
    Callback = function()
      if getgenv().QuantumHUD_Running then
	pcall(function()
		game:GetService("RunService"):UnbindFromRenderStep("Quantum_Stationary_Engine")
		local legacy = game:GetService("Workspace"):FindFirstChild("QUANTUM_STATIONARY_STORAGE")
		if legacy then legacy:Destroy() end
	end)
end
getgenv().QuantumHUD_Running = true
getgenv().LaunchQuantumGraphicsPipeline = function(customConfig)
	customConfig = customConfig or {}
	local QuantumHUD = {}
	QuantumHUD.__index = QuantumHUD
	local Players = game:GetService("Players")
	local Workspace = game:GetService("Workspace")
	local RunService = game:GetService("RunService")
	local Lighting = game:GetService("Lighting") 
	function QuantumHUD.new()
		local self = setmetatable({}, QuantumHUD)
		self.Config = {
			MaxHUDs = customConfig.MaxHUDs or 5,                                       
			MaxDistance = customConfig.MaxDistance or 361,                                 
			StorageName = "QUANTUM_STATIONARY_STORAGE",
			BodyReflectance = customConfig.BodyReflectance or 0.15,   
			HeadReflectance = customConfig.HeadReflectance or 0.01,   
			LightBrightness = customConfig.LightBrightness or 0.45,   
			LightRange = customConfig.LightRange or 11.0,             
			OutlineTransparency = customConfig.OutlineTransparency or 0.05, 
			PinkGlassBg = Color3.fromRGB(255, 230, 238),      
			PinkGlassStroke = Color3.fromRGB(255, 230, 238), 
			MyCardBg = Color3.fromRGB(45, 15, 22),             
			MyCardStroke = Color3.fromRGB(45, 15, 22),       
			HealthBarProgressColor = Color3.fromRGB(255, 120, 160), 
			HealthBarContainerColor = Color3.fromRGB(255, 255, 255), 
			TextHDMain = Color3.fromRGB(255, 255, 255),        
			TextHDSub = Color3.fromRGB(255, 190, 210),         
			ShadowColor = Color3.fromRGB(20, 5, 10),           
			CardSize = Vector3.new(4.6, 1.75, 0.05),            
			ShoulderHeight = 1.6,                             
			EyeSeparation = 4.3,                               
			ViewAngleThreshold = 0.12,
			BaseStiffness = 18.5,     
			FluidDragCoeff = 0.25,    
			ParallaxIntensity = 0.35, 
			MicroVibeFreq = 8.5       
		}
		self.LocalPlayer = Players.LocalPlayer
		self.Slots = {}
		self.IsRunning = false
		self.StorageFolder = nil
		self.MyFluidState = { Position = Vector3.new(), Velocity = Vector3.new(), Rotation = Vector3.new() }
		self.SlotFluidStates = {}
		self.GlobalCurrentAlpha = 1.0                          
		return self
	end
	function QuantumHUD:_updateFluidEngine(state, targetPos, dt)
		local displacement = state.Position - targetPos
		local distance = displacement.Magnitude
		local dynamicDamping = 0.45 + math.clamp(1 / (distance + 0.1), 0, 1.8)
		local springForce = -self.Config.BaseStiffness * displacement
		local baseDampingForce = -dynamicDamping * state.Velocity
		local fluidDragForce = -state.Velocity.Unit * (state.Velocity.Magnitude ^ 2) * self.Config.FluidDragCoeff
		if state.Velocity.Magnitude == 0 then fluidDragForce = Vector3.new() end
		local acceleration = springForce + baseDampingForce + fluidDragForce
		state.Velocity = state.Velocity + acceleration * dt
		state.Position = state.Position + state.Velocity * dt
		return state.Position
	end
	function QuantumHUD:_isTargetVisibleThroughCover(camera, myChar, targetChar, targetRoot)
		if not myChar or not targetChar then return false end
		local raycastParams = RaycastParams.new()
		local ignoreList = {myChar, targetChar}
		if self.StorageFolder then table.insert(ignoreList, self.StorageFolder) end
		raycastParams.FilterDescendantsInstances = ignoreList
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		local camPos = camera.CFrame.Position
		local checkPoints = { targetRoot.Position }
		local head = targetChar:FindFirstChild("Head")
		if head then table.insert(checkPoints, head.Position) end
		local leftLeg = targetChar:FindFirstChild("Left Leg") or targetChar:FindFirstChild("LeftLowerLeg")
		if leftLeg then table.insert(checkPoints, leftLeg.Position) end
		local rightLeg = targetChar:FindFirstChild("Right Leg") or targetChar:FindFirstChild("RightLowerLeg")
		if rightLeg then table.insert(checkPoints, rightLeg.Position) end
		for _, point in ipairs(checkPoints) do
			local direction = point - camPos
			local result = Workspace:Raycast(camPos, direction, raycastParams)
			if not result then return true end
		end
		return false
	end
	function QuantumHUD:PurgeLegacyPipelines()
		pcall(function() RunService:UnbindFromRenderStep("Quantum_Stationary_Engine") end)
		local legacy = Workspace:FindFirstChild(self.Config.StorageName)
		if legacy then pcall(function() legacy:Destroy() end) task.wait(0.02) end
	end
	function QuantumHUD:_buildGlassContainer(name)
		if not self.StorageFolder then
			self.StorageFolder = Workspace:FindFirstChild(self.Config.StorageName) or Instance.new("Folder")
			self.StorageFolder.Name = self.Config.StorageName
			self.StorageFolder.Parent = Workspace
		end
		local masterPart = Instance.new("Part")
		masterPart.Name = "ST_Master_" .. name
		masterPart.Size = self.Config.CardSize
		masterPart.Transparency = 1
		masterPart.CanCollide = false; masterPart.CanTouch = false; masterPart.CanQuery = false
		masterPart.Anchored = true
		masterPart.Parent = self.StorageFolder
		local blurFilter = Instance.new("Part")
		blurFilter.Name = "GlassBlurFilter"
		blurFilter.Size = Vector3.new(self.Config.CardSize.X - 0.02, self.Config.CardSize.Y - 0.02, 0.01)
		blurFilter.Material = Enum.Material.Glass
		blurFilter.Transparency = 1 
		blurFilter.Color = self.Config.PinkGlassBg
		blurFilter.CanCollide = false; blurFilter.CanTouch = false; blurFilter.CanQuery = false
		blurFilter.Anchored = true
		blurFilter.Parent = masterPart
		return masterPart
	end
	function QuantumHUD:_attachUltraHDCanvas(parentPart, isLocal)
		local sGui = Instance.new("SurfaceGui")
		sGui.Name = "CanvasEngine"
		sGui.Face = Enum.NormalId.Front
		sGui.CanvasSize = Vector2.new(1380, 525)           
		sGui.PixelsPerStud = 300                             
		sGui.AlwaysOnTop = true
		sGui.LightInfluence = 0.0                          
		sGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		sGui.Enabled = false 
		sGui.Parent = parentPart
		local canvas = Instance.new("CanvasGroup")
		canvas.Name = "AlphaGroup"
		canvas.Size = UDim2.new(1, 0, 1, 0)
		canvas.BackgroundColor3 = isLocal and self.Config.MyCardBg or self.Config.PinkGlassBg
		canvas.GroupTransparency = 1                       
		canvas.BorderSizePixel = 0
		canvas.Parent = sGui
		Instance.new("UICorner", canvas).CornerRadius = UDim.new(0, 42) 
		local stroke = Instance.new("UIStroke", canvas)
		stroke.Thickness = 6.5                                         
		stroke.Color = isLocal and self.Config.MyCardStroke or self.Config.PinkGlassStroke
		local avatar = Instance.new("ImageLabel")
		avatar.Name = "UserAvatar"
		avatar.Size = UDim2.new(0, 130, 0, 130)
		avatar.Position = UDim2.new(0, 45, 0.5, -65)
		avatar.BackgroundTransparency = 1
		avatar.Parent = canvas
		Instance.new("UICorner", avatar).CornerRadius = UDim.new(1, 0)
		local avStroke = Instance.new("UIStroke", avatar)
		avStroke.Thickness = 4
		avStroke.Color = stroke.Color
		local function CreateHDText(name, size, pos, color, font)
			local label = Instance.new("TextLabel")
			label.Name = name
			label.Size = UDim2.new(0.75, 0, 0.22, 0)
			label.Position = pos
			label.BackgroundTransparency = 1
			label.TextColor3 = color
			label.TextSize = size
			label.Font = font
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.TextStrokeTransparency = 1
			local shadow = Instance.new("UIStroke", label)
			shadow.Color = self.Config.ShadowColor
			shadow.Thickness = 3.5
			shadow.LineJoinMode = Enum.LineJoinMode.Round
			label.Parent = canvas
			return label
		end
		CreateHDText("TitleLabel", 46, UDim2.new(0, 210, 0.16, 0), self.Config.TextHDMain, Enum.Font.GothamBold)
		CreateHDText("SubTagLabel", 32, UDim2.new(0, 210, 0.46, 0), self.Config.TextHDSub, Enum.Font.GothamBold)
		CreateHDText("StatusLabel", 34, UDim2.new(0, 210, 0.72, 0), self.Config.TextHDMain, Enum.Font.Code)
		if isLocal then
			local coordLabel = CreateHDText("CoordLabel", 28, UDim2.new(0, 210, 0.73, 0), self.Config.TextHDSub, Enum.Font.Code)
			coordLabel.Size = UDim2.new(0.75, 0, 0.18, 0)
			canvas.StatusLabel.Position = UDim2.new(0, 210, 0.56, 0)
			canvas.StatusLabel.TextSize = 30
			local hpContainer = Instance.new("Frame")
			hpContainer.Name = "HPContainer"
			hpContainer.Size = UDim2.new(0, 1120, 0, 14)
			hpContainer.Position = UDim2.new(0, 210, 0.43, 0)
			hpContainer.BackgroundColor3 = self.Config.HealthBarContainerColor
			hpContainer.BorderSizePixel = 0
			hpContainer.Parent = canvas
			Instance.new("UICorner", hpContainer).CornerRadius = UDim.new(0, 7)
			local hpProgress = Instance.new("Frame")
			hpProgress.Name = "HPProgress"
			hpProgress.Size = UDim2.new(1, 0, 1, 0) 
			hpProgress.BackgroundColor3 = self.Config.HealthBarProgressColor
			hpProgress.BorderSizePixel = 0
			hpProgress.Parent = hpContainer
			Instance.new("UICorner", hpProgress).CornerRadius = UDim.new(0, 7)
		end
		return canvas
	end
	function QuantumHUD:_calculateCinematicTransform(targetRoot, camera, state, gameTime, deltaTime)
		local camCF = camera.CFrame
		local baseShoulderPos = targetRoot.Position + Vector3.new(0, self.Config.ShoulderHeight, 0)
		local targetWorldPos = baseShoulderPos + (camCF.RightVector * self.Config.EyeSeparation)
		local slowLayer = math.sin(gameTime * 0.95) * math.cos(gameTime * 0.3) * 0.09
		local fastLayer = math.sin(gameTime * self.Config.MicroVibeFreq) * 0.006 
		local finalBobY = slowLayer + fastLayer
		local finalBobX = math.cos(gameTime * 1.1) * math.sin(gameTime * 0.4) * 0.06
		targetWorldPos = targetWorldPos + Vector3.new(finalBobX, finalBobY, finalBobX * 0.3)
		local dt = math.min(deltaTime, 0.03)
		local currentPhysicsPos = self:_updateFluidEngine(state, targetWorldPos, dt)
		local lookAtCF = CFrame.lookAt(currentPhysicsPos, camCF.Position, Vector3.new(0, 1, 0))
		local localTargetVec = camCF:ToObjectSpace(lookAtCF).Position.Unit
		local targetTiltX = -localTargetVec.Y * self.Config.ParallaxIntensity
		local targetTiltY = localTargetVec.X * self.Config.ParallaxIntensity
		state.Rotation = state.Rotation + (Vector3.new(targetTiltX, targetTiltY, 0) - state.Rotation) * 0.15
		return lookAtCF * CFrame.Angles(state.Rotation.X, state.Rotation.Y, math.sin(gameTime * 0.5) * 0.005)
	end
	function QuantumHUD:_evaluateGlobalState(myRoot, myHum, camera)
		if myHum.MoveDirection.Magnitude > 0.01 then return 1.0 end
		local cameraToMeDirection = (camera.CFrame.Position - myRoot.Position).Unit
		local lookDirectionDot = myRoot.CFrame.LookVector:Dot(cameraToMeDirection)
		if lookDirectionDot > self.Config.ViewAngleThreshold then return 0.0 else return 1.0 end
	end
	function QuantumHUD:_launchPipelineLoop()
		RunService:BindToRenderStep("Quantum_Stationary_Engine", Enum.RenderPriority.Camera.Value + 1, function(dt)
			if not self.IsRunning then return end
			local camera = Workspace.CurrentCamera
			local myChar = self.LocalPlayer.Character
			local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
			local myHum = myChar and myChar:FindFirstChild("Humanoid")
			local currentTime = os.clock()
			if not (camera and myRoot and myHum) then return end
			local targetGlobalAlpha = self:_evaluateGlobalState(myRoot, myHum, camera)
			local wasHidden = (self.GlobalCurrentAlpha > 0.95)
			local alphaSpeed = targetGlobalAlpha == 0 and 0.09 or 0.25
			self.GlobalCurrentAlpha = self.GlobalCurrentAlpha + (targetGlobalAlpha - self.GlobalCurrentAlpha) * alphaSpeed
			local isGlobalVisible = self.GlobalCurrentAlpha < 0.95
			local computedBlurTransparency = 0.45 + (self.GlobalCurrentAlpha * 0.55)
			if self.My3DInstance then
				if isGlobalVisible then
					self.My3DInstance.CanvasEngine.Enabled = true
					local alphaGroup = self.My3DInstance.CanvasEngine.AlphaGroup
					alphaGroup.GroupTransparency = self.GlobalCurrentAlpha
					self.My3DInstance.GlassBlurFilter.Transparency = computedBlurTransparency
					local hpRatio = math.clamp(myHum.Health / myHum.MaxHealth, 0, 1)
					alphaGroup.StatusLabel.Text = "💖 状态: " .. tostring(math.floor(hpRatio * 100)) .. "%"
					alphaGroup.HPContainer.HPProgress.Size = UDim2.new(hpRatio, 0, 1, 0)
					local pos = myRoot.Position
					alphaGroup.CoordLabel.Text = string.format("坐标: X:%.1f / Y:%.1f / Z:%.1f", pos.X, pos.Y, pos.Z)
					if wasHidden then 
						local basePos = myRoot.Position + (camera.CFrame.RightVector * self.Config.EyeSeparation)
						self.MyFluidState.Position = basePos
						self.MyFluidState.Velocity = Vector3.new()
						self.MyFluidState.Rotation = Vector3.new()
					end
					local finalCF = self:_calculateCinematicTransform(myRoot, camera, self.MyFluidState, currentTime, dt)
					self.My3DInstance.CFrame = finalCF
					self.My3DInstance.GlassBlurFilter.CFrame = finalCF * CFrame.new(0, 0, -0.01)
				else
					self.My3DInstance.CanvasEngine.Enabled = false
					self.My3DInstance.GlassBlurFilter.Transparency = 1
				end
			end
			local targetPool = {}
			for _, player in pairs(Players:GetPlayers()) do
				if player ~= self.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
					local tChar = player.Character; local tRoot = tChar.HumanoidRootPart; local tHum = tChar.Humanoid
					if tHum.Health > 0 then
						local _, inViewport = camera:WorldToScreenPoint(tRoot.Position)
						local distance = (myRoot.Position - tRoot.Position).Magnitude
						if inViewport and distance <= self.Config.MaxDistance then
							local isVisible = self:_isTargetVisibleThroughCover(camera, myChar, tChar, tRoot)
							if isVisible then
								table.insert(targetPool, {player = player, root = tRoot, hum = tHum, dist = distance, char = tChar})
							end
						end
					end
				end
			end
			table.sort(targetPool, function(a, b) return a.dist < b.dist end)
			for i = 1, self.Config.MaxHUDs do
				local slot = self.Slots[i]
				local data = targetPool[i]
				if data and isGlobalVisible then
					slot.Part.CanvasEngine.Enabled = true
					local alphaGroup = slot.Part.CanvasEngine.AlphaGroup
					alphaGroup.GroupTransparency = self.GlobalCurrentAlpha
					slot.Part.GlassBlurFilter.Transparency = computedBlurTransparency
					if wasHidden or not self.SlotFluidStates[i] or slot.LastTarget ~= data.player then
						local basePos = data.root.Position + (camera.CFrame.RightVector * self.Config.EyeSeparation)
						self.SlotFluidStates[i] = { Position = basePos, Velocity = Vector3.new(), Rotation = Vector3.new() }
					end
					local finalCF = self:_calculateCinematicTransform(data.root, camera, self.SlotFluidStates[i], currentTime, dt)
					slot.Part.CFrame = finalCF
					slot.Part.GlassBlurFilter.CFrame = finalCF * CFrame.new(0, 0, -0.01)
					if slot.LastTarget ~= data.player then
						slot.LastTarget = data.player
						alphaGroup.TitleLabel.Text = data.player.DisplayName
						local avatarUrl = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(data.player.UserId) .. "&w=150&h=150"
						if alphaGroup.UserAvatar.Image ~= avatarUrl then
							alphaGroup.UserAvatar.Image = avatarUrl
						end
						local tool = data.char:FindFirstChildOfClass("Tool")
						alphaGroup.SubTagLabel.Text = tool and ("🌸 " .. tool.Name) or "[ UNARMED ]"
					end
					alphaGroup.StatusLabel.Text = "💢 HP: " .. tostring(math.floor(data.hum.Health)) .. " / " .. tostring(data.hum.MaxHealth)
				else
					if slot.Part then
						slot.Part.CanvasEngine.Enabled = false
						slot.Part.GlassBlurFilter.Transparency = 1
					end
					if not data then
						slot.LastTarget = nil
						self.SlotFluidStates[i] = nil
					end
				end
			end
		end)
	end
	function QuantumHUD:_applyVisualEnhancements(character)
		if not character then return end
		for _, item in ipairs(character:GetDescendants()) do
			if item.Name == "Quantum_Self_Highlight" or item.Name == "Quantum_Self_PointLight" then
				item:Destroy()
			end
		end
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("MeshPart") or part:IsA("BasePart") then
				if part:IsA("MeshPart") then
					part.RenderFidelity = Enum.RenderFidelity.Precise
				end
				part.CastShadow = true
				pcall(function()
					if part.Material == Enum.Material.Plastic then
						part.Material = Enum.Material.SmoothPlastic
					end
					if part.Name == "Head" or part.Name == "Face" or part.Name:find("Face") then
						part.Reflectance = self.Config.HeadReflectance
					else
						part.Reflectance = self.Config.BodyReflectance
					end
				end)
			end
		end
		local lowerTorso = character:FindFirstChild("LowerTorso") or character:FindFirstChild("Torso")
		if lowerTorso then
			local light = Instance.new("PointLight")
			light.Name = "Quantum_Self_PointLight"
			light.Color = Color3.fromRGB(255, 245, 250) 
			light.Brightness = self.Config.LightBrightness                      
			light.Range = self.Config.LightRange                           
			light.Shadows = true                        
			light.Parent = lowerTorso
		end
		local highlight = Instance.new("Highlight")
		highlight.Name = "Quantum_Self_Highlight"
		highlight.FillColor = Color3.fromRGB(255, 255, 255)
		highlight.FillTransparency = 1.0            
		highlight.OutlineColor = Color3.fromRGB(255, 255, 255) 
		highlight.OutlineTransparency = self.Config.OutlineTransparency         
		highlight.Adornee = character
		highlight.Parent = character
	end
	function QuantumHUD:_maximizeMobileGraphicsPipeline()
		pcall(function()
			settings().Rendering.QualityLevel = Enum.QualityLevel.Level21
			Lighting.Technology = Enum.Technology.Future
			Lighting.ShadowMapEnabled = true
			Lighting.GlobalShadows = true
			Lighting.EnvironmentDiffuseScale = 1.0  
			Lighting.EnvironmentSpecularScale = 1.0 
			Lighting.Ambient = Color3.fromRGB(35, 32, 38)
			Lighting.OutdoorAmbient = Color3.fromRGB(45, 42, 50)
		end)
		for _, fx in ipairs(Lighting:GetChildren()) do
			if fx.Name:find("QuantumFX_") then fx:Destroy() end
		end
		local colorCorrection = Instance.new("ColorCorrectionEffect")
		colorCorrection.Name = "QuantumFX_ColorMax"
		colorCorrection.Brightness = 0.02
		colorCorrection.Contrast = 0.20       
		colorCorrection.Saturation = 0.16     
		colorCorrection.TintColor = Color3.fromRGB(255, 252, 248) 
		colorCorrection.Parent = Lighting
		local bloom = Instance.new("BloomEffect")
		bloom.Name = "QuantumFX_BloomMax"
		bloom.Intensity = 0.95                
		bloom.Size = 32                       
		bloom.Threshold = 0.80                
		bloom.Parent = Lighting
		local sunRays = Instance.new("SunRaysEffect")
		sunRays.Name = "QuantumFX_SunRaysMax"
		sunRays.Intensity = 0.40
		sunRays.Spread = 0.92
		sunRays.Parent = Lighting
		local blur = Instance.new("BlurEffect")
		blur.Name = "QuantumFX_MotionBlurMax"
		blur.Size = 2.6
		blur.Parent = Lighting
		task.spawn(function()
			for _, desc in ipairs(Workspace:GetDescendants()) do
				if desc:IsA("BasePart") and not desc:IsDescendantOf(Players.LocalPlayer.Character) then
					pcall(function()
						if desc.Material == Enum.Material.Plastic then
							desc.Material = Enum.Material.SmoothPlastic
						end
						if desc.Reflectance < 0.05 then
							desc.Reflectance = 0.06
						end
					end)
				end
			end
		end)
	end
	function QuantumHUD:Start()
		self:PurgeLegacyPipelines()
		self.IsRunning = true
		self:_maximizeMobileGraphicsPipeline()
		self.My3DInstance = self:_buildGlassContainer("LocalPlayer")
		local myCanvas = self:_attachUltraHDCanvas(self.My3DInstance, true)
		myCanvas.TitleLabel.Text = "👑 " .. self.LocalPlayer.DisplayName
		myCanvas.SubTagLabel.Text = "🌸如果没人爱着你，还有开发者爱着你(=^▽^=)"
		myCanvas.UserAvatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(self.LocalPlayer.UserId) .. "&w=150&h=150"
		if self.LocalPlayer.Character then
			self:_applyVisualEnhancements(self.LocalPlayer.Character)
		end
		self.LocalPlayer.CharacterAdded:Connect(function(newCharacter)
			self:_applyVisualEnhancements(newCharacter)
		end)
		for i = 1, self.Config.MaxHUDs do
			local part = self:_buildGlassContainer("Slot_" .. i)
			local canvas = self:_attachUltraHDCanvas(part, false)
			self.Slots[i] = {Part = part, Canvas = canvas, LastTarget = nil}
		end
		self:_launchPipelineLoop()
	end
	local RunInstance = QuantumHUD.new()
	RunInstance:Start()
end
LaunchQuantumGraphicsPipeline({
	MaxHUDs = 5,              
	MaxDistance = 360,         
	BodyReflectance = 0.15,    
	HeadReflectance = 0.01,    
	LightBrightness = 0.45,    
	LightRange = 11.0,         
	OutlineTransparency = 0.05 
})  
    end
})
Tabs.zho:Button({
    Title = "强制锁人",
    Callback = function()
        local Players       = game:GetService("Players")
local RunService    = game:GetService("RunService")
local Workspace     = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local StarterGui    = game:GetService("StarterGui")
local TweenService  = game:GetService("TweenService")
local Camera        = Workspace.CurrentCamera
local LocalPlayer   = Players.LocalPlayer
local Enabled       = false
local LockedTarget  = nil
local SMOOTHNESS    = 0.75
local MAX_DISTANCE  = 1000
local SEARCH_DISTANCE = 55
local CAMERA_LEFT_OFFSET = -1.27
local lastSearchTime = 0
local SEARCH_RATE    = 0.25
local screenGui = Instance.new("ScreenGui")
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
local function getTargetPart(character)
    return character and character:FindFirstChild("Head")
end
local function getNeckPosition(head)
    if not head then return nil end
    local char = head.Parent
    if not char then return nil end
    local neckAtt = head:FindFirstChild("NeckAttachment")
    if not neckAtt then
        local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
        if torso then
            neckAtt = torso:FindFirstChild("NeckAttachment")
        end
    end
    if neckAtt and neckAtt:IsA("Attachment") then
        return neckAtt.WorldPosition
    end
    return (head.CFrame * CFrame.new(0, -0.5, 0)).Position
end
local function findClosestTarget()
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local closest, minDist = nil, math.huge
    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    local overlapParams = OverlapParams.new()
    overlapParams.FilterDescendantsInstances = {LocalPlayer.Character}
    overlapParams.FilterType = Enum.RaycastFilterType.Exclude
    local nearbyParts = Workspace:GetPartBoundsInRadius(myRoot.Position, SEARCH_DISTANCE, overlapParams)
    local checkedModels = {}
    for _, part in ipairs(nearbyParts) do
        local char = part:FindFirstAncestorWhichIsA("Model")
        if char and not checkedModels[char] and char ~= LocalPlayer.Character then
            checkedModels[char] = true
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local targetPart = getTargetPart(char)
                if targetPart then
                    local neckPos = getNeckPosition(targetPart)
                    if neckPos then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(neckPos)
                        if onScreen then
                            local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                            if dist < minDist then
                                minDist = dist
                                closest = targetPart
                            end
                        end
                    end
                end
            end
        end
    end
    return closest
end
local function isValidTarget(targetPart)
    if not targetPart then return false end
    local char = targetPart.Parent
    if not char or not char:IsA("Model") then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    if char == LocalPlayer.Character then return false end
    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if myRoot then
        local neckPos = getNeckPosition(targetPart)
        if neckPos and (neckPos - myRoot.Position).Magnitude > MAX_DISTANCE then
            return false
        end
    end
    return true
end
local function forceInstantReset()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        Camera.CameraType = Enum.CameraType.Fixed
        Camera.CameraSubject = char.Humanoid
        Camera.CameraType = Enum.CameraType.Custom
    end
end
local toggleBtn
local billboard
local function createUI()
    toggleBtn = Instance.new("ImageButton")
    toggleBtn.Size = UDim2.new(0, 85, 0, 85)
    toggleBtn.Position = UDim2.new(1, -95, 0, 10)
    toggleBtn.BackgroundTransparency = 1
    toggleBtn.Image = "rbxassetid://110432273832755"
    toggleBtn.ScaleType = Enum.ScaleType.Fit
    toggleBtn.Parent = screenGui
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = toggleBtn
    billboard = Instance.new("BillboardGui")
    billboard.Name = "锁定指示器"
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true
    billboard.LightInfluence = 0
    billboard.Enabled = false
    billboard.Size = UDim2.new(0, 60, 0, 60)
    billboard.Parent = screenGui
    local indImage = Instance.new("ImageLabel")
    indImage.Size = UDim2.new(1, 0, 1, 0)
    indImage.BackgroundTransparency = 1
    indImage.Image = "rbxassetid://100230908593841"
    indImage.ImageColor3 = Color3.fromRGB(0, 255, 255)
    indImage.Parent = billboard
    local indCorner = Instance.new("UICorner")
    indCorner.CornerRadius = UDim.new(1, 0)
    indCorner.Parent = indImage
    local dragging, dragStart, startPos
    toggleBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = toggleBtn.Position
        end
    end)
    toggleBtn.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
            local delta = input.Position - dragStart
            toggleBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    toggleBtn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    local function toggleEnabled()
        Enabled = not Enabled
        if Enabled then
            LockedTarget = findClosestTarget()
            StarterGui:SetCore("SendNotification", {
                Title = "锁定系统",
                Text = "已开启锁定",
                Icon = "rbxassetid://82817965256191",
                Duration = 2
            })
        else
            LockedTarget = nil
            forceInstantReset()
            if billboard then
                billboard.Enabled = false
            end
            StarterGui:SetCore("SendNotification", {
                Title = "锁定系统",
                Text = "已关闭锁定",
                Icon = "rbxassetid://82817965256191",
                Duration = 2
            })
        end
        toggleBtn.ImageTransparency = Enabled and 0 or 0.5
    end
    toggleBtn.MouseButton1Click:Connect(toggleEnabled)
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.L then
            toggleEnabled()
        end
    end)
end
createUI()
local function onCharacterAdded(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.Died:Connect(function()
            Enabled = false
            LockedTarget = nil
            forceInstantReset()
            if billboard then billboard.Enabled = false end
            toggleBtn.ImageTransparency = 0.5
        end)
    end
end
if LocalPlayer.Character then onCharacterAdded(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
RunService.RenderStepped:Connect(function()
    if not Enabled then
        if billboard then billboard.Enabled = false end
        return
    end
    local now = tick()
    if now - lastSearchTime > SEARCH_RATE then
        if not isValidTarget(LockedTarget) then
            LockedTarget = findClosestTarget()
        end
        lastSearchTime = now
    end
    if LockedTarget and LockedTarget.Parent then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            Camera.CameraType = Enum.CameraType.Fixed
            Camera.CameraSubject = char.Humanoid
            Camera.CameraType = Enum.CameraType.Custom
        end
        local targetPos = getNeckPosition(LockedTarget)
        if targetPos then
            local rightVec = Camera.CFrame.RightVector
            local finalPos = targetPos - (rightVec * CAMERA_LEFT_OFFSET)
            local targetCFrame = CFrame.new(Camera.CFrame.Position, finalPos)
            Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, SMOOTHNESS)
        end
        local charTarget = LockedTarget.Parent
        local adorneePart = charTarget:FindFirstChild("UpperTorso") or charTarget:FindFirstChild("Torso") or charTarget:FindFirstChild("HumanoidRootPart")
        if adorneePart then
            billboard.Adornee = adorneePart
            billboard.Enabled = true
            local distance = (Camera.CFrame.Position - adorneePart.Position).Magnitude
            local scale = math.clamp(1400 / (distance + 8), 1.5, 8)
            billboard.Size = UDim2.new(0, scale * 10, 0, scale * 10)
        else
            billboard.Enabled = false
        end
    else
        if billboard then billboard.Enabled = false end
    end
end)
    end
})
Tabs.fe:Paragraph({
    Title = "🔞动作fe🔞:",
    Desc = "备注",
    Image = "https://play-lh.googleusercontent.com/7cIIPlWm4m7AGqVpEsIfyL-HW4cQla4ucXnfalMft1TMIYQIlf2vqgmthlZgbNAQoaQ",
    ImageSize = 20,
    ThumbnailSize = 120
})
Tabs.fe:Button({
  Title = "feSussHub",
  Callback = function()
    loadstring(game:HttpGet(('https://gist.githubusercontent.com/Nilrogram/8b0c8bd710be142f383c71f79279752c/raw/e4fb01a7de7cd498bb53270d2ad191dfab268a88/FE%2520SussyHub'),true))();
  end
})
Tabs.fe:Button({
    Title = "FE无需本体死亡甩飞",
    Callback = function()
        loadstring(game:HttpGet('https://gist.githubusercontent.com/axelinharlem182/1ee425c9d850af697f8c3cb108a9d816/raw/c4660b01faf4db266e8031e310121a65836f98a7/The%20Villain',true))()
    end
})
Tabs.fe:Button({
    Title = "格斗",
    Callback = function()
        loadstring(game:HttpGet("https://github.com/Sinister-Scripts/Roblox-Exploits/raw/refs/heads/main/FE-Fighter-Cracked"))()
    end
})
Tabs.fe:Button({
    Title = "r6动作",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-R6-Animations-Menu-By-Me-19427"))()
    end
})
Tabs.fe:Button({
    Title = "猫动作脚本",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/Y1MkBRn3"))()
    end
})
Tabs.fe:Button({
    Title = "撸关r6",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
    end
})
Tabs.fe:Button({
    Title = "撸关r15",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
    end
})
Tabs.fe:Button({
    Title = "R15无头",
    Callback = function()
        loadstring(game:HttpGet(("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/假无头.lua"),true))()
    end
})
Tabs.fe:Button({
    Title = "R6无头",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Gazer-Ha/Valiant-Ui-Lib-Gazed-/refs/heads/main/Head%20Pack'))()
    end
})
Tabs.fe:Button({
    Title = "FE蛇",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/qwertys/refs/heads/main/qwerty5.lua"))()
    end
})
Tabs.fe:Button({
    Title = "FE隐形",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/vP6CrQJj"))()
    end
})
Tabs.fe:Button({
    Title = "FE超光速和超级跳跃",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fake-lag-41217"))()
    end
})
Tabs.fe:Button({
    Title = "祖国人",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/giobolqv1/homelander-by-GioBolqv1-/refs/heads/main/homelander.lua"))()
    end
})
Tabs.fe:Button({
    Title = "FE爬行",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_vZDX8j5ggfAf58QhdJ59BVEmF6nmZgq4Mcjt2l8wn16CiStIW2P6EkNc605qv9K4.lua.txt'))()
    end
})
Tabs.fe:Button({
    Title = "将军飞踢",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fe-DropKick-Script-165813"))()
    end
})
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
ESP_Config = {
    EnableESP = false,
    ShowBox = true,
    ShowHealth = true,
    ShowName = true,
    ShowDistance = true,
    ShowTracer = false,
    ShowSkeleton = false,
    ShowWeapon = false,
    WallHack = false,
    TeamCheck = false,
    MaxDrawDistance = 350,
    BoxThickness = 1,
    TracerThickness = 1,
    SkeletonThickness = 2,
    EnemyColor = Color3.new(1, 0.3, 0.3),
    TeammateColor = Color3.new(0.3, 1, 0.3),
    NPCColor = Color3.new(1, 1, 0.2),
    BoxColor = Color3.new(1, 1, 1),
    TracerColor = Color3.new(1, 0, 0),
    SkeletonColor = Color3.new(0.2, 0.8, 1),
    HealthBarColor = Color3.new(0, 1, 0),
}
local ESPComponents = {}
local function createESP(player)
    local box = Drawing.new("Square")
    box.Visible = false
    box.Color = ESP_Config.BoxColor
    box.Thickness = ESP_Config.BoxThickness
    box.Filled = false
    local healthBar = Drawing.new("Square")
    healthBar.Visible = false
    healthBar.Color = ESP_Config.HealthBarColor
    healthBar.Thickness = 1
    healthBar.Filled = true
    local healthBarBackground = Drawing.new("Square")
    healthBarBackground.Visible = false
    healthBarBackground.Color = Color3.new(0, 0, 0)
    healthBarBackground.Transparency = 0.5
    healthBarBackground.Thickness = 1
    healthBarBackground.Filled = true
    local healthBarBorder = Drawing.new("Square")
    healthBarBorder.Visible = false
    healthBarBorder.Color = Color3.new(1, 1, 1)
    healthBarBorder.Thickness = 1
    healthBarBorder.Filled = false
    local healthText = Drawing.new("Text")
    healthText.Visible = false
    healthText.Color = Color3.new(1, 1, 1)
    healthText.Size = 14
    healthText.Font = Drawing.Fonts.Monospace
    healthText.Outline = true
    healthText.OutlineColor = Color3.new(0, 0, 0)
    local nameText = Drawing.new("Text")
    nameText.Visible = false
    nameText.Color = Color3.new(1, 1, 1)
    nameText.Size = 16
    nameText.Font = Drawing.Fonts.Monospace
    nameText.Outline = true
    nameText.OutlineColor = Color3.new(0, 0, 0)
    local distanceText = Drawing.new("Text")
    distanceText.Visible = false
    distanceText.Color = Color3.new(1, 1, 0)
    distanceText.Size = 14
    distanceText.Font = Drawing.Fonts.Monospace
    distanceText.Outline = true
    distanceText.OutlineColor = Color3.new(0, 0, 0)
    local weaponText = Drawing.new("Text")
    weaponText.Visible = false
    weaponText.Color = Color3.new(1, 0.5, 0)
    weaponText.Size = 14
    weaponText.Font = Drawing.Fonts.Monospace
    weaponText.Outline = true
    weaponText.OutlineColor = Color3.new(0, 0, 0)
    local tracer = Drawing.new("Line")
    tracer.Visible = false
    tracer.Color = ESP_Config.TracerColor
    tracer.Thickness = ESP_Config.TracerThickness
    local skeletonLines = {}
    local skeletonPoints = {}
    for i = 1, 15 do
        skeletonLines[i] = Drawing.new("Line")
        skeletonLines[i].Visible = false
        skeletonLines[i].Color = ESP_Config.SkeletonColor
        skeletonLines[i].Thickness = ESP_Config.SkeletonThickness
    end
    skeletonPoints["Head"] = Drawing.new("Circle")
    skeletonPoints["Head"].Visible = false
    skeletonPoints["Head"].Color = Color3.new(1, 0.5, 0)
    skeletonPoints["Head"].Thickness = 2
    skeletonPoints["Head"].Filled = true
    skeletonPoints["Head"].Radius = 4
    local lastHealth = 100
    local healthChangeTime = 0
    local smoothHealth = 100
    ESPComponents[player] = {
        box = box,
        healthBar = healthBar,
        healthBarBackground = healthBarBackground,
        healthBarBorder = healthBarBorder,
        healthText = healthText,
        nameText = nameText,
        distanceText = distanceText,
        weaponText = weaponText,
        tracer = tracer,
        skeletonLines = skeletonLines,
        skeletonPoints = skeletonPoints
    }
    local function hideAll()
        box.Visible = false
        healthBar.Visible = false
        healthBarBackground.Visible = false
        healthBarBorder.Visible = false
        healthText.Visible = false
        nameText.Visible = false
        distanceText.Visible = false
        weaponText.Visible = false
        tracer.Visible = false
        for _, line in pairs(skeletonLines) do
            line.Visible = false
        end
        for _, point in pairs(skeletonPoints) do
            point.Visible = false
        end
    end
    RunService.RenderStepped:Connect(function()
        if not ESP_Config.EnableESP then
            hideAll()
            return
        end
        if not player.Character
            or not player.Character:FindFirstChild("HumanoidRootPart")
            or not player.Character:FindFirstChild("Humanoid")
            or player == LocalPlayer then
            hideAll()
            return
        end
        if ESP_Config.TeamCheck and player.Team and player.Team == LocalPlayer.Team then
            hideAll()
            return
        end
        local character = player.Character
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChild("Humanoid")
        if not rootPart or not humanoid or humanoid.Health <= 0 then
            hideAll()
            return
        end
        local dist = (rootPart.Position - Camera.CFrame.Position).Magnitude
        if dist > ESP_Config.MaxDrawDistance then
            hideAll()
            return
        end
        local rootPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
        local headPos, _ = Camera:WorldToViewportPoint(rootPart.Position + Vector3.new(0, 3, 0))
        local legPos, _ = Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0))
        local color = ESP_Config.EnemyColor
        if ESP_Config.TeamCheck and player.Team and player.Team == LocalPlayer.Team then
            color = ESP_Config.TeammateColor
        end
        local weaponName = "无武器"
        for _, tool in ipairs(character:GetChildren()) do
            if tool:IsA("Tool") then
                weaponName = tool.Name
                break
            end
        end
        if ESP_Config.ShowBox and onScreen then
            box.Size = Vector2.new(1000 / rootPos.Z, headPos.Y - legPos.Y)
            box.Position = Vector2.new(rootPos.X - box.Size.X / 2, rootPos.Y - box.Size.Y / 2)
            box.Visible = true
            box.Color = ESP_Config.BoxColor
            box.Thickness = ESP_Config.BoxThickness
        else
            box.Visible = false
        end
        if ESP_Config.ShowHealth and onScreen then
            local healthPercentage = humanoid.Health / humanoid.MaxHealth
            local barWidth = 50
            local barHeight = 5
            local barX = headPos.X - barWidth / 2
            local barY = headPos.Y - 20
            healthBarBackground.Size = Vector2.new(barWidth, barHeight)
            healthBarBackground.Position = Vector2.new(barX, barY)
            healthBarBackground.Visible = true
            healthBarBorder.Size = Vector2.new(barWidth, barHeight)
            healthBarBorder.Position = Vector2.new(barX, barY)
            healthBarBorder.Visible = true
            smoothHealth = smoothHealth + (humanoid.Health - smoothHealth) * 0.1
            local smoothHP = smoothHealth / humanoid.MaxHealth
            healthBar.Size = Vector2.new(barWidth * smoothHP, barHeight)
            healthBar.Position = Vector2.new(barX, barY)
            if smoothHP >= 0.8 then
                healthBar.Color = Color3.new(0, 1, 0)
            elseif smoothHP >= 0.5 then
                healthBar.Color = Color3.new(1, 1, 0)
            elseif smoothHP >= 0.2 then
                healthBar.Color = Color3.new(1, 0.5, 0)
            else
                healthBar.Color = Color3.new(1, 0, 0)
            end
            if humanoid.Health ~= lastHealth then
                healthChangeTime = tick()
                lastHealth = humanoid.Health
            end
            if tick() - healthChangeTime < 0.5 then
                healthBar.Color = Color3.new(1, 0, 0)
            end
            healthBar.Visible = true
            healthText.Position = Vector2.new(barX + barWidth + 5, barY - 5)
            healthText.Text = math.floor(humanoid.Health) .. "/" .. math.floor(humanoid.MaxHealth)
            healthText.Color = color
            healthText.Visible = true
        else
            healthBar.Visible = false
            healthBarBackground.Visible = false
            healthBarBorder.Visible = false
            healthText.Visible = false
        end
        if ESP_Config.ShowName and onScreen then
            nameText.Position = Vector2.new(headPos.X, headPos.Y - 35)
            nameText.Text = player.Name
            nameText.Color = color
            nameText.Visible = true
            if ESP_Config.ShowDistance then
                distanceText.Position = Vector2.new(headPos.X, headPos.Y + 10)
                distanceText.Text = math.floor(dist) .. "m"
                distanceText.Visible = true
            else
                distanceText.Visible = false
            end
            if ESP_Config.ShowWeapon then
                weaponText.Position = Vector2.new(headPos.X, headPos.Y - 50)
                weaponText.Text = weaponName
                weaponText.Visible = true
            else
                weaponText.Visible = false
            end
        else
            nameText.Visible = false
            distanceText.Visible = false
            weaponText.Visible = false
        end
        if ESP_Config.ShowTracer then
            local head = character:FindFirstChild("Head")
            if head then
                local hPos, hOnScreen = Camera:WorldToViewportPoint(head.Position)
                if hOnScreen then
                    tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    tracer.To = Vector2.new(hPos.X, hPos.Y)
                    tracer.Visible = true
                    tracer.Color = ESP_Config.TracerColor
                    tracer.Thickness = ESP_Config.TracerThickness
                    if dist < 20 then
                        tracer.Color = Color3.new(0, 1, 0)
                    elseif dist < 50 then
                        tracer.Color = Color3.new(1, 1, 0)
                    else
                        tracer.Color = ESP_Config.TracerColor
                    end
                else
                    tracer.Visible = false
                end
            else
                tracer.Visible = false
            end
        else
            tracer.Visible = false
        end
        if ESP_Config.ShowSkeleton and onScreen then
            local head = character:FindFirstChild("Head")
            local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
            local leftArm = character:FindFirstChild("Left Arm") or character:FindFirstChild("LeftUpperArm")
            local rightArm = character:FindFirstChild("Right Arm") or character:FindFirstChild("RightUpperArm")
            local leftLeg = character:FindFirstChild("Left Leg") or character:FindFirstChild("LeftUpperLeg")
            local rightLeg = character:FindFirstChild("Right Leg") or character:FindFirstChild("RightUpperLeg")
            if head and torso and leftArm and rightArm and leftLeg and rightLeg then
                local hP = Camera:WorldToViewportPoint(head.Position)
                local tP = Camera:WorldToViewportPoint(torso.Position)
                local laP = Camera:WorldToViewportPoint(leftArm.Position)
                local raP = Camera:WorldToViewportPoint(rightArm.Position)
                local llP = Camera:WorldToViewportPoint(leftLeg.Position)
                local rlP = Camera:WorldToViewportPoint(rightLeg.Position)
                skeletonPoints["Head"].Position = Vector2.new(hP.X, hP.Y)
                skeletonPoints["Head"].Visible = true
                skeletonLines[1].From = Vector2.new(hP.X, hP.Y)
                skeletonLines[1].To = Vector2.new(tP.X, tP.Y)
                skeletonLines[1].Visible = true
                skeletonLines[2].From = Vector2.new(tP.X, tP.Y)
                skeletonLines[2].To = Vector2.new(laP.X, laP.Y)
                skeletonLines[2].Visible = true
                skeletonLines[3].From = Vector2.new(tP.X, tP.Y)
                skeletonLines[3].To = Vector2.new(raP.X, raP.Y)
                skeletonLines[3].Visible = true
                skeletonLines[4].From = Vector2.new(tP.X, tP.Y)
                skeletonLines[4].To = Vector2.new(llP.X, llP.Y)
                skeletonLines[4].Visible = true
                skeletonLines[5].From = Vector2.new(tP.X, tP.Y)
                skeletonLines[5].To = Vector2.new(rlP.X, rlP.Y)
                skeletonLines[5].Visible = true
                if character:FindFirstChild("LeftLowerArm") then
                    local pos = Camera:WorldToViewportPoint(character.LeftLowerArm.Position)
                    skeletonLines[6].From = Vector2.new(laP.X, laP.Y)
                    skeletonLines[6].To = Vector2.new(pos.X, pos.Y)
                    skeletonLines[6].Visible = true
                end
                if character:FindFirstChild("RightLowerArm") then
                    local pos = Camera:WorldToViewportPoint(character.RightLowerArm.Position)
                    skeletonLines[7].From = Vector2.new(raP.X, raP.Y)
                    skeletonLines[7].To = Vector2.new(pos.X, pos.Y)
                    skeletonLines[7].Visible = true
                end
                if character:FindFirstChild("LeftLowerLeg") then
                    local pos = Camera:WorldToViewportPoint(character.LeftLowerLeg.Position)
                    skeletonLines[8].From = Vector2.new(llP.X, llP.Y)
                    skeletonLines[8].To = Vector2.new(pos.X, pos.Y)
                    skeletonLines[8].Visible = true
                end
                if character:FindFirstChild("RightLowerLeg") then
                    local pos = Camera:WorldToViewportPoint(character.RightLowerLeg.Position)
                    skeletonLines[9].From = Vector2.new(rlP.X, rlP.Y)
                    skeletonLines[9].To = Vector2.new(pos.X, pos.Y)
                    skeletonLines[9].Visible = true
                end
            else
                for _, line in pairs(skeletonLines) do line.Visible = false end
                for _, point in pairs(skeletonPoints) do point.Visible = false end
            end
        else
            for _, line in pairs(skeletonLines) do line.Visible = false end
            for _, point in pairs(skeletonPoints) do point.Visible = false end
        end
    end)
end
local function cleanupESP(player)
    if ESPComponents[player] then
        local comps = ESPComponents[player]
        for key, component in pairs(comps) do
            if typeof(component) == "table" then
                for _, drawing in pairs(component) do
                    if typeof(drawing) == "userdata" then
                        pcall(function() drawing:Remove() end)
                    end
                end
            else
                if typeof(component) == "userdata" then
                    pcall(function() component:Remove() end)
                end
            end
        end
        ESPComponents[player] = nil
    end
end
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        createESP(player)
    end
end
Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        createESP(player)
    end
end)
Players.PlayerRemoving:Connect(function(player)
    cleanupESP(player)
end)
Tabs.ESP:Paragraph({
    Title = "ESP透视设置",
    Desc = "Drawing API高性能透视",
    ImageSize = 22,
    ThumbnailSize = 0
})
Tabs.ESP:Toggle({
    Title = "开启ESP总开关",
    Desc = "全局启用透视",
    Default = false,
    Callback = function(state)
        ESP_Config.EnableESP = state
        if not state then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    if ESPComponents[player] then
                        for key, component in pairs(ESPComponents[player]) do
                            if typeof(component) == "table" then
                                for _, drawing in pairs(component) do
                                    if typeof(drawing) == "userdata" then
                                        pcall(function() drawing.Visible = false end)
                                    end
                                end
                            else
                                if typeof(component) == "userdata" then
                                    pcall(function() component.Visible = false end)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
})
Tabs.ESP:Toggle({
    Title = "显示头顶名称",
    Desc = "玩家ID",
    Default = true,
    Callback = function(v) ESP_Config.ShowName = v end
})
Tabs.ESP:Toggle({
    Title = "显示血量",
    Default = true,
    Callback = function(v) ESP_Config.ShowHealth = v end
})
Tabs.ESP:Toggle({
    Title = "显示距离",
    Default = true,
    Callback = function(v) ESP_Config.ShowDistance = v end
})
Tabs.ESP:Toggle({
    Title = "方框透视",
    Desc = "2D方框",
    Default = true,
    Callback = function(v) ESP_Config.ShowBox = v end
})
Tabs.ESP:Toggle({
    Title = "射线透视",
    Desc = "从屏幕底部到头部",
    Default = false,
    Callback = function(v) ESP_Config.ShowTracer = v end
})
Tabs.ESP:Toggle({
    Title = "骨架透视",
    Desc = "骨骼线条",
    Default = false,
    Callback = function(v) ESP_Config.ShowSkeleton = v end
})
Tabs.ESP:Toggle({
    Title = "武器显示",
    Desc = "显示手持武器名",
    Default = false,
    Callback = function(v) ESP_Config.ShowWeapon = v end
})
Tabs.ESP:Toggle({
    Title = "穿墙ESP",
    Desc = "墙体遮挡依旧显示",
    Default = false,
    Callback = function(v) ESP_Config.WallHack = v end
})
Tabs.ESP:Toggle({
    Title = "区分队友颜色",
    Desc = "队友绿/敌人红/NPC黄",
    Default = false,
    Callback = function(v) ESP_Config.TeamCheck = v end
})
Tabs.ESP:Slider({
    Title = "ESP最大可视距离",
    Desc = "超出距离不渲染",
    Value = {Min=50, Max=1000, Default=350},
    Step = 10,
    IsTextbox = true,
    Callback = function(val) ESP_Config.MaxDrawDistance = val end
})
Tabs.bot:Paragraph({
    Title = "自瞄与子追",
    Desc = "Camera.CFrame暴力自瞄 + 子弹追踪",
})
local AimConfig = {
    Enabled = false,
    BulletTrack = false,
    FOV = 200,
    Smoothness = 0.15,
    Prediction = 0.12,
    BulletSpeed = 1500,
    BulletDrop = 0,
    WallCheck = true,
    ShowFOV = false,
    ShowTracer = true,
    AimPart = "Head",
    TeamCheck = true,
    JumpPrediction = true,
}
local aimFOVCircle = Drawing.new("Circle")
aimFOVCircle.Visible = false
aimFOVCircle.Color = Color3.fromRGB(255, 50, 50)
aimFOVCircle.Thickness = 1.5
aimFOVCircle.Filled = false
aimFOVCircle.Transparency = 0.4
aimFOVCircle.NumSides = 64
aimFOVCircle.Radius = AimConfig.FOV
aimFOVCircle.Position = Camera.ViewportSize / 2
local aimTracer = Drawing.new("Line")
aimTracer.Visible = false
aimTracer.Color = Color3.fromRGB(255, 50, 50)
aimTracer.Thickness = 1.5
aimTracer.Transparency = 0.4
aimTracer.From = Camera.ViewportSize / 2
aimTracer.To = Camera.ViewportSize / 2
local aimTargetPart = nil
local mainConn = nil
local function findClosestPlayer()
    local mousePos = UserInputService:GetMouseLocation()
    local viewportSize = Camera.ViewportSize
    local center = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
    local best = nil
    local bestDist = AimConfig.FOV
    for i = 1, #Players:GetPlayers() do
        local player = Players:GetPlayers()[i]
        if player == LocalPlayer then
        elseif player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if not humanoid or not hrp or humanoid.Health <= 0 then
            elseif AimConfig.TeamCheck and player.Team and player.Team == LocalPlayer.Team then
            else
                local part = player.Character:FindFirstChild(AimConfig.AimPart)
                if not part then part = player.Character:FindFirstChild("Head") end
                if not part then part = hrp end
                if part then
                    local sp, vis = Camera:WorldToViewportPoint(part.Position)
                    if vis and sp.Z < 1000 then
                        local sd = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                        if sd < bestDist then
                            best = part
                            bestDist = sd
                        end
                    end
                end
            end
        end
    end
    return best
end
local function isWallHit(part)
    if not AimConfig.WallCheck then return false end
    local origin = Camera.CFrame.Position
    local dir = (part.Position - origin)
    local rayP = RaycastParams.new()
    rayP.FilterType = Enum.RaycastFilterType.Exclude
    rayP.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
    local result = workspace:Raycast(origin, dir, rayP)
    if result and not result.Instance:IsDescendantOf(part.Parent) then
        return true
    end
    return false
end
local function doCameraAim()
    if not aimTargetPart or not aimTargetPart.Parent then return end
    local hum = aimTargetPart.Parent:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return end
    if isWallHit(aimTargetPart) then return end
    local dist = (aimTargetPart.Position - Camera.CFrame.Position).Magnitude
    local time = dist / math.max(AimConfig.BulletSpeed, 100)
    local vel = Vector3.zero
    local tHrp = aimTargetPart.Parent:FindFirstChild("HumanoidRootPart")
    if tHrp then
        vel = tHrp.AssemblyLinearVelocity
    end
    local predictPos = aimTargetPart.Position + vel * AimConfig.Prediction
    local dropOffset = Vector3.new(0, -AimConfig.BulletDrop * time * time, 0)
    local jumpOff = Vector3.zero
    if AimConfig.JumpPrediction and tHrp then
        if tHrp.AssemblyLinearVelocity.Y > 10 then
            jumpOff = Vector3.new(0, tHrp.AssemblyLinearVelocity.Y * AimConfig.Prediction * 0.5, 0)
        end
    end
    local targetPos = predictPos + dropOffset + jumpOff
    local targetCF = CFrame.new(Camera.CFrame.Position, targetPos)
    local s = AimConfig.Smoothness
    if s >= 1 then
        Camera.CFrame = targetCF
    else
        Camera.CFrame = Camera.CFrame:Lerp(targetCF, s)
    end
end
Tabs.bot:Toggle({
    Title = "🎯 自瞄总开关",
    Desc = "暴力Camera自瞄，直接控制视角锁定目标",
    Default = false,
    Callback = function(state)
        AimConfig.Enabled = state
        if state then
            if not mainConn then
                mainConn = RunService.RenderStepped:Connect(function()
                    if not AimConfig.Enabled then
                        aimTargetPart = nil
                        aimFOVCircle.Visible = false
                        aimTracer.Visible = false
                        return
                    end
                    aimFOVCircle.Position = Camera.ViewportSize / 2
                    aimFOVCircle.Radius = AimConfig.FOV
                    aimFOVCircle.Visible = AimConfig.ShowFOV
                    if AimConfig.Enabled then
                        aimTargetPart = findClosestPlayer()
                        doCameraAim()
                    else
                        aimTargetPart = nil
                    end
                    if aimTargetPart and aimTargetPart.Parent then
                        local sp, vis = Camera:WorldToViewportPoint(aimTargetPart.Position)
                        if vis then
                            if AimConfig.Enabled and AimConfig.ShowTracer then
                                aimTracer.Visible = true
                                aimTracer.From = Camera.ViewportSize / 2
                                aimTracer.To = Vector2.new(sp.X, sp.Y)
                            else
                                aimTracer.Visible = false
                            end
                        else
                            aimTracer.Visible = false
                        end
                    else
                        aimTracer.Visible = false
                    end
                end)
            end
        else
            if mainConn then
                mainConn:Disconnect()
                mainConn = nil
            end
            aimTargetPart = nil
            aimFOVCircle.Visible = false
            aimTracer.Visible = false
        end
    end
})
local btHbSize = 8
local btHbConn = nil
local function btExpandPlayer(player)
    if player == LocalPlayer then return end
    if AimConfig.TeamCheck and player.Team and player.Team == LocalPlayer.Team then return end
    local char = player.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local size = math.clamp(btHbSize, 0, 100)
    pcall(function()
        hrp.Size = Vector3.new(size, size, size)
        hrp.Transparency = 1
        hrp.CanCollide = false
    end)
end
local function btResetPlayer(player)
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    pcall(function()
        hrp.Size = Vector3.new(2, 2, 1)
        hrp.Transparency = 0
        hrp.CanCollide = true
    end)
end
Tabs.bot:Toggle({
    Title = "💣 子追总开关",
    Desc = "扩大敌人碰撞箱，子弹自动命中（每帧持续扩大）",
    Default = false,
    Callback = function(state)
        AimConfig.BulletTrack = state
        if state then
            if not btHbConn then
                btHbConn = RunService.Heartbeat:Connect(function()
                    if AimConfig.BulletTrack then
                        for i = 1, #Players:GetPlayers() do
                            btExpandPlayer(Players:GetPlayers()[i])
                        end
                    end
                end)
            end
            for i = 1, #Players:GetPlayers() do
                local player = Players:GetPlayers()[i]
                if player ~= LocalPlayer then
                    player.CharacterAdded:Connect(function()
                        task.wait(1)
                        if AimConfig.BulletTrack then
                            btExpandPlayer(player)
                        end
                    end)
                end
            end
        else
            if btHbConn then
                btHbConn:Disconnect()
                btHbConn = nil
            end
            for i = 1, #Players:GetPlayers() do
                btResetPlayer(Players:GetPlayers()[i])
            end
        end
    end
})
Tabs.bot:Slider({
    Title = "📦 判定箱大小",
    Desc = "敌人碰撞箱扩大倍数 (0=关闭, 100=巨大)",
    Value = { Min = 0, Max = 100, Default = 8 },
    Step = 1,
    Callback = function(value)
        btHbSize = value
    end
})
Tabs.bot:Slider({
    Title = "🎯 自瞄范围 (FOV)",
    Desc = "自瞄FOV范围 (像素)",
    Value = { Min = 20, Max = 1000, Default = 200 },
    Step = 10,
    Callback = function(value)
        AimConfig.FOV = value
        aimFOVCircle.Radius = value
    end
})
Tabs.bot:Slider({
    Title = "🔘 平滑系数",
    Desc = "1=瞬移锁定，越小越丝滑",
    Value = { Min = 0.01, Max = 1, Default = 0.15 },
    Step = 0.01,
    Callback = function(value)
        AimConfig.Smoothness = value
    end
})
Tabs.bot:Slider({
    Title = "⚡ 预判强度",
    Desc = "预判目标移动方向和速度",
    Value = { Min = 0, Max = 1, Default = 0.12 },
    Step = 0.01,
    Callback = function(value)
        AimConfig.Prediction = value
    end
})
Tabs.bot:Slider({
    Title = "🔫 弹道速度",
    Desc = "预判用的子弹速度",
    Value = { Min = 100, Max = 5000, Default = 1500 },
    Step = 50,
    Callback = function(value)
        AimConfig.BulletSpeed = value
    end
})
Tabs.bot:Slider({
    Title = "📉 弹道下坠",
    Desc = "子弹下坠补偿",
    Value = { Min = 0, Max = 200, Default = 0 },
    Step = 1,
    Callback = function(value)
        AimConfig.BulletDrop = value
    end
})
Tabs.bot:Dropdown({
    Title = "🎯 自瞄/追踪部位",
    Desc = "瞄准身体哪个部位",
    Values = {[1] = "Head", [2] = "HumanoidRootPart", [3] = "UpperTorso", [4] = "LowerTorso"},
    Callback = function(option)
        AimConfig.AimPart = option
    end
})
Tabs.bot:Toggle({
    Title = "🧱 掩体判断",
    Desc = "被墙挡住时不瞄准",
    Default = true,
    Callback = function(state)
        AimConfig.WallCheck = state
    end
})
Tabs.bot:Toggle({
    Title = "⭕ 显示FOV圆圈",
    Desc = "屏幕上显示自瞄范围",
    Default = false,
    Callback = function(state)
        AimConfig.ShowFOV = state
    end
})
Tabs.bot:Toggle({
    Title = "📏 显示自瞄射线",
    Desc = "从准星到目标画红线",
    Default = true,
    Callback = function(state)
        AimConfig.ShowTracer = state
    end
})
Tabs.bot:Toggle({
    Title = "👥 区分队友",
    Desc = "不瞄准队友",
    Default = true,
    Callback = function(state)
        AimConfig.TeamCheck = state
    end
})
Tabs.bot:Toggle({
    Title = "🦘 跳打预判",
    Desc = "预判跳跃目标的Y轴位移",
    Default = true,
    Callback = function(state)
        AimConfig.JumpPrediction = state
    end
})
-- 子追V2 (Universal Silent Aim - WindUI Integrated)
Tabs.bot:Paragraph({
    Title = "子追V2",
    Desc = "静默瞄准 - 子弹追踪（Universal Silent Aim）",
})

local SA = {
    Enabled = false,
    TeamCheck = false,
    VisibleCheck = false,
    TargetPart = "HumanoidRootPart",
    Method = "Raycast",
    FOVRadius = 130,
    FOVVisible = false,
    HitChance = 100,
    MaxDistance = 500,
    PriorityMode = "准星最近",
    Wallbang = false,
    ShowTarget = true,
    ShowTracer = true,
    ShowDamage = false,
    HighlightEnabled = false,
    HeadshotChanceEnabled = false,
    HeadshotChance = 0,
}

-- Drawing objects for SA V2
local saFOVCircle = Drawing.new("Circle")
saFOVCircle.Visible = false; saFOVCircle.ZIndex = 1000; saFOVCircle.Thickness = 1.5; saFOVCircle.Filled = false; saFOVCircle.Color = Color3.fromRGB(54, 57, 241); saFOVCircle.Transparency = 0.5; saFOVCircle.NumSides = 64; saFOVCircle.Radius = SA.FOVRadius; saFOVCircle.Position = Camera.ViewportSize / 2

local saIndicator = Drawing.new("Circle")
saIndicator.Visible = false; saIndicator.ZIndex = 1000; saIndicator.Thickness = 2; saIndicator.Filled = false; saIndicator.Color = Color3.fromRGB(255, 0, 0); saIndicator.NumSides = 64; saIndicator.Radius = 15

local saTracer = Drawing.new("Line")
saTracer.Visible = false; saTracer.ZIndex = 998; saTracer.Color = Color3.fromRGB(255, 255, 0); saTracer.Thickness = 1; saTracer.Transparency = 0.5

local saCurrentTarget = nil
local saHighlight = nil
local saLastHealth = {}
local saDamageIndicators = {}

-- SA V2 helper functions
local function saIsPartVisible(part)
    if not part then return false end
    local char = LocalPlayer.Character
    if not char then return false end
    local origin = char:FindFirstChild("Head") and char.Head.Position or Camera.CFrame.Position
    local dir = part.Position - origin
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {char, part.Parent}
    return not workspace:Raycast(origin, dir.Unit * dir.Magnitude, params)
end

local function saGetClosest()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return nil end
    local root = LocalPlayer.Character.HumanoidRootPart
    local center = Camera.ViewportSize / 2
    local best = nil
    local bestDist = SA.FOVRadius
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        if player ~= LocalPlayer and not (SA.TeamCheck and player.Team == LocalPlayer.Team) then
            local char = player.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if char and hum and hum.Health > 0 then
                local part = char:FindFirstChild(SA.TargetPart) or char:FindFirstChild("HumanoidRootPart")
                if part then
                    if not (SA.VisibleCheck and not saIsPartVisible(part)) then
                        local dist = (root.Position - part.Position).Magnitude
                        if dist <= SA.MaxDistance then
                            local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
                            if onScreen then
                                local fovDist = (center - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                                if fovDist < bestDist then
                                    bestDist = fovDist
                                    best = {character = char, part = part, dist = dist, health = hum.Health}
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    if best then
        return best.character, best.part
    end
    return nil, nil
end

-- SA V2 Hook (RenderStepped for target selection)
local saConn = nil
local saOldNamecall = nil
local saOldIndex = nil
local saOldRayNew = nil
local saActive = false

-- UI Controls for SA V2
local saSec1 = Tabs.bot:Section({ Title = "子追V2 - 主设置" })

saSec1:Toggle({
    Title = "启用子追V2",
    Desc = "静默瞄准开关",
    Callback = function(state)
        SA.Enabled = state
        if state and not saActive then
            saActive = true
            saConn = game:GetService("RunService").RenderStepped:Connect(function()
                if not SA.Enabled then return end
                saFOVCircle.Position = Camera.ViewportSize / 2
                saFOVCircle.Radius = SA.FOVRadius
                saFOVCircle.Visible = SA.FOVVisible
                saCurrentTarget = nil
                local char, part = saGetClosest()
                if char and part then
                    saCurrentTarget = part
                    if SA.ShowTarget then
                        local sp, onS = Camera:WorldToViewportPoint(part.Position)
                        if onS then
                            saIndicator.Visible = true
                            saIndicator.Position = Vector2.new(sp.X, sp.Y)
                            saIndicator.Radius = 15
                            saIndicator.Color = saIsPartVisible(part) and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
                        end
                    end
                    if SA.HighlightEnabled and char then
                        if not saHighlight then
                            saHighlight = Instance.new("Highlight")
                            saHighlight.FillTransparency = 0.5
                            saHighlight.OutlineTransparency = 0
                        end
                        saHighlight.Parent = char
                        saHighlight.Adornee = char
                        saHighlight.Enabled = true
                        saHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        saHighlight.FillColor = Color3.fromRGB(255, 255, 0)
                        saHighlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                    end
                else
                    saIndicator.Visible = false
                    if saHighlight then saHighlight:Destroy() saHighlight = nil end
                end
                if SA.ShowTracer and saCurrentTarget then
                    local sp, onS = Camera:WorldToViewportPoint(saCurrentTarget.Position)
                    saTracer.Visible = onS
                    if onS then
                        saTracer.From = Camera.ViewportSize / 2
                        saTracer.To = Vector2.new(sp.X, sp.Y)
                    end
                else
                    saTracer.Visible = false
                end
            end)
            -- Hook __namecall
            saOldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
                local method = getnamecallmethod()
                local args = {...}
                local self = args[1]
                if SA.Enabled and not checkcaller() and saCurrentTarget then
                    if method == "Raycast" and SA.Method == "Raycast" then
                        args[3] = (saCurrentTarget.Position - args[2]).Unit * 1000
                        return saOldNamecall(unpack(args))
                    end
                end
                return saOldNamecall(...)
            end))
            -- Hook __index for Mouse.Hit/Target
            saOldIndex = hookmetamethod(game, "__index", newcclosure(function(self, idx)
                if SA.Enabled and SA.Method == "Mouse.Hit/Target" and saCurrentTarget and not checkcaller() then
                    if idx == "Target" or idx == "target" then
                        return saCurrentTarget
                    elseif idx == "Hit" or idx == "hit" then
                        return saCurrentTarget.CFrame
                    end
                end
                return saOldIndex(self, idx)
            end))
        elseif not state and saActive then
            saActive = false
            if saConn then saConn:Disconnect() saConn = nil end
            if saOldNamecall then saOldNamecall:UnHook() saOldNamecall = nil end
            if saOldIndex then saOldIndex:UnHook() saOldIndex = nil end
            saFOVCircle.Visible = false
            saIndicator.Visible = false
            saTracer.Visible = false
            if saHighlight then saHighlight:Destroy() saHighlight = nil end
            saCurrentTarget = nil
        end
    end
})

saSec1:Toggle({
    Title = "队伍检查",
    Desc = "不瞄准队友",
    Callback = function(state) SA.TeamCheck = state end
})

saSec1:Toggle({
    Title = "可见性检查",
    Desc = "只瞄准可见目标",
    Callback = function(state) SA.VisibleCheck = state end
})

saSec1:Toggle({
    Title = "穿墙",
    Desc = "无视墙壁",
    Callback = function(state) SA.Wallbang = state end
})

saSec1:Toggle({
    Title = "显示FOV圈",
    Callback = function(state) SA.FOVVisible = state; if not state then saFOVCircle.Visible = false end end
})

saSec1:Toggle({
    Title = "显示目标指示器",
    Callback = function(state) SA.ShowTarget = state; if not state then saIndicator.Visible = false end end
})

saSec1:Toggle({
    Title = "显示追踪线",
    Callback = function(state) SA.ShowTracer = state; if not state then saTracer.Visible = false end end
})

saSec1:Toggle({
    Title = "高亮目标",
    Callback = function(state)
        SA.HighlightEnabled = state
        if not state and saHighlight then saHighlight:Destroy() saHighlight = nil end
    end
})

local saSec2 = Tabs.bot:Section({ Title = "子追V2 - 参数" })

saSec2:Slider({
    Title = "FOV半径",
    Desc = "瞄准范围",
    Value = {Min=10, Max=500, Default=SA.FOVRadius},
    Step = 5,
    Callback = function(val) SA.FOVRadius = val end
})

saSec2:Slider({
    Title = "最大距离",
    Desc = "最远瞄准距离",
    Value = {Min=50, Max=2000, Default=SA.MaxDistance},
    Step = 50,
    Callback = function(val) SA.MaxDistance = val end
})

saSec2:Slider({
    Title = "命中率",
    Desc = "静默瞄准命中率",
    Value = {Min=0, Max=100, Default=SA.HitChance},
    Step = 5,
    IsTextbox = true,
    Callback = function(val) SA.HitChance = val end
})

saSec2:Dropdown({
    Title = "目标部位",
    Desc = "瞄准的身体部位",
    Values = {[1] = "Head", [2] = "HumanoidRootPart", [3] = "Random"},
    Callback = function(option) SA.TargetPart = option end
})

saSec2:Dropdown({
    Title = "瞄准方式",
    Desc = "静默瞄准Hook方式",
    Values = {[1] = "Raycast", [2] = "Mouse.Hit/Target"},
    Callback = function(option) SA.Method = option end
})

saSec2:Dropdown({
    Title = "优先模式",
    Desc = "目标选择优先级",
    Values = {[1] = "准星最近", [2] = "距离最近", [3] = "最低血量"},
    Callback = function(option) SA.PriorityMode = option end
})

saSec2:Toggle({
    Title = "爆头几率",
    Desc = "随机爆头",
    Callback = function(state) SA.HeadshotChanceEnabled = state end
})

saSec2:Slider({
    Title = "爆头概率",
    Desc = "爆头几率百分比",
    Value = {Min=0, Max=100, Default=SA.HeadshotChance},
    Step = 5,
    IsTextbox = true,
    Callback = function(val) SA.HeadshotChance = val end
})

Tabs.bot:Button({
    Title = "静默瞄准通用",
    Callback = function()
        local SilentAimSettings = {
    Enabled = false,
    ClassName = "Universal Silent Aim",
    ToggleKey = "RightAlt",
    TeamCheck = false,
    VisibleCheck = false,
    TargetPart = "HumanoidRootPart",
    SilentAimMethod = "Raycast",
    FOVRadius = 130,
    FOVVisible = true,
    ShowSilentAimTarget = false,
    MouseHitPrediction = false,
    MouseHitPredictionAmount = 0.165,
    HitChance = 100,
    HeadshotChanceEnabled = false,
    HeadshotChance = 0,
    FixedFOV = true,
    TargetIndicatorRadius = 20,
    CrosshairLength = 30,
    CrosshairGap = 5,
    IndicatorRotationEnabled = false,
    IndicatorRotationSpeed = 1,
    IndicatorRainbowEnabled = false,
    IndicatorRainbowSpeed = 1,
    MaxDistance = 500,
    PriorityMode = "准星最近",
    TargetInfoStyle = "面板",
    ShowTargetName = true,
    ShowTargetHealth = true,
    ShowTargetDistance = true,
    ShowTargetCategory = false,
    ShowDamageNotifier = false,
    HighlightEnabled = false,
    HighlightRainbowEnabled = false,
    HighlightColor = Color3.fromRGB(255, 255, 0),
    IndependentPanelPosition = "200,200",
    IndependentPanelPinned = false,
    LeakAndHitMode = false,
    Wallbang = false,
    EnableNameTargeting = false,
    WhitelistedNames = {},
    BlacklistedNames = {},
    ShowTracer = false,
    Tracer_Y_Offset = 0,
    WhitelistPath = {},
    IndicatorBreathingEnabled = true,
    IndicatorBreathingSpeed = 1,
    IndicatorBreathingMin = 0.8,
    IndicatorBreathingMax = 1.2,
    ThreeLineCrosshairEnabled = true,
    ThreeLineCrosshairLength = 30,
    ThreeLineCrosshairGap = 5
}
getgenv().SilentAimSettings = SilentAimSettings
local MainFileName = "UniversalSilentAim"
local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Debris = game:GetService("Debris")
local CoreGui = game:GetService("CoreGui")
local PathfindingService = game:GetService("PathfindingService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local GetPlayers = Players.GetPlayers
local WorldToViewportPoint = Camera.WorldToViewportPoint
local FindFirstChild = game.FindFirstChild
local RenderStepped = RunService.RenderStepped
local GetMouseLocation = UserInputService.GetMouseLocation
local resume = coroutine.resume
local create = coroutine.create
local ValidTargetParts = {"Head", "HumanoidRootPart"}
local PredictionAmount = 0.165
local currentTargetPart = nil
local currentHighlight = nil
local currentRotationAngle = 0
local currentIndicatorHue = 0
local npcList = {}
local targetMap = {}
local avatarCache = {}
local recentShots = {}
local pendingDamage = {}
local lockedTargetObject = nil
local target_indicator_circle = Drawing.new("Circle")
target_indicator_circle.Visible = false; target_indicator_circle.ZIndex = 1000; target_indicator_circle.Thickness = 2; target_indicator_circle.Filled = false
local target_indicator_lines = {}
for i = 1, 5 do local line = Drawing.new("Line"); line.Visible = false; line.ZIndex = 1000; line.Thickness = 2; table.insert(target_indicator_lines, line) end
local tracer_line = Drawing.new("Line")
tracer_line.Visible = false; tracer_line.ZIndex = 998; tracer_line.Color = Color3.fromRGB(255, 255, 0); tracer_line.Thickness = 1; tracer_line.Transparency = 1
local overhead_info_texts = {
    Name = Drawing.new("Text"),
    Health = Drawing.new("Text"),
    Distance = Drawing.new("Text"),
    Category = Drawing.new("Text")
}
for _, text in pairs(overhead_info_texts) do
    text.Visible = false; text.ZIndex = 1001; text.Font = Drawing.Fonts.Plex; text.Size = 14; text.Color = Color3.fromRGB(255, 255, 255); text.Center = true; text.Outline = true
end
local panel_info_bg = Drawing.new("Square")
panel_info_bg.Visible = false; panel_info_bg.ZIndex = 1002; panel_info_bg.Color = Color3.fromRGB(0, 0, 0); panel_info_bg.Thickness = 0; panel_info_bg.Filled = true; panel_info_bg.Transparency = 0.5
local panel_info_texts = {
    Name = Drawing.new("Text"),
    Health = Drawing.new("Text"),
    Distance = Drawing.new("Text"),
    Category = Drawing.new("Text")
}
for _, text in pairs(panel_info_texts) do
    text.Visible = false; text.ZIndex = 1003; text.Font = Drawing.Fonts.Plex; text.Size = 14; text.Color = Color3.fromRGB(255, 255, 255); text.Center = false; text.Outline = true
end
local FOVCircleGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
FOVCircleGui.Name = "FOVCircleGui"; FOVCircleGui.ResetOnSpawn = false; FOVCircleGui.IgnoreGuiInset = true; FOVCircleGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local FOVCircleFrame = Instance.new("Frame", FOVCircleGui)
FOVCircleFrame.Name = "FOVCircleFrame"; FOVCircleFrame.AnchorPoint = Vector2.new(0.5, 0.5); FOVCircleFrame.Position = UDim2.fromScale(0.5, 0.5); FOVCircleFrame.BackgroundTransparency = 1
local FOVStroke = Instance.new("UIStroke", FOVCircleFrame)
FOVStroke.Name = "FOVStroke"; FOVStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; FOVStroke.Thickness = 1; FOVStroke.Transparency = 0.5
local FOVCorner = Instance.new("UICorner", FOVCircleFrame)
FOVCorner.Name = "FOVCorner"; FOVCorner.CornerRadius = UDim.new(1, 0)
local IndependentPanelGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
IndependentPanelGui.Name = "IndependentPanelGui"; IndependentPanelGui.ResetOnSpawn = false; IndependentPanelGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local IndependentPanelFrame = Instance.new("Frame", IndependentPanelGui)
IndependentPanelFrame.Name = "PanelFrame"; IndependentPanelFrame.Size = UDim2.fromOffset(160, 100);
IndependentPanelFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30); IndependentPanelFrame.BackgroundTransparency = 0.3; IndependentPanelFrame.BorderSizePixel = 1; IndependentPanelFrame.BorderColor3 = Color3.new(1,1,1)
IndependentPanelFrame.Visible = false; IndependentPanelFrame.Active = true
local IPCorner = Instance.new("UICorner", IndependentPanelFrame); IPCorner.CornerRadius = UDim.new(0, 4)
local IPListLayout = Instance.new("UIListLayout", IndependentPanelFrame)
IPListLayout.Padding = UDim.new(0, 5); IPListLayout.SortOrder = Enum.SortOrder.LayoutOrder; IPListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center; IPListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
local independent_panel_texts = {}
for i, name in ipairs({"Name", "Health", "Distance", "Category"}) do
    local label = Instance.new("TextLabel", IndependentPanelFrame)
    label.Name = name; label.Size = UDim2.new(1, -10, 0, 15); label.BackgroundTransparency = 1
    label.Font = Enum.Font.SourceSans; label.TextSize = 14; label.TextColor3 = Color3.new(1,1,1); label.TextXAlignment = Enum.TextXAlignment.Left; label.LayoutOrder = i
    independent_panel_texts[name] = label
end
IndependentPanelFrame.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 and IndependentPanelFrame.Draggable then IndependentPanelFrame.Position = UDim2.fromOffset(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) end end)
IndependentPanelFrame.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 and IndependentPanelFrame.Draggable then SilentAimSettings.IndependentPanelPosition = IndependentPanelFrame.Position.X.Offset .. "," .. IndependentPanelFrame.Position.Y.Offset end end)
local ExpectedArguments = {
    FindPartOnRayWithIgnoreList = { ArgCountRequired = 3, Args = {"Instance", "Ray", "table", "boolean", "boolean"} },
    FindPartOnRayWithWhitelist = { ArgCountRequired = 3, Args = {"Instance", "Ray", "table", "boolean"} },
    FindPartOnRay = { ArgCountRequired = 2, Args = {"Instance", "Ray", "Instance", "boolean", "boolean"} },
    Raycast = { ArgCountRequired = 3, Args = {"Instance", "Vector3", "Vector3", "RaycastParams"} }
}
local HitSounds = {
    ["bell"] = "rbxassetid://8679627751",
    ["metal"] = "rbxassetid://3125624765",
    ["click"] = "rbxassetid://17755696142",
    ["exp"] = "rbxassetid://10070796384"
}
local rainbowColor = Color3.fromHSV(0, 1, 1)
task.spawn(function()
    while task.wait() do
        if Library and Library.Unloaded then break end
        local hue = (tick() % 6) / 6
        rainbowColor = Color3.fromHSV(hue, 1, 1)
    end
end)
local function playHitSound(soundId)
    local sound = Instance.new("Sound")
    sound.Parent = CoreGui
    sound.SoundId = soundId
    sound.Volume = 0.6
    sound:Play()
    Debris:AddItem(sound, sound.TimeLength + 0.2)
end
function CalculateChance(Percentage)
    Percentage = math.floor(Percentage)
    return math.random() <= Percentage / 100
end
do
    if not isfolder(MainFileName) then makefolder(MainFileName) end
    if not isfolder(string.format("%s/%s", MainFileName, tostring(game.PlaceId))) then makefolder(string.format("%s/%s", MainFileName, tostring(game.PlaceId))) end
end
local function getPositionOnScreen(Vector)
    local Vec3, OnScreen = WorldToViewportPoint(Camera, Vector)
    return Vector2.new(Vec3.X, Vec3.Y), OnScreen
end
local function ValidateArguments(Args, RayMethod)
    local Matches = 0
    if #Args < RayMethod.ArgCountRequired then return false end
    for Pos, Argument in next, Args do if typeof(Argument) == RayMethod.Args[Pos] then Matches = Matches + 1 end end
    return Matches >= RayMethod.ArgCountRequired
end
local function getDirection(Origin, Position)
    return (Position - Origin).Unit * 1000
end
local function isNPC(obj)
    return obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj.Humanoid.Health > 0 and obj:FindFirstChild("HumanoidRootPart") and not Players:GetPlayerFromCharacter(obj)
end
function getTargetCategory(character)
    if not character then return "无" end
    if Players:GetPlayerFromCharacter(character) then
        return "玩家"
    end
    if SilentAimSettings.EnableNameTargeting then
        local name = character.Name:lower()
        for _, whitelistedName in ipairs(SilentAimSettings.WhitelistedNames) do
            if whitelistedName and whitelistedName ~= "" and string.find(name, whitelistedName:lower(), 1, true) then
                return "添加的"
            end
        end
    end
    for _, path in ipairs(SilentAimSettings.WhitelistPath) do
        local obj = workspace:FindFirstChild(path)
        if obj and obj == character then
            return "路径白名单"
        end
    end
    if character:FindFirstChild("Humanoid") then
         return "NPC"
    end
    return "未知"
end
local function updateNPCs()
    local newNpcList = {}
    local addedNpcs = {}
    if SilentAimSettings.EnableNameTargeting and #SilentAimSettings.WhitelistedNames > 0 then
        for _, model in ipairs(workspace:GetDescendants()) do
            if isNPC(model) then
                for _, substring in ipairs(SilentAimSettings.WhitelistedNames) do
                    if substring and substring ~= "" and string.find(model.Name:lower(), substring:lower(), 1, true) then
                        if not addedNpcs[model] then
                            table.insert(newNpcList, model)
                            addedNpcs[model] = true
                            break
                        end
                    end
                end
            end
        end
    end
    for _, path in ipairs(SilentAimSettings.WhitelistPath) do
        local obj = workspace:FindFirstChild(path)
        if obj and isNPC(obj) and not addedNpcs[obj] then
            table.insert(newNpcList, obj)
            addedNpcs[obj] = true
        end
    end
    for _, v in ipairs(workspace:GetChildren()) do
        if isNPC(v) then
            if not addedNpcs[v] then
                table.insert(newNpcList, v)
                addedNpcs[v] = true
            end
        end
    end
    npcList = newNpcList
end
local function isBlacklisted(name)
    local lowerName = name:lower()
    for _, blacklistedName in ipairs(SilentAimSettings.BlacklistedNames) do
        if blacklistedName:lower() == lowerName then
            return true
        end
    end
    return false
end
local function isPartVisible(part, customOrigin)
    if not part then return false end
    local localCharacter = LocalPlayer.Character
    if not localCharacter then return false end
    local origin = customOrigin or Camera.CFrame.Position
    local direction = part.Position - origin
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {localCharacter, part.Parent}
    local raycastResult = workspace:Raycast(origin, direction.Unit * direction.Magnitude, raycastParams)
    return not raycastResult
end
local function getClosestPlayer()
    local LocalPlayerCharacter = LocalPlayer.Character
    if not LocalPlayerCharacter or not LocalPlayerCharacter:FindFirstChild("HumanoidRootPart") then return nil end
    local localRoot = LocalPlayerCharacter.HumanoidRootPart
    local AimPoint = SilentAimSettings.FixedFOV and (Camera.ViewportSize / 2) or GetMouseLocation(UserInputService)
    local candidates = {}
    for _, Player in ipairs(GetPlayers(Players)) do
        if Player ~= LocalPlayer and not (SilentAimSettings.TeamCheck and Player.Team == LocalPlayer.Team) and not isBlacklisted(Player.Name) then
            local Character = Player.Character
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
            if Character and Humanoid and Humanoid.Health > 0 then
                local partForChecks = Character:FindFirstChild(SilentAimSettings.TargetPart) or Character:FindFirstChild("HumanoidRootPart")
                if not partForChecks then continue end
                if not (SilentAimSettings.VisibleCheck and not isPartVisible(partForChecks, LocalPlayerCharacter.Head.Position)) then
                    local physicalDist = (localRoot.Position - partForChecks.Position).Magnitude
                    if physicalDist <= SilentAimSettings.MaxDistance then
                        if SilentAimSettings.PriorityMode == "最近的人(无FOV)" then
                            table.insert(candidates, {character = Character, fov = math.huge, dist = physicalDist, health = Humanoid.Health})
                        else
                            local ScreenPosition, OnScreen = getPositionOnScreen(partForChecks.Position)
                            if OnScreen then
                                local fovDist = (AimPoint - ScreenPosition).Magnitude
                                if fovDist <= SilentAimSettings.FOVRadius then
                                    table.insert(candidates, {character = Character, fov = fovDist, dist = physicalDist, health = Humanoid.Health})
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    if #candidates == 0 then return nil end
    table.sort(candidates, function(a, b)
        if SilentAimSettings.PriorityMode == "最低血量" then
            return a.health < b.health
        elseif SilentAimSettings.PriorityMode == "距离最近" or SilentAimSettings.PriorityMode == "最近的人(无FOV)" then
            return a.dist < b.dist
        else
            return a.fov < b.fov
        end
    end)
    return candidates[1].character
end
local function getNPCTarget()
    local LocalPlayerCharacter = LocalPlayer.Character
    if not LocalPlayerCharacter or not LocalPlayerCharacter:FindFirstChild("HumanoidRootPart") then return nil end
    local localRoot = LocalPlayerCharacter.HumanoidRootPart
    local AimPoint = SilentAimSettings.FixedFOV and (Camera.ViewportSize / 2) or GetMouseLocation(UserInputService)
    local candidates = {}
    for _, NPCModel in ipairs(npcList) do
        if not (SilentAimSettings.TeamCheck and NPCModel.Team and NPCModel.Team == LocalPlayer.Team) and not isBlacklisted(NPCModel.Name) then
            local Humanoid = NPCModel and NPCModel:FindFirstChildOfClass("Humanoid")
            if NPCModel and Humanoid and Humanoid.Health > 0 then
                local partForChecks = NPCModel:FindFirstChild(SilentAimSettings.TargetPart) or NPCModel.PrimaryPart or NPCModel:FindFirstChild("HumanoidRootPart")
                if not partForChecks then continue end
                if not (SilentAimSettings.VisibleCheck and not isPartVisible(partForChecks, LocalPlayerCharacter.Head.Position)) then
                    local physicalDist = (localRoot.Position - partForChecks.Position).Magnitude
                    if physicalDist <= SilentAimSettings.MaxDistance then
                         if SilentAimSettings.PriorityMode == "最近的人(无FOV)" then
                            table.insert(candidates, {character = NPCModel, fov = math.huge, dist = physicalDist, health = Humanoid.Health})
                        else
                            local ScreenPosition, OnScreen = getPositionOnScreen(partForChecks.Position)
                            if OnScreen then
                                local fovDist = (AimPoint - ScreenPosition).Magnitude
                                if fovDist <= SilentAimSettings.FOVRadius then
                                    table.insert(candidates, {character = NPCModel, fov = fovDist, dist = physicalDist, health = Humanoid.Health})
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    if #candidates == 0 then return nil end
    table.sort(candidates, function(a, b)
        if SilentAimSettings.PriorityMode == "最低血量" then
            return a.health < b.health
        elseif SilentAimSettings.PriorityMode == "距离最近" or SilentAimSettings.PriorityMode == "最近的人(无FOV)" then
            return a.dist < b.dist
        else
            return a.fov < b.fov
        end
    end)
    return candidates[1].character
end
function getPolygonPoints(center, radius, sides)
    local points = {}
    local rotationOffset = SilentAimSettings.IndicatorRotationEnabled and currentRotationAngle or 0
    for i = 1, sides do
        local angle = (i - 1) * (2 * math.pi / sides) - (math.pi / 2) + rotationOffset
        table.insert(points, Vector2.new(center.X + radius * math.cos(angle), center.Y + radius * math.sin(angle)))
    end
    return points
end
function hideAllVisuals()
    target_indicator_circle.Visible = false
    for _, line in ipairs(target_indicator_lines) do line.Visible = false end
    for _, text in pairs(overhead_info_texts) do text.Visible = false end
    panel_info_bg.Visible = false
    for _, text in pairs(panel_info_texts) do text.Visible = false end
    if IndependentPanelFrame then IndependentPanelFrame.Visible = false end
end
local repo = "https://raw.githubusercontent.com/SyndromeXph/NOL-Obsidian/refs/heads/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
local Options = Library.Options
local Toggles = Library.Toggles
local Window = Library:CreateWindow({ Title = "通用 Slient Aim", Footer = "Yuxin", Center = true, AutoShow = true })
local Tabs = {
    Main = Window:AddTab("主页", "user"),
    Visuals = Window:AddTab("视觉", "camera"),
    Management = Window:AddTab("管理", "users"),
    Misc = Window:AddTab("杂项", "box"),
    ["UI Settings"] = Window:AddTab("UI设置", "settings"),
}
local MainSettingsBox = Tabs.Main:AddLeftGroupbox("主设置")
MainSettingsBox:AddToggle("EnabledToggle", { Text = "启用", Default = SilentAimSettings.Enabled }):AddKeyPicker("EnabledKeybind", { Default = SilentAimSettings.ToggleKey, SyncToggleState = true, Mode = "Toggle" })
Toggles.EnabledToggle:OnChanged(function(Value) SilentAimSettings.Enabled = Value end)
MainSettingsBox:AddToggle("TeamCheckToggle", { Text = "队伍检查", Default = SilentAimSettings.TeamCheck }):OnChanged(function(Value) SilentAimSettings.TeamCheck = Value end)
MainSettingsBox:AddToggle("VisibleCheckToggle", { Text = "可见性检查", Default = SilentAimSettings.VisibleCheck }):OnChanged(function(Value) SilentAimSettings.VisibleCheck = Value end)
MainSettingsBox:AddToggle("WallbangToggle", { Text = "穿墙", Default = SilentAimSettings.Wallbang}):OnChanged(function(Value) SilentAimSettings.Wallbang = Value end)
MainSettingsBox:AddToggle("LeakAndHitToggle", { Text = "漏打模式", Default = SilentAimSettings.LeakAndHitMode}):OnChanged(function(Value) SilentAimSettings.LeakAndHitMode = Value end)
MainSettingsBox:AddSlider('HitChanceSlider', { Text = '命中率', Default = SilentAimSettings.HitChance, Min = 0, Max = 100, Rounding = 1, Suffix = "%" }):OnChanged(function(Value) SilentAimSettings.HitChance = Value end)
local TargetingBox = Tabs.Main:AddRightGroupbox("目标")
TargetingBox:AddDropdown("TargetModeDropdown", { Text = "目标种类", Default = "请选择", Values = {"玩家", "NPC", "所有"} }):OnChanged(function(Value) SilentAimSettings.TargetMode = Value end)
TargetingBox:AddDropdown("TargetPartDropdown", { Values = {"Head", "HumanoidRootPart", "Random"}, Default = SilentAimSettings.TargetPart, Text = "目标部位" }):OnChanged(function(Value) SilentAimSettings.TargetPart = Value end)
TargetingBox:AddDropdown("PriorityModeDropdown", { Text = "优先模式", Default = SilentAimSettings.PriorityMode, Values = {"准星最近", "距离最近", "最低血量", "最近的人(无FOV)"} }):OnChanged(function(Value) SilentAimSettings.PriorityMode = Value end)
TargetingBox:AddSlider('MaxDistanceSlider', { Text = '最大距离', Default = SilentAimSettings.MaxDistance, Min = 10, Max = 2000, Rounding = 0, Suffix = "studs" }):OnChanged(function(Value) SilentAimSettings.MaxDistance = Value end)
local MethodBox = Tabs.Main:AddRightGroupbox("方法")
MethodBox:AddDropdown("MethodDropdown", { Text = "静默瞄准方式", Default = SilentAimSettings.SilentAimMethod, Values = { "Raycast","FindPartOnRay", "FindPartOnRayWithWhitelist", "FindPartOnRayWithIgnoreList", "ScreenPointToRay", "ViewportPointToRay", "Ray", "Mouse.Hit/Target" } }):OnChanged(function(Value) SilentAimSettings.SilentAimMethod = Value end)
MethodBox:AddToggle("PredictionToggle", { Text = "Mouse.Hit/Target 预判", Default = SilentAimSettings.MouseHitPrediction }):OnChanged(function(Value) SilentAimSettings.MouseHitPrediction = Value end)
MethodBox:AddSlider("PredictionAmountSlider", { Text = "预判量", Min = 0, Max = 1, Default = SilentAimSettings.MouseHitPredictionAmount, Rounding = 3 }):OnChanged(function(Value) SilentAimSettings.MouseHitPredictionAmount = Value; PredictionAmount = Value end)
MethodBox:AddToggle("HeadshotChanceToggle", { Text = "启用爆头几率", Default = SilentAimSettings.HeadshotChanceEnabled }):OnChanged(function(Value) SilentAimSettings.HeadshotChanceEnabled = Value end)
MethodBox:AddSlider('HeadshotChanceSlider', { Text = '爆头概率', Default = SilentAimSettings.HeadshotChance, Min = 0, Max = 100, Rounding = 1, Suffix = "%" }):OnChanged(function(Value) SilentAimSettings.HeadshotChance = Value end)
local FovIndicatorBox = Tabs.Visuals:AddLeftGroupbox("范围与指示器")
FovIndicatorBox:AddToggle("FOVVisibleToggle", { Text = "显示FOV圈", Default = SilentAimSettings.FOVVisible }):AddColorPicker("FOVColorPicker", { Default = Color3.fromRGB(54, 57, 241), Title = "FOV圈颜色" })
Toggles.FOVVisibleToggle:OnChanged(function(Value) FOVCircleGui.Enabled = Value; SilentAimSettings.FOVVisible = Value end)
Options.FOVColorPicker:OnChanged(function(Value) FOVStroke.Color = Value end)
FovIndicatorBox:AddSlider("FOVRadiusSlider", { Text = "FOV圈半径", Min = 10, Max = 1000, Default = SilentAimSettings.FOVRadius, Rounding = 0 }):OnChanged(function(Value) FOVCircleFrame.Size = UDim2.fromOffset(Value * 2, Value * 2); SilentAimSettings.FOVRadius = Value end)
FovIndicatorBox:AddToggle("FixedFOVToggle", { Text = "固定FOV (移动端)", Default = SilentAimSettings.FixedFOV }):OnChanged(function(Value) SilentAimSettings.FixedFOV = Value end)
FovIndicatorBox:AddToggle("ShowTargetToggle", { Text = "显示目标", Default = SilentAimSettings.ShowSilentAimTarget }):AddColorPicker("TargetIndicatorColorPicker", { Default = Color3.fromRGB(255,0,0), Title = "指示器颜色" })
Toggles.ShowTargetToggle:OnChanged(function(Value) SilentAimSettings.ShowSilentAimTarget = Value end)
Options.TargetIndicatorColorPicker:OnChanged(function(Value) target_indicator_circle.Color = Value; for _, line in ipairs(target_indicator_lines) do line.Color = Value end end)
FovIndicatorBox:AddDropdown("IndicatorStyleDropdown", { Text = "指示器样式", Values = {"Circle", "Triangle", "Pentagram", "十字准星", "三线准星"}, Default = "Circle" })
FovIndicatorBox:AddSlider("TargetIndicatorRadiusSlider", { Text = "指示器大小(通用)", Min = 5, Max = 50, Default = SilentAimSettings.TargetIndicatorRadius, Rounding = 0 }):OnChanged(function(Value) SilentAimSettings.TargetIndicatorRadius = Value end)
FovIndicatorBox:AddSlider("CrosshairLengthSlider", { Text = "十字准星长度", Min = 5, Max = 100, Default = SilentAimSettings.CrosshairLength, Rounding = 0 }):OnChanged(function(Value) SilentAimSettings.CrosshairLength = Value end)
FovIndicatorBox:AddSlider("CrosshairGapSlider", { Text = "十字准星间隙", Min = 0, Max = 50, Default = SilentAimSettings.CrosshairGap, Rounding = 0 }):OnChanged(function(Value) SilentAimSettings.CrosshairGap = Value end)
FovIndicatorBox:AddToggle("IndicatorRotationToggle", { Text = "指示器旋转", Default = SilentAimSettings.IndicatorRotationEnabled }):OnChanged(function(Value) SilentAimSettings.IndicatorRotationEnabled = Value end)
FovIndicatorBox:AddSlider("IndicatorRotationSpeedSlider", { Text = "旋转速度", Min = 0, Max = 10, Default = SilentAimSettings.IndicatorRotationSpeed, Rounding = 1 }):OnChanged(function(Value) SilentAimSettings.IndicatorRotationSpeed = Value end)
FovIndicatorBox:AddToggle("IndicatorRainbowToggle", { Text = "启用彩虹色", Default = SilentAimSettings.IndicatorRainbowEnabled }):OnChanged(function(Value) SilentAimSettings.IndicatorRainbowEnabled = Value end)
FovIndicatorBox:AddSlider("IndicatorRainbowSpeedSlider", { Text = "颜色变换速度", Min = 0, Max = 10, Default = SilentAimSettings.IndicatorRainbowSpeed, Rounding = 1 }):OnChanged(function(Value) SilentAimSettings.IndicatorRainbowSpeed = Value end)
FovIndicatorBox:AddToggle("IndicatorBreathingToggle", { Text = "启用呼吸效果", Default = SilentAimSettings.IndicatorBreathingEnabled }):OnChanged(function(Value) SilentAimSettings.IndicatorBreathingEnabled = Value end)
FovIndicatorBox:AddSlider("IndicatorBreathingSpeedSlider", { Text = "呼吸速度", Min = 0.1, Max = 5, Default = SilentAimSettings.IndicatorBreathingSpeed, Rounding = 1 }):OnChanged(function(Value) SilentAimSettings.IndicatorBreathingSpeed = Value end)
FovIndicatorBox:AddSlider("IndicatorBreathingMinSlider", { Text = "呼吸最小比例", Min = 0.1, Max = 1, Default = SilentAimSettings.IndicatorBreathingMin, Rounding = 2 }):OnChanged(function(Value) SilentAimSettings.IndicatorBreathingMin = Value end)
FovIndicatorBox:AddSlider("IndicatorBreathingMaxSlider", { Text = "呼吸最大比例", Min = 1, Max = 3, Default = SilentAimSettings.IndicatorBreathingMax, Rounding = 2 }):OnChanged(function(Value) SilentAimSettings.IndicatorBreathingMax = Value end)
FovIndicatorBox:AddToggle("ThreeLineCrosshairToggle", { Text = "启用三线准星", Default = SilentAimSettings.ThreeLineCrosshairEnabled }):OnChanged(function(Value) SilentAimSettings.ThreeLineCrosshairEnabled = Value end)
FovIndicatorBox:AddSlider("ThreeLineCrosshairLengthSlider", { Text = "三线准星长度", Min = 5, Max = 100, Default = SilentAimSettings.ThreeLineCrosshairLength, Rounding = 0 }):OnChanged(function(Value) SilentAimSettings.ThreeLineCrosshairLength = Value end)
FovIndicatorBox:AddSlider("ThreeLineCrosshairGapSlider", { Text = "三线准星间隙", Min = 0, Max = 50, Default = SilentAimSettings.ThreeLineCrosshairGap, Rounding = 0 }):OnChanged(function(Value) SilentAimSettings.ThreeLineCrosshairGap = Value end)
local InfoBox = Tabs.Visuals:AddRightGroupbox("信息")
InfoBox:AddDropdown("TargetInfoStyleDropdown", { Text = "信息显示样式", Default = SilentAimSettings.TargetInfoStyle, Values = {"面板", "头顶", "独立面板"} }):OnChanged(function(Value) SilentAimSettings.TargetInfoStyle = Value end)
InfoBox:AddToggle("ShowTargetNameToggle", { Text = "显示目标名字", Default = SilentAimSettings.ShowTargetName }):OnChanged(function(Value) SilentAimSettings.ShowTargetName = Value end)
InfoBox:AddToggle("ShowTargetHealthToggle", { Text = "显示目标血量", Default = SilentAimSettings.ShowTargetHealth }):OnChanged(function(Value) SilentAimSettings.ShowTargetHealth = Value end)
InfoBox:AddToggle("ShowTargetDistanceToggle", { Text = "显示目标距离", Default = SilentAimSettings.ShowTargetDistance }):OnChanged(function(Value) SilentAimSettings.ShowTargetDistance = Value end)
InfoBox:AddToggle("ShowTargetCategoryToggle", { Text = "显示目标类别", Default = SilentAimSettings.ShowTargetCategory }):OnChanged(function(Value) SilentAimSettings.ShowTargetCategory = Value end)
InfoBox:AddButton("重置独立面板位置", function()
    SilentAimSettings.IndependentPanelPosition = "200,200"
    local pos = SilentAimSettings.IndependentPanelPosition:split(",")
    IndependentPanelFrame.Position = UDim2.fromOffset(tonumber(pos[1]), tonumber(pos[2]))
end)
InfoBox:AddToggle("PinPanelToggle", {Text = "固定面板", Default = SilentAimSettings.IndependentPanelPinned}):OnChanged(function(value)
    SilentAimSettings.IndependentPanelPinned = value
    IndependentPanelFrame.Draggable = not value
end)
local ExtrasBox = Tabs.Visuals:AddRightGroupbox("额外")
ExtrasBox:AddToggle("HighlightToggle", { Text = "启用高亮", Default = SilentAimSettings.HighlightEnabled }):AddColorPicker("HighlightColorPicker", { Default = SilentAimSettings.HighlightColor, Title = "高亮颜色" })
Toggles.HighlightToggle:OnChanged(function(Value) SilentAimSettings.HighlightEnabled = Value end)
Options.HighlightColorPicker:OnChanged(function(Value) SilentAimSettings.HighlightColor = Value end)
ExtrasBox:AddToggle("HighlightRainbowToggle", { Text = "高亮彩虹色", Default = SilentAimSettings.HighlightRainbowEnabled }):OnChanged(function(Value) SilentAimSettings.HighlightRainbowEnabled = Value end)
ExtrasBox:AddToggle("DamageNotifierToggle", { Text = "显示伤害通知", Default = SilentAimSettings.ShowDamageNotifier }):OnChanged(function(Value) SilentAimSettings.ShowDamageNotifier = Value end)
ExtrasBox:AddDropdown('HitSound', { Text = '击中音效', Default = '关闭', Values = {'关闭', 'bell', 'metal', 'click', 'exp'} })
ExtrasBox:AddToggle("ShowTracerToggle", { Text = "显示目标追踪线", Default = SilentAimSettings.ShowTracer }):AddColorPicker("TracerColorPicker", { Default = tracer_line.Color, Title = "追踪线颜色" })
Toggles.ShowTracerToggle:OnChanged(function(Value) SilentAimSettings.ShowTracer = Value end)
Options.TracerColorPicker:OnChanged(function(Value) tracer_line.Color = Value end)
ExtrasBox:AddSlider('TracerYOffsetSlider', { Text = '追踪线Y轴偏移', Default = SilentAimSettings.Tracer_Y_Offset, Min = -10, Max = 10, Rounding = 3, Suffix = " studs" }):OnChanged(function(Value) SilentAimSettings.Tracer_Y_Offset = Value end)
local ManualLockGroupBox = Tabs.Management:AddLeftGroupbox("手动锁定")
ManualLockGroupBox:AddDropdown("TargetSelectorDropdown", { Text = "锁定目标 (无=自动)", Default = "无", Values = {"无"} }):OnChanged(function(selectedName)
    if selectedName == "无" then
        lockedTargetObject = nil
    else
        lockedTargetObject = targetMap[selectedName]
    end
end)
ManualLockGroupBox:AddButton("刷新列表", function()
    targetMap = {}
    local targetNames = {"无"}
    local targetMode = SilentAimSettings.TargetMode
    if targetMode == "NPC" or targetMode == "所有" then
        updateNPCs()
    end
    if targetMode == "玩家" or targetMode == "所有" then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                if not (SilentAimSettings.TeamCheck and player.Team == LocalPlayer.Team) then
                    table.insert(targetNames, player.Name)
                    targetMap[player.Name] = player
                end
            end
        end
    end
    if targetMode == "NPC" or targetMode == "所有" then
        for _, npc in ipairs(npcList) do
            if npc and npc.Name and npc.PrimaryPart then
                table.insert(targetNames, npc.Name)
                targetMap[npc.Name] = npc
            end
        end
    end
    Options.TargetSelectorDropdown:SetValues(targetNames, "无")
    lockedTargetObject = nil
end)
local NameTargetingGroup = Tabs.Management:AddLeftGroupbox("名称索敌")
NameTargetingGroup:AddToggle("EnableNameTargetingToggle", { Text = "启用名称索敌", Default = SilentAimSettings.EnableNameTargeting }):OnChanged(function(Value)
    SilentAimSettings.EnableNameTargeting = Value
end)
local whitelistDataOption = NameTargetingGroup:AddInput("WhitelistData", { Text = "Whitelist Internal Data", Default = "[]" })
whitelistDataOption.Visible = false
local function updateWhitelistData()
    local jsonString = HttpService:JSONEncode(SilentAimSettings.WhitelistedNames)
    whitelistDataOption:SetValue(jsonString)
end
NameTargetingGroup:AddInput("WhitelistNameInput", { Text = "名称", PlaceholderText = "输入要锁定的NPC名称关键字" })
NameTargetingGroup:AddButton("添加到列表", function()
    local name = Options.WhitelistNameInput.Value
    if name and name ~= "" then
        table.insert(SilentAimSettings.WhitelistedNames, name)
        Options.WhitelistDropdown:SetValues(SilentAimSettings.WhitelistedNames)
        Options.WhitelistNameInput:SetValue("")
        updateWhitelistData()
    end
end)
NameTargetingGroup:AddDropdown("WhitelistDropdown", { Text = "名称列表", Values = SilentAimSettings.WhitelistedNames or {} })
NameTargetingGroup:AddButton("从列表中删除", function()
    local selectedName = Options.WhitelistDropdown.Value
    if selectedName then
        for i, name in ipairs(SilentAimSettings.WhitelistedNames) do
            if name == selectedName then
                table.remove(SilentAimSettings.WhitelistedNames, i)
                break
            end
        end
        Options.WhitelistDropdown:SetValues(SilentAimSettings.WhitelistedNames)
        updateWhitelistData()
    end
end)
whitelistDataOption:OnChanged(function(jsonString)
    if not jsonString or jsonString == "" then jsonString = "[]" end
    local success, decoded = pcall(HttpService.JSONDecode, HttpService, jsonString)
    if success and type(decoded) == 'table' then
        SilentAimSettings.WhitelistedNames = decoded
        Options.WhitelistDropdown:SetValues(SilentAimSettings.WhitelistedNames)
    end
end)
local WhitelistPathGroup = Tabs.Management:AddLeftGroupbox("白名单路径管理")
WhitelistPathGroup:AddInput("WhitelistPathInput", { Text = "路径", PlaceholderText = "输入从Workspace开始的路径" })
WhitelistPathGroup:AddButton("添加路径", function()
    local path = Options.WhitelistPathInput.Value
    if path and path ~= "" then
        table.insert(SilentAimSettings.WhitelistPath, path)
        Options.WhitelistPathDropdown:SetValues(SilentAimSettings.WhitelistPath)
        Options.WhitelistPathInput:SetValue("")
    end
end)
WhitelistPathGroup:AddDropdown("WhitelistPathDropdown", { Text = "路径列表", Values = SilentAimSettings.WhitelistPath or {} })
WhitelistPathGroup:AddButton("删除路径", function()
    local selectedPath = Options.WhitelistPathDropdown.Value
    if selectedPath then
        for i, p in ipairs(SilentAimSettings.WhitelistPath) do
            if p == selectedPath then
                table.remove(SilentAimSettings.WhitelistPath, i)
                break
            end
        end
        Options.WhitelistPathDropdown:SetValues(SilentAimSettings.WhitelistPath)
    end
end)
local BlacklistGroup = Tabs.Management:AddRightGroupbox("黑名单管理")
local blacklistDataOption = BlacklistGroup:AddInput("BlacklistData", { Text = "Blacklist Internal Data", Default = "[]" })
blacklistDataOption.Visible = false
local function updateBlacklistData()
    local jsonString = HttpService:JSONEncode(SilentAimSettings.BlacklistedNames)
    blacklistDataOption:SetValue(jsonString)
end
BlacklistGroup:AddInput("BlacklistNameInput", { Text = "名称", PlaceholderText = "输入要拉黑的精确名称" })
BlacklistGroup:AddButton("添加到黑名单", function()
    local name = Options.BlacklistNameInput.Value
    if name and name ~= "" and not isBlacklisted(name) then
        table.insert(SilentAimSettings.BlacklistedNames, name)
        Options.BlacklistDropdown:SetValues(SilentAimSettings.BlacklistedNames)
        Options.BlacklistNameInput:SetValue("")
        updateBlacklistData()
    end
end)
BlacklistGroup:AddDropdown("BlacklistDropdown", { Text = "黑名单列表", Values = SilentAimSettings.BlacklistedNames or {} })
BlacklistGroup:AddButton("从黑名单中删除", function()
    local selectedName = Options.BlacklistDropdown.Value
    if selectedName then
        for i, name in ipairs(SilentAimSettings.BlacklistedNames) do
            if name == selectedName then
                table.remove(SilentAimSettings.BlacklistedNames, i)
                break
            end
        end
        Options.BlacklistDropdown:SetValues(SilentAimSettings.BlacklistedNames)
        updateBlacklistData()
    end
end)
blacklistDataOption:OnChanged(function(jsonString)
    if not jsonString or jsonString == "" then jsonString = "[]" end
    local success, decoded = pcall(HttpService.JSONDecode, HttpService, jsonString)
    if success and type(decoded) == 'table' then
        SilentAimSettings.BlacklistedNames = decoded
        Options.BlacklistDropdown:SetValues(SilentAimSettings.BlacklistedNames)
    end
end)
local CharacterModGroup = Tabs.Misc:AddLeftGroupbox("角色修改")
local originalCharacterData = {}
local transparencyLoopConnection = nil
local function restoreCharacterAppearance()
    for part, data in pairs(originalCharacterData) do
        if part and part.Parent then
            part.Material = data.material
            part.Color = data.color
            part.Transparency = data.transparency
        end
    end
    originalCharacterData = {}
end
local function transparencyLoop()
    if not LocalPlayer.Character then
        if next(originalCharacterData) then
            originalCharacterData = {}
        end
        return
    end
    local isRainbowEnabled = Toggles.TransparentCharacterRainbow.Value
    for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
        if part:IsA("BasePart") then
            if not originalCharacterData[part] then
                originalCharacterData[part] = {
                    material = part.Material,
                    color = part.Color,
                    transparency = part.Transparency
                }
            end
            part.Material = Enum.Material.ForceField
            if isRainbowEnabled then
                part.Color = rainbowColor
            else
                part.Color = originalCharacterData[part].color
            end
        end
    end
end
CharacterModGroup:AddToggle("TransparentCharacterEnabled", { Text = "人物透明", Default = false }):OnChanged(function(value)
    if value then
        transparencyLoopConnection = RunService.Heartbeat:Connect(transparencyLoop)
    else
        if transparencyLoopConnection then
            transparencyLoopConnection:Disconnect()
            transparencyLoopConnection = nil
        end
        restoreCharacterAppearance()
    end
end)
CharacterModGroup:AddToggle("TransparentCharacterRainbow", { Text = "人物变色", Default = false }):OnChanged(function(value)
    if not value and Toggles.TransparentCharacterEnabled.Value then
        restoreCharacterAppearance()
        task.wait()
        transparencyLoop()
    end
end)
local EntertainmentGroup = Tabs.Misc:AddLeftGroupbox("娱乐")
local spinThread = nil
local spinEnabled = false
local spinSpeed = math.rad(10)
local function spinCharacter()
    while spinEnabled and task.wait() do
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = hrp.CFrame * CFrame.Angles(0, spinSpeed, 0)
        else
            break
        end
    end
    spinThread = nil
end
EntertainmentGroup:AddToggle("SpinToggle", { Text = "启用旋转", Default = false }):OnChanged(function(value)
    spinEnabled = value
    if spinEnabled and not spinThread then
        spinThread = coroutine.create(spinCharacter)
        coroutine.resume(spinThread)
    end
end)
EntertainmentGroup:AddSlider("SpinSpeedSlider", { Text = "旋转速度", Default = 10, Min = 1, Max = 100, Rounding = 0 }):OnChanged(function(value)
    spinSpeed = math.rad(value)
end)
FOVCircleGui.Enabled = Toggles.FOVVisibleToggle.Value
FOVStroke.Color = Options.FOVColorPicker.Value
FOVCircleFrame.Size = UDim2.fromOffset(Options.FOVRadiusSlider.Value * 2, Options.FOVRadiusSlider.Value * 2)
IndependentPanelFrame.Draggable = not SilentAimSettings.IndependentPanelPinned
task.spawn(function()
    while task.wait(2) do
        if SilentAimSettings.TargetMode == "NPC" or SilentAimSettings.TargetMode == "所有" then
            updateNPCs()
        end
    end
end)
local lastHealthValues = {}
local damageIndicators = {}
local DAMAGE_INDICATOR_FADE_TIME = 1
local pos = SilentAimSettings.IndependentPanelPosition:split(",")
IndependentPanelFrame.Position = UDim2.fromOffset(tonumber(pos[1]), tonumber(pos[2]))
local lastTargetCharacter = nil
local lockedRandomPart = nil
resume(create(function()
    RenderStepped:Connect(function()
        if SilentAimSettings.IndicatorRotationEnabled then currentRotationAngle = (currentRotationAngle + (SilentAimSettings.IndicatorRotationSpeed / 50)) % (math.pi * 2) end
        if SilentAimSettings.IndicatorRainbowEnabled or SilentAimSettings.HighlightRainbowEnabled or (Toggles.TransparentCharacterRainbow and Toggles.TransparentCharacterRainbow.Value) then currentIndicatorHue = (currentIndicatorHue + (SilentAimSettings.IndicatorRainbowSpeed / 200)) % 1 end
        local currentTime = tick()
        for i = #recentShots, 1, -1 do
            if currentTime - recentShots[i].time > 1 then
                table.remove(recentShots, i)
            end
        end
        local isEnabled = Toggles.EnabledToggle.Value
        currentTargetPart = nil
        local currentTargetCharacter = nil
        if isEnabled then
            if lockedTargetObject then
                 if lockedTargetObject.Parent and not isBlacklisted(lockedTargetObject.Name) then
                    if lockedTargetObject:IsA("Player") then
                        currentTargetCharacter = lockedTargetObject.Character
                    elseif lockedTargetObject:IsA("Model") then
                        currentTargetCharacter = lockedTargetObject
                    end
                else
                    lockedTargetObject = nil
                    Options.TargetSelectorDropdown:SetValue("无")
                end
            else
                local targetMode = SilentAimSettings.TargetMode
                local playerTarget, npcTarget
                if targetMode == "玩家" or targetMode == "所有" then playerTarget = getClosestPlayer() end
                if targetMode == "NPC" or targetMode == "所有" then npcTarget = getNPCTarget() end
                if playerTarget and npcTarget then
                    local priority = SilentAimSettings.PriorityMode
                    if priority == "最低血量" then
                        local pHumanoid = playerTarget:FindFirstChildOfClass("Humanoid")
                        local nHumanoid = npcTarget:FindFirstChildOfClass("Humanoid")
                        currentTargetCharacter = (pHumanoid and nHumanoid and pHumanoid.Health <= nHumanoid.Health) and playerTarget or npcTarget
                    else
                        local pDist = (LocalPlayer.Character.HumanoidRootPart.Position - playerTarget.HumanoidRootPart.Position).Magnitude
                        local nDist = (LocalPlayer.Character.HumanoidRootPart.Position - npcTarget.HumanoidRootPart.Position).Magnitude
                        currentTargetCharacter = pDist < nDist and playerTarget or npcTarget
                    end
                else
                    currentTargetCharacter = playerTarget or npcTarget
                end
            end
        end
        if currentTargetCharacter ~= lastTargetCharacter then
            lockedRandomPart = nil
        end
        lastTargetCharacter = currentTargetCharacter
        if currentTargetCharacter then
            local humanoid = currentTargetCharacter:FindFirstChildOfClass("Humanoid")
            if not humanoid or humanoid.Health <= 0 then
                if lockedTargetObject and lockedTargetObject:IsA("Model") and lockedTargetObject == currentTargetCharacter then
                    lockedTargetObject = nil
                    Options.TargetSelectorDropdown:SetValue("无")
                end
                currentTargetCharacter = nil
                currentTargetPart = nil
            else
                local baseTargetPart = nil
                if SilentAimSettings.LeakAndHitMode then
                    for _, part in ipairs(currentTargetCharacter:GetDescendants()) do
                        if part:IsA("BasePart") and part.Parent == currentTargetCharacter then
                            if isPartVisible(part) then
                                baseTargetPart = part
                                break
                            end
                        end
                    end
                else
                    local targetPartName = SilentAimSettings.TargetPart
                    if targetPartName == "Random" then
                        if not lockedRandomPart or not lockedRandomPart.Parent or lockedRandomPart.Parent ~= currentTargetCharacter then
                            lockedRandomPart = currentTargetCharacter[ValidTargetParts[math.random(1, #ValidTargetParts)]]
                        end
                        baseTargetPart = lockedRandomPart
                    else
                        baseTargetPart = currentTargetCharacter:FindFirstChild(targetPartName) or currentTargetCharacter:FindFirstChild("HumanoidRootPart")
                    end
                end
                if baseTargetPart then
                    if SilentAimSettings.HeadshotChanceEnabled and CalculateChance(SilentAimSettings.HeadshotChance) then
                        local headPart = currentTargetCharacter:FindFirstChild("Head")
                        if headPart then
                            currentTargetPart = headPart
                        else
                            currentTargetPart = baseTargetPart
                        end
                    else
                        currentTargetPart = baseTargetPart
                    end
                else
                    currentTargetPart = nil
                end
            end
        end
        if isEnabled and currentTargetPart then
            local humanoid = currentTargetPart.Parent:FindFirstChildOfClass("Humanoid")
            if humanoid then
                local currentHealth = humanoid.Health
                local lastHealth = lastHealthValues[humanoid]
                if lastHealth and currentHealth < lastHealth then
                    local damage = math.floor(lastHealth - currentHealth)
                    if damage > 0 then
                        if not pendingDamage[humanoid] then
                            pendingDamage[humanoid] = { damage = 0, lastUpdate = tick(), position = currentTargetPart.Position }
                        end
                        pendingDamage[humanoid].damage = pendingDamage[humanoid].damage + damage
                        pendingDamage[humanoid].lastUpdate = tick()
                        pendingDamage[humanoid].position = currentTargetPart.Position
                        local selectedSoundName = Options.HitSound.Value
                        if selectedSoundName ~= '关闭' then
                            local soundId = HitSounds[selectedSoundName]
                            if soundId then
                                playHitSound(soundId)
                            end
                        end
                    end
                end
                lastHealthValues[humanoid] = currentHealth
            end
        end
        local DAMAGE_ACCUMULATION_WINDOW = 0.15
        for humanoid, data in pairs(pendingDamage) do
            if currentTime - data.lastUpdate > DAMAGE_ACCUMULATION_WINDOW then
                if SilentAimSettings.ShowDamageNotifier and data.damage > 0 then
                    local screenPos, onScreen = getPositionOnScreen(data.position)
                    if onScreen then
                        local indicator = {};
                        indicator.Created = tick();
                        indicator.Position = screenPos;
                        indicator.TextObject = Drawing.new("Text")
                        indicator.TextObject.Font = Drawing.Fonts.Monospace;
                        indicator.TextObject.Text = string.format("-%d", data.damage)
                        indicator.TextObject.Color = Color3.fromRGB(255, 50, 50);
                        indicator.TextObject.Size = 20
                        indicator.TextObject.Center = true;
                        indicator.TextObject.Outline = true
                        table.insert(damageIndicators, indicator)
                    end
                end
                pendingDamage[humanoid] = nil
            end
        end
        for i = #damageIndicators, 1, -1 do
            local indicator = damageIndicators[i]; local age = tick() - indicator.Created
            if age > DAMAGE_INDICATOR_FADE_TIME then
                indicator.TextObject:Remove(); table.remove(damageIndicators, i)
            else
                local progress = age / DAMAGE_INDICATOR_FADE_TIME
                indicator.TextObject.Position = indicator.Position - Vector2.new(0, progress * 40)
                indicator.TextObject.Transparency = progress; indicator.TextObject.Visible = true
            end
        end
        hideAllVisuals()
        if currentHighlight and (not currentTargetCharacter or not SilentAimSettings.HighlightEnabled) then
            currentHighlight:Destroy()
            currentHighlight = nil
        end
        if isEnabled and currentTargetCharacter and SilentAimSettings.HighlightEnabled then
             if not currentHighlight then
                currentHighlight = Instance.new("Highlight")
                currentHighlight.Parent = currentTargetCharacter
            end
            currentHighlight.Adornee = currentTargetCharacter
            currentHighlight.Enabled = true
            currentHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            if SilentAimSettings.HighlightRainbowEnabled then
                local rainbowColor = Color3.fromHSV(currentIndicatorHue, 1, 1)
                currentHighlight.FillColor = rainbowColor
                currentHighlight.OutlineColor = rainbowColor
                currentHighlight.FillTransparency = 0.5
                currentHighlight.OutlineTransparency = 0
            else
                currentHighlight.FillColor = SilentAimSettings.HighlightColor
                currentHighlight.OutlineColor = SilentAimSettings.HighlightColor
                currentHighlight.FillTransparency = 0.5
                currentHighlight.OutlineTransparency = 0
            end
        end
        if isEnabled and currentTargetPart then
            local RootToViewportPoint, IsOnScreen = getPositionOnScreen(currentTargetPart.Position)
            if IsOnScreen and Toggles.ShowTargetToggle.Value then
                local indicatorRadius = SilentAimSettings.TargetIndicatorRadius
                local indicatorStyle = Options.IndicatorStyleDropdown.Value
                local finalIndicatorColor; local isTargetVisible = isPartVisible(currentTargetPart)
                if isTargetVisible then finalIndicatorColor = Color3.fromRGB(0, 255, 0); indicatorRadius = indicatorRadius * 0.6
                elseif SilentAimSettings.IndicatorRainbowEnabled then finalIndicatorColor = Color3.fromHSV(currentIndicatorHue, 1, 1)
                else finalIndicatorColor = Options.TargetIndicatorColorPicker.Value end
                local breathingScale = 1
                if SilentAimSettings.IndicatorBreathingEnabled then
                    breathingScale = SilentAimSettings.IndicatorBreathingMin + 
                                     (SilentAimSettings.IndicatorBreathingMax - SilentAimSettings.IndicatorBreathingMin) * 
                                     (math.sin(tick() * SilentAimSettings.IndicatorBreathingSpeed * math.pi * 2) * 0.5 + 0.5)
                end
                if indicatorStyle == "Circle" then
                    target_indicator_circle.Visible = true; target_indicator_circle.Color = finalIndicatorColor; target_indicator_circle.Radius = indicatorRadius * breathingScale; target_indicator_circle.Position = RootToViewportPoint
                elseif indicatorStyle == "Triangle" then
                    local points = getPolygonPoints(RootToViewportPoint, indicatorRadius * breathingScale, 3)
                    for i = 1, 3 do local line = target_indicator_lines[i]; line.Visible = true; line.Color = finalIndicatorColor; line.From = points[i]; line.To = points[i % 3 + 1] end
                elseif indicatorStyle == "Pentagram" then
                    local points = getPolygonPoints(RootToViewportPoint, indicatorRadius * breathingScale, 5)
                    local pentagram_order = {1, 3, 5, 2, 4}
                    for i = 1, 5 do local line = target_indicator_lines[i]; line.Visible = true; line.Color = finalIndicatorColor; line.From = points[pentagram_order[i]]; line.To = points[pentagram_order[i % 5 + 1]] end
                elseif indicatorStyle == "十字准星" then
                    local length = SilentAimSettings.CrosshairLength * breathingScale
                    local gap = SilentAimSettings.CrosshairGap * breathingScale
                    local center = RootToViewportPoint
                    local rotation = SilentAimSettings.IndicatorRotationEnabled and currentRotationAngle or 0
                    local cos, sin = math.cos(rotation), math.sin(rotation)
                    local function rotate(v)
                        return Vector2.new(v.X * cos - v.Y * sin, v.X * sin + v.Y * cos)
                    end
                    local points = {
                        {From = rotate(Vector2.new(0, -length)) + center, To = rotate(Vector2.new(0, -gap)) + center},
                        {From = rotate(Vector2.new(0, length)) + center, To = rotate(Vector2.new(0, gap)) + center},
                        {From = rotate(Vector2.new(-length, 0)) + center, To = rotate(Vector2.new(-gap, 0)) + center},
                        {From = rotate(Vector2.new(length, 0)) + center, To = rotate(Vector2.new(gap, 0)) + center}
                    }
                    for i = 1, 4 do
                        target_indicator_lines[i].Visible = true
                        target_indicator_lines[i].Color = finalIndicatorColor
                        target_indicator_lines[i].From = points[i].From
                        target_indicator_lines[i].To = points[i].To
                    end
                elseif indicatorStyle == "三线准星" and SilentAimSettings.ThreeLineCrosshairEnabled then
                    local length = SilentAimSettings.ThreeLineCrosshairLength * breathingScale
                    local gap = SilentAimSettings.ThreeLineCrosshairGap * breathingScale
                    local center = RootToViewportPoint
                    local rotation = SilentAimSettings.IndicatorRotationEnabled and currentRotationAngle or 0
                    for i = 1, 3 do
                        local angle = rotation + (i - 1) * (math.pi * 2 / 3)
                        local dir = Vector2.new(math.cos(angle), math.sin(angle))
                        local start = center + dir * gap
                        local endPos = center + dir * length
                        target_indicator_lines[i].Visible = true
                        target_indicator_lines[i].Color = finalIndicatorColor
                        target_indicator_lines[i].From = start
                        target_indicator_lines[i].To = endPos
                    end
                end
            end
            local showAnyInfo = Toggles.ShowTargetNameToggle.Value or Toggles.ShowTargetHealthToggle.Value or Toggles.ShowTargetDistanceToggle.Value or Toggles.ShowTargetCategoryToggle.Value
            if showAnyInfo then
                local player = Players:GetPlayerFromCharacter(currentTargetCharacter)
                local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                local humanoid = currentTargetCharacter:FindFirstChildOfClass("Humanoid")
                if humanoid and localRoot then
                    local targetName = player and player.DisplayName or currentTargetCharacter.Name
                    local health = math.floor(humanoid.Health)
                    local maxHealth = humanoid.MaxHealth
                    local dist = math.floor((localRoot.Position - currentTargetPart.Position).Magnitude)
                    local category = getTargetCategory(currentTargetCharacter)
                    local infoStyle = SilentAimSettings.TargetInfoStyle
                    if infoStyle == "独立面板" then
                        IndependentPanelFrame.Visible = true
                        independent_panel_texts.Name.Visible = Toggles.ShowTargetNameToggle.Value
                        independent_panel_texts.Health.Visible = Toggles.ShowTargetHealthToggle.Value
                        independent_panel_texts.Distance.Visible = Toggles.ShowTargetDistanceToggle.Value
                        independent_panel_texts.Category.Visible = Toggles.ShowTargetCategoryToggle.Value
                        if Toggles.ShowTargetNameToggle.Value then independent_panel_texts.Name.Text = "目标: " .. targetName end
                        if Toggles.ShowTargetHealthToggle.Value then independent_panel_texts.Health.Text = string.format("血量: %d", health) end
                        if Toggles.ShowTargetDistanceToggle.Value then independent_panel_texts.Distance.Text = string.format("距离: %dm", dist) end
                        if Toggles.ShowTargetCategoryToggle.Value then independent_panel_texts.Category.Text = "类别: " .. category end
                    elseif infoStyle == "面板" and IsOnScreen then
                        local indicatorRadius = SilentAimSettings.TargetIndicatorRadius
                        local linesDrawn = 0; local lineHeight = 15; local infoPos = RootToViewportPoint + Vector2.new(indicatorRadius + 5, -22)
                        if Toggles.ShowTargetNameToggle.Value then local textObj = panel_info_texts.Name; textObj.Text = targetName; textObj.Position = infoPos + Vector2.new(5, 5 + (linesDrawn * lineHeight)); textObj.Visible = true; linesDrawn = linesDrawn + 1 end
                        if Toggles.ShowTargetHealthToggle.Value then local textObj = panel_info_texts.Health; textObj.Text = string.format("血量: %d", health); textObj.Position = infoPos + Vector2.new(5, 5 + (linesDrawn * lineHeight)); textObj.Visible = true; linesDrawn = linesDrawn + 1 end
                        if Toggles.ShowTargetDistanceToggle.Value then local textObj = panel_info_texts.Distance; textObj.Text = string.format("距离: %dm", dist); textObj.Position = infoPos + Vector2.new(5, 5 + (linesDrawn * lineHeight)); textObj.Visible = true; linesDrawn = linesDrawn + 1 end
                        if Toggles.ShowTargetCategoryToggle.Value then local textObj = panel_info_texts.Category; textObj.Text = "类别: " .. category; textObj.Position = infoPos + Vector2.new(5, 5 + (linesDrawn * lineHeight)); textObj.Visible = true; linesDrawn = linesDrawn + 1 end
                        if linesDrawn > 0 then panel_info_bg.Position = infoPos; panel_info_bg.Size = Vector2.new(120, 10 + (linesDrawn * lineHeight)); panel_info_bg.Visible = true end
                    elseif infoStyle == "头顶" and IsOnScreen then
                        local indicatorRadius = SilentAimSettings.TargetIndicatorRadius
                        local linesDrawn = 0; local lineHeight = 15; local base_y = RootToViewportPoint.Y - indicatorRadius - 10
                        if Toggles.ShowTargetNameToggle.Value then local textObj = overhead_info_texts.Name; textObj.Text = string.format("[%s]", targetName); textObj.Position = Vector2.new(RootToViewportPoint.X, base_y - (linesDrawn * lineHeight)); textObj.Visible = true; linesDrawn = linesDrawn + 1 end
                        if Toggles.ShowTargetHealthToggle.Value then local textObj = overhead_info_texts.Health; textObj.Text = string.format("[%d]", health); textObj.Position = Vector2.new(RootToViewportPoint.X, base_y - (linesDrawn * lineHeight)); textObj.Visible = true; linesDrawn = linesDrawn + 1 end
                        if Toggles.ShowTargetDistanceToggle.Value then local textObj = overhead_info_texts.Distance; textObj.Text = string.format("[%dm]", dist); textObj.Position = Vector2.new(RootToViewportPoint.X, base_y - (linesDrawn * lineHeight)); textObj.Visible = true; linesDrawn = linesDrawn + 1 end
                        if Toggles.ShowTargetCategoryToggle.Value then local textObj = overhead_info_texts.Category; textObj.Text = string.format("[%s]", category); textObj.Position = Vector2.new(RootToViewportPoint.X, base_y - (linesDrawn * lineHeight)); textObj.Visible = true; linesDrawn = linesDrawn + 1 end
                    end
                end
            end
        elseif isEnabled then
            local infoStyle = SilentAimSettings.TargetInfoStyle
            if infoStyle == "独立面板" then
                IndependentPanelFrame.Visible = true
                independent_panel_texts.Name.Visible = true
                independent_panel_texts.Health.Visible = true
                independent_panel_texts.Distance.Visible = false
                independent_panel_texts.Category.Visible = false
                independent_panel_texts.Name.Text = "状态: 自动索敌中..."
                independent_panel_texts.Health.Text = "目标: 无"
            end
        end
        if Toggles.ShowTracerToggle.Value and isEnabled and currentTargetPart then
            local targetHead = currentTargetCharacter and currentTargetCharacter:FindFirstChild("Head")
            local tracerTargetPosition = (targetHead and targetHead.Position) or currentTargetPart.Position
            local y_offset = SilentAimSettings.Tracer_Y_Offset
            local finalTracerPosition = tracerTargetPosition - Vector3.new(0, y_offset, 0)
            local targetScreenPos, IsOnScreen = getPositionOnScreen(finalTracerPosition)
            tracer_line.Visible = IsOnScreen
            if IsOnScreen then tracer_line.From = Camera.ViewportSize / 2; tracer_line.To = targetScreenPos; tracer_line.Color = Options.TracerColorPicker.Value end
        else
            tracer_line.Visible = false
        end
        if Toggles.FOVVisibleToggle.Value then
            if Toggles.FixedFOVToggle.Value then FOVCircleFrame.Position = UDim2.fromScale(0.5, 0.5) else local mousePos = GetMouseLocation(UserInputService); FOVCircleFrame.Position = UDim2.fromOffset(mousePos.X, mousePos.Y) end
        end
    end)
end))
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    if not SilentAimSettings.Enabled or checkcaller() then return oldNamecall(...) end
    local Method = getnamecallmethod()
    local Arguments = {...}
    local self = Arguments[1]
    if CalculateChance(SilentAimSettings.HitChance) and currentTargetPart then
        local currentMethod = SilentAimSettings.SilentAimMethod
        local shotOrigin = nil
        if (Method == "FindPartOnRayWithIgnoreList" and currentMethod == Method) or
           (Method == "FindPartOnRayWithWhitelist" and currentMethod == Method) or
           ((Method == "FindPartOnRay" or Method == "findPartOnRay") and currentMethod:lower() == Method:lower()) then
            if ValidateArguments(Arguments, ExpectedArguments[Method] or ExpectedArguments["FindPartOnRay"]) then
                shotOrigin = Arguments[2].Origin
                table.insert(recentShots, {origin = shotOrigin, time = tick()})
                if SilentAimSettings.Wallbang then
                    return currentTargetPart, currentTargetPart.Position, currentTargetPart.CFrame.LookVector, currentTargetPart.Material
                end
                Arguments[2] = Ray.new(Arguments[2].Origin, getDirection(Arguments[2].Origin, currentTargetPart.Position))
                return oldNamecall(unpack(Arguments))
            end
        elseif Method == "Raycast" and currentMethod == Method then
            if ValidateArguments(Arguments, ExpectedArguments.Raycast) then
                shotOrigin = Arguments[2]
                table.insert(recentShots, {origin = shotOrigin, time = tick()})
                if SilentAimSettings.Wallbang then
                    local direction = getDirection(shotOrigin, currentTargetPart.Position)
                    local wallbangParams = RaycastParams.new()
                    wallbangParams.FilterType = Enum.RaycastFilterType.Include
                    wallbangParams.FilterDescendantsInstances = {currentTargetPart.Parent}
                    local newArgs = {self, shotOrigin, direction, wallbangParams}
                    return oldNamecall(unpack(newArgs))
                end
                Arguments[3] = getDirection(Arguments[2], currentTargetPart.Position)
                return oldNamecall(unpack(Arguments))
            end
        elseif (Method == "ScreenPointToRay" or Method == "ViewportPointToRay") and currentMethod == Method and self == Camera then
            shotOrigin = Camera.CFrame.Position
            local direction = (currentTargetPart.Position - shotOrigin).Unit
            table.insert(recentShots, {origin = shotOrigin, time = tick()})
            return Ray.new(shotOrigin, direction)
        end
    end
    return oldNamecall(...)
end))
local oldIndex
local oldRayNew
oldIndex = hookmetamethod(game, "__index", newcclosure(function(self, Index)
    if not SilentAimSettings.Enabled or checkcaller() or self ~= Mouse then return oldIndex(self, Index) end
    if SilentAimSettings.SilentAimMethod == "Mouse.Hit/Target" and currentTargetPart then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
                table.insert(recentShots, {origin = LocalPlayer.Character.Head.Position, time = tick()})
            end
            if Index == "Target" or Index == "target" then
                return currentTargetPart
            elseif Index == "Hit" or Index == "hit" then
                return (SilentAimSettings.MouseHitPrediction and (currentTargetPart.CFrame + (currentTargetPart.Velocity * currentTargetPart.Velocity.magnitude * SilentAimSettings.MouseHitPredictionAmount))) or currentTargetPart.CFrame
            elseif Index == "X" or Index == "x" then
                return self.X
            elseif Index == "Y" or Index == "y" then
                return self.Y
            elseif Index == "UnitRay" then
                return Ray.new(self.Origin, (self.Hit.p - self.Origin.p).Unit)
            end
    end
    return oldIndex(self, Index)
end))
oldRayNew = hookfunction(Ray.new, newcclosure(function(origin, direction)
    if not SilentAimSettings.Enabled or checkcaller() or SilentAimSettings.SilentAimMethod ~= "Ray" or not currentTargetPart or not CalculateChance(SilentAimSettings.HitChance) then
        return oldRayNew(origin, direction)
    end
    table.insert(recentShots, {origin = origin, time = tick()})
    local newDirectionVector = getDirection(origin, currentTargetPart.Position)
    return oldRayNew(origin, newDirectionVector)
end))
Library:OnUnload(function()
    FOVCircleGui:Destroy()
    if IndependentPanelGui then
        IndependentPanelGui:Destroy()
    end
    if currentHighlight then
        currentHighlight:Destroy()
    end
    if transparencyLoopConnection then
        transparencyLoopConnection:Disconnect()
        transparencyLoopConnection = nil
        restoreCharacterAppearance()
    end
    hideAllVisuals()
    oldNamecall:UnHook()
    oldIndex:UnHook()
    oldRayNew:UnHook()
end)
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })
SaveManager:SetFolder("UniversalSilentAim/Configs")
SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])
SaveManager:LoadAutoloadConfig()
    end
})
Tabs.Lemon:Paragraph({
    Title = "柠檬脚本:",
    Desc = "备注",
    Image = "https://play-lh.googleusercontent.com/7cIIPlWm4m7AGqVpEsIfyL-HW4cQla4ucXnfalMft1TMIYQIlf2vqgmthlZgbNAQoaQ",
    ImageSize = 20,
    ThumbnailSize = 120
})
Tabs.Lemon:Button({
    Title = "卖柠檬1",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Fluxyyy333/HoshiOnTop/main/loader.lua"))()
    end
})
Tabs.Lemon:Button({
    Title = "卖柠檬2",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Kenniel123/Sell-Lemons/refs/heads/main/Sell%20Lemons"))()
    end
})
Tabs.Lemon:Button({
    Title = "卖柠檬3",
    Callback = function()
        loadstring(game:HttpGet("https://rblxscripts.net/raw/axonic-hub-best-script-76ab7a48"))()
    end
})
Tabs.Lucky:Paragraph({
    Title = "踢一个幸运的方块:",
    Desc = "",
    Image = "https://play-lh.googleusercontent.com/7cIIPlWm4m7AGqVpEsIfyL-HW4cQla4ucXnfalMft1TMIYQIlf2vqgmthlZgbNAQoaQ",
    ImageSize = 20,
    ThumbnailSize = 120
})
Tabs.Lucky:Button({
    Title = "踢幸运方块1",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/d130dee84ed1d9ccecfd6a91fc49665b.lua"))()
    end
})
Tabs.Lucky:Button({
    Title = "踢幸运方块2",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/KickaLuckyBlock"))()
    end
})
Tabs.MiniWar:Paragraph({
    Title = "迷你战争:",
    Desc = "自动收集选定物品，按自定义市场价格条件出售，升级技能，根据优先级攻击敌人，并领取任务奖励。它还包括突袭追踪、可调节延迟、过滤销售、传送选项、商店工具、服务器功能、杂项工具以及可配置的设置标签页",
    Image = "https://play-lh.googleusercontent.com/7cIIPlWm4m7AGqVpEsIfyL-HW4cQla4ucXnfalMft1TMIYQIlf2vqgmthlZgbNAQoaQ",
    ImageSize = 20,
    ThumbnailSize = 120
})
Tabs.MiniWar:Button({
    Title = "迷你战争1",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LynX99-9/komtolmmek2script/refs/heads/main/CyraaHub.lua", true))()
    end
})
Tabs.doors:Paragraph({
    Title = "doors:",
    Desc = "功能较多",
    Image = "https://play-lh.googleusercontent.com/7cIIPlWm4m7AGqVpEsIfyL-HW4cQla4ucXnfalMft1TMIYQIlf2vqgmthlZgbNAQoaQ",
    ImageSize = 20,
    ThumbnailSize = 120
})
Tabs.doors:Button({
    Title = "doors1",
    Callback = function()
        loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/ef9b5a30ec84e201b585c3ef1850d264b216441eab77257f0e9184de826cc47e/download"))()
    end
})
Tabs.doors:Button({
    Title = "doors2",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ROSHANDVS2/ROSHAN-HUB-SCRIPTS/refs/heads/main/ROSHAN-DOORS-PAGUE-HUB.lua"))()
    end
})
Tabs.dao:Paragraph({
    Title = "刀刃球:",
    Desc = "备注",
    Image = "https://play-lh.googleusercontent.com/7cIIPlWm4m7AGqVpEsIfyL-HW4cQla4ucXnfalMft1TMIYQIlf2vqgmthlZgbNAQoaQ",
    ImageSize = 20,
    ThumbnailSize = 120
})
Tabs.dao:Button({
    Title = "刀刃球1",
    Callback = function()
        loadstring(game:HttpGet('https://levi-hub-x.vercel.app/Loader.lua'))()
    end
})
Tabs.dao:Button({
    Title = "刀刃球2",
    Callback = function()
        loadstring(game:HttpGet('https://levi-hub-x.vercel.app/Loader.lua'))()
    end
})
Tabs.shen99:Paragraph({
    Title = "99:",
    Desc = "🌲 树光环重做，⚔️ 杀戮光环滑块变化，📦 Bring Items 重做，🧭 传送清理，🎥 免费摄像头修复，🏃 玩家模组修复，🛰️ ESP清理，🌲 树光环重做",
    Image = "https://play-lh.googleusercontent.com/7cIIPlWm4m7AGqVpEsIfyL-HW4cQla4ucXnfalMft1TMIYQIlf2vqgmthlZgbNAQoaQ",
    ImageSize = 20,
    ThumbnailSize = 120
})
Tabs.shen99:Button({
    Title = "99-1",
    Callback = function()
        loadstring(game:HttpGet("https://rblxscripts.net/raw/99-nights-in-the-forest-foxname-bring-items-god-mode-auto-gr-f4e6400e"))()
    end
})
Tabs.shen99:Button({
    Title = "99-2",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Iceware-RBLX/Roblox/refs/heads/main/loader.lua", true))()
    end
})
Tabs.shen99:Button({
    Title = "99-3",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Kenniel123/99-Nights-in-the-Forest/refs/heads/main/99%20Nights%20in%20the%20Forest"))()
    end
})
local moshaSection = Tabs.mosha:Section({ Title = "谋杀悬疑2", Opened = true })
moshaSection:Paragraph({
    Title = "谋杀悬疑2:",
    Desc = "",
    Image = "https://play-lh.googleusercontent.com/7cIIPlWm4m7AGqVpEsIfyL-HW4cQla4ucXnfalMft1TMIYQIlf2vqgmthlZgbNAQoaQ",
    ImageSize = 20,
    ThumbnailSize = 120
})
moshaSection:Button({
    Title = "谋杀悬疑1",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ultimatep568/Spark-Hub/refs/heads/main/SparkHub_Loader.lua"))()
    end
})
moshaSection:Button({
    Title = "谋杀悬疑2",
    Callback = function()
        loadstring(game:HttpGet('https://raw.smokingscripts.org/vertex.lua'))()
    end
})
moshaSection:Button({
    Title = "谋杀悬疑3",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ultimatep568/Spark-Hub/refs/heads/main/SparkHub_Loader.lua"))()
    end
})
moshaSection:Button({
    Title = "谋杀悬疑4",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/renardofficiel/game/refs/heads/main/MurderMystery2/main.lua", true))()
    end
})
local fwq = {}
Tabs.fwq:Button({
    Title = "🗡️刀战竞技场🗡️",
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/gerelyncontiga-dot/343f67d6e26d379b9757154b05b88962/raw/e4d8410be86143d2de412eda78f644181c0ca464/Knife%2520Areccna"))()
    end
})
Tabs.fwq:Button({
    Title = "手枪竞技场",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/shoqiang.lua"))()
    end
})
Tabs.fwq:Button({
    Title = "💎多成员坦克战💎",
    Callback = function()
       loadstring(game:HttpGet("https://pastebin.com/raw/J1z1z0kB"))()
    end
})
Tabs.fwq:Button({
    Title = "❤️画画还是寻找",
    Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/c2rpt/Paint-or-seek/refs/heads/main/Main"))()
    end
})
Tabs.fwq:Button({
    Title = "城镇",
    Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/xlebaaa3-netizen/cryo/refs/heads/main/TownLoader"))()
    end
})
Tabs.fwq:Button({
    Title = "竞争对手",
    Callback = function()
loadstring(game:HttpGet("https://aetherea.lol/Beta.luau"))()
    end
})
Tabs.fwq:Button({
    Title = "偷走一个脑红",
    Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()
    end
})
local JS = {}
JS.autoXP = false
Tabs.JiSuChuanQi:Toggle({
    Title = "自动刷经验 150",
    Desc = "城市内使用",
    Value = false,
    Callback = function(state)
        JS.autoXP = state
        if state then
            task.spawn(function()
                while JS.autoXP do
                    local orbEvent = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("orbEvent")
                    if orbEvent then
                        for _ = 1, 18 do
                            orbEvent:FireServer("collectOrb", "Orange Orb", "City")
                        end
                    end
                    task.wait(0.1)
                end
            end)
        end
    end
})
JS.cssdkq = false
local speedLoop = nil
Tabs.JiSuChuanQi:Toggle({
    Title = "自动刷速度(城市)",
    Desc = "城市内使用",
    Value = false,
    Callback = function(state)
        JS.cssdkq = state
        if speedLoop then
            task.cancel(speedLoop)
            speedLoop = nil
        end
        if state then
            speedLoop = task.spawn(function()
                while JS.cssdkq and task.wait(0.15) do
                    local orbEvent = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("orbEvent")
                    if orbEvent then
                        for _ = 1, 18 do
                            orb:FireServer("collectOrb", "Red Orb", "City")
                            task.wait(0.01)
                        end
                    end
                end
            end)
        end
        WindUI:Notify({
            Title = "HB：",
            Content = state and "已开启自动刷速度(城市)" or "已关闭自动刷速度(城市)",
            Icon = state and "check" or "x",
            Duration = 2
        })
    end
})
JS.bxsdkq = false
Tabs.JiSuChuanQi:Toggle({
    Title = "自动刷速度(白雪城市)",
    Desc = "白雪城市内使用",
    Value = false,
    Callback = function(state)
        JS.bxsdkq = state
        if state then
            task.spawn(function()
                while JS.bxsdkq do
                    local orbEvent = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("orbEvent")
                    if orbEvent then
                        for _ = 1, 18 do
                            orbEvent:FireServer("collectOrb", "Red Orb", "Snow City")
                        end
                    end
                    task.wait(0.0001)
                end
            end)
        end
        WindUI:Notify({
            Title = "HB: ",
            Content = state and "已开启自动刷速度(白雪城市)" or "已关闭自动刷速度(白雪城市)",
            Icon = state and "check" or "x",
            Duration = 2
        })
    end
})
JS.dysdkq = false
Tabs.JiSuChuanQi:Toggle({
    Title = "自动刷速度(岩浆城市)",
    Desc = "岩浆城市内使用",
    Value = false,
    Callback = function(state)
        JS.dysdkq = state
        if state then
            task.spawn(function()
                while JS.dysdkq do
                    local orbEvent = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("orbEvent")
                    if orbEvent then
                        for _ = 1, 16 do
                            orbEvent:FireServer("collectOrb", "Red Orb", "Magma City")
                        end
                    end
                    task.wait(0.0001)
                end
            end)
        end
        WindUI:Notify({
            Title = "HB：",
            Content = state and "已开启自动刷速度(岩浆城市)" or "已关闭自动刷速度(岩浆城市)",
            Icon = state and "check" or "x",
            Duration = 2
        })
    end
})
JS.cqsdkq = false
Tabs.JiSuChuanQi:Toggle({
    Title = "自动刷速度(传奇公路)",
    Desc = "传奇公路内使用",
    Value = false,
    Callback = function(state)
        JS.cqsdkq = state
        if state then
            task.spawn(function()
                while JS.cqsdkq do
                    local orbEvent = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("orbEvent")
                    if orbEvent then
                        for _ = 1, 16 do
                            orbEvent:FireServer("collectOrb", "Red Orb", "Legends Highway")
                        end
                    end
                    task.wait(0.0001)
                end
            end)
        end
        WindUI:Notify({
            Title = "HB：",
            Content = state and "已开启自动刷速度(传奇公路)" or "已关闭自动刷速度(传奇公路)",
            Icon = state and "check" or "x",
            Duration = 2
        })
    end
})
Tabs.JiSuChuanQi:Divider()
JS.cskq = false
Tabs.JiSuChuanQi:Toggle({
    Title = "自动重生",
    Desc = "可重生时将自动重生",
    Value = false,
    Callback = function(state)
        JS.cskq = state
        if state then
            task.spawn(function()
                while JS.cskq do
                    local rebirthEvent = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("rebirthEvent")
                    if rebirthEvent then
                        rebirthEvent:FireServer("rebirthRequest")
                    end
                    task.wait(0.0001)
                end
            end)
        end
        WindUI:Notify({
            Title = "HB：",
            Content = state and "已开启自动重生" or "已关闭自动重生",
            Icon = state and "check" or "x",
            Duration = 2
        })
    end
})
Tabs.JiSuChuanQi:Divider()
JS.cszskq = false
Tabs.JiSuChuanQi:Toggle({
    Title = "自动刷钻石(城市)",
    Desc = "城市内使用",
    Value = false,
    Callback = function(state)
        JS.cszskq = state
        if state then
            task.spawn(function()
                while JS.cszskq do
                    local orbEvent = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("orbEvent")
                    if orbEvent then
                        for _ = 1, 20 do
                            orbEvent:FireServer("collectOrb", "Gem", "City")
                        end
                    end
                    task.wait(0.0001)
                end
            end)
        end
        WindUI:Notify({
            Title = "HB：",
            Content = state and "已开启自动刷钻石(城市)" or "已关闭自动刷钻石(城市)",
            Icon = state and "check" or "x",
            Duration = 2
        })
    end
})
JS.bxzskq = false
Tabs.JiSuChuanQi:Toggle({
    Title = "自动刷钻石(白雪城市)",
    Desc = "白雪城市内使用",
    Value = false,
    Callback = function(state)
        JS.bxzskq = state
        if state then
            task.spawn(function()
                while JS.bxzskq do
                    local orbEvent = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("orbEvent")
                    if orbEvent then
                        for _ = 1, 20 do
                            orbEvent:FireServer("collectOrb", "Gem", "Snow City")
                        end
                    end
                    task.wait(0.0001)
                end
            end)
        end
        WindUI:Notify({
            Title = "HB：",
            Content = state and "已开启自动刷钻石(白雪城市)" or "已关闭自动刷钻石(白雪城市)",
            Icon = state and "check" or "x",
            Duration = 2
        })
    end
})
JS.yjzskq = false
Tabs.JiSuChuanQi:Toggle({
    Title = "自动刷钻石(岩浆城市)",
    Desc = "岩浆城市内使用",
    Value = false,
    Callback = function(state)
        JS.yjzskq = state
        if state then
            task.spawn(function()
                while JS.yjzskq do
                    local orbEvent = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("orbEvent")
                    if orbEvent then
                        for _ = 1, 20 do
                            orbEvent:FireServer("collectOrb", "Gem", "Magma City")
                        end
                    end
                    task.wait(0.0001)
                end
            end)
        end
        WindUI:Notify({
            Title = "HB：",
            Content = state and "已开启自动刷钻石(岩浆城市)" or "已关闭自动刷钻石(岩浆城市)",
            Icon = state and "check" or "x",
            Duration = 2
        })
    end
})
JS.cqzskq = false
Tabs.JiSuChuanQi:Toggle({
    Title = "自动刷钻石(传奇公路)",
    Desc = "传奇公路内使用",
    Value = false,
    Callback = function(state)
        JS.cqzskq = state
        if state then
            task.spawn(function()
                while JS.cqzskq do
                    local orbEvent = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("orbEvent")
                    if orbEvent then
                        for _ = 1, 20 do
                            orbEvent:FireServer("collectOrb", "Gem", "Legends Highway")
                        end
                    end
                    task.wait(0.0001)
                end
            end)
        end
        WindUI:Notify({
            Title = "HB：",
            Content = state and "已开启自动刷钻石(传奇公路)" or "已关闭自动刷钻石(传奇公路)",
            Icon = state and "check" or "x",
            Duration = 2
        })
    end
})
local qPoints = {
    CFrame.new(-278.8976135253906, 66.09315490722656, -10946.564453125),
    CFrame.new(3980.05029296875, 159.91925048828125, 5589.21533203125),
    CFrame.new(137.6853485107422, 75.40111541748047, -5972.4873046875),
    CFrame.new(-15376.439453125, 412.2984619140625, 4475.322265625),
    CFrame.new(-489.440673828125, 98.277099609375, 2502.03564453125),
    CFrame.new(-15167.5068359375, 382.1965026855469, 4888.2900390625),
    CFrame.new(2094.217041015625, 251.98931884765625, 12877.951171875),
    CFrame.new(-1645.1728515625, 69.02545928955078, 5337.923828125),
    CFrame.new(-13254.447265625, 222.44158935546875, 4891.56005859375),
    CFrame.new(-533.439208984375, 58.4377326965332, 209.794921875),
    CFrame.new(473.2319641113281, 66.08084106445312, -10867.8388671875),
    CFrame.new(2333.369873046875, 161.6602325439453, 13369.1240234375),
    CFrame.new(5392.5322265625, 297.8348388671875, 5885.2138671875),
    CFrame.new(3806.247802734375, 299.41748046875, 7225.6806640625),
    CFrame.new(1664.3343505859375, 80.900390625, 12589.7109375),
    CFrame.new(1769.7236328125, 80.90105438232422, 12879.7958984375),
    CFrame.new(-11097.05859375, 200.84193420410156, 4465.34375),
    CFrame.new(-13140.974609375, 200.84193420410156, 4465.39599609375),
    CFrame.new(-536.3781127929688, 58.43798065185547, -133.1399688720703),
    CFrame.new(2485.461181640625, 135.55299377441406, 12384.6455078125),
    CFrame.new(1173.287109375, 92.03070831298828, -6024.24365234375),
    CFrame.new(-85.52466583251953, 115.9759750366211, -107.73560333251953),
    CFrame.new(1805.7076416015625, 90.94168853759766, 4617.30712890625),
    CFrame.new(-350.6163330078125, 66.06715393066406, -8732.2490234375),
    CFrame.new(5666.32861328125, 326.5240478515625, 6494.826171875),
    CFrame.new(4516.66845703125, 221.20545959472656, 7181.7421875),
    CFrame.new(-1746.5504150390625, 150.5835418701172, 5372.54248046875),
    CFrame.new(5361.96826171875, 297.8207092285156, 7025.44482421875),
    CFrame.new(4650.1669921875, 221.213134765625, 5608.54345703125),
    CFrame.new(-12993.1826171875, 200.82785034179688, 5222.71337890625),
    CFrame.new(355.5094299316406, 111.75679779052734, -10924.6923828125),
    CFrame.new(1942.0057373046875, 93.18344116210938, -2047.2164306640625),
    CFrame.new(-15156.52734375, 355.08978271484375, 4141.91357421875),
    CFrame.new(2062.114990234375, 159.88404846191406, 4374.28076171875),
    CFrame.new(230.04505920410156, 94.17676544189453, 80.71623229980469),
}
JS.sqkq = false
Tabs.JiSuChuanQi:Toggle({
    Title = "自动刷圈",
    Desc = "传奇公路内使用",
    Value = false,
    Callback = function(state)
        JS.sqkq = state
        if state then
            task.spawn(function()
                while JS.sqkq do
                    for _, zdsq in ipairs(qPoints) do
                        local char = getCharacter()
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = zdsq
                        end
                        task.wait(0.0001)
                    end
                    task.wait(0.0001)
                end
            end)
        else
            local char = getCharacter()
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(-568.6292114257812, 3.1723721027374268, 412.86492919921875)
            end
        end
        WindUI:Notify({
            Title = "HB：",
            Content = state and "已开启自动刷圈" or "已关闭自动刷圈",
            Icon = state and "check" or "x",
            Duration = 2
        })
    end
})
local function teleportTo(cframe)
    local char = getCharacter()
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = cframe
    end
    WindUI:Notify({
        Title = "HB：",
        Content = "传送成功",
        Icon = "bell",
        Duration = 3
    })
end
Tabs.JiSuChuanQi:Button({
    Title = "传送至城市（出生点）",
    Callback = function()
        teleportTo(CFrame.new(-568.6292114257812, 3.1723721027374268, 412.86492919921875))
    end
})
Tabs.JiSuChuanQi:Button({
    Title = "传送至神秘洞穴",
    Callback = function()
        teleportTo(CFrame.new(-9683.048828125, 58.352359771728516, 3136.626953125))
    end
})
Tabs.JiSuChuanQi:Button({
    Title = "传送至白雪城市",
    Callback = function()
        teleportTo(CFrame.new(-866.3868408203125, 3.222372055053711, 2165.70654296875))
    end
})
Tabs.JiSuChuanQi:Button({
    Title = "传送至地狱洞穴",
    Callback = function()
        teleportTo(CFrame.new(-11041.357421875, 58.352359771728516, 4111.8251953125))
    end
})
Tabs.JiSuChuanQi:Button({
    Title = "传送至熔岩城市",
    Callback = function()
        teleportTo(CFrame.new(1616.8270263671875, 3.2723801136016846, 4330.65234375))
    end
})
Tabs.JiSuChuanQi:Button({
    Title = "传送至水手路线",
    Callback = function()
        teleportTo(CFrame.new(-1618.4071044921875, 8.759234428405762, 4892.44091796875))
    end
})
Tabs.JiSuChuanQi:Button({
    Title = "传送至电光洞穴",
    Callback = function()
        teleportTo(CFrame.new(-13107.9892578125, 58.352359771728516, 4099.099609375))
    end
})
Tabs.JiSuChuanQi:Button({
    Title = "传送至传奇公路",
    Callback = function()
        teleportTo(CFrame.new(3673.601318359375, 70.75231170654297, 5588.7958984375))
    end
})
Tabs.JiSuChuanQi:Button({
    Title = "传送至丛林洞穴",
    Callback = function()
        teleportTo(CFrame.new(-15266.7880859375, 239.7072296142578, 3769.77490234375))
    end
})
JS.zdbskq = false
Tabs.JiSuChuanQi:Toggle({
    Title = "自动比赛",
    Desc = "当有比赛时自动参加比赛",
    Value = false,
    Callback = function(state)
        JS.zdbskq = state
        if state then
            task.spawn(function()
                while JS.zdbskq do
                    local raceEvent = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("raceEvent")
                    if raceEvent then
                        raceEvent:FireServer("joinRace")
                    end
                    task.wait(0.0001)
                end
            end)
        end
        WindUI:Notify({
            Title = "HB：",
            Content = state and "已开启自动比赛" or "已关闭自动比赛",
            Icon = state and "check" or "x",
            Duration = 2
        })
    end
})
JS.zdsdkq = false
Tabs.JiSuChuanQi:Toggle({
    Title = "自动刷速度V2",
    Desc = "可在任意地方使用（不稳定）",
    Value = false,
    Callback = function(state)
        JS.zdsdkq = state
        if state then
            task.spawn(function()
                while JS.zdsdkq do
                    local questsEvent = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("questsEvent")
                    if questsEvent then
                        for _ = 1, 20 do
                            questsEvent:FireServer("collectQuest", Instance.new("Folder", nil))
                        end
                    end
                    task.wait(0.0001)
                end
            end)
        end
        WindUI:Notify({
            Title = "HB：",
            Content = state and "已开启自动刷速度V2" or "已关闭自动刷速度V2",
            Icon = state and "check" or "x",
            Duration = 2
        })
    end
})
JS.mcwkq = false
Tabs.JiSuChuanQi:Toggle({
    Title = "自动买宠物",
    Desc = "快速获得宠物，消耗钻石",
    Value = false,
    Callback = function(state)
        JS.mcwkq = state
        if state then
            task.spawn(function()
                while JS.mcwkq do
                    local openCrystalRemote = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("openCrystalRemote")
                    if openCrystalRemote then
                        openCrystalRemote:InvokeServer("openCrystal", "Jungle Crystal")
                    end
                    task.wait(0.0001)
                end
            end)
        end
        WindUI:Notify({
            Title = "HB：",
            Content = state and "已开启自动买宠物" or "已关闭自动买宠物",
            Icon = state and "check" or "x",
            Duration = 2
        })
    end
})
JS.mwjkq = false
Tabs.JiSuChuanQi:Toggle({
    Title = "自动买尾迹",
    Desc = "快速获得尾迹，消耗钻石",
    Value = false,
    Callback = function(state)
        JS.mwjkq = state
        if state then
            task.spawn(function()
                while JS.mwjkq do
                    local openCrystalRemote = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("openCrystalRemote")
                    if openCrystalRemote then
                        openCrystalRemote:InvokeServer("openCrystal", "Inferno Crystal")
                    end
                    task.wait(0.0001)
                end
            end)
        end
        WindUI:Notify({
            Title = "HB：",
            Content = state and "已开启自动买尾迹" or "已关闭自动买尾迹",
            Icon = state and "check" or "x",
            Duration = 2
        })
    end
})
local QC = {}
local qcSection1 = Tabs.QiCheYingXiao:Section({ Title = "自动功能" })
local qcSection2 = Tabs.QiCheYingXiao:Section({ Title = "比赛功能" })
QC.Auto = false
qcSection1:Toggle({
    Title = "自动刷钱",
    Desc = "创建平台并自动刷钱",
    Value = false,
    Callback = function(state)
        QC.Auto = state
        if state then
            task.spawn(function()
                local part = Instance.new("Part")
                part.Position = Vector3.new(0, 60, 0)
                part.Size = Vector3.new(1000, 5, 1000)
                part.Anchored = true
                part.Name = "Keaths Platform"
                part.CollisionGroupId = 5
                part.Parent = Workspace
                local part2 = Instance.new("Part")
                part2.Position = Vector3.new(0, 10, 0)
                part2.Size = Vector3.new(1000, 5, 1000)
                part2.Anchored = true
                part2.Name = "Keaths Platform"
                part2.CollisionGroupId = 5
                part2.Parent = Workspace
                local part3 = Instance.new("Part")
                part3.Position = Vector3.new(0, 99, 0)
                part3.Size = Vector3.new(1000, 5, 1000)
                part3.Anchored = true
                part3.Name = "Keaths Platform"
                part3.CollisionGroupId = 5
                part3.Parent = Workspace
                while QC.Auto do
                    task.wait(0.1)
                    local chr = LocalPlayer.Character
                    if chr and chr:FindFirstChild("Humanoid") and chr.Humanoid.SeatPart then
                        local car = chr.Humanoid.SeatPart.Parent.Parent
                        pcall(function()
                            car:PivotTo(CFrame.new(0, 0, 0))
                            task.wait(0.81)
                            car:PivotTo(part.CFrame)
                            task.wait(1)
                            car:PivotTo(part2.CFrame)
                            task.wait(1)
                            car:PivotTo(part3.CFrame)
                        end)
                    end
                end
            end)
        end
    end
})
QC.buyer = false
qcSection1:Toggle({
    Title = "自动建造",
    Desc = "自动购买建筑升级",
    Value = false,
    Callback = function(state)
        QC.buyer = state
        if state then
            task.spawn(function()
                while QC.buyer do
                    task.wait()
                    local function plot()
                        for i, v in pairs(Workspace.Tycoons:GetDescendants()) do
                            if v.Name == "Owner" and v.ClassName == "StringValue" and v.Value == LocalPlayer.Name then
                                return v.Parent
                            end
                        end
                        return nil
                    end
                    pcall(function()
                        local tycoon = plot()
                        if tycoon and tycoon:FindFirstChild("Dealership") and tycoon.Dealership:FindFirstChild("Purchases") then
                            for i, v in pairs(tycoon.Dealership.Purchases:GetChildren()) do
                                if QC.buyer and v:FindFirstChild("TycoonButton") and v.TycoonButton:FindFirstChild("Button") and v.TycoonButton.Button.Transparency == 0 then
                                    ReplicatedStorage.Remotes.Build:FireServer("BuyItem", v.Name)
                                    task.wait(0.3)
                                end
                            end
                        end
                    end)
                end
            end)
        end
    end
})
QC.season = false
qcSection2:Toggle({
    Title = "自动完成赛季11比赛",
    Desc = "自动完成赛季11比赛",
    Value = false,
    Callback = function(state)
        QC.season = state
        if state then
            task.spawn(function()
                while QC.season do
                    local checkpoints = Workspace:FindFirstChild("Races") and Workspace.Races:FindFirstChild("Season") and Workspace.Races.Season:FindFirstChild("Checkpoints")
                    if checkpoints then
                        for i, v in pairs(checkpoints:GetDescendants()) do
                            if v.Name == "IsActive" and v.Value == true then
                                local chr = LocalPlayer.Character
                                if chr and chr:FindFirstChild("Humanoid") and chr.Humanoid.SeatPart then
                                    local car = chr.Humanoid.SeatPart.Parent.Parent
                                    pcall(function()
                                        if v.Parent.Name ~= "20" then
                                            car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                                        else
                                            car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                                            task.wait(0.2)
                                            car:PivotTo(CFrame.new(v.Parent.Parent.Parent.GoalPart.Position))
                                        end
                                    end)
                                end
                                task.wait(0.2)
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})
QC.oval = false
qcSection2:Toggle({
    Title = "自动完成圆形赛",
    Desc = "自动完成圆形赛",
    Value = false,
    Callback = function(state)
        QC.oval = state
        if state then
            task.spawn(function()
                while QC.oval do
                    local checkpoints = Workspace:FindFirstChild("Races") and Workspace.Races:FindFirstChild("Race") and Workspace.Races.Race:FindFirstChild("Oval") and Workspace.Races.Race.Oval:FindFirstChild("Checkpoints")
                    if checkpoints then
                        for i, v in pairs(checkpoints:GetDescendants()) do
                            if v.Name == "IsActive" and v.Value == true then
                                local chr = LocalPlayer.Character
                                if chr and chr:FindFirstChild("Humanoid") and chr.Humanoid.SeatPart then
                                    local car = chr.Humanoid.SeatPart.Parent.Parent
                                    pcall(function()
                                        if v.Parent.Name ~= "4" then
                                            car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                                        else
                                            car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                                            task.wait(0.2)
                                            car:PivotTo(CFrame.new(v.Parent.Parent.Parent.GoalPart.Position))
                                        end
                                    end)
                                end
                                task.wait(0.2)
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})
QC.gokart = false
qcSection2:Toggle({
    Title = "自动完成卡丁车赛",
    Desc = "自动完成卡丁车赛",
    Value = false,
    Callback = function(state)
        QC.gokart = state
        if state then
            task.spawn(function()
                while QC.gokart do
                    local checkpoints = Workspace:FindFirstChild("Races") and Workspace.Races:FindFirstChild("Race") and Workspace.Races.Race:FindFirstChild("Gokart") and Workspace.Races.Race.Gokart:FindFirstChild("Checkpoints")
                    if checkpoints then
                        for i, v in pairs(checkpoints:GetDescendants()) do
                            if v.Name == "IsActive" and v.Value == true then
                                local chr = LocalPlayer.Character
                                if chr and chr:FindFirstChild("Humanoid") and chr.Humanoid.SeatPart then
                                    local car = chr.Humanoid.SeatPart.Parent.Parent
                                    pcall(function()
                                        if v.Parent.Name ~= "9" then
                                            car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                                        else
                                            car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                                            task.wait(0.2)
                                            car:PivotTo(CFrame.new(v.Parent.Parent.Parent.GoalPart.Position))
                                        end
                                    end)
                                end
                                task.wait(0.2)
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})
QC.circuit = false
qcSection2:Toggle({
    Title = "自动完成转圈赛",
    Desc = "自动完成转圈赛",
    Value = false,
    Callback = function(state)
        QC.circuit = state
        if state then
            task.spawn(function()
                while QC.circuit do
                    local checkpoints = Workspace:FindFirstChild("Races") and Workspace.Races:FindFirstChild("Race") and Workspace.Races.Race:FindFirstChild("Circuit") and Workspace.Races.Race.Circuit:FindFirstChild("Checkpoints")
                    if checkpoints then
                        for i, v in pairs(checkpoints:GetDescendants()) do
                            if v.Name == "IsActive" and v.Value == true then
                                local chr = LocalPlayer.Character
                                if chr and chr:FindFirstChild("Humanoid") and chr.Humanoid.SeatPart then
                                    local car = chr.Humanoid.SeatPart.Parent.Parent
                                    pcall(function()
                                        if v.Parent.Name ~= "13" then
                                            car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                                        else
                                            car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                                            task.wait(0.2)
                                            car:PivotTo(CFrame.new(v.Parent.Parent.Parent.GoalPart.Position))
                                        end
                                    end)
                                end
                                task.wait(0.2)
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})
QC.racetest3 = false
qcSection2:Toggle({
    Title = "自动完成漂移赛",
    Desc = "自动完成漂移赛",
    Value = false,
    Callback = function(state)
        QC.racetest3 = state
        if not state then
            local distance = math.huge
            local partvelo = nil
            for a, b in pairs(Workspace.DriftTrack:GetDescendants()) do
                if b.Name == "DriftAsphalt" and b.Parent.Name == "Model" then
                    local Dist = (Vector3.new(-2567.529296875, 601.9335327148438, 2018.6964111328125) - b.Position).magnitude
                    if Dist < distance then
                        distance = Dist
                        partvelo = b
                    end
                end
            end
            if partvelo then
                partvelo.Velocity = LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 0
            end
        end
        if state then
            task.spawn(function()
                local partvelo = nil
                while QC.racetest3 do
                    task.wait()
                    if LocalPlayer.PlayerGui:FindFirstChild("Menu") and LocalPlayer.PlayerGui.Menu:FindFirstChild("Race") and LocalPlayer.PlayerGui.Menu.Race.Visible == false then
                        local chr = LocalPlayer.Character
                        if chr and chr:FindFirstChild("Humanoid") and chr.Humanoid.SeatPart then
                            local car = chr.Humanoid.SeatPart.Parent.Parent
                            pcall(function()
                                car:PivotTo(CFrame.new(-2502.25146484375, 601.9251708984375, 2013.3966064453125))
                                car.Engine.Velocity = Vector3.new(0, 0, 0)
                                chr.Head.Anchored = true
                                car.Engine.Velocity = Vector3.new(0, 0, 0)
                                task.wait(1)
                                car.Engine.Velocity = Vector3.new(0, 0, 0)
                                chr.Head.Anchored = false
                                car.Engine.Velocity = Vector3.new(0, 0, 0)
                                task.wait(1)
                                local raceHandler = Workspace:FindFirstChild("Races") and Workspace.Races:FindFirstChild("RaceHandler")
                                if raceHandler and raceHandler:FindFirstChild("StartLobby") then
                                    raceHandler.StartLobby:FireServer("Drift")
                                end
                                partvelo = nil
                                repeat
                                    task.wait()
                                    if LocalPlayer:DistanceFromCharacter(Vector3.new(-2502.25146484375, 601.9251708984375, 2013.3966064453125)) > 10 then
                                        car:PivotTo(CFrame.new(-2502.25146484375, 601.9251708984375, 2013.3966064453125))
                                        car.Engine.Velocity = Vector3.new(0, 0, 0)
                                        task.wait(0.1)
                                        if raceHandler and raceHandler:FindFirstChild("StartLobby") then
                                            raceHandler.StartLobby:FireServer("Drift")
                                        end
                                    end
                                until LocalPlayer.PlayerGui:FindFirstChild("Menu") and LocalPlayer.PlayerGui.Menu:FindFirstChild("Race") and LocalPlayer.PlayerGui.Menu.Race.Visible == true or QC.racetest3 == false
                            end)
                        end
                    elseif LocalPlayer.PlayerGui:FindFirstChild("Menu") and LocalPlayer.PlayerGui.Menu:FindFirstChild("Race") and LocalPlayer.PlayerGui.Menu.Race.Visible == true then
                        if partvelo == nil then
                            local distance = math.huge
                            for a, b in pairs(Workspace.DriftTrack:GetDescendants()) do
                                if b.Name == "DriftAsphalt" and b.Parent.Name == "Model" then
                                    local Dist = (Vector3.new(-2567.529296875, 601.9335327148438, 2018.6964111328125) - b.Position).magnitude
                                    if Dist < distance then
                                        distance = Dist
                                        partvelo = b
                                    end
                                end
                            end
                            if partvelo then
                                partvelo.Velocity = LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 1000
                            end
                        end
                        if partvelo and LocalPlayer:DistanceFromCharacter(partvelo.Position) > 10 then
                            local chr = LocalPlayer.Character
                            if chr and chr:FindFirstChild("Humanoid") and chr.Humanoid.SeatPart then
                                local car = chr.Humanoid.SeatPart.Parent.Parent
                                pcall(function()
                                    car:PivotTo(partvelo.CFrame)
                                end)
                            end
                        end
                        task.wait()
                    end
                end
            end)
        end
    end
})
QC.police = false
qcSection2:Toggle({
    Title = "自动完成警察抓小偷赛",
    Desc = "自动完成警察抓小偷赛",
    Value = false,
    Callback = function(state)
        QC.police = state
        if state then
            task.spawn(function()
                while QC.police do
                    local checkpoints = Workspace:FindFirstChild("Races") and Workspace.Races:FindFirstChild("Police") and Workspace.Races.Police:FindFirstChild("Checkpoints")
                    if checkpoints then
                        for i, v in pairs(checkpoints:GetDescendants()) do
                            if v.Name == "IsActive" and v.Value == true then
                                local chr = LocalPlayer.Character
                                if chr and chr:FindFirstChild("Humanoid") and chr.Humanoid.SeatPart then
                                    local car = chr.Humanoid.SeatPart.Parent.Parent
                                    pcall(function()
                                        if v.Parent.Name ~= "18" then
                                            car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                                        else
                                            car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                                            task.wait(0.2)
                                            car:PivotTo(CFrame.new(v.Parent.Parent.Parent.GoalPart.Position))
                                        end
                                    end)
                                end
                                task.wait(0.2)
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})
QC.city = false
qcSection2:Toggle({
    Title = "自动完成城市赛",
    Desc = "自动完成城市赛",
    Value = false,
    Callback = function(state)
        QC.city = state
        if state then
            task.spawn(function()
                while QC.city do
                    local checkpoints = Workspace:FindFirstChild("Races") and Workspace.Races:FindFirstChild("City") and Workspace.Races.City:FindFirstChild("City") and Workspace.Races.City.City:FindFirstChild("Checkpoints")
                    if checkpoints then
                        for i, v in pairs(checkpoints:GetDescendants()) do
                            if v.Name == "IsActive" and v.Value == true then
                                local chr = LocalPlayer.Character
                                if chr and chr:FindFirstChild("Humanoid") and chr.Humanoid.SeatPart then
                                    local car = chr.Humanoid.SeatPart.Parent.Parent
                                    pcall(function()
                                        if v.Parent.Name ~= "17" then
                                            car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                                        else
                                            car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                                            task.wait(0.2)
                                            car:PivotTo(CFrame.new(v.Parent.Parent.Parent.GoalPart.Position))
                                        end
                                    end)
                                end
                                task.wait(0.2)
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})
QC.highway = false
qcSection2:Toggle({
    Title = "自动完成公路赛",
    Desc = "自动完成公路赛",
    Value = false,
    Callback = function(state)
        QC.highway = state
        if state then
            task.spawn(function()
                while QC.highway do
                    local checkpoints = Workspace:FindFirstChild("Races") and Workspace.Races:FindFirstChild("City") and Workspace.Races.City:FindFirstChild("Highway") and Workspace.Races.City.Highway:FindFirstChild("Checkpoints")
                    if checkpoints then
                        for i, v in pairs(checkpoints:GetDescendants()) do
                            if v.Name == "IsActive" and v.Value == true then
                                local chr = LocalPlayer.Character
                                if chr and chr:FindFirstChild("Humanoid") and chr.Humanoid.SeatPart then
                                    local car = chr.Humanoid.SeatPart.Parent.Parent
                                    pcall(function()
                                        if v.Parent.Name ~= "23" then
                                            car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                                        else
                                            car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                                            task.wait(0.2)
                                            car:PivotTo(CFrame.new(v.Parent.Parent.Parent.GoalPart.Position))
                                        end
                                    end)
                                end
                                task.wait(0.2)
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})
QC.mountain = false
qcSection2:Toggle({
    Title = "自动完成山脉赛",
    Desc = "自动完成山脉赛",
    Value = false,
    Callback = function(state)
        QC.mountain = state
        if state then
            task.spawn(function()
                while QC.mountain do
                    local checkpoints = Workspace:FindFirstChild("Races") and Workspace.Races:FindFirstChild("Mountain") and Workspace.Races.Mountain:FindFirstChild("Checkpoints")
                    if checkpoints then
                        for i, v in pairs(checkpoints:GetDescendants()) do
                            if v.Name == "IsActive" and v.Value == true then
                                local chr = LocalPlayer.Character
                                if chr and chr:FindFirstChild("Humanoid") and chr.Humanoid.SeatPart then
                                    local car = chr.Humanoid.SeatPart.Parent.Parent
                                    pcall(function()
                                        if v.Parent.Name ~= "26" then
                                            car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                                        else
                                            car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                                            task.wait(0.2)
                                            car:PivotTo(CFrame.new(v.Parent.Parent.Parent.GoalPart.Position))
                                        end
                                    end)
                                end
                                task.wait(0.2)
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})
QC.Sponge = false
qcSection2:Toggle({
    Title = "自动完成海绵赛",
    Desc = "自动完成海绵宝宝赛",
    Value = false,
    Callback = function(state)
        QC.Sponge = state
        if state then
            task.spawn(function()
                while QC.Sponge do
                    local chr = LocalPlayer.Character
                    if chr and chr:FindFirstChild("Humanoid") and chr.Humanoid.SeatPart then
                        local car = chr.Humanoid.SeatPart.Parent.Parent
                        local spongeRace = Workspace:FindFirstChild("Races") and Workspace.Races:FindFirstChild("SpongeBobRace")
                        if spongeRace and spongeRace:FindFirstChild("Checkpoints") then
                            pcall(function()
                                car:PivotTo(spongeRace.Checkpoints["1"].Checkpoint.CFrame)
                                task.wait(1)
                                car:PivotTo(spongeRace.Checkpoints["2"].Checkpoint.CFrame)
                                task.wait(0.1)
                                car:PivotTo(spongeRace.Checkpoints["3"].Checkpoint.CFrame)
                                task.wait(1)
                                car:PivotTo(spongeRace.Checkpoints["4"].Checkpoint.CFrame)
                                task.wait(0.1)
                                car:PivotTo(spongeRace.Checkpoints["5"].Checkpoint.CFrame)
                                task.wait(1)
                                car:PivotTo(spongeRace.Checkpoints["6"].Checkpoint.CFrame)
                                task.wait(0.1)
                                car:PivotTo(spongeRace.Checkpoints["7"].Checkpoint.CFrame)
                                task.wait(1)
                                car:PivotTo(spongeRace.Checkpoints["8"].Checkpoint.CFrame)
                                car:PivotTo(spongeRace.Checkpoints["9"].Checkpoint.CFrame)
                                task.wait(1)
                                car:PivotTo(spongeRace.Checkpoints["10"].Checkpoint.CFrame)
                                task.wait(0.2)
                            end)
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})
local BG = {}
BG.currentLanguage = "Chinese"
BG.languageChanged = false
local Translations = {
    ["功能"] = "Features",
    ["语言设置"] = "Language Settings",
    ["自动乞讨"] = "Auto Beg",
    ["自动购买员工"] = "Auto Buy Employees",
    ["自动升级"] = "Auto Upgrade",
    ["金钱光环"] = "Money Aura",
    ["当前语言"] = "Current Language",
    ["中文"] = "Chinese",
    ["英文"] = "English",
    ["应用语言"] = "Apply Language",
    ["语言更改"] = "Language Change",
    ["成功"] = "Success",
    ["语言"] = "Language",
    ["当前语言已经是"] = "Current language is already",
    ["请重启脚本以使更改生效"] = "Please restart the script for changes to take effect"
}
local function translateText(text)
    if not text or type(text) ~= "string" then return text end
    if BG.currentLanguage == "English" then
        return Translations[text] or text
    else
        for cn, en in pairs(Translations) do
            if text == en then
                return cn
            end
        end
        return text
    end
end
local function translateGUI(gui)
    if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) then
        pcall(function()
            local text = gui.Text
            if text and text ~= "" then
                local translatedText = translateText(text)
                if translatedText ~= text then
                    gui.Text = translatedText
                end
            end
        end)
    end
end
local function scanAndTranslate()
    for _, gui in ipairs(game:GetService("CoreGui"):GetDescendants()) do
        translateGUI(gui)
    end
    if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
        for _, gui in ipairs(LocalPlayer.PlayerGui:GetDescendants()) do
            translateGUI(gui)
        end
    end
end
local function setupDescendantListener(parent)
    parent.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
            task.wait(0.1)
            translateGUI(descendant)
        end
    end)
end
local function setupTranslationEngine()
    pcall(setupDescendantListener, game:GetService("CoreGui"))
    if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
        pcall(setupDescendantListener, LocalPlayer.PlayerGui)
    end
    scanAndTranslate()
    while true do
        scanAndTranslate()
        task.wait(3)
    end
end
task.spawn(function()
    task.wait(2)
    setupTranslationEngine()
end)
local bgLangSection = Tabs.ChengWeiQiGai:Section({ Title = "语言设置" })
bgLangSection:Dropdown({
    Title = "当前语言",
    Values = {"中文", "English"},
    Value = "中文",
    Callback = function(option)
        if option == "English" then
            BG.currentLanguage = "English"
        else
            BG.currentLanguage = "Chinese"
        end
        BG.languageChanged = true
    end
})
bgLangSection:Button({
    Title = "应用语言",
    Callback = function()
        if BG.languageChanged then
            WindUI:Notify({
                Title = "语言更改",
                Content = "请重启脚本以使更改生效",
                Duration = 5,
                Icon = "info"
            })
            BG.languageChanged = false
        else
            WindUI:Notify({
                Title = "语言",
                Content = "当前语言已经是 " .. BG.currentLanguage,
                Duration = 3,
                Icon = "info"
            })
        end
    end
})
local bgFeatureSection = Tabs.ChengWeiQiGai:Section({ Title = "功能" })
BG.AutoFastMoney = false
bgFeatureSection:Toggle({
    Title = "自动乞讨",
    Desc = "自动乞讨获取金钱",
    Value = false,
    Callback = function(state)
        BG.AutoFastMoney = state
        if state then
            task.spawn(function()
                local bases = Workspace:FindFirstChild("Bases")
                local rs = ReplicatedStorage
                if not bases or not rs then return end
                local ev = rs:FindFirstChild("Remotes") and rs.Remotes:FindFirstChild("MinigameEvent")
                if not ev then return end
                local function findBase()
                    for _, b in pairs(bases:GetChildren()) do
                        local o = b:FindFirstChild("Owner")
                        if o then
                            local v = o.Value
                            if v == LocalPlayer or tostring(v) == LocalPlayer.Name or tonumber(v) == LocalPlayer.UserId then
                                return b
                            end
                        end
                    end
                    return nil
                end
                local b = findBase()
                if b then
                    local beg = b:FindFirstChild("BegPrompt")
                    if beg then
                        local prompt = beg:FindFirstChild("ProximityPrompt")
                        if prompt then
                            local char = getCharacter()
                            if char and char:FindFirstChild("HumanoidRootPart") then
                                char.HumanoidRootPart.CFrame = beg.CFrame + Vector3.new(0, 3, 0)
                                fireproximityprompt(prompt)
                            end
                            while BG.AutoFastMoney do
                                RunService.RenderStepped:Wait()
                                ev:FireServer(true)
                            end
                        end
                    end
                end
            end)
        end
    end
})
BG.AutoBuyEmployees = false
bgFeatureSection:Toggle({
    Title = "自动购买员工",
    Desc = "自动购买所有员工",
    Value = false,
    Callback = function(state)
        BG.AutoBuyEmployees = state
        if state then
            task.spawn(function()
                local BuyEmployee = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("BuyEmployee")
                if not BuyEmployee then return end
                while BG.AutoBuyEmployees do
                    for i = 1, 75 do
                        if i ~= 13 and i ~= 14 then
                            BuyEmployee:FireServer(i)
                            task.wait(0.3)
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})
BG.AutoBuyUpgrades = false
bgFeatureSection:Toggle({
    Title = "自动升级",
    Desc = "自动升级所有项目",
    Value = false,
    Callback = function(state)
        BG.AutoBuyUpgrades = state
        if state then
            task.spawn(function()
                local Upgrade = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Upgrade")
                if not Upgrade then return end
                while BG.AutoBuyUpgrades do
                    task.wait(0.1)
                    Upgrade:FireServer("Beg Power")
                    Upgrade:FireServer("Income")
                    Upgrade:FireServer("Box Tier")
                    Upgrade:FireServer("Alley Tier")
                end
            end)
        end
    end
})
BG.MoneyAura = false
bgFeatureSection:Toggle({
    Title = "金钱光环",
    Desc = "自动收集金钱",
    Value = false,
    Callback = function(state)
        BG.MoneyAura = state
        if state then
            task.spawn(function()
                local Money = Workspace:FindFirstChild("Money")
                if not Money then return end
                while BG.MoneyAura do
                    local char = getCharacter()
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        local HRP = char.HumanoidRootPart
                        local OldCFrame = HRP.CFrame
                        for _, v in pairs(Money:GetDescendants()) do
                            if v:IsA("ProximityPrompt") and v.Parent and v.Parent:IsA("BasePart") then
                                HRP.CFrame = v.Parent.CFrame + Vector3.new(0, 3, 0)
                                fireproximityprompt(v, 0, true)
                            end
                        end
                        HRP.CFrame = OldCFrame
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})
local CS = {}
local csSection = Tabs.ZaiChaoShi:Section({ Title = "自动收集功能" })
CS.collectFood = false
csSection:Toggle({
    Title = "自动收集食物",
    Value = false,
    Callback = function(state)
        CS.collectFood = state
        if state then
            task.spawn(function()
                while CS.collectFood do
                    for _, v in next, Workspace.Map.Util.Items:GetChildren() do
                        if v.ToolStats and v.ToolStats.ItemType and v.ToolStats.ItemType.Value == "Food" then
                            ReplicatedStorage.Remotes.RequestPickupItem:FireServer(v)
                        end
                    end
                    task.wait()
                end
            end)
        end
    end
})
CS.collectFlashlight = false
csSection:Toggle({
    Title = "自动收集手电筒",
    Value = false,
    Callback = function(state)
        CS.collectFlashlight = state
        if state then
            task.spawn(function()
                while CS.collectFlashlight do
                    for _, v in next, Workspace.Map.Util.Items:GetChildren() do
                        if v.ToolStats and v.ToolStats.ItemType and v.ToolStats.ItemType.Value == "Flashlight" then
                            ReplicatedStorage.Remotes.RequestPickupItem:FireServer(v)
                        end
                    end
                    task.wait()
                end
            end)
        end
    end
})
CS.collectMelee = false
csSection:Toggle({
    Title = "自动收集近战武器",
    Value = false,
    Callback = function(state)
        CS.collectMelee = state
        if state then
            task.spawn(function()
                while CS.collectMelee do
                    for _, v in next, Workspace.Map.Util.Items:GetChildren() do
                        if v.ToolStats and v.ToolStats.ItemType and v.ToolStats.ItemType.Value == "Melee" then
                            ReplicatedStorage.Remotes.RequestPickupItem:FireServer(v)
                        end
                    end
                    task.wait()
                end
            end)
        end
    end
})
CS.collectGun = false
csSection:Toggle({
    Title = "自动收集枪",
    Value = false,
    Callback = function(state)
        CS.collectGun = state
        if state then
            task.spawn(function()
                while CS.collectGun do
                    for _, v in next, Workspace.Map.Util.Items:GetChildren() do
                        if v.ToolStats and v.ToolStats.ItemType and v.ToolStats.ItemType.Value == "Gun" then
                            ReplicatedStorage.Remotes.RequestPickupItem:FireServer(v)
                        end
                    end
                    task.wait()
                end
            end)
        end
    end
})
CS.collectHealth = false
csSection:Toggle({
    Title = "自动收集药品",
    Value = false,
    Callback = function(state)
        CS.collectHealth = state
        if state then
            task.spawn(function()
                while CS.collectHealth do
                    for _, v in next, Workspace.Map.Util.Items:GetChildren() do
                        if v.ToolStats and v.ToolStats.ItemType and v.ToolStats.ItemType.Value == "Health" then
                            ReplicatedStorage.Remotes.RequestPickupItem:FireServer(v)
                        end
                    end
                    task.wait()
                end
            end)
        end
    end
})
CS.autoReload = false
csSection:Toggle({
    Title = "自动装弹",
    Value = false,
    Callback = function(state)
        CS.autoReload = state
        if state then
            task.spawn(function()
                while CS.autoReload do
                    ReplicatedStorage.Remotes.Weapon.GunReloaded:FireServer(nil, 1)
                    task.wait()
                end
            end)
        end
    end
})
CS.autoShoot = false
csSection:Toggle({
    Title = "自动开枪",
    Value = false,
    Callback = function(state)
        CS.autoShoot = state
        if state then
            task.spawn(function()
                while CS.autoShoot do
                    for _, v in next, LocalPlayer.Backpack:GetChildren() do
                        if v:FindFirstChild("ToolStats") and v.ToolStats:FindFirstChild("Ammo") then
                            for _, e in next, Workspace.Enemies:GetChildren() do
                                if e and e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then
                                    local BulletsPerShot = v.ToolStats.BulletsPerShot.Value
                                    local DirectionTbl = {}
                                    for i = 1, BulletsPerShot do
                                        table.insert(DirectionTbl, Vector3.new(e.Head.Position.X, e.Head.Position.Y, e.Head.Position.Z).Unit)
                                    end
                                    local args = {
                                        [1] = {
                                            ["FiringPlayer"] = LocalPlayer,
                                            ["FiredTime"] = os.time(),
                                            ["FiringPlayerUserId"] = LocalPlayer.UserId,
                                            ["Origin"] = Vector3.new(LocalPlayer.Character:GetPivot().Position),
                                            ["UID"] = LocalPlayer.UserId .. "_1",
                                            ["WeaponInstance"] = v,
                                            ["ThisBulletProperties"] = {
                                                ["BulletSpread"] = v.ToolStats.BulletSpread.Value,
                                                ["BulletsPerShot"] = v.ToolStats.BulletsPerShot.Value,
                                                ["BulletPenetration"] = v.ToolStats.BulletPenetration.Value,
                                                ["BulletSpeed"] = v.ToolStats.BulletSpeed.Value,
                                                ["FireSound"] = v.ToolStats.FireSound.Value,
                                                ["BulletSize"] = v.ToolStats.BulletSize.Value
                                            },
                                            ["DirectionTbl"] = DirectionTbl
                                        }
                                    }
                                    ReplicatedStorage.Remotes.Weapon.GunFired:FireServer(unpack(args))
                                end
                            end
                        end
                    end
                    task.wait()
                end
            end)
        end
    end
})
CS.superGun = false
csSection:Toggle({
    Title = "修改超级枪",
    Value = false,
    Callback = function(state)
        CS.superGun = state
        if state then
            task.spawn(function()
                while CS.superGun do
                    for _, v in next, LocalPlayer.Backpack:GetChildren() do
                        if v.ToolStats and v.ToolStats:FindFirstChild("Ammo") then
                            v.ToolStats.ReloadTime.Value = 0
                            v.ToolStats.FireDelay.Value = 0
                            v.ToolStats.Ammo.Value = math.huge
                            v.ToolStats.Damage.Value = math.huge
                        end
                    end
                    task.wait()
                end
            end)
        end
    end
})
CS.infiniteStats = false
csSection:Toggle({
    Title = "无限体力和饥饿度",
    Value = false,
    Callback = function(state)
        CS.infiniteStats = state
        if state then
            task.spawn(function()
                while CS.infiniteStats do
                    local char = getCharacter()
                    if char and char:FindFirstChild("CharacterData") then
                        char.CharacterData.MaxStamina.Value = math.huge
                        char.CharacterData.MaxEnergy.Value = math.huge
                        char.CharacterData.Energy.Value = char.CharacterData.MaxEnergy.Value
                        char.CharacterData.Stamina.Value = char.CharacterData.MaxStamina.Value
                    end
                    task.wait()
                end
            end)
        end
    end
})
CS.nightHide = false
csSection:Toggle({
    Title = "夜晚自动躲避",
    Value = false,
    Callback = function(state)
        CS.nightHide = state
        if state then
            task.spawn(function()
                local oldpos = nil
                while CS.nightHide do
                    if ReplicatedStorage.GameInfo.TimeOfDay.Value == "Night" then
                        oldpos = LocalPlayer.Character:GetPivot().Position
                        repeat
                            task.wait()
                            LocalPlayer.Character:PivotTo(CFrame.new(306.18927001953125, 36.67450714111328, -519.2435913085938))
                            if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                LocalPlayer.Character.HumanoidRootPart.Anchored = true
                            end
                        until ReplicatedStorage.GameInfo.TimeOfDay.Value ~= "Night"
                        if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            LocalPlayer.Character.HumanoidRootPart.Anchored = false
                        end
                        if oldpos then
                            LocalPlayer.Character:PivotTo(CFrame.new(oldpos))
                        end
                    else
                        task.wait()
                    end
                end
            end)
        end
    end
})
local YS = {}
local ysSection = Tabs.YuanSuLiLiang:Section({ Title = "自动功能" })
YS.autobuild = false
ysSection:Toggle({
    Title = "自动建造",
    Value = false,
    Callback = function(state)
        YS.autobuild = state
        if state then
            task.spawn(function()
                while YS.autobuild do
                    for _, v in next, Workspace.Tycoons:GetChildren() do
                        if v.Name == LocalPlayer.Name then
                            for _, a in next, v.Buttons:GetChildren() do
                                if a.Button and a.Button.Color == Color3.fromRGB(0, 127, 0) then
                                    local char = getCharacter()
                                    if char and char:FindFirstChild("HumanoidRootPart") then
                                        char.HumanoidRootPart.CFrame = a.Button.CFrame
                                    end
                                end
                            end
                        end
                    end
                    task.wait()
                end
            end)
        end
    end
})
YS.autocollect = false
ysSection:Toggle({
    Title = "自动收集钱",
    Value = false,
    Callback = function(state)
        YS.autocollect = state
        if state then
            task.spawn(function()
                while YS.autocollect do
                    for _, v in next, Workspace.Tycoons:GetChildren() do
                        if v.Name == LocalPlayer.Name then
                            local char = getCharacter()
                            if char and char:FindFirstChild("HumanoidRootPart") then
                                char.HumanoidRootPart.CFrame = v.Auxiliary.Collector.Collect.CFrame
                            end
                        end
                    end
                    task.wait(5)
                end
            end)
        end
    end
})
YS.autocollectcrate = false
ysSection:Toggle({
    Title = "自动收集钱箱",
    Value = false,
    Callback = function(state)
        YS.autocollectcrate = state
        if state then
            task.spawn(function()
                while YS.autocollectcrate do
                    for _, v in next, Workspace:GetChildren() do
                        if v.Name == "BalloonCrate" and v:FindFirstChild("Crate") and v.Crate:FindFirstChild("ProximityPrompt") then
                            local char = getCharacter()
                            if char and char:FindFirstChild("HumanoidRootPart") then
                                char.HumanoidRootPart.CFrame = v.Crate.CFrame
                                fireproximityprompt(v.Crate.ProximityPrompt)
                            end
                        end
                    end
                    task.wait()
                end
            end)
        end
    end
})
YS.autocollectdollar = false
ysSection:Toggle({
    Title = "自动收集boss掉的钱",
    Value = false,
    Callback = function(state)
        YS.autocollectdollar = state
        if state then
            task.spawn(function()
                while YS.autocollectdollar do
                    for _, v in next, Workspace:GetChildren() do
                        if v.Name == "Dollar" then
                            local char = getCharacter()
                            if char and char:FindFirstChild("HumanoidRootPart") then
                                char.HumanoidRootPart.CFrame = v.CFrame
                            end
                        end
                    end
                    task.wait()
                end
            end)
        end
    end
})
YS.autocollectchest = false
ysSection:Toggle({
    Title = "自动收集宝箱",
    Value = false,
    Callback = function(state)
        YS.autocollectchest = state
        if state then
            task.spawn(function()
                while YS.autocollectchest do
                    for _, v in pairs(Workspace.Treasure.Chests:GetChildren()) do
                        if v.Name == "Chest" and v:FindFirstChild("ProximityPrompt") then
                            local char = getCharacter()
                            if char and char:FindFirstChild("HumanoidRootPart") then
                                char.HumanoidRootPart.CFrame = v.CFrame
                                fireproximityprompt(v.ProximityPrompt)
                            end
                        end
                    end
                    task.wait()
                end
            end)
        end
    end
})
ysSection:Button({
    Title = "传送一次中心",
    Callback = function()
        local char = getCharacter()
        if char and char:FindFirstChild("HumanoidRootPart") then
            local oldpos = char.HumanoidRootPart.CFrame
            task.wait(0.5)
            char.HumanoidRootPart.CFrame = Workspace.Map.Center.CFrame
            task.wait(0.3)
            char.HumanoidRootPart.CFrame = oldpos
        end
    end
})
local JD = {}
local jdSection = Tabs.JianZaoJiDi:Section({ Title = "战斗功能" })
JD.autoPunch = false
jdSection:Toggle({
    Title = "自动挥舞拳头",
    Value = false,
    Callback = function(state)
        JD.autoPunch = state
        if state then
            task.spawn(function()
                while JD.autoPunch do
                    local args = {
                        [1] = true,
                        [2] = Vector3.new(0, 0, 0),
                        [3] = 50,
                        [4] = Enum.Material.Water,
                        [5] = "RangeAttack"
                    }
                    ReplicatedStorage.Remotes.Events.ToolState:FireServer(unpack(args))
                    task.wait()
                end
            end)
        end
    end
})
JD.rangeAttack = false
jdSection:Toggle({
    Title = "范围攻击",
    Value = false,
    Callback = function(state)
        JD.rangeAttack = state
        if state then
            task.spawn(function()
                while JD.rangeAttack do
                    for _, enemy in next, Workspace.Characters:GetChildren() do
                        if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") then
                            if enemy ~= LocalPlayer.Character and enemy.Humanoid.Health > 0 then
                                local char = getCharacter()
                                if char and char:FindFirstChild("HumanoidRootPart") then
                                    local distance = (char.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
                                    if distance <= 999 then
                                        local args = {
                                            [1] = true,
                                            [2] = enemy.HumanoidRootPart.Position,
                                            [3] = 50,
                                            [4] = Enum.Material.Water,
                                            [5] = "RangeAttack"
                                        }
                                        pcall(function()
                                            ReplicatedStorage.Remotes.Events.ToolState:FireServer(unpack(args))
                                        end)
                                    end
                                end
                            end
                        end
                    end
                    task.wait()
                end
            end)
        end
    end
})
local ZQ = {}
local SCRIPT_URL = "https://raw.githubusercontent.com/YunLua/Lua/refs/heads/main/ATM.lua"
local AUTO_FOLDER = "HB脚本"
local AUTO_RELOAD_FILE = AUTO_FOLDER .. "/auto_reload.txt"
local STATE_FILE = AUTO_FOLDER .. "/atm_state.txt"
if not isfolder(AUTO_FOLDER) then
    makefolder(AUTO_FOLDER)
end
ZQ.ATTACK_REGISTER = true
ZQ.ATTACK_ATM = true
ZQ.RUN = false
if isfile(STATE_FILE) then
    ZQ.RUN = readfile(STATE_FILE) == "1"
end
local function saveState()
    writefile(STATE_FILE, ZQ.RUN and "1" or "0")
end
local zqSection = Tabs.ZhengZaiXunQiu:Section({ Title = "主要功能" })
zqSection:Toggle({
    Title = "打击目标收银机",
    Value = ZQ.ATTACK_REGISTER,
    Callback = function(state)
        ZQ.ATTACK_REGISTER = state
    end
})
zqSection:Toggle({
    Title = "打击目标ATM",
    Value = ZQ.ATTACK_ATM,
    Callback = function(state)
        ZQ.ATTACK_ATM = state
    end
})
zqSection:Toggle({
    Title = "自动打击",
    Desc = "自动寻找目标并打击，未找到自动换服后自动重载",
    Value = ZQ.RUN,
    Callback = function(state)
        ZQ.RUN = state
        saveState()
        if state then
            task.spawn(function()
                local VIM = game:GetService("VirtualInputManager")
                local TeleportService = game:GetService("TeleportService")
                local HttpService = game:GetService("HttpService")
                local GizmosFolder = Workspace.Local.Gizmos.White
                local NO_ATM_TIME = 0
                local SERVER_HOP_TIME = 25
                local RANDOM_POS = {
                    Vector3.new(-1137, 78, -1953),
                    Vector3.new(-44, 63, -2083),
                    Vector3.new(194, 60, -2884),
                    Vector3.new(-412, 106, -1301),
                    Vector3.new(-377, 410, -741),
                    Vector3.new(-985, 380, -1145),
                    Vector3.new(-854, 406, -1505)
                }
                local function getPart(obj)
                    if obj:IsA("BasePart") then return obj end
                    for _, v in ipairs(obj:GetDescendants()) do
                        if v:IsA("BasePart") then
                            return v
                        end
                    end
                end
                local function isATM(obj)
                    local t = obj:GetAttribute("gizmoType")
                    if t == "ATM" and ZQ.ATTACK_ATM then
                        return true
                    elseif t == "Register" and ZQ.ATTACK_REGISTER then
                        return true
                    end
                    return false
                end
                local function getNearestATM()
                    local nearest, dist = nil, math.huge
                    for _, gizmo in ipairs(GizmosFolder:GetChildren()) do
                        if isATM(gizmo) then
                            local part = getPart(gizmo)
                            if part then
                                local char = getCharacter()
                                if char and char:FindFirstChild("HumanoidRootPart") then
                                    local d = (char.HumanoidRootPart.Position - part.Position).Magnitude
                                    if d < dist then
                                        nearest, dist = part, d
                                    end
                                end
                            end
                        end
                    end
                    return nearest
                end
                local function teleportTo(target)
                    local char = getCharacter()
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        if typeof(target) == "Vector3" then
                            char.HumanoidRootPart.CFrame = CFrame.new(target)
                        elseif typeof(target) == "Instance" then
                            char.HumanoidRootPart.CFrame = target.CFrame * CFrame.new(0, 5, 0)
                        end
                    end
                end
                local function pressE(time)
                    local start = tick()
                    while tick() - start < time do
                        VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                        VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                        task.wait(0.05)
                    end
                end
                local function collectATM(atm)
                    local start = tick()
                    while tick() - start < 3 and atm.Parent and not atm:GetAttribute("Collected") do
                        task.wait(0.1)
                    end
                    pressE(1.5)
                end
                local function serverHop()
                    writefile(AUTO_RELOAD_FILE, "1")
                    saveState()
                    local placeId = game.PlaceId
                    local ok, data = pcall(function()
                        local url = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100"):format(placeId)
                        return HttpService:JSONDecode(game:HttpGet(url)).data
                    end)
                    if not ok then return end
                    local servers = {}
                    for _, s in pairs(data) do
                        if s.playing < s.maxPlayers and s.id ~= game.JobId then
                            table.insert(servers, s.id)
                        end
                    end
                    if #servers > 0 then
                        TeleportService:TeleportToPlaceInstance(placeId, servers[math.random(#servers)], LocalPlayer)
                    end
                end
                while ZQ.RUN do
                    local atm = getNearestATM()
                    if atm then
                        teleportTo(atm)
                        task.wait(0.3)
                        pressE(1.5)
                        collectATM(atm)
                        NO_ATM_TIME = 0
                    else
                        NO_ATM_TIME = NO_ATM_TIME + 0.7
                        teleportTo(RANDOM_POS[math.random(#RANDOM_POS)])
                        if NO_ATM_TIME >= SERVER_HOP_TIME then
                            warn("25秒未找到目标，正在换服")
                            task.wait(1)
                            ZQ.RUN = false
                            saveState()
                            queue_on_teleport([[
                                loadstring(game:HttpGet("https://raw.githubusercontent.com/YunLua/Lua/refs/heads/main/ATM.lua"))()
                            ]])
                            wait()
                            serverHop()
                            break
                        end
                    end
                    task.wait(0.7)
                end
            end)
        end
    end
})
local ZZ = {}
local zzSection = Tabs.ZhongZhiHuaYuan:Section({ Title = "功能" })
ZZ.MaxFruits = 10
zzSection:Slider({
    Title = "售卖要求最低背包数量",
    Desc = "背包数量超过此值才会售卖",
    Value = { Min = 0, Max = 100, Default = 10 },
    Step = 1,
    IsTextbox = true,
    Callback = function(value)
        ZZ.MaxFruits = value
    end
})
ZZ.AutoCollectAndSell = false
zzSection:Toggle({
    Title = "自动收集加售卖",
    Value = false,
    Callback = function(state)
        ZZ.AutoCollectAndSell = state
        if state then
            task.spawn(function()
                while ZZ.AutoCollectAndSell do
                    pcall(function()
                        local char = getCharacter()
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            if #LocalPlayer.Backpack:GetChildren() > ZZ.MaxFruits then
                                local oldpos = char.HumanoidRootPart.CFrame
                                char.HumanoidRootPart.CFrame = Workspace.NPCS["Sell Stands"]["Shop Stand"].CFrame * CFrame.new(0, 0, 3)
                                task.wait(0.5)
                                ReplicatedStorage.GameEvents.Sell_Inventory:FireServer()
                                task.wait(1)
                                char.HumanoidRootPart.CFrame = oldpos
                            end
                            for _, plot in pairs(Workspace.Farm:GetChildren()) do
                                local important = plot:FindFirstChild("Important") or plot:FindFirstChild("Importanert")
                                if important and important:FindFirstChild("Data") and important.Data:FindFirstChild("Owner") then
                                    if important.Data.Owner.Value == LocalPlayer.Name then
                                        for _, prompt in ipairs(important.Plants_Physical:GetDescendants()) do
                                            if prompt:IsA("ProximityPrompt") then
                                                prompt.MaxActivationDistance = math.huge
                                                fireproximityprompt(prompt)
                                            end
                                        end
                                        break
                                    end
                                end
                            end
                        end
                    end)
                    task.wait(1)
                end
            end)
        end
    end
})
ZZ.AutoCollect = false
zzSection:Toggle({
    Title = "自动收集",
    Value = false,
    Callback = function(state)
        ZZ.AutoCollect = state
        if state then
            task.spawn(function()
                while ZZ.AutoCollect do
                    pcall(function()
                        local char = getCharacter()
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            for _, plot in pairs(Workspace.Farm:GetChildren()) do
                                local important = plot:FindFirstChild("Important") or plot:FindFirstChild("Importanert")
                                if important and important:FindFirstChild("Data") and important.Data:FindFirstChild("Owner") then
                                    if important.Data.Owner.Value == LocalPlayer.Name then
                                        for _, prompt in ipairs(important.Plants_Physical:GetDescendants()) do
                                            if prompt:IsA("ProximityPrompt") then
                                                prompt.MaxActivationDistance = math.huge
                                                fireproximityprompt(prompt)
                                            end
                                        end
                                        break
                                    end
                                end
                            end
                        end
                    end)
                    task.wait(1)
                end
            end)
        end
    end
})
ZZ.AutoCollect2 = false
zzSection:Toggle({
    Title = "自动收集2.0",
    Value = false,
    Callback = function(state)
        ZZ.AutoCollect2 = state
        if state then
            task.spawn(function()
                while ZZ.AutoCollect2 do
                    pcall(function()
                        local char = getCharacter()
                        if char and char:FindFirstChild("Humanoid") then
                            for _, plot in pairs(Workspace.Farm:GetChildren()) do
                                local important = plot:FindFirstChild("Important") or plot:FindFirstChild("Importanert")
                                if important and important:FindFirstChild("Data") and important.Data:FindFirstChild("Owner") then
                                    if important.Data.Owner.Value == LocalPlayer.Name then
                                        for _, prompt in ipairs(important.Plants_Physical:GetDescendants()) do
                                            if prompt:IsA("ProximityPrompt") then
                                                char.Humanoid:MoveTo(prompt.Parent.Position)
                                                prompt.MaxActivationDistance = math.huge
                                                fireproximityprompt(prompt)
                                            end
                                        end
                                        break
                                    end
                                end
                            end
                        end
                    end)
                    task.wait(1)
                end
            end)
        end
    end
})
ZZ.AutoSell = false
zzSection:Toggle({
    Title = "自动售卖",
    Value = false,
    Callback = function(state)
        ZZ.AutoSell = state
        if state then
            task.spawn(function()
                while ZZ.AutoSell do
                    pcall(function()
                        local char = getCharacter()
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            if #LocalPlayer.Backpack:GetChildren() > ZZ.MaxFruits then
                                local oldpos = char.HumanoidRootPart.CFrame
                                char.HumanoidRootPart.CFrame = Workspace.NPCS["Sell Stands"]["Shop Stand"].CFrame * CFrame.new(0, 0, 3)
                                task.wait(0.5)
                                ReplicatedStorage.GameEvents.Sell_Item:FireServer()
                                ReplicatedStorage.GameEvents.Sell_Inventory:FireServer()
                                task.wait(1)
                                char.HumanoidRootPart.CFrame = oldpos
                            end
                        end
                    end)
                    task.wait(1)
                end
            end)
        end
    end
})
ZZ.AutoPlant = false
zzSection:Toggle({
    Title = "自动种植",
    Value = false,
    Callback = function(state)
        ZZ.AutoPlant = state
        if state then
            task.spawn(function()
                while ZZ.AutoPlant do
                    pcall(function()
                        local char = getCharacter()
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            local tool = nil
                            local seedType = nil
                            for _, item in ipairs(char:GetChildren()) do
                                if item:IsA("Tool") and item.Name:find("Seed") then
                                    seedType = item.Name:match("^(.-) Seed")
                                    tool = item
                                    break
                                end
                            end
                            if not tool then
                                for _, item in ipairs(LocalPlayer.Backpack:GetChildren()) do
                                    if item:IsA("Tool") and item.Name:find("Seed") then
                                        seedType = item.Name:match("^(.-) Seed")
                                        tool = item
                                        break
                                    end
                                end
                            end
                            if tool and seedType then
                                if tool.Parent == LocalPlayer.Backpack then
                                    char.Humanoid:EquipTool(tool)
                                    repeat task.wait() until tool.Parent == char
                                end
                                ReplicatedStorage.GameEvents.Plant_RE:FireServer(
                                    Vector3.new(math.floor(char.HumanoidRootPart.Position.X), 0.1, math.floor(char.HumanoidRootPart.Position.Z)),
                                    seedType
                                )
                            end
                        end
                    end)
                    task.wait(1)
                end
            end)
        end
    end
})
ZZ.showSeedTimer = false
local seedTimerActive = false
zzSection:Toggle({
    Title = "显示种子刷新时间",
    Value = false,
    Callback = function(state)
        ZZ.showSeedTimer = state
        if state then
            if not seedTimerActive then
                seedTimerActive = true
                local TimeGui = Instance.new("ScreenGui")
                TimeGui.Name = "TimeGui"
                TimeGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                TimeGui.Parent = game:GetService("CoreGui")
                local TimeLabel = Instance.new("TextLabel")
                TimeLabel.Name = "TimeLabel"
                TimeLabel.BackgroundTransparency = 1
                TimeLabel.BorderColor3 = Color3.new(0, 0, 0)
                TimeLabel.Position = UDim2.new(0.80, 0, 0.00090, 0)
                TimeLabel.Size = UDim2.new(0, 135, 0, 50)
                TimeLabel.Font = Enum.Font.GothamSemibold
                TimeLabel.Text = "种子下次更新时间: "
                TimeLabel.TextColor3 = Color3.new(1, 1, 1)
                TimeLabel.TextScaled = true
                TimeLabel.TextSize = 14
                TimeLabel.TextWrapped = true
                TimeLabel.Parent = TimeGui
                local UIGradient = Instance.new("UIGradient")
                UIGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
                    ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 127, 0)),
                    ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 255, 0)),
                    ColorSequenceKeypoint.new(0.30, Color3.fromRGB(0, 255, 0)),
                    ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 255)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 0, 255)),
                    ColorSequenceKeypoint.new(0.60, Color3.fromRGB(139, 0, 255)),
                    ColorSequenceKeypoint.new(0.70, Color3.fromRGB(255, 0, 0)),
                    ColorSequenceKeypoint.new(0.80, Color3.fromRGB(255, 127, 0)),
                    ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 255, 0)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 255, 0))
                }
                UIGradient.Rotation = 360
                UIGradient.Parent = TimeLabel
                local TweenService = game:GetService("TweenService")
                local tweeninfo = TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
                local tween = TweenService:Create(UIGradient, tweeninfo, {Rotation = 360})
                tween:Play()
                task.spawn(function()
                    while ZZ.showSeedTimer do
                        task.wait()
                        pcall(function()
                            if LocalPlayer.PlayerGui and LocalPlayer.PlayerGui.Seed_Shop and LocalPlayer.PlayerGui.Seed_Shop.Frame and LocalPlayer.PlayerGui.Seed_Shop.Frame.Frame and LocalPlayer.PlayerGui.Seed_Shop.Frame.Frame.Timer then
                                TimeLabel.Text = "时间: " .. LocalPlayer.PlayerGui.Seed_Shop.Frame.Frame.Timer.Text
                            end
                        end)
                    end
                    TimeGui:Destroy()
                    seedTimerActive = false
                end)
            end
        else
            seedTimerActive = false
        end
    end
})
ZZ.selectedSeed = "Carrot"
zzSection:Dropdown({
    Title = "选择种子",
    Values = {"Carrot", "Strawberry", "Blueberry", "Orange Tulip", "Tomato", "Corn", "Daffodil", "Watermelon", "Pumpkin", "Apple", "Bamboo", "Coconut", "Cactus", "Dragon Fruit", "Mango", "Grape"},
    Value = "Carrot",
    Callback = function(value)
        ZZ.selectedSeed = value
    end
})
ZZ.AutoBuySeeds = false
zzSection:Toggle({
    Title = "自动购买种子",
    Value = false,
    Callback = function(state)
        ZZ.AutoBuySeeds = state
        if state then
            task.spawn(function()
                while ZZ.AutoBuySeeds do
                    pcall(function()
                        ReplicatedStorage.GameEvents.BuySeedStock:FireServer(ZZ.selectedSeed)
                    end)
                    task.wait(0.2)
                end
            end)
        end
    end
})
zzSection:Button({
    Title = "购买种子",
    Callback = function()
        ReplicatedStorage.GameEvents.BuySeedStock:FireServer(ZZ.selectedSeed)
    end
})
ZZ.AutoBuyWateringCan = false
zzSection:Toggle({
    Title = "自动购买水壶",
    Value = false,
    Callback = function(state)
        ZZ.AutoBuyWateringCan = state
        if state then
            task.spawn(function()
                while ZZ.AutoBuyWateringCan do
                    pcall(function()
                        ReplicatedStorage.GameEvents.BuyGearStock:FireServer("Watering Can")
                    end)
                    task.wait(1)
                end
            end)
        end
    end
})
local ZR = {}
local zrSection = Tabs.ZiRanZaiHai:Section({ Title = "功能" })
zrSection:Button({
    Title = "指南针",
    Desc = "要使用的话就必须买指南针",
    Callback = function()
        local p = LocalPlayer
        local r = ReplicatedStorage.Remotes.Compass
        local c = p.Backpack:FindFirstChild("Compass")
        local h = p.Character:FindFirstChild("Humanoid")
        if c and h then
            h:EquipTool(c)
            task.wait()
            r:FireServer("Vote Map", 3)
            r:FireServer("Vote Map", 4)
            task.wait()
            h:UnequipTools()
            WindUI:Notify({
                Title = "通知",
                Content = "加载成功",
                Duration = 1,
                Icon = "check",
            })
        end
    end
})
zrSection:Button({
    Title = "黑洞",
    Desc = "点击加载",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Super-ring-Parts-V6-28581"))()
        WindUI:Notify({
            Title = "通知",
            Content = "加载成功",
            Duration = 3,
            Icon = "check",
        })
    end
})
zrSection:Button({
    Title = "物理磁铁",
    Desc = "可以把下面的东西吸上来可以踩",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/cytj777i/6669178/main/%E5%8D%95%E4%B8%80%E7%89%A9%E4%BD%93%E9%A3%9E%E8%A1%8C%E8%BD%BD%E8%87%AA%E5%B7%B1%E6%9C%80%E7%BB%88%E4%BC%98%E5%8C%96%E7%89%88"))()
        WindUI:Notify({
            Title = "通知",
            Content = "加载成功",
            Duration = 1,
            Icon = "check",
        })
    end
})
zrSection:Button({
    Title = "无敌少侠",
    Desc = "用了它，你就会变成城市超人",
    Callback = function()
local UserInputService = game:GetService("UserInputService")
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
if isMobile then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/396abc/Script/refs/heads/main/MobileFly.lua"))()
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/396abc/Script/refs/heads/main/FlyR15.lua"))()
end
        WindUI:Notify({
            Title = "通知",
            Content = "加载成功",
            Duration = 1,
            Icon = "check",
        })
    end
})
zrSection:Button({
    Title = "防止摔跤伤害",
    Desc = "就算掉下去了，也毫发无伤，掉到水里面也会死的",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/cytj777i/Fall-injury/main/%E9%98%B2%E6%AD%A2%E6%91%94%E8%90%BD%E4%BC%A4%E5%AE%B3"))()
        WindUI:Notify({
            Title = "通知",
            Content = "加载成功",
            Duration = 1,
            Icon = "check",
        })
    end
})
local ZC = {}
local zcSection = Tabs.ZuiQiangZhanChang:Section({ Title = "战斗功能" })
zcSection:Button({
    Title = "执行连招(Flowing Water + Lethal Whirlwind Stream)",
    Desc = "点击后执行一套连招",
    Callback = function()
        local player = LocalPlayer
        local char = player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local hrp = char.HumanoidRootPart
        local TweenService = game:GetService("TweenService")
        local args1 = {
            [1] = {
                ["Tool"] = player.Backpack:FindFirstChild("Flowing Water"),
                ["Goal"] = "Console Move"
            }
        }
        char.Communicate:FireServer(unpack(args1))
        task.wait(2.15)
        local forward = hrp.CFrame.LookVector.Unit
        local distance = 20
        local duration = 0.1
        local goalPos = hrp.Position + forward * distance
        local tween = TweenService:Create(hrp, TweenInfo.new(duration), {
            CFrame = CFrame.new(goalPos, goalPos + forward)
        })
        tween:Play()
        tween.Completed:Wait()
        hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(180), 0)
        local args2 = {
            [1] = {
                ["Tool"] = player.Backpack:FindFirstChild("Lethal Whirlwind Stream"),
                ["Goal"] = "Console Move"
            }
        }
        char.Communicate:FireServer(unpack(args2))
        WindUI:Notify({
            Title = "通知",
            Content = "连招执行成功",
            Duration = 2,
            Icon = "check",
        })
    end
})
local tp = Tabs.tp:Section({ Title = "躲避" })
tp:Toggle({
    Title = "自动获胜",
    Default = false,
    Callback = function(state)
        ActiveAutoWin = state
        if ActiveAutoWin then
            WindUI:Notify({
                Title = "提示提示",
                Content = "自动获胜已开启",
                Duration = 4
            })
            spawn(function()
                while ActiveAutoWin do
                    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if character and rootPart then
                        if character:GetAttribute("Downed") then
                            ReplicatedStorage.Events.Player.ChangePlayerMode:FireServer(true)
                            task.wait(0.5)
                        end
                        if not character:GetAttribute("Downed") then
                            local securityPart = Instance.new("Part")
                            securityPart.Name = "SecurityPartTemp"
                            securityPart.Size = Vector3.new(10, 1, 10)
                            securityPart.Position = Vector3.new(0, 500, 0)
                            securityPart.Anchored = true
                            securityPart.Transparency = 1
                            securityPart.CanCollide = true
                            securityPart.Parent = Workspace
                            rootPart.CFrame = securityPart.CFrame + Vector3.new(0, 3, 0)
                            task.wait(0.5)
                            securityPart:Destroy()
                        end
                    end
                    task.wait(0.1)
                end
            end)
        else
            WindUI:Notify({
                Title = "提示提示",
                Content = "自动获胜已关闭",
                Duration = 4
            })
        end
    end
})
tp:Toggle({
    Title = "自动刷钱",
    Default = false,
    Callback = function(state)
        ActiveAutoFarmMoney = state
        if ActiveAutoFarmMoney then
            WindUI:Notify({
                Title = "提示提示",
                Content = "自动刷钱已开启",
                Duration = 4
            })
            spawn(function()
                while ActiveAutoFarmMoney do
                    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                    if character and rootPart then
                        if character:GetAttribute("Downed") then
                            ReplicatedStorage.Events.Player.ChangePlayerMode:FireServer(true)
                            task.wait(0.5)
                        end
                        local downedPlayerFound = false
                        local playersInGame = Workspace:FindFirstChild("Game") and Workspace.Game:FindFirstChild("Players")
                        if playersInGame then
                            for _, v in pairs(playersInGame:GetChildren()) do
                                if v:IsA("Model") and v:FindFirstChildOfClass("Humanoid") and v:GetAttribute("Downed") then
                                    rootPart.CFrame = v.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                                    ReplicatedStorage.Events.Character.Interact:FireServer("Revive", true, v)
                                    task.wait(0.5)
                                    downedPlayerFound = true
                                    break
                                end
                            end
                        end
                        if not downedPlayerFound then
                        end
                        local securityPart = Instance.new("Part")
                        securityPart.Name = "SecurityPartTemp"
                        securityPart.Size = Vector3.new(10, 1, 10)
                        securityPart.Position = Vector3.new(0, 500, 0)
                        securityPart.Anchored = true
                        securityPart.Transparency = 1
                        securityPart.CanCollide = true
                        securityPart.Parent = Workspace
                        rootPart.CFrame = securityPart.CFrame + Vector3.new(0, 3, 0)
                    else
                    end
                    task.wait(1)
                end
            end)
        else
            WindUI:Notify({
                Title = "提示提示",
                Content = "自动刷钱已关闭",
                Duration = 4
            })
        end
    end
})
tp:Toggle({
    Title = "自动复活自己",
    Default = false,
    Callback = function(state)
        autoReviveEnabled = state
        if autoReviveEnabled then
            WindUI:Notify({
                Title = "提示提示",
                Content = "自动复活已开启",
                Duration = 4
            })
        else
            WindUI:Notify({
                Title = "提示提示",
                Content = "自动复活已关闭",
                Duration = 4
            })
        end
    end
})
tp:Button({
    Title = "复活自己",
    Callback = function()
        local player = LocalPlayer
        local character = player.Character
        if character and character:GetAttribute("Downed") then
            ReplicatedStorage.Events.Player.ChangePlayerMode:FireServer(true)
            WindUI:Notify({
                Title = "提示提示",
                Content = "✅已复活!",
                Duration = 4
            })
        else
            WindUI:Notify({
                Title = "提示提示",
                Content = "你还没有倒地!",
                Duration = 4
            })
        end
    end
})
local zw = {}
local zwSection = Tabs.zw:Section({ Title = "主要功能" })
zwSection:Toggle({
  Title = "杀戮光环",
  Icon = "check",
  Default = false,
  Callback = function(Value)
    _G.AutoAttack = Value
    if Value then
      local RS = game:GetService("ReplicatedStorage")
      local Event = RS.Remotes.AttacksServer.WeaponAttack
      local Players = game:GetService("Players")
      local Player = Players.LocalPlayer
      local Char = Player.Character or Player.CharacterAdded:Wait()
      local HRP = Char:WaitForChild("HumanoidRootPart")
      Player.CharacterAdded:Connect(function(c)
        Char = c
        HRP = c:WaitForChild("HumanoidRootPart")
      end)
      task.spawn(function()
        while _G.AutoAttack do
          local targets = {}
          for _, mob in ipairs(workspace.ScriptedMap.Brainrots:GetChildren()) do
            local pp = mob.PrimaryPart or mob:FindFirstChild("HumanoidRootPart")
            if pp and (pp.Position - HRP.Position).Magnitude <= DistanceForKillAura then
              table.insert(targets, mob.Name)
            end
          end
          if #targets > 0 then
            Event:FireServer(targets)
          end
          task.wait()
        end
      end)
    end
  end
})
zwSection:Input({
  Title = "攻击范围[20默认]",
  Value = tostring(DefaultKillAuraDistance),
  Callback = function(value)
    local numValue = tonumber(value)
    if numValue then
      DistanceForKillAura = numValue
     else
    end
  end
})
local autoSell = false
zwSection:Section({Title = "出售脑红"})
zwSection:Toggle({
  Title = "自动出售脑红",
  Default = false,
  Callback = function(state)
    autoSell = state
    if autoSell then
      task.spawn(function()
        while autoSell do
          local success, errorMsg = pcall(function()
            game:GetService("ReplicatedStorage").Remotes.ItemSell:FireServer()
          end)
          if not success then
          end
          task.wait(0.1)
        end
      end)
    end
  end
})
local sellInterval = 0.1
zwSection:Slider({
  Title = "出售间隔",
  Value = {
    Min = 0.05,
    Max = 1,
    Default = 0.1
  },
  Callback = function(Value)
    sellInterval = Value
  end
})
local autoSell = false
zwSection:Section({Title = "出售植物"})
zwSection:Toggle({
  Title = "自动出售植物",
  Default = false,
  Callback = function(state)
    autoSell = state
    if autoSell then
      task.spawn(function()
        while autoSell do
          local success, errorMsg = pcall(function()
            local args = {
              [2] = true
            }
            game:GetService("ReplicatedStorage").Remotes.ItemSell:FireServer(unpack(args))
          end)
          if not success then
          end
          task.wait(sellInterval)
        end
      end)
    end
  end
})
local sellInterval = 0.1
zwSection:Slider({
  Title = "出售间隔",
  Value = {
    Min = 0.05,
    Max = 1,
    Default = 0.1
  },
  Callback = function(Value)
    sellInterval = Value
  end
})
local chineseNames = {
  ["Cactus Seed"] = "仙人掌种子",
  ["Strawberry Seed"] = "草莓种子",
  ["Pumpkin Seed"] = "南瓜种子",
  ["Sunflower Seed"] = "向日葵种子",
  ["Dragon Fruit Seed"] = "火龙果种子",
  ["Eggplant Seed"] = "茄子种子",
  ["Watermelon Seed"] = "西瓜种子",
  ["Grape Seed"] = "葡萄种子",
  ["Cocotank Seed"] = "可可坦克种子",
  ["Carnivorous Plant Seed"] = "食人植物种子",
  ["Mr Carrot Seed"] = "胡萝卜先生种子",
  ["Tomatrio Seed"] = "番茄三重奏种子",
  ["Shroombino Seed"] = "蘑菇宾诺种子",
  ["Mango Seed"] = "芒果种子",
  ["King Limone Seed"] = "柠檬王种子"
}
local chineseSeedOptions = {}
for engName, chsName in pairs(chineseNames) do
  chineseSeedOptions[chsName] = engName
end
local chineseSeedList = {}
for _, chsName in pairs(chineseNames) do
  table.insert(chineseSeedList, chsName)
end
local selectedSeeds = {}
zwSection:Dropdown({
  Title = "选择要购买的种子",
  Values = chineseSeedList,
  Value = {},
  Multi = true,
  Callback = function(selectedChineseNames)
    selectedSeeds = {}
    for _, chsName in ipairs(selectedChineseNames) do
      local engName = chineseSeedOptions[chsName]
      if engName then
        table.insert(selectedSeeds, engName)
      end
    end
  end
})
zwSection:Button({
  Title = "购买一次选中种子",
  Callback = function()
    for _, seedName in ipairs(selectedSeeds) do
      local args = {
        [1] = seedName,
        [2] = true
      }
      game:GetService("ReplicatedStorage").Remotes.BuyItem:FireServer(unpack(args))
      WindUI:Notify({
        Title = "购买成功",
        Content = "已购买: " .. chineseNames[seedName],
        Duration = 2,
        Icon = "shopping-cart"
      })
      task.wait(0.1)
    end
  end
})
zwSection:Toggle({
  Title = "自动购买选中种子",
  Value = false,
  Callback = function(state)
    autoBuyEnabled = state
    if buyConnection then
      buyConnection:Disconnect()
      buyConnection = nil
    end
    if state then
      buyConnection = RunService.Heartbeat:Connect(function()
        for _, seedName in ipairs(selectedSeeds) do
          local args = {
            [1] = seedName,
            [2] = true
          }
          game:GetService("ReplicatedStorage").RemoteEvents.BuySeed:FireServer(unpack(args))
          task.wait(0.2)
        end
      end)
    end
  end
})
zwSection:Button({
  Title = "强制停止自动购买[防bug可不用]",
  Callback = function()
    autoBuyEnabled = false
    if buyConnection then
      buyConnection:Disconnect()
      buyConnection = nil
    end
    WindUI:Notify({
      Title = "已停止",
      Content = "已停止自动购买",
      Duration = 2,
      Icon = "stop-circle"
    })
  end
})
local kg = {}
local kgSection = Tabs.kg:Section({ Title = "主要功能" })
kgSection:Toggle({
     Title = "自动收集矿物",
     Desc = "",
     Value = false,
     Callback = function(state)
         while state and task.wait() do
             for _, v in pairs(workspace.Items:GetChildren()) do
                 if v then
                     local args = {v.Name}
                     game:GetService("ReplicatedStorage"):FindFirstChild("shared/network/MiningNetwork@GlobalMiningEvents").CollectItem:FireServer(unpack(args))
                 end
             end
         end
     end
 })
kgSection:Toggle({
     Title = "自动收集矿物2有bug❌",
     Desc = "",
     Value = false,
     Callback = function(state)
         while state and task.wait() do
             for _, v in pairs(workspace:GetChildren()) do
                 if v:IsA("Model") and v:GetAttribute("Name") == "Trader Tom" then
                     game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v:FindFirstChild("HumanoidRootPart").CFrame
                     game:GetService("ReplicatedStorage").Ml.SellInventory:FireServer()
                     break
                 end
             end
         end
     end
 })
Tabs.dw:Paragraph({
    Title = "动物医院（异常）🧪:",
    Desc = "请使用TX翻译",
    Image = "https://play-lh.googleusercontent.com/7cIIPlWm4m7AGqVpEsIfyL-HW4cQla4ucXnfalMft1TMIYQIlf2vqgmthlZgbNAQoaQ",
    ImageSize = 20,
    ThumbnailSize = 120
})
Tabs.dw:Button({
    Title = "TX翻译❤️",
    Callback = function()
        TX = "TX Script"
Script = "全自动翻译"
loadstring(game:HttpGet("https://raw.githubusercontent.com/JsYb666/Item/refs/heads/main/Auto-language"))()
    end
})
Tabs.dw:Button({
    Title = "动物医院（异常） 🧪",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/rblxshop/Rblxscripts/refs/heads/main/AnimalHospital.lua"))()
    end
})
Tabs.dw:Button({
    Title = "动物医院（异常） 🧪2",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LynX99-9/komtolmmek2script/refs/heads/main/CyraaHub.lua", true))()
    end
})
Tabs.dw:Button({
    Title = "动物医院（异常） 🧪3",
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/NoxScriptsZeN/92555dca436989a077ed25b172d4bc78/raw"))()
    end
})
Tabs.dw:Button({
    Title = "动物医院（异常） 🧪4",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HexHubX/Games/refs/heads/main/Script%20Games.lua"))()
    end
})
task.spawn(function()
    task.wait(0.3)
    local mainFrame = Window.UIElements and Window.UIElements.Main
    if not mainFrame then
        mainFrame = game.CoreGui:FindFirstChild("WindUI") and game.CoreGui.WindUI:FindFirstChild("Window")
        if mainFrame then
            mainFrame = mainFrame:FindFirstChild("Main")
        end
    end
    if mainFrame then
        local side = mainFrame:FindFirstChild("Side")
        if side then
            local tabBtns = side:FindFirstChild("TabBtns")
            if tabBtns then
                for _, child in ipairs(tabBtns:GetChildren()) do
                    if child:IsA("ImageLabel") and child:FindFirstChild("TabText") then
                        child.Image = sjzIcon
                        child.ImageRectSize = nil
                        child.ImageRectOffset = nil
                        child.ScaleType = Enum.ScaleType.Fit
                        child.Size = UDim2.new(0, 24, 0, 24)
                    end
                end
                print("✅ 所有标签页图标已替换为自定义图片")
            end
        end
    end
end)

-- DF动作包系统 (远程加载，减少卡顿)

local emSec = Tabs.Emote:Section({ Title = "DF动作包" })

emSec:Button({
    Title = "打开DF动作包",
    Desc = "加载独立的动作包UI（减少主脚本卡顿）",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/yuihghghg/RJ/refs/heads/main/DFdongzuo.lua"))()
        end)
    end
})

-- ============================================================
-- 监狱人生功能 (Prison Life)
-- ============================================================

-- 通用功能
local prisonSec1 = Tabs.Prison:Section({ Title = "通用功能" })

prisonSec1:Button({
    Title = "电网电击不会造成死亡",
    Desc = "删除所有damagePart并阻止重生",
    Callback = function()
        local function removeAllDamageParts()
            for _, object in ipairs(workspace.Prison_Fences:GetDescendants()) do
                if object.Name == "damagePart" then
                    object:Destroy()
                end
            end
        end
        removeAllDamageParts()
        workspace.Prison_Fences.DescendantAdded:Connect(function(descendant)
            if descendant.Name == "damagePart" then
                task.wait()
                descendant:Destroy()
            end
        end)
    end
})

local AutoArrestEnabled = false
local ArrestDistance = 15
task.spawn(function()
    while task.wait(0.25) do
        if not AutoArrestEnabled then continue end
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then continue end
        local myRoot = char.HumanoidRootPart
        for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
            if plr == LocalPlayer or not plr.Character then continue end
            local team = plr.Team
            if team and (team.Name == "Prisoners" or team.Name == "Prisoner" or team.Name == "Inmates") then
                local targetRoot = plr.Character:FindFirstChild("HumanoidRootPart")
                if targetRoot then
                    local dist = (myRoot.Position - targetRoot.Position).Magnitude
                    if dist <= ArrestDistance then
                        pcall(function()
                            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ArrestPlayer"):InvokeServer(plr, 1)
                        end)
                    end
                end
            end
        end
    end
end)

prisonSec1:Toggle({
    Title = "附近自动逮捕",
    Desc = "自动逮捕范围内的囚犯",
    Callback = function(v)
        AutoArrestEnabled = v
    end
})

prisonSec1:Input({
    Title = "逮捕距离[15默认]",
    Value = "15",
    Callback = function(text)
        local num = tonumber(text)
        if num then ArrestDistance = num end
    end
})

prisonSec1:Button({
    Title = "删除门禁卡大门",
    Callback = function()
        if workspace:FindFirstChild("Doors") then
            workspace.Doors:Destroy()
        end
    end
})

prisonSec1:Button({
    Title = "删除牢房大门",
    Callback = function()
        if workspace:FindFirstChild("CellDoors") then
            workspace.CellDoors:Destroy()
        end
    end
})

prisonSec1:Button({
    Title = "删除所有马桶",
    Callback = function()
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "Toilet" then
                v:Destroy()
            end
        end
    end
})

-- 自身玩家设置
local prisonSec2 = Tabs.Prison:Section({ Title = "自身玩家设置" })

local WalkSpeedEnabled = false
local WalkSpeedValue = 50
local function updatePrisonWalkSpeed()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = WalkSpeedEnabled and WalkSpeedValue or 16
    end
end

prisonSec2:Toggle({
    Title = "移速修改",
    Desc = "开启/关闭移速修改",
    Callback = function(v)
        WalkSpeedEnabled = v
        updatePrisonWalkSpeed()
    end
})

prisonSec2:Input({
    Title = "移动速度[50默认]",
    Value = "50",
    Callback = function(text)
        local num = tonumber(text)
        if num then WalkSpeedValue = num; updatePrisonWalkSpeed() end
    end
})

local JumpPowerEnabled = false
local JumpPowerValue = 50
local function updatePrisonJumpPower()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.UseJumpPower = true
        hum.JumpPower = JumpPowerEnabled and JumpPowerValue or 50
    end
end

prisonSec2:Toggle({
    Title = "跳跃力度修改",
    Desc = "开启/关闭跳跃力度修改",
    Callback = function(v)
        JumpPowerEnabled = v
        updatePrisonJumpPower()
    end
})

prisonSec2:Input({
    Title = "跳跃力度[50默认]",
    Value = "50",
    Callback = function(text)
        local num = tonumber(text)
        if num then JumpPowerValue = num; updatePrisonJumpPower() end
    end
})

task.spawn(function()
    game:GetService("RunService").Heartbeat:Connect(function()
        updatePrisonWalkSpeed()
        updatePrisonJumpPower()
    end)
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        updatePrisonWalkSpeed()
        updatePrisonJumpPower()
    end)
end)

local InfiniteJumpPrison = false
prisonSec2:Toggle({
    Title = "无限跳跃",
    Desc = "空中也可以跳跃",
    Callback = function(v) InfiniteJumpPrison = v end
})
game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfiniteJumpPrison then
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- 隐身功能
local prisonInvisible = false
local prisonCharParts = {}

local function prisonSetupCharacter()
    local char = LocalPlayer.Character
    if not char then return end
    prisonCharParts = {}
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.Transparency == 0 then
            table.insert(prisonCharParts, part)
        end
    end
end

prisonSetupCharacter()
LocalPlayer.CharacterAdded:Connect(function()
    prisonInvisible = false
    task.wait(1)
    prisonSetupCharacter()
end)

task.spawn(function()
    local hrp
    game:GetService("RunService").Heartbeat:Connect(function()
        if prisonInvisible then
            local char = LocalPlayer.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if root and hum then
                local oldCFrame = root.CFrame
                local oldCameraOffset = hum.CameraOffset
                local targetCFrame = oldCFrame * CFrame.new(0, -75, 0)
                local offset = targetCFrame:ToObjectSpace(CFrame.new(oldCFrame.Position)).Position
                root.CFrame = targetCFrame
                hum.CameraOffset = offset
                game:GetService("RunService").RenderStepped:Wait()
                root.CFrame = oldCFrame
                hum.CameraOffset = oldCameraOffset
            end
        end
    end)
end)

prisonSec2:Toggle({
    Title = "人物隐身",
    Desc = "其他玩家看不到你",
    Callback = function(v)
        prisonInvisible = v
        for _, part in pairs(prisonCharParts) do
            if part and part.Parent then
                part.Transparency = v and 0.5 or 0
            end
        end
    end
})

-- 传送功能
local prisonSec3 = Tabs.Prison:Section({ Title = "传送功能" })

local prisonTps = {
    ["警局枪械点"] = Vector3.new(856.14, 102.62, 2256.75),
    ["小偷基地"] = Vector3.new(-981.62, 108.12, 2056.98),
    ["监狱外部"] = Vector3.new(485.23, 97.99, 2244.82),
    ["生成小偷车辆"] = Vector3.new(-915.86, 95.13, 2134.13),
    ["生成警车"] = Vector3.new(615.49, 98.20, 2488.75),
}

prisonSec3:Button({
    Title = "传送到警局枪械点",
    Callback = function()
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = CFrame.new(prisonTps["警局枪械点"]) end
    end
})

prisonSec3:Button({
    Title = "传送到小偷基地",
    Callback = function()
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = CFrame.new(prisonTps["小偷基地"]) end
    end
})

prisonSec3:Button({
    Title = "传送到监狱外部",
    Callback = function()
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = CFrame.new(prisonTps["监狱外部"]) end
    end
})

prisonSec3:Button({
    Title = "传送到小偷车辆点",
    Callback = function()
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = CFrame.new(prisonTps["生成小偷车辆"]) end
    end
})

prisonSec3:Button({
    Title = "传送到警车点",
    Callback = function()
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = CFrame.new(prisonTps["生成警车"]) end
    end
})

-- 战斗功能
local prisonSec4 = Tabs.Prison:Section({ Title = "战斗功能" })

local prisonRapidFire = false
local prisonOldNC = nil
local prisonFiringExtra = false
local prisonShootEvent = nil

task.spawn(function()
    local gr = game:GetService("ReplicatedStorage"):FindFirstChild("GunRemotes")
    if gr then
        prisonShootEvent = gr:FindFirstChild("ShootEvent")
    end
end)

prisonSec4:Button({
    Title = "武器射速999",
    Desc = "点击一次射出多发（M9/MP5/AK-47/M4A1/FAL/Remington/Revolver/M700）",
    Callback = function()
        if not prisonShootEvent then return end
        if prisonRapidFire then
            prisonRapidFire = false
            return
        end
        prisonRapidFire = true
        -- 只 hook ShootEvent 的 __namecall，不影响其他对象
        local oldNamecall
        oldNamecall = hookmetamethod(prisonShootEvent, "__namecall", newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if prisonRapidFire and not prisonFiringExtra and method == "FireServer" and self == prisonShootEvent then
                local args = {...}
                local result = oldNamecall(self, ...)
                task.spawn(function()
                    prisonFiringExtra = true
                    for i = 1, 3 do
                        task.wait(0.08)
                        if prisonRapidFire then
                            pcall(function()
                                oldNamecall(self, unpack(args))
                            end)
                        end
                    end
                    prisonFiringExtra = false
                end)
                return result
            end
            return oldNamecall(self, ...)
        end))
        prisonOldNC = oldNamecall
    end
})

local prisonInfiniteAmmo = false
local prisonAmmoConn = nil

prisonSec4:Button({
    Title = "无限弹药",
    Desc = "所有武器弹药永不减少",
    Callback = function()
        if prisonInfiniteAmmo then
            prisonInfiniteAmmo = false
            if prisonAmmoConn then
                prisonAmmoConn:Disconnect()
                prisonAmmoConn = nil
            end
            return
        end
        prisonInfiniteAmmo = true
        prisonAmmoConn = game:GetService("RunService").Heartbeat:Connect(function()
            if not prisonInfiniteAmmo then return end
            local char = LocalPlayer.Character
            if not char then return end
            for _, tool in ipairs(char:GetChildren()) do
                if tool:IsA("Tool") then
                    for _, v in ipairs(tool:GetDescendants()) do
                        if v:IsA("IntValue") or v:IsA("NumberValue") then
                            local n = string.lower(v.Name)
                            if n == "ammo" or n == "clip" or n == "currentammo" or n == "ammoleft" or n == "magazine" or n == "currentmag" then
                                local maxV = tool:FindFirstChild("MaxAmmo") or tool:FindFirstChild("MaxClip") or tool:FindFirstChild("maxAmmo") or tool:FindFirstChild("maxClip")
                                if maxV and (maxV:IsA("IntValue") or maxV:IsA("NumberValue")) then
                                    v.Value = maxV.Value
                                else
                                    v.Value = math.max(v.Value, 999)
                                end
                            end
                        end
                    end
                end
            end
            task.wait(0.5)
        end)
    end
})

prisonSec4:Button({
    Title = "获取所有武器",
    Desc = "获取MP5/AK-47/Remington 870（通过InteractWithItem）",
    Callback = function()
        pcall(function()
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local ohrp = hrp.CFrame
            local giver = workspace:FindFirstChild("Prison_ITEMS") and workspace.Prison_ITEMS:FindFirstChild("giver")
            if not giver then return end
            local interactRemote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("InteractWithItem", 5)
            if not interactRemote then return end
            local gunData = {
                ["MP5"] = {"MP5", "Meshes/MP5 (2)"},
                ["AK-47"] = {"AK-47", "Meshes/AK47_7"},
            }
            for gunName, data in pairs(gunData) do
                local gunFolder = giver:FindFirstChild(data[1])
                if gunFolder then
                    local meshPart = gunFolder:FindFirstChild(data[2])
                    if meshPart then
                        hrp.CFrame = meshPart.CFrame
                        task.wait(0.3)
                        interactRemote:InvokeServer(meshPart)
                        task.wait(0.3)
                    end
                end
            end
            -- Remington 870 (第三个子项)
            local children = giver:GetChildren()
            for _, child in ipairs(children) do
                if child.Name ~= "MP5" and child.Name ~= "AK-47" then
                    local meshPart = child:FindFirstChildOfClass("MeshPart") or child:FindFirstChildWhichIsA("MeshPart")
                    if meshPart then
                        hrp.CFrame = meshPart.CFrame
                        task.wait(0.3)
                        interactRemote:InvokeServer(meshPart)
                        task.wait(0.3)
                    end
                end
            end
            hrp.CFrame = ohrp
        end)
    end
})

-- 趣味功能
local prisonSec5 = Tabs.Prison:Section({ Title = "趣味功能" })

local prisonArrestAura = false
local prisonArrestAuraConn = nil

prisonSec5:Toggle({
    Title = "逮捕光环",
    Desc = "自动逮捕附近的所有罪犯",
    Callback = function(v)
        prisonArrestAura = v
        if v then
            prisonArrestAuraConn = game:GetService("RunService").Heartbeat:Connect(function()
                if not prisonArrestAura then return end
                task.wait(0.5)
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
                    if plr ~= LocalPlayer and plr.Character then
                        local team = plr.Team
                        if team and (team.Name == "Criminals" or team.Name == "Criminal" or team.Name == "Prisoners" or team.Name == "Prisoner" or team.Name == "Inmates") then
                            local tRoot = plr.Character:FindFirstChild("HumanoidRootPart")
                            if tRoot then
                                local dist = (hrp.Position - tRoot.Position).Magnitude
                                if dist <= 30 then
                                    pcall(function()
                                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ArrestPlayer"):InvokeServer(plr, 1)
                                    end)
                                    task.wait(0.5)
                                end
                            end
                        end
                    end
                end
            end)
        else
            if prisonArrestAuraConn then
                prisonArrestAuraConn:Disconnect()
                prisonArrestAuraConn = nil
            end
        end
    end
})

prisonSec5:Button({
    Title = "一键逮捕所有罪犯",
    Desc = "传送到每个罪犯背后并逮捕（需要手铐）",
    Callback = function()
        pcall(function()
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if not hrp or not hum or hum.Health <= 0 then return end
            local arrestRemote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ArrestPlayer")
            local oPos = hrp.CFrame
            for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character then
                    local team = plr.Team
                    if team and (team.Name == "Criminals" or team.Name == "Criminal") then
                        local tRoot = plr.Character:FindFirstChild("HumanoidRootPart")
                        if tRoot then
                            local lookVec = tRoot.CFrame.LookVector
                            local behind = tRoot.Position - (lookVec * 3)
                            hrp.CFrame = CFrame.new(behind, tRoot.Position)
                            task.wait(0.3)
                            pcall(function()
                                arrestRemote:InvokeServer(plr, 1)
                            end)
                            task.wait(0.5)
                            if not (LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health > 0) then
                                return
                            end
                        end
                    end
                end
            end
            hrp.CFrame = oPos
        end)
    end
})

prisonSec5:Button({
    Title = "成为罪犯",
    Desc = "传送到罪犯出生点自动加入罪犯阵营",
    Callback = function()
        pcall(function()
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local oPos = hrp.CFrame
            local crimSpawn = workspace:FindFirstChild("Criminals Spawn")
            if crimSpawn then
                local spawnLoc = crimSpawn:FindFirstChild("SpawnLocation")
                if spawnLoc then
                    hrp.CFrame = spawnLoc.CFrame
                    task.wait(3)
                    hrp.CFrame = oPos
                end
            end
        end)
    end
})

-- 究极分区
local prisonSec6 = Tabs.Prison:Section({ Title = "究极" })

prisonSec6:Button({
    Title = "如果你受够就开此按钮（超模）",
    Desc = "加载超模脚本，效果离谱慎用",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/f34p9fh3a4/.xyz/refs/heads/main/loader.lua"))()
        end)
    end
})

Window:SelectTab(2)
if Window.Unload then
    Window.Unload:Connect(function()
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local function ClearSignalConnections(signal)
        for _, conn in ipairs(getconnections(signal)) do
            pcall(conn.Disconnect, conn)
        end
    end
    ClearSignalConnections(RunService.RenderStepped)
    ClearSignalConnections(RunService.Heartbeat)
    ClearSignalConnections(RunService.Stepped)
    ClearSignalConnections(UserInputService.InputBegan)
    ClearSignalConnections(UserInputService.InputChanged)
    ClearSignalConnections(UserInputService.InputEnded)
    getgenv().enabled = false
    autoInteract = false
    JS = nil
    ZR = nil
    ZZ = nil
    ZQ = nil
    local bootGui = game.CoreGui:FindFirstChild("DeltaForceBootAnimation")
    if bootGui then
        pcall(function() bootGui:Destroy() end)
    end
    if getgenv().ESP_Cache then
        for _, data in pairs(getgenv().ESP_Cache) do
            if data.Highlight then pcall(data.Highlight.Destroy, data.Highlight) end
            if data.Billboard then pcall(data.Billboard.Destroy, data.Billboard) end
        end
        table.clear(getgenv().ESP_Cache)
    end
    if getgenv().DrawList then
        for _, drawObj in pairs(getgenv().DrawList) do
            drawObj.Visible = false
            pcall(drawObj.Remove, drawObj)
        end
        table.clear(getgenv().DrawList)
    end
    for _, tweenObj in ipairs(TweenService:GetTweens()) do
        pcall(tweenObj.Cancel, tweenObj)
    end
    if getgenv().tabIconTask then
        task.cancel(getgenv().tabIconTask)
        getgenv().tabIconTask = nil
    end
    print("✅ 脚本卸载：所有连接、缓存、后台线程清理完成")
end)
end
end) -- end of pcall
if not mainScriptSuccess then
    showErrorPopup(tostring(mainScriptError))
end
