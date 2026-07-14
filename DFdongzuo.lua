-- ============================================================
-- Delta Force 动作包 独立脚本
-- 从 jack.lua 提取的动作包系统
-- ============================================================

if not game.Loaded then game.Loaded:Wait() end

local LocalPlayer = game:GetService("Players").LocalPlayer

-- WindUI 加载
local WindUI = nil
local mainScriptSuccess, mainScriptError = pcall(function()
WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/yuihghghg/RJ/refs/heads/main/ui.lua"))()
end)

if not mainScriptSuccess or not WindUI then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "动作包",
        Text = "WindUI 加载失败: " .. tostring(mainScriptError),
        Duration = 5
    })
    return
end

WindUI:Notify({
    Title = "动作包",
    Content = "Delta Force 动作包已加载",
    Duration = 3,
    Position = "Left"
})

-- WindUI 主题设置 (DeltaForce)
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

-- 创建独立 Window
local Window = WindUI:CreateWindow({
    Title = "Delta Force 动作包",
    Author = "User",
    Folder = "EmoteHub",
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

local sjzIcon = "https://i.postimg.cc/d1sH5qJN/1781878127576.png"

-- 创建 Emote Tab
local Tabs = {}
Tabs.Emote = Window:Tab({ Title = "🎭动作包", Icon = sjzIcon })

-- ============================================================
-- 动作包系统 (AFEM Emote System - WindUI Based)
-- 所有动作和动画包数据已内嵌，无需网络请求
-- ============================================================

local emHttp = game:GetService("HttpService")
local emLoaded = true
local emoteList = {}
local packList = {}
local currentTrack = nil
local emSearchGui = nil

local function emStopAll()
    pcall(function()
        if currentTrack then currentTrack:Stop() currentTrack = nil end
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                local anim = hum:FindFirstChildOfClass("Animator")
                if anim then
                    for _, t in ipairs(anim:GetPlayingAnimationTracks()) do t:Stop() end
                end
            end
        end
    end)
end

local function emPlay(animId)
    emStopAll()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        local animator = hum:FindFirstChildOfClass("Animator")
        if animator then
            local anim = Instance.new("Animation")
            anim.AnimationId = animId
            local track = animator:LoadAnimation(anim)
            if track then
                currentTrack = track
                track:Play()
                track.Looped = false
                track.Ended:Connect(function() if currentTrack == track then currentTrack = nil end end)
                return
            end
        end
        local animate = char:FindFirstChild("Animate")
        if animate and animate:FindFirstChild("PlayEmote") then
            local anim = Instance.new("Animation")
            anim.AnimationId = animId
            animate.PlayEmote:Invoke(anim)
        end
    end)
end

-- Emote data embedded directly (no network fetch needed)
do
    local _list = {}
    _list[#_list + 1] = {name = "地板霹雳舞 - Tommy Hilfiger", origName = "Floor Rock Freeze - Tommy Hilfiger", animId = "http://www.roblox.com/asset/?id=10214314957", marketId = 10214411646}
    _list[#_list + 1] = {name = "逛街表情", origName = "Around Town Face", animId = "http://www.roblox.com/asset/?id=10713981723", marketId = 10724075136}
    _list[#_list + 1] = {name = "鼓王 - Royal Blood", origName = "Drum Master - Royal Blood", animId = "http://www.roblox.com/asset/?id=10714070681", marketId = 6531538868}
    _list[#_list + 1] = {name = "TWICE - Nayeon流行舞", origName = "TWICE Pop by Nayeon", animId = "http://www.roblox.com/asset/?id=13768941455", marketId = 13768975574}
    _list[#_list + 1] = {name = "blah blah表情", origName = "Blah Blah Face", animId = "http://www.roblox.com/asset/?id=10713986541", marketId = 10724082211}
    _list[#_list + 1] = {name = "超级冲刺", origName = "Super Charge", animId = "http://www.roblox.com/asset/?id=10478338114", marketId = 10478368365}
    _list[#_list + 1] = {name = "摇滚手势表情", origName = "Rock On Face", animId = "http://www.roblox.com/asset/?id=10714403700", marketId = 10724743832}
    _list[#_list + 1] = {name = "旋转", origName = "Twirl", animId = "http://www.roblox.com/asset/?id=10714293450", marketId = 3716633898}
    _list[#_list + 1] = {name = "轰鸣", origName = "Vroom Vroom", animId = "http://www.roblox.com/asset/?id=18526397037", marketId = 18526410572}
    _list[#_list + 1] = {name = "兔子跳表情", origName = "Bunny Hop Face", animId = "http://www.roblox.com/asset/?id=10714004791", marketId = 10724100901}
    _list[#_list + 1] = {name = "迷你金刚", origName = "Mini Kong", animId = "http://www.roblox.com/asset/?id=17000021306", marketId = 17000058939}
    _list[#_list + 1] = {name = "胜利之舞", origName = "Victory Dance", animId = "http://www.roblox.com/asset/?id=15505456446", marketId = 15506503658}
    _list[#_list + 1] = {name = "拳击表情", origName = "Boxing Punch Face", animId = "http://www.roblox.com/asset/?id=10717116749", marketId = 10724095946}
    _list[#_list + 1] = {name = "扭臀舞 - Zara Larsson", origName = "Hips Poppin' - Zara Larsson", animId = "http://www.roblox.com/asset/?id=10714364213", marketId = 6797919579}
    _list[#_list + 1] = {name = "架子鼓独奏 - Royal Blood", origName = "Drum Solo - Royal Blood", animId = "http://www.roblox.com/asset/?id=10714074218", marketId = 6532844183}
    _list[#_list + 1] = {name = "嗖嗖表情", origName = "Swish Face", animId = "http://www.roblox.com/asset/?id=10714349738", marketId = 10724795160}
    _list[#_list + 1] = {name = "Panini舞 - Lil Nas X", origName = "Panini Dance - Lil Nas X (LNX)", animId = "http://www.roblox.com/asset/?id=10714394082", marketId = 5915781665}
    _list[#_list + 1] = {name = "海豚舞表情", origName = "Dolphin Dance Face", animId = "http://www.roblox.com/asset/?id=10714068222", marketId = 10724129066}
    _list[#_list + 1] = {name = "扭臂表情", origName = "Arm Twist Face", animId = "http://www.roblox.com/asset/?id=10713968716", marketId = 10724072953}
    _list[#_list + 1] = {name = "眼镜蛇手臂 - Tai Verdes", origName = "Cobra Arms - Tai Verdes", animId = "http://www.roblox.com/asset/?id=10714022275", marketId = 7942964447}
    _list[#_list + 1] = {name = "Nicki Minaj - Super Bass", origName = "Nicki Minaj That's That Super Bass Emote", animId = "http://www.roblox.com/asset/?id=15571446961", marketId = 15571536896}
    _list[#_list + 1] = {name = "开心", origName = "Happy", animId = "http://www.roblox.com/asset/?id=10714352626", marketId = 4849499887}
    _list[#_list + 1] = {name = "宝宝舞", origName = "Baby Dance", animId = "http://www.roblox.com/asset/?id=10713983178", marketId = 4272484885}
    _list[#_list + 1] = {name = "Rasputin - Boney M.", origName = "Rasputin – Boney M.", animId = "http://www.roblox.com/asset/?id=114872820353992", marketId = 133477296392756}
    _list[#_list + 1] = {name = "Tommy K-Pop 麦克风掉落", origName = "Tommy K-Pop Mic Drop", animId = "http://www.roblox.com/asset/?id=14024642130", marketId = 14024722653}
    _list[#_list + 1] = {name = "霹雳舞表情", origName = "Top Rock Face", animId = "http://www.roblox.com/asset/?id=10714336041", marketId = 10724158202}
    _list[#_list + 1] = {name = "Mae Stephens - 手臂波浪", origName = "Mae Stephens – Arm Wave", animId = "http://www.roblox.com/asset/?id=16584481352", marketId = 16584496781}
    _list[#_list + 1] = {name = "胜利 - 24kGoldn", origName = "Victory - 24kGoldn", animId = "http://www.roblox.com/asset/?id=10714171628", marketId = 9178397781}
    _list[#_list + 1] = {name = "BLACKPINK - Shut Down 第一部", origName = "BLACKPINK Shut Down - Part 1", animId = "http://www.roblox.com/asset/?id=14901306096", marketId = 14901369589}
    _list[#_list + 1] = {name = "Elton John - 摇滚", origName = "Elton John - Rock Out", animId = "http://www.roblox.com/asset/?id=11753474067", marketId = 11753545334}
    _list[#_list + 1] = {name = "兔子跳", origName = "Bunny Hop", animId = "http://www.roblox.com/asset/?id=10714004791", marketId = 4646296016}
    _list[#_list + 1] = {name = "高挥手表情", origName = "High Wave Face", animId = "http://www.roblox.com/asset/?id=10714362852", marketId = 10724583652}
    _list[#_list + 1] = {name = "桑巴舞", origName = "Samba", animId = "http://www.roblox.com/asset/?id=10714386947", marketId = 6869813008}
    _list[#_list + 1] = {name = "发抖表情", origName = "Shiver Face", animId = "http://www.roblox.com/asset/?id=10714379581", marketId = 10724764698}
    _list[#_list + 1] = {name = "BLACKPINK Pink Venom - Get em", origName = "BLACKPINK Pink Venom - Get em Get em Get em", animId = "http://www.roblox.com/asset/?id=14548619594", marketId = 14548709888}
    _list[#_list + 1] = {name = "机器人M3GAN", origName = "Robot M3GAN", animId = "http://www.roblox.com/asset/?id=125803725853577", marketId = 90569436057900}
    _list[#_list + 1] = {name = "伤心表情", origName = "Sad Face", animId = "http://www.roblox.com/asset/?id=10714392876", marketId = 10724750483}
    _list[#_list + 1] = {name = "Baby Queen - 空气吉他与滑膝", origName = "Baby Queen - Air Guitar & Knee Slide", animId = "http://www.roblox.com/asset/?id=14352335202", marketId = 14353417553}
    _list[#_list + 1] = {name = "美艳触地", origName = "Beauty Touchdown", animId = "http://www.roblox.com/asset/?id=16302968986", marketId = 16303091119}
    _list[#_list + 1] = {name = "Stray Kids - 水上行走", origName = "Stray Kids Walkin On Water", animId = "http://www.roblox.com/asset/?id=125064469983655", marketId = 100773414188482}
    _list[#_list + 1] = {name = "摇滚手势", origName = "Rock On", animId = "http://www.roblox.com/asset/?id=10714403700", marketId = 5915782672}
    _list[#_list + 1] = {name = "巴宝莉绽放表情", origName = "Burberry Bloom Face", animId = "http://www.roblox.com/asset/?id=10714007154", marketId = 10724103239}
    _list[#_list + 1] = {name = "英雄落地表情", origName = "Hero Landing Face", animId = "http://www.roblox.com/asset/?id=10714360164", marketId = 10724578114}
    _list[#_list + 1] = {name = "GDMC", origName = "gdmc", animId = "http://www.roblox.com/asset/?id=13694101936", marketId = 13694143234}
    _list[#_list + 1] = {name = "TWICE - 什么是爱", origName = "TWICE What Is Love", animId = "http://www.roblox.com/asset/?id=13327655243", marketId = 13344121112}
    _list[#_list + 1] = {name = "最伟大表情", origName = "Greatest Face", animId = "http://www.roblox.com/asset/?id=10714349037", marketId = 10724561821}
    _list[#_list + 1] = {name = "鼓王表情", origName = "Drum Master Royal Blood Face", animId = "http://www.roblox.com/asset/?id=10714070681", marketId = 10724133813}
    _list[#_list + 1] = {name = "Elton John - 心形舞步", origName = "Elton John - Heart Shuffle", animId = "http://www.roblox.com/asset/?id=17748314784", marketId = 17748346932}
    _list[#_list + 1] = {name = "无聊", origName = "Bored", animId = "http://www.roblox.com/asset/?id=10713992055", marketId = 5230661597}
    _list[#_list + 1] = {name = "招手表情", origName = "Beckon Face", animId = "http://www.roblox.com/asset/?id=10713984554", marketId = 10724080069}
    _list[#_list + 1] = {name = "行屈膝礼", origName = "Curtsy", animId = "http://www.roblox.com/asset/?id=10714061912", marketId = 4646306583}
    _list[#_list + 1] = {name = "杰克舞步", origName = "Jacks", animId = "http://www.roblox.com/asset/?id=10714375667", marketId = 3570649048}
    _list[#_list + 1] = {name = "TWICE - Feel Special", origName = "TWICE Feel Special", animId = "http://www.roblox.com/asset/?id=14899980745", marketId = 14900153406}
    _list[#_list + 1] = {name = "害羞", origName = "Shy", animId = "http://www.roblox.com/asset/?id=10714369325", marketId = 3576717965}
    _list[#_list + 1] = {name = "Jawny - 跺脚", origName = "Jawny - Stomp", animId = "http://www.roblox.com/asset/?id=16392075853", marketId = 16392120020}
    _list[#_list + 1] = {name = "时尚攀爬", origName = "Stylish Climb", animId = "http://www.roblox.com/asset/?id=10921271391", marketId = 619509955}
    _list[#_list + 1] = {name = "Gashina - SUNMI", origName = "Gashina - SUNMI", animId = "http://www.roblox.com/asset/?id=9527886709", marketId = 9528294735}
    _list[#_list + 1] = {name = "空气吉他", origName = "Air Guitar", animId = "http://www.roblox.com/asset/?id=10713959108", marketId = 3696761354}
    _list[#_list + 1] = {name = "老城路表情", origName = "Old Town Road Dance LNX Face", animId = "http://www.roblox.com/asset/?id=10714391240", marketId = 10724722774}
    _list[#_list + 1] = {name = "Olivia Rodrigo - 漂浮坠落", origName = "Olivia Rodrigo Fall Back to Float", animId = "http://www.roblox.com/asset/?id=15549124879", marketId = 15554016057}
    _list[#_list + 1] = {name = "鼓手动作 - Twenty One Pilots", origName = "Drummer Moves - Twenty One Pilots", animId = "http://www.roblox.com/asset/?id=10714072822", marketId = 7422838770}
    _list[#_list + 1] = {name = "指挥家 - George Ezra", origName = "The Conductor - George Ezra", animId = "http://www.roblox.com/asset/?id=10370359115", marketId = 10370926562}
    _list[#_list + 1] = {name = "天鹅舞表情", origName = "Swan Dance Face", animId = "http://www.roblox.com/asset/?id=10714352930", marketId = 10724792751}
    _list[#_list + 1] = {name = "HH2", origName = "hh2", animId = "http://www.roblox.com/asset/?id=14851541605", marketId = 14851597817}
    _list[#_list + 1] = {name = "怒吼表情", origName = "Borocks Rage Face", animId = "http://www.roblox.com/asset/?id=10713999630", marketId = 10724092960}
    _list[#_list + 1] = {name = "耸肩", origName = "Shrug", animId = "http://www.roblox.com/asset/?id=10714374484", marketId = 3576968026}
    _list[#_list + 1] = {name = "Elton John - 心跳", origName = "Elton John - Heart Skip", animId = "http://www.roblox.com/asset/?id=11309255148", marketId = 11309263077}
    _list[#_list + 1] = {name = "BLACKPINK Lisa - Money", origName = "BLACKPINK LISA Money", animId = "http://www.roblox.com/asset/?id=15679623052", marketId = 15679957363}
    _list[#_list + 1] = {name = "周六舞表情", origName = "Saturday Dance Face", animId = "http://www.roblox.com/asset/?id=10714382522", marketId = 10724762302}
    _list[#_list + 1] = {name = "5G超速舞步", origName = "Hyperfast 5G Dance Move", animId = "http://www.roblox.com/asset/?id=10714371264", marketId = 9408642191}
    _list[#_list + 1] = {name = "空气吉他(备用)", origName = "Emote_AirGuitar", animId = "http://www.roblox.com/asset/?id=10713959108", marketId = 10706515130}
    _list[#_list + 1] = {name = "体育场表情", origName = "Stadium Face", animId = "http://www.roblox.com/asset/?id=10714356920", marketId = 10724787518}
    _list[#_list + 1] = {name = "Baby Queen - 面部特写", origName = "Baby Queen - Face Frame", animId = "http://www.roblox.com/asset/?id=14352340648", marketId = 14353421343}
    _list[#_list + 1] = {name = "美国队霹雳舞", origName = "Team USA Breaking Emote", animId = "http://www.roblox.com/asset/?id=18526288497", marketId = 18526338976}
    _list[#_list + 1] = {name = "hype舞表情", origName = "Hype Dance Face", animId = "http://www.roblox.com/asset/?id=10714369624", marketId = 10724596932}
    _list[#_list + 1] = {name = "THHS V3", origName = "thhsv3", animId = "http://www.roblox.com/asset/?id=14109772540", marketId = 14109936431}
    _list[#_list + 1] = {name = "BBY", origName = "bby", animId = "http://www.roblox.com/asset/?id=14851544078", marketId = 14851599382}
    _list[#_list + 1] = {name = "猴子", origName = "Monkey", animId = "http://www.roblox.com/asset/?id=10714388352", marketId = 3716636630}
    _list[#_list + 1] = {name = "BLACKPINK - As If It's Your Last", origName = "BLACKPINK As If It's Your Last", animId = "http://www.roblox.com/asset/?id=18855536648", marketId = 18855603653}
    _list[#_list + 1] = {name = "M3GAN之舞", origName = "M3GAN's Dance", animId = "http://www.roblox.com/asset/?id=99649534578309", marketId = 127271798262177}
    _list[#_list + 1] = {name = "崛起 - The Chainsmokers", origName = "Rise Above - The Chainsmokers", animId = "http://www.roblox.com/asset/?id=12992262118", marketId = 13071993910}
    _list[#_list + 1] = {name = "体育场", origName = "Stadium", animId = "http://www.roblox.com/asset/?id=10714356920", marketId = 3360686498}
    _list[#_list + 1] = {name = "不是我的错 - Zara Larsson", origName = "It Ain't My Fault - Zara Larsson", animId = "http://www.roblox.com/asset/?id=10714374267", marketId = 6797948622}
    _list[#_list + 1] = {name = "霹雳舞测试", origName = "TopRock - Test", animId = "http://www.roblox.com/asset/?id=3058460854", marketId = 3061648072}
    _list[#_list + 1] = {name = "高举双手表情", origName = "High Hands Face", animId = "http://www.roblox.com/asset/?id=10714361543", marketId = 10724580385}
    _list[#_list + 1] = {name = "OK手势 - Tai Verdes", origName = "AOK - Tai Verdes", animId = "http://www.roblox.com/asset/?id=10713962506", marketId = 7942960760}
    _list[#_list + 1] = {name = "TWICE - Like Ooh-Ahh", origName = "TWICE Like Ooh-Ahh", animId = "http://www.roblox.com/asset/?id=14123781004", marketId = 14124050904}
    _list[#_list + 1] = {name = "机器人", origName = "Robot", animId = "http://www.roblox.com/asset/?id=10714392151", marketId = 3576721660}
    _list[#_list + 1] = {name = "Elton John - 升华", origName = "Elton John - Elevate", animId = "http://www.roblox.com/asset/?id=11394033602", marketId = 11394056822}
    _list[#_list + 1] = {name = "假日表情", origName = "Holiday Dance LNX Face", animId = "http://www.roblox.com/asset/?id=10714365721", marketId = 10724589591}
    _list[#_list + 1] = {name = "牙线舞", origName = "Floss Dance", animId = "http://www.roblox.com/asset/?id=10714340543", marketId = 5917570207}
    _list[#_list + 1] = {name = "空中舞蹈", origName = "Air Dance", animId = "http://www.roblox.com/asset/?id=10713957138", marketId = 4646302011}
    _list[#_list + 1] = {name = "滚石吉他弹奏", origName = "Rolling Stones Guitar Strum", animId = "http://www.roblox.com/asset/?id=18148804340", marketId = 18148839527}
    _list[#_list + 1] = {name = "出去表情", origName = "Get Out Face", animId = "http://www.roblox.com/asset/?id=10714345862", marketId = 10724556943}
    _list[#_list + 1] = {name = "瑜伽莲花坐", origName = "Alo Yoga Pose - Lotus Position", animId = "http://www.roblox.com/asset/?id=12507085924", marketId = 12507097350}
    _list[#_list + 1] = {name = "悬浮 - Cuco", origName = "Cuco - Levitate", animId = "http://www.roblox.com/asset/?id=15698404340", marketId = 15698511500}
    _list[#_list + 1] = {name = "Olivia Rodrigo - good 4 u", origName = "Olivia Rodrigo good 4 u", animId = "http://www.roblox.com/asset/?id=15517862739", marketId = 15554013003}
    _list[#_list + 1] = {name = "HH1", origName = "hh1", animId = "http://www.roblox.com/asset/?id=14851539444", marketId = 14851596394}
    _list[#_list + 1] = {name = "NBA怪兽扣篮", origName = "NBA Monster Dunk", animId = "http://www.roblox.com/asset/?id=132748833449150", marketId = 117511481049460}
    _list[#_list + 1] = {name = "杰克舞步表情", origName = "Jacks Face", animId = "http://www.roblox.com/asset/?id=10714375667", marketId = 10724611182}
    _list[#_list + 1] = {name = "TWICE - 擒拿 第一部", origName = "TWICE Takedown pt 1 from Kpop Demon Hunters", animId = "http://www.roblox.com/asset/?id=140182843839424", marketId = 94796833553521}
    _list[#_list + 1] = {name = "BLACKPINK - DDU-DU DDU-DU", origName = "BLACKPINK DDU-DU DDU-DU", animId = "http://www.roblox.com/asset/?id=16553170471", marketId = 16553262614}
    _list[#_list + 1] = {name = "宝宝舞表情", origName = "Baby Dance Face", animId = "http://www.roblox.com/asset/?id=10713983178", marketId = 10724077540}
    _list[#_list + 1] = {name = "侧翻 - George Ezra", origName = "Cartwheel - George Ezra", animId = "http://www.roblox.com/asset/?id=10370351535", marketId = 10370929905}
    _list[#_list + 1] = {name = "瑜伽战士二式", origName = "Alo Yoga Pose - Warrior II", animId = "http://www.roblox.com/asset/?id=12507083048", marketId = 12507106431}
    _list[#_list + 1] = {name = "偶像", origName = "Idol", animId = "http://www.roblox.com/asset/?id=10714372526", marketId = 4102317848}
    _list[#_list + 1] = {name = "更大声", origName = "Louder", animId = "http://www.roblox.com/asset/?id=10714385204", marketId = 3576751796}
    _list[#_list + 1] = {name = "左右移动表情", origName = "Side to Side Face", animId = "http://www.roblox.com/asset/?id=10714366910", marketId = 10724780384}
    _list[#_list + 1] = {name = "钓鱼表情", origName = "Fishing Face", animId = "http://www.roblox.com/asset/?id=10714101749", marketId = 10724549462}
    _list[#_list + 1] = {name = "恰恰舞表情", origName = "Cha Cha Face", animId = "http://www.roblox.com/asset/?id=10714018192", marketId = 10724113524}
    _list[#_list + 1] = {name = "发脾气", origName = "Tantrum", animId = "http://www.roblox.com/asset/?id=10714340558", marketId = 5104374556}
    _list[#_list + 1] = {name = "同意表情", origName = "Agree Face", animId = "http://www.roblox.com/asset/?id=10713954623", marketId = 10706508686}
    _list[#_list + 1] = {name = "TWICE - I GOT YOU 第二部", origName = "TWICE I GOT YOU part 2", animId = "http://www.roblox.com/asset/?id=16256203246", marketId = 16256253954}
    _list[#_list + 1] = {name = "TWICE - LIKEY", origName = "TWICE LIKEY", animId = "http://www.roblox.com/asset/?id=14899979575", marketId = 14900151704}
    _list[#_list + 1] = {name = "Stray Kids - MANIAC", origName = "MANIAC - Stray Kids", animId = "http://www.roblox.com/asset/?id=11309304959", marketId = 11309309359}
    _list[#_list + 1] = {name = "发脾气表情", origName = "Tantrum Face", animId = "http://www.roblox.com/asset/?id=10714340558", marketId = 10724429547}
    _list[#_list + 1] = {name = "树表情", origName = "Tree Face", animId = "http://www.roblox.com/asset/?id=10714330764", marketId = 10724154153}
    _list[#_list + 1] = {name = "最伟大", origName = "Greatest", animId = "http://www.roblox.com/asset/?id=10714349037", marketId = 3762654854}
    _list[#_list + 1] = {name = "The Zabb", origName = "The Zabb", animId = "http://www.roblox.com/asset/?id=129470135909814", marketId = 71389516735424}
    _list[#_list + 1] = {name = "派对达人表情", origName = "Block Partier Face", animId = "http://www.roblox.com/asset/?id=10713988674", marketId = 10715267454}
    _list[#_list + 1] = {name = "倾斜", origName = "Tilt", animId = "http://www.roblox.com/asset/?id=10714338461", marketId = 3360692915}
    _list[#_list + 1] = {name = "Tommy - 射箭", origName = "Tommy - Archer", animId = "http://www.roblox.com/asset/?id=13823324057", marketId = 13823339506}
    _list[#_list + 1] = {name = "BLACKPINK - Shut Down 第二部", origName = "BLACKPINK Shut Down - Part 2", animId = "http://www.roblox.com/asset/?id=14901308987", marketId = 14901371589}
    _list[#_list + 1] = {name = "僵尸", origName = "Zombie", animId = "http://www.roblox.com/asset/?id=10714089137", marketId = 4212496830}
    _list[#_list + 1] = {name = "Thanos开心跳 - 鱿鱼游戏", origName = "Thanos Happy Jump - Squid Game", animId = "http://www.roblox.com/asset/?id=97611664803614", marketId = 82217023310738}
    _list[#_list + 1] = {name = "Bone Chillin Bop", origName = "Bone Chillin' Bop", animId = "http://www.roblox.com/asset/?id=15122972413", marketId = 15123050663}
    _list[#_list + 1] = {name = "周六舞 - Twenty One Pilots", origName = "Saturday Dance - Twenty One Pilots", animId = "http://www.roblox.com/asset/?id=10714382522", marketId = 7422833723}
    _list[#_list + 1] = {name = "你好表情", origName = "Hello Face", animId = "http://www.roblox.com/asset/?id=10714359093", marketId = 10724574725}
    _list[#_list + 1] = {name = "上上下下 - Twenty One Pilots", origName = "Up and Down - Twenty One Pilots", animId = "http://www.roblox.com/asset/?id=10714174918", marketId = 7422843994}
    _list[#_list + 1] = {name = "拉我下去表情 - Zara Larsson", origName = "Take Me Under Zara Larsson Face", animId = "http://www.roblox.com/asset/?id=10714345459", marketId = 10724435211}
    _list[#_list + 1] = {name = "超级英雄登场表情", origName = "Superhero Reveal Face", animId = "http://www.roblox.com/asset/?id=10714355069", marketId = 10724789914}
    _list[#_list + 1] = {name = "桑巴步舞", origName = "Samba Step Dance", animId = "http://www.roblox.com/asset/?id=14620742793", marketId = 14620757085}
    _list[#_list + 1] = {name = "左右移动", origName = "Side to Side", animId = "http://www.roblox.com/asset/?id=10714366910", marketId = 3762641826}
    _list[#_list + 1] = {name = "TH-AFSC", origName = "th-afsc", animId = "http://www.roblox.com/asset/?id=14024645241", marketId = 14024725245}
    _list[#_list + 1] = {name = "Mae Stephens - 钢琴手", origName = "Mae Stephens - Piano Hands", animId = "http://www.roblox.com/asset/?id=16553163212", marketId = 16553249658}
    _list[#_list + 1] = {name = "SpongeBob Imaginaaation 🌈", origName = "SpongeBob Imaginaaation 🌈", animId = "http://www.roblox.com/asset/?id=18443237526", marketId = 18443268949}
    _list[#_list + 1] = {name = "面部体操", origName = "Face Calisthenics", animId = "http://www.roblox.com/asset/?id=9830680869", marketId = 9830731012}
    _list[#_list + 1] = {name = "甩头", origName = "Head Banging", animId = "http://www.roblox.com/asset/?id=5915711491", marketId = 5915779725}
    _list[#_list + 1] = {name = "钓鱼", origName = "Fishing", animId = "http://www.roblox.com/asset/?id=10714101749", marketId = 3994129128}
    _list[#_list + 1] = {name = "睡觉", origName = "Sleep", animId = "http://www.roblox.com/asset/?id=10714360343", marketId = 4689362868}
    _list[#_list + 1] = {name = "抱团表情", origName = "Huddle Face", animId = "http://www.roblox.com/asset/?id=10714366893", marketId = 10724591600}
    _list[#_list + 1] = {name = "新舞蹈", origName = "newdance", animId = "http://www.roblox.com/asset/?id=14352353329", marketId = 14352435946}
    _list[#_list + 1] = {name = "待机动画", origName = "Idle Animation", animId = "http://www.roblox.com/asset/?id=4417977954", marketId = 4418326547}
    _list[#_list + 1] = {name = "英熙转头 - 鱿鱼游戏", origName = "Young-hee Head Spin - Squid Game", animId = "http://www.roblox.com/asset/?id=112011282168475", marketId = 134615135651900}
    _list[#_list + 1] = {name = "The Weeknd - Starboy猫步", origName = "The Weeknd Starboy Strut", animId = "http://www.roblox.com/asset/?id=71105746210464", marketId = 130245358716273}
    _list[#_list + 1] = {name = "KATSEYE - Touch", origName = "KATSEYE - Touch", animId = "http://www.roblox.com/asset/?id=135876612109535", marketId = 139021427684680}
    _list[#_list + 1] = {name = "霹雳舞", origName = "Top Rock", animId = "http://www.roblox.com/asset/?id=10714336041", marketId = 3570535774}
    _list[#_list + 1] = {name = "高挥手", origName = "High Wave", animId = "http://www.roblox.com/asset/?id=10714362852", marketId = 5915776835}
    _list[#_list + 1] = {name = "开心表情", origName = "Happy Face", animId = "http://www.roblox.com/asset/?id=10714352626", marketId = 10724566501}
    _list[#_list + 1] = {name = "曼城单车射门", origName = "Man City Bicycle Kick", animId = "http://www.roblox.com/asset/?id=13421057998", marketId = 13422286833}
    _list[#_list + 1] = {name = "Elton John - 依然挺立", origName = "Elton John - Still Standing", animId = "http://www.roblox.com/asset/?id=11444443576", marketId = 11435177473}
    _list[#_list + 1] = {name = "猴子表情", origName = "Monkey Face", animId = "http://www.roblox.com/asset/?id=10714388352", marketId = 10724718533}
    _list[#_list + 1] = {name = "跳跃欢呼表情", origName = "Jumping Cheer Face", animId = "http://www.roblox.com/asset/?id=10714376994", marketId = 10724681291}
    _list[#_list + 1] = {name = "BLACKPINK - Lovesick Girls", origName = "BLACKPINK - Lovesick Girls", animId = "http://www.roblox.com/asset/?id=16874472321", marketId = 16874600526}
    _list[#_list + 1] = {name = "面部测试行走", origName = "Face Test Walk", animId = "http://www.roblox.com/asset/?id=9803605108", marketId = 9803628950}
    _list[#_list + 1] = {name = "头晕", origName = "Dizzy", animId = "http://www.roblox.com/asset/?id=10714066964", marketId = 3934986896}
    _list[#_list + 1] = {name = "花式脚步表情", origName = "Fancy Feet Face", animId = "http://www.roblox.com/asset/?id=10714076981", marketId = 10724542904}
    _list[#_list + 1] = {name = "TWICE - Strategy", origName = "TWICE Strategy", animId = "http://www.roblox.com/asset/?id=97311229290836", marketId = 106862678450011}
    _list[#_list + 1] = {name = "奥运下马", origName = "Olympic Dismount", animId = "http://www.roblox.com/asset/?id=18665825805", marketId = 18666650035}
    _list[#_list + 1] = {name = "不同意表情", origName = "Disagree Face", animId = "http://www.roblox.com/asset/?id=10714065135", marketId = 10724124755}
    _list[#_list + 1] = {name = "Elton John - 钢琴跳跃", origName = "Elton John - Piano Jump", animId = "http://www.roblox.com/asset/?id=11453082181", marketId = 11453096488}
    _list[#_list + 1] = {name = "Nicki Minaj - Anaconda", origName = "Nicki Minaj Anaconda", animId = "http://www.roblox.com/asset/?id=15571450952", marketId = 15571539403}
    _list[#_list + 1] = {name = "Annyeong (안녕)", origName = "Annyeong (안녕)", animId = "http://www.roblox.com/asset/?id=9527883498", marketId = 9528286240}
    _list[#_list + 1] = {name = "花式脚步", origName = "Fancy Feet", animId = "http://www.roblox.com/asset/?id=10714076981", marketId = 3934988903}
    _list[#_list + 1] = {name = "宁静波浪", origName = "Quiet Waves", animId = "http://www.roblox.com/asset/?id=10714390497", marketId = 7466046574}
    _list[#_list + 1] = {name = "摇滚吉他 - Royal Blood", origName = "Rock Guitar - Royal Blood", animId = "http://www.roblox.com/asset/?id=10714393929", marketId = 6532155086}
    _list[#_list + 1] = {name = "怒吼", origName = "Borock's Rage", animId = "http://www.roblox.com/asset/?id=10713999630", marketId = 3236848555}
    _list[#_list + 1] = {name = "Nicki Minaj - Boom Boom Boom", origName = "Nicki Minaj Boom Boom Boom", animId = "http://www.roblox.com/asset/?id=15571448688", marketId = 15571538346}
    _list[#_list + 1] = {name = "Paris Hilton - 标志性IT女孩", origName = "Paris Hilton - Iconic IT-Grrrl", animId = "http://www.roblox.com/asset/?id=15392756794", marketId = 15392932768}
    _list[#_list + 1] = {name = "Baby Queen - 弹跳旋转", origName = "Baby Queen - Bouncy Twirl", animId = "http://www.roblox.com/asset/?id=14352343065", marketId = 14353423348}
    _list[#_list + 1] = {name = "面部测试跑步", origName = "Face Test Run", animId = "http://www.roblox.com/asset/?id=9801814462", marketId = 9803627020}
    _list[#_list + 1] = {name = "TWICE - Set Me Free 舞蹈2", origName = "TWICE Set Me Free - Dance 2", animId = "http://www.roblox.com/asset/?id=12714231087", marketId = 12715397488}
    _list[#_list + 1] = {name = "巴宝莉宝石表情", origName = "Burberry Gem Face", animId = "http://www.roblox.com/asset/?id=10714008655", marketId = 10724105474}
    _list[#_list + 1] = {name = "BLACKPINK - Boombayah", origName = "BLACKPINK Boombayah Emote", animId = "http://www.roblox.com/asset/?id=16553164850", marketId = 16553259683}
    _list[#_list + 1] = {name = "Chill Vibes - George Ezra", origName = "Chill Vibes - George Ezra", animId = "http://www.roblox.com/asset/?id=10370353969", marketId = 10370918044}
    _list[#_list + 1] = {name = "偶像表情", origName = "Idol Face", animId = "http://www.roblox.com/asset/?id=10714372526", marketId = 10724606884}
    _list[#_list + 1] = {name = "TWICE - I GOT YOU 第一部", origName = "TWICE I GOT YOU part 1", animId = "http://www.roblox.com/asset/?id=16215030041", marketId = 16215060261}
    _list[#_list + 1] = {name = "高举双手", origName = "High Hands", animId = "http://www.roblox.com/asset/?id=10714361543", marketId = 9710994651}
    _list[#_list + 1] = {name = "叫醒服务 - KSI", origName = "Wake Up Call - KSI", animId = "http://www.roblox.com/asset/?id=10714168145", marketId = 7202900159}
    _list[#_list + 1] = {name = "Nicki Minaj - Starships", origName = "Nicki Minaj Starships", animId = "http://www.roblox.com/asset/?id=15571453761", marketId = 15571540519}
    _list[#_list + 1] = {name = "曼城蝎子射门", origName = "Man City Scorpion Kick", animId = "http://www.roblox.com/asset/?id=13694096724", marketId = 13694139364}
    _list[#_list + 1] = {name = "指向2", origName = "Point2", animId = "http://www.roblox.com/asset/?id=10714395441", marketId = 3576823880}
    _list[#_list + 1] = {name = "YUNGBLUD - 高踢", origName = "YUNGBLUD – HIGH KICK", animId = "http://www.roblox.com/asset/?id=14022936101", marketId = 14022978026}
    _list[#_list + 1] = {name = "Paris Hill - 滑动律动", origName = "Paris Hilton - Sliving For The Groove", animId = "http://www.roblox.com/asset/?id=15392759696", marketId = 15392927897}
    _list[#_list + 1] = {name = "嗖嗖", origName = "Swish", animId = "http://www.roblox.com/asset/?id=10714349738", marketId = 3821527813}
    _list[#_list + 1] = {name = "5G超速表情", origName = "Hyperfast 5G Dance Move Face", animId = "http://www.roblox.com/asset/?id=10714371264", marketId = 10724599687}
    _list[#_list + 1] = {name = "睡觉表情", origName = "Sleep Face", animId = "http://www.roblox.com/asset/?id=10714360343", marketId = 10724782174}
    _list[#_list + 1] = {name = "不同意", origName = "Disagree", animId = "http://www.roblox.com/asset/?id=10714065135", marketId = 4849495710}
    _list[#_list + 1] = {name = "跳跃挥手", origName = "Jumping Wave", animId = "http://www.roblox.com/asset/?id=10714378156", marketId = 4940602656}
    _list[#_list + 1] = {name = "三明治舞", origName = "Sandwich Dance", animId = "http://www.roblox.com/asset/?id=10714384494", marketId = 4390121879}
    _list[#_list + 1] = {name = "贱女孩舞歇", origName = "Mean Girls Dance Break", animId = "http://www.roblox.com/asset/?id=15963314052", marketId = 15963348695}
    _list[#_list + 1] = {name = "TWICE - Set Me Free 舞蹈1", origName = "TWICE Set Me Free - Dance 1", animId = "http://www.roblox.com/asset/?id=12714228341", marketId = 12715395038}
    _list[#_list + 1] = {name = "HIPMOTION - Amaarae", origName = "HIPMOTION - Amaarae", animId = "http://www.roblox.com/asset/?id=16572740012", marketId = 16572756230}
    _list[#_list + 1] = {name = "海斯曼姿势", origName = "Heisman Pose", animId = "http://www.roblox.com/asset/?id=10714357129", marketId = 3696763549}
    _list[#_list + 1] = {name = "瑜伽三角式", origName = "Alo Yoga Pose - Triangle", animId = "http://www.roblox.com/asset/?id=12507084541", marketId = 12507120275}
    _list[#_list + 1] = {name = "扭臀表情 - Zara Larsson", origName = "Hips Poppin Zara Larsson Face", animId = "http://www.roblox.com/asset/?id=10714364213", marketId = 10724587450}
    _list[#_list + 1] = {name = " swagger行走", origName = "Swag Walk", animId = "http://www.roblox.com/asset/?id=10478341260", marketId = 10478377385}
    _list[#_list + 1] = {name = "僵尸表情", origName = "Zombie Face", animId = "http://www.roblox.com/asset/?id=10714089137", marketId = 10719119055}
    _list[#_list + 1] = {name = "Kick It舞步 - NCT 127", origName = "Kick It Dance Move - NCT 127", animId = "http://www.roblox.com/asset/?id=12259826609", marketId = 12259888240}
    _list[#_list + 1] = {name = "Vans Ollie", origName = "Vans Ollie", animId = "http://www.roblox.com/asset/?id=18305395285", marketId = 18305539673}
    _list[#_list + 1] = {name = "Sticker舞步 - NCT 127", origName = "Sticker Dance Move - NCT 127", animId = "http://www.roblox.com/asset/?id=12259825026", marketId = 12259885838}
    _list[#_list + 1] = {name = "海豚舞", origName = "Dolphin Dance", animId = "http://www.roblox.com/asset/?id=10714068222", marketId = 5938365243}
    _list[#_list + 1] = {name = "TWICE - The Feels", origName = "TWICE The Feels", animId = "http://www.roblox.com/asset/?id=12874447851", marketId = 12874468267}
    _list[#_list + 1] = {name = "海绵宝宝舞", origName = "SpongeBob Dance", animId = "http://www.roblox.com/asset/?id=18443245017", marketId = 18443271885}
    _list[#_list + 1] = {name = "快手", origName = "Fast Hands", animId = "http://www.roblox.com/asset/?id=10714100539", marketId = 4272351660}
    _list[#_list + 1] = {name = "BLACKPINK - Ice Cream", origName = "BLACKPINK Ice Cream", animId = "http://www.roblox.com/asset/?id=16181797368", marketId = 16181840356}
    _list[#_list + 1] = {name = "哈哈", origName = "Haha", animId = "http://www.roblox.com/asset/?id=10714350889", marketId = 4102315500}
    _list[#_list + 1] = {name = "Y", origName = "Y", animId = "http://www.roblox.com/asset/?id=10714164866", marketId = 4391211308}
    _list[#_list + 1] = {name = "恰恰舞", origName = "Cha-Cha", animId = "http://www.roblox.com/asset/?id=10714018192", marketId = 3696764866}
    _list[#_list + 1] = {name = "hype舞", origName = "Hype Dance", animId = "http://www.roblox.com/asset/?id=10714369624", marketId = 3696757129}
    _list[#_list + 1] = {name = "T表情", origName = "T Face", animId = "http://www.roblox.com/asset/?id=10714347453", marketId = 10724797869}
    _list[#_list + 1] = {name = "Baby Queen - 走秀", origName = "Baby Queen - Strut", animId = "http://www.roblox.com/asset/?id=14352362059", marketId = 14353425085}
    _list[#_list + 1] = {name = "Boom Boom Clap - George Ezra", origName = "Boom Boom Clap - George Ezra", animId = "http://www.roblox.com/asset/?id=10370346995", marketId = 10370934040}
    _list[#_list + 1] = {name = "耸肩表情", origName = "Shrug Face", animId = "http://www.roblox.com/asset/?id=10714374484", marketId = 10724769921}
    _list[#_list + 1] = {name = "秀手腕表情", origName = "Show Dem Wrists Face", animId = "http://www.roblox.com/asset/?id=10714377090", marketId = 10724767724}
    _list[#_list + 1] = {name = "Paris Hilton - 检查角度", origName = "Paris Hilton - Checking My Angles", animId = "http://www.roblox.com/asset/?id=15392752812", marketId = 15392937495}
    _list[#_list + 1] = {name = "Chappell Roan - HOT TO GO!", origName = "Chappell Roan HOT TO GO!", animId = "http://www.roblox.com/asset/?id=85267023718407", marketId = 79312439851071}
    _list[#_list + 1] = {name = "想玩吗?", origName = "Wanna play?", animId = "http://www.roblox.com/asset/?id=16646423316", marketId = 16646438742}
    _list[#_list + 1] = {name = "宁静波浪表情", origName = "Quiet Waves Face", animId = "http://www.roblox.com/asset/?id=10714390497", marketId = 10724737263}
    _list[#_list + 1] = {name = "能量爆发表情", origName = "Power Blast Face", animId = "http://www.roblox.com/asset/?id=10714389396", marketId = 10724734962}
    _list[#_list + 1] = {name = "鬼鬼祟祟表情", origName = "Sneaky Face", animId = "http://www.roblox.com/asset/?id=10714358528", marketId = 10724784852}
    _list[#_list + 1] = {name = "Yungblud - 更快乐跳跃", origName = "Yungblud Happier Jump", animId = "http://www.roblox.com/asset/?id=15609995579", marketId = 15610015346}
    _list[#_list + 1] = {name = "GloRilla - Tomorrow之舞", origName = "GloRilla - \"Tomorrow\" Dance", animId = "http://www.roblox.com/asset/?id=15689278184", marketId = 15689315657}
    _list[#_list + 1] = {name = "BLACKPINK - How You Like That", origName = "BLACKPINK - How You Like That", animId = "http://www.roblox.com/asset/?id=16874470507", marketId = 16874596971}
    _list[#_list + 1] = {name = "Paris Hilton - Sanasa", origName = "Paris Hilton Sanasa", animId = "http://www.roblox.com/asset/?id=16126469463", marketId = 16126526506}
    _list[#_list + 1] = {name = "指向2表情", origName = "Point 2 Face", animId = "http://www.roblox.com/asset/?id=10714395441", marketId = 10724732638}
    _list[#_list + 1] = {name = "健美者", origName = "Bodybuilder", animId = "http://www.roblox.com/asset/?id=10713990381", marketId = 3994130516}
    _list[#_list + 1] = {name = "TWICE - Fancy", origName = "TWICE Fancy", animId = "http://www.roblox.com/asset/?id=13520524517", marketId = 13520623514}
    _list[#_list + 1] = {name = "HUGO - 出发!", origName = "HUGO Let's Drive!", animId = "http://www.roblox.com/asset/?id=17360699557", marketId = 17360720445}
    _list[#_list + 1] = {name = "Panini舞表情", origName = "Panini Dance LNX Face", animId = "http://www.roblox.com/asset/?id=10714394082", marketId = 10724726812}
    _list[#_list + 1] = {name = "敬礼表情", origName = "Salute Face", animId = "http://www.roblox.com/asset/?id=10714389988", marketId = 10724752755}
    _list[#_list + 1] = {name = "打节拍表情", origName = "Keeping Time Face", animId = "http://www.roblox.com/asset/?id=10714380563", marketId = 10724703650}
    _list[#_list + 1] = {name = "鬼鬼祟祟", origName = "Sneaky", animId = "http://www.roblox.com/asset/?id=10714358528", marketId = 3576754235}
    _list[#_list + 1] = {name = "微风拂面表情", origName = "Flowing Breeze Face", animId = "http://www.roblox.com/asset/?id=10714342957", marketId = 10724554835}
    _list[#_list + 1] = {name = "害羞表情", origName = "Shy Face", animId = "http://www.roblox.com/asset/?id=10714369325", marketId = 10724777226}
    _list[#_list + 1] = {name = "在外面表情", origName = "On the Outside Face", animId = "http://www.roblox.com/asset/?id=10714392953", marketId = 10724725042}
    _list[#_list + 1] = {name = "摇滚吉他表情", origName = "Rock Guitar Royal Blood Face", animId = "http://www.roblox.com/asset/?id=10714393929", marketId = 10724741789}
    _list[#_list + 1] = {name = "拉我下去 - Zara Larsson", origName = "Take Me Under - Zara Larsson", animId = "http://www.roblox.com/asset/?id=10714345459", marketId = 6797938823}
    _list[#_list + 1] = {name = "逛街", origName = "Around Town", animId = "http://www.roblox.com/asset/?id=10713981723", marketId = 3576747102}
    _list[#_list + 1] = {name = "街舞", origName = "Break Dance", animId = "http://www.roblox.com/asset/?id=10714003221", marketId = 5915773992}
    _list[#_list + 1] = {name = "Skibidi马桶 - 泰坦激光旋转", origName = "Skibidi Toilet - Titan Speakerman Laser Spin", animId = "http://www.roblox.com/asset/?id=134283166482394", marketId = 103102322875221}
    _list[#_list + 1] = {name = "Sturdy舞 - Ice Spice", origName = "Sturdy Dance - Ice Spice", animId = "http://www.roblox.com/asset/?id=17746180844", marketId = 17746270218}
    _list[#_list + 1] = {name = "倾斜表情", origName = "Tilt Face", animId = "http://www.roblox.com/asset/?id=10714338461", marketId = 10724425256}
    _list[#_list + 1] = {name = "街舞表情", origName = "Break Dance Face", animId = "http://www.roblox.com/asset/?id=10714003221", marketId = 10724098896}
    _list[#_list + 1] = {name = "健美者表情", origName = "Bodybuilder Face", animId = "http://www.roblox.com/asset/?id=10713990381", marketId = 10724087630}
    _list[#_list + 1] = {name = "DearALICE - Ariana", origName = "DearALICE - Ariana", animId = "http://www.roblox.com/asset/?id=134318425949290", marketId = 133765015173412}
    _list[#_list + 1] = {name = "BLACKPINK Rosé - On The Ground", origName = "BLACKPINK ROSÉ On The Ground", animId = "http://www.roblox.com/asset/?id=15679624464", marketId = 15679958535}
    _list[#_list + 1] = {name = "BLACKPINK Jisoo - Flower", origName = "BLACKPINK JISOO Flower", animId = "http://www.roblox.com/asset/?id=15439354020", marketId = 15439454888}
    _list[#_list + 1] = {name = "Skadoosh - 功夫熊猫4", origName = "Skadoosh Emote - Kung Fu Panda 4", animId = "http://www.roblox.com/asset/?id=16371217304", marketId = 16371235025}
    _list[#_list + 1] = {name = "BLACKPINK Pink Venom - Straight to Ya Dome", origName = "BLACKPINK Pink Venom - Straight to Ya Dome", animId = "http://www.roblox.com/asset/?id=14548621256", marketId = 14548711723}
    _list[#_list + 1] = {name = "BURBERRY LOLA ATTITUDE - BLOOM", origName = "BURBERRY LOLA ATTITUDE - BLOOM", animId = "http://www.roblox.com/asset/?id=10714007154", marketId = 10147919199}
    _list[#_list + 1] = {name = "加油表情", origName = "Hwaiting Face", animId = "http://www.roblox.com/asset/?id=10714368233", marketId = 10724594344}
    _list[#_list + 1] = {name = "时尚", origName = "Fashionable", animId = "http://www.roblox.com/asset/?id=10714091938", marketId = 3576745472}
    _list[#_list + 1] = {name = "开心待机备选表情", origName = "Happy Idle Alt Face", animId = "http://www.roblox.com/asset/?id=10714355650", marketId = 10724570441}
    _list[#_list + 1] = {name = "鼓掌", origName = "Applaud", animId = "http://www.roblox.com/asset/?id=10713966026", marketId = 5915779043}
    _list[#_list + 1] = {name = "Mean Mug - Tommy Hilfiger", origName = "Mean Mug - Tommy Hilfiger", animId = "http://www.roblox.com/asset/?id=10214317325", marketId = 10214415687}
    _list[#_list + 1] = {name = "Thanos开心跳", origName = "Thanos Happy Jump", animId = "http://www.roblox.com/asset/?id=97611664803614", marketId = 76228547293788}
    _list[#_list + 1] = {name = "牛仔竞技舞表情", origName = "Rodeo Dance LNX Face", animId = "http://www.roblox.com/asset/?id=10714395175", marketId = 10724747951}
    _list[#_list + 1] = {name = "BLACKPINK - Kill This Love", origName = "BLACKPINK Kill This Love", animId = "http://www.roblox.com/asset/?id=16181798319", marketId = 16181843366}
    _list[#_list + 1] = {name = "史莱克怒吼", origName = "Shrek Roar", animId = "http://www.roblox.com/asset/?id=18524313628", marketId = 18524331128}
    _list[#_list + 1] = {name = "做鬼脸表情", origName = "Making Faces Face", animId = "http://www.roblox.com/asset/?id=10714387027", marketId = 10724716280}
    _list[#_list + 1] = {name = "牙线舞表情", origName = "Floss Dance Face", animId = "http://www.roblox.com/asset/?id=10714340543", marketId = 10724551787}
    _list[#_list + 1] = {name = "套索转身表情", origName = "Lasso Turn Tai Verdes Face", animId = "http://www.roblox.com/asset/?id=10714382225", marketId = 10724707416}
    _list[#_list + 1] = {name = "空气吉他", origName = "Air Guitar", animId = "http://www.roblox.com/asset/?id=15505454268", marketId = 15506499986}
    _list[#_list + 1] = {name = "BURBERRY LOLA ATTITUDE - HYDRO", origName = "BURBERRY LOLA ATTITUDE - HYDRO", animId = "http://www.roblox.com/asset/?id=10147823318", marketId = 10147926081}
    _list[#_list + 1] = {name = "老城路舞 - Lil Nas X", origName = "Old Town Road Dance - Lil Nas X (LNX)", animId = "http://www.roblox.com/asset/?id=10714391240", marketId = 5938394742}
    _list[#_list + 1] = {name = "桑巴表情", origName = "Samba Face", animId = "http://www.roblox.com/asset/?id=10714386947", marketId = 10724754724}
    _list[#_list + 1] = {name = "摇滚 - Bebe Rexha", origName = "Rock Out - Bebe Rexha", animId = "http://www.roblox.com/asset/?id=18225053113", marketId = 18225077553}
    _list[#_list + 1] = {name = "V姿势 - Tommy Hilfiger", origName = "V Pose - Tommy Hilfiger", animId = "http://www.roblox.com/asset/?id=10214319518", marketId = 10214418283}
    _list[#_list + 1] = {name = "机器人表情", origName = "Robot Face", animId = "http://www.roblox.com/asset/?id=10714392151", marketId = 10724739787}
    _list[#_list + 1] = {name = "如神一般", origName = "Godlike", animId = "http://www.roblox.com/asset/?id=10714347256", marketId = 3823158750}
    _list[#_list + 1] = {name = "快手表情", origName = "Fast Hands Face", animId = "http://www.roblox.com/asset/?id=10714100539", marketId = 10724547467}
    _list[#_list + 1] = {name = "排舞表情", origName = "Line Dance Face", animId = "http://www.roblox.com/asset/?id=10714383856", marketId = 10724709841}
    _list[#_list + 1] = {name = "呆萌舞表情", origName = "Dorky Dance Face", animId = "http://www.roblox.com/asset/?id=10714069471", marketId = 10724130955}
    _list[#_list + 1] = {name = "套索转身 - Tai Verdes", origName = "Lasso Turn - Tai Verdes", animId = "http://www.roblox.com/asset/?id=10714382225", marketId = 7942972744}
    _list[#_list + 1] = {name = "Charli xcx - 苹果舞", origName = "Charli xcx - Apple Dance", animId = "http://www.roblox.com/asset/?id=18946844622", marketId = 18946876350}
    _list[#_list + 1] = {name = "如神一般表情", origName = "Godlike Face", animId = "http://www.roblox.com/asset/?id=10714347256", marketId = 10724559140}
    _list[#_list + 1] = {name = "你不能和我们一起坐表情", origName = "You Cant Sit With Us Face", animId = "http://www.roblox.com/asset/?id=10714161572", marketId = 10719153702}
    _list[#_list + 1] = {name = "空中舞蹈表情", origName = "Air Dance Face", animId = "http://www.roblox.com/asset/?id=10713957138", marketId = 10706512017}
    _list[#_list + 1] = {name = "忍者神龟舞", origName = "TMNT Dance", animId = "http://www.roblox.com/asset/?id=18665811005", marketId = 18665886405}
    _list[#_list + 1] = {name = "行屈膝礼表情", origName = "Curtsy Face", animId = "http://www.roblox.com/asset/?id=10714061912", marketId = 10724119906}
    _list[#_list + 1] = {name = "海斯曼姿势表情", origName = "Heisman Pose Face", animId = "http://www.roblox.com/asset/?id=10714357129", marketId = 10724572119}
    _list[#_list + 1] = {name = "OK手势表情", origName = "AOK Tai Verdes Face", animId = "http://www.roblox.com/asset/?id=10713962506", marketId = 10724066517}
    _list[#_list + 1] = {name = "眼镜蛇手臂表情", origName = "Cobra Arms Tai Verdes Face", animId = "http://www.roblox.com/asset/?id=10714022275", marketId = 10724117861}
    _list[#_list + 1] = {name = "小鸡表情", origName = "Chicken Dance Face", animId = "http://www.roblox.com/asset/?id=10714020158", marketId = 10724115841}
    _list[#_list + 1] = {name = "舞步鞋表情", origName = "Dancin Shoes Face", animId = "http://www.roblox.com/asset/?id=10714063823", marketId = 10724122704}
    _list[#_list + 1] = {name = "巴宝莉反射表情", origName = "Burberry Reflex Face", animId = "http://www.roblox.com/asset/?id=10714010337", marketId = 10724107909}
    _list[#_list + 1] = {name = "开心待机表情", origName = "Happy Idle Face", animId = "http://www.roblox.com/asset/?id=10714354162", marketId = 10724568814}
    _list[#_list + 1] = {name = "鼓掌表情", origName = "Applaud Face", animId = "http://www.roblox.com/asset/?id=10713966026", marketId = 10724070077}
    _list[#_list + 1] = {name = "招手", origName = "Beckon", animId = "http://www.roblox.com/asset/?id=10713984554", marketId = 5230615437}
    _list[#_list + 1] = {name = "你好", origName = "Hello", animId = "http://www.roblox.com/asset/?id=10714359093", marketId = 3576686446}
    _list[#_list + 1] = {name = "不是我的错表情", origName = "It Aint My Fault Zara Larsson Face", animId = "http://www.roblox.com/asset/?id=10714374267", marketId = 10724609066}
    _list[#_list + 1] = {name = "2 Baddies舞步 - NCT 127", origName = "2 Baddies Dance Move - NCT 127", animId = "http://www.roblox.com/asset/?id=12259828678", marketId = 12259890638}
    _list[#_list + 1] = {name = "庆祝表情", origName = "Celebrate Face", animId = "http://www.roblox.com/asset/?id=10714016223", marketId = 10724111025}
    _list[#_list + 1] = {name = "Imagine Dragons - Bones之舞", origName = "Imagine Dragons - “Bones” Dance", animId = "http://www.roblox.com/asset/?id=15689279687", marketId = 15689314578}
    _list[#_list + 1] = {name = "NBA WNBA 后仰投篮", origName = "NBA WNBA Fadeaway", animId = "http://www.roblox.com/asset/?id=18526362841", marketId = 18526373545}
    _list[#_list + 1] = {name = "呆萌舞", origName = "Dorky Dance", animId = "http://www.roblox.com/asset/?id=10714069471", marketId = 4212499637}
    _list[#_list + 1] = {name = "ALTÉGO - Couldn't Care Less", origName = "ALTÉGO - Couldn’t Care Less", animId = "http://www.roblox.com/asset/?id=107875941017127", marketId = 92859581691366}
    _list[#_list + 1] = {name = "Udzal召唤", origName = "Ud'zal's Summoning", animId = "http://www.roblox.com/asset/?id=10714177846", marketId = 3307604888}
    _list[#_list + 1] = {name = "节日舞蹈", origName = "Festive Dance", animId = "http://www.roblox.com/asset/?id=15679621440", marketId = 15679955281}
    _list[#_list + 1] = {name = "上下表情", origName = "Up and Down Face", animId = "http://www.roblox.com/asset/?id=10714174918", marketId = 10724142022}
    _list[#_list + 1] = {name = "微风拂面", origName = "Flowing Breeze", animId = "http://www.roblox.com/asset/?id=10714342957", marketId = 7466047578}
    _list[#_list + 1] = {name = "超级英雄登场", origName = "Superhero Reveal", animId = "http://www.roblox.com/asset/?id=10714355069", marketId = 3696759798}
    _list[#_list + 1] = {name = "Wisp - 空气吉他", origName = "Wisp - air guitar", animId = "http://www.roblox.com/asset/?id=17370775305", marketId = 17370797454}
    _list[#_list + 1] = {name = "无聊表情", origName = "Bored Face", animId = "http://www.roblox.com/asset/?id=10713992055", marketId = 10724090645}
    _list[#_list + 1] = {name = "霜之风采 - Tommy Hilfiger", origName = "Frosty Flair - Tommy Hilfiger", animId = "http://www.roblox.com/asset/?id=10214311282", marketId = 10214406616}
    _list[#_list + 1] = {name = "Sidekicks - George Ezra", origName = "Sidekicks - George Ezra", animId = "http://www.roblox.com/asset/?id=10370362157", marketId = 10370922566}
    _list[#_list + 1] = {name = "摇滚", origName = "Rock n Roll", animId = "http://www.roblox.com/asset/?id=15505458452", marketId = 15506496093}
    _list[#_list + 1] = {name = "跳跃挥手表情", origName = "Jumping Wave Face", animId = "http://www.roblox.com/asset/?id=10714378156", marketId = 10724701566}
    _list[#_list + 1] = {name = "BURBERRY LOLA ATTITUDE - REFLEX", origName = "BURBERRY LOLA ATTITUDE - REFLEX", animId = "http://www.roblox.com/asset/?id=10714010337", marketId = 10147921916}
    _list[#_list + 1] = {name = "Y表情", origName = "Y Face", animId = "http://www.roblox.com/asset/?id=10714164866", marketId = 10724083642}
    _list[#_list + 1] = {name = "畏缩", origName = "Cower", animId = "http://www.roblox.com/asset/?id=4940563117", marketId = 4940597758}
    _list[#_list + 1] = {name = "排舞", origName = "Line Dance", animId = "http://www.roblox.com/asset/?id=10714383856", marketId = 4049646104}
    _list[#_list + 1] = {name = "敬礼", origName = "Salute", animId = "http://www.roblox.com/asset/?id=10714389988", marketId = 3360689775}
    _list[#_list + 1] = {name = "拳击 - KSI", origName = "Boxing Punch - KSI", animId = "http://www.roblox.com/asset/?id=10717116749", marketId = 7202896732}
    _list[#_list + 1] = {name = "面部测试待机", origName = "Face Test Idle", animId = "http://www.roblox.com/asset/?id=9803641757", marketId = 9803670031}
    _list[#_list + 1] = {name = "Elton John - 猫人", origName = "Elton John - Cat Man", animId = "http://www.roblox.com/asset/?id=11444441914", marketId = 11435175895}
    _list[#_list + 1] = {name = "扭臂", origName = "Arm Twist", animId = "http://www.roblox.com/asset/?id=10713968716", marketId = 9710992846}
    _list[#_list + 1] = {name = "打节拍", origName = "Keeping Time", animId = "http://www.roblox.com/asset/?id=10714380563", marketId = 4646306072}
    _list[#_list + 1] = {name = "加油", origName = "Hwaiting (화이팅)", animId = "http://www.roblox.com/asset/?id=10714368233", marketId = 9528291779}
    _list[#_list + 1] = {name = "Dave旋转步 - Glass Animals", origName = "Dave's Spin Move - Glass Animals", animId = "http://www.roblox.com/asset/?id=16272432203", marketId = 16276501655}
    _list[#_list + 1] = {name = "外面 - Twenty One Pilots", origName = "On The Outside - Twenty One Pilots", animId = "http://www.roblox.com/asset/?id=10714392953", marketId = 7422841700}
    _list[#_list + 1] = {name = "你不能和我们一起坐 - Sunmi", origName = "You can't sit with us - Sunmi", animId = "http://www.roblox.com/asset/?id=9983520970", marketId = 9983549160}
    _list[#_list + 1] = {name = "舞步鞋 - Twenty One Pilots", origName = "Dancin' Shoes - Twenty One Pilots", animId = "http://www.roblox.com/asset/?id=10714063823", marketId = 7405123844}
    _list[#_list + 1] = {name = "时尚旋转", origName = "Fashion Spin", animId = "http://www.roblox.com/asset/?id=131669256082047", marketId = 130046968468383}
    _list[#_list + 1] = {name = "恰恰舞", origName = "Cha Cha", animId = "http://www.roblox.com/asset/?id=6862001787", marketId = 6865013133}
    _list[#_list + 1] = {name = "派对达人", origName = "Block Partier", animId = "http://www.roblox.com/asset/?id=10713988674", marketId = 6865011755}
    _list[#_list + 1] = {name = "更大声表情", origName = "Louder Face", animId = "http://www.roblox.com/asset/?id=10714385204", marketId = 10724712331}
    _list[#_list + 1] = {name = "树", origName = "Tree", animId = "http://www.roblox.com/asset/?id=10714330764", marketId = 4049634387}
    _list[#_list + 1] = {name = "摇滚巨星 - Royal Blood", origName = "Rock Star - Royal Blood", animId = "http://www.roblox.com/asset/?id=10714400171", marketId = 6533100850}
    _list[#_list + 1] = {name = "牛仔竞技舞 - Lil Nas X", origName = "Rodeo Dance - Lil Nas X (LNX)", animId = "http://www.roblox.com/asset/?id=10714395175", marketId = 5938397555}
    _list[#_list + 1] = {name = "Udzal召唤表情", origName = "Udzals Summoning Face", animId = "http://www.roblox.com/asset/?id=10714177846", marketId = 10724146852}
    _list[#_list + 1] = {name = "天鹅舞", origName = "Swan Dance", animId = "http://www.roblox.com/asset/?id=10714352930", marketId = 7466048475}
    _list[#_list + 1] = {name = "手臂波浪", origName = "Arm Wave", animId = "http://www.roblox.com/asset/?id=5915648213", marketId = 5915773155}
    _list[#_list + 1] = {name = "能量爆发", origName = "Power Blast", animId = "http://www.roblox.com/asset/?id=10714389396", marketId = 4849497510}
    _list[#_list + 1] = {name = "跳跃欢呼", origName = "Jumping Cheer", animId = "http://www.roblox.com/asset/?id=5895324424", marketId = 5895009708}
    _list[#_list + 1] = {name = "同意", origName = "Agree", animId = "http://www.roblox.com/asset/?id=10713954623", marketId = 4849487550}
    _list[#_list + 1] = {name = "Baby Queen - 戏剧性鞠躬", origName = "Baby Queen - Dramatic Bow", animId = "http://www.roblox.com/asset/?id=14352337694", marketId = 14353419229}
    _list[#_list + 1] = {name = "曼城后空翻", origName = "Man City Backflip", animId = "http://www.roblox.com/asset/?id=13694100677", marketId = 13694140956}
    _list[#_list + 1] = {name = "BURBERRY LOLA ATTITUDE - NIMBUS", origName = "BURBERRY LOLA ATTITUDE - NIMBUS", animId = "http://www.roblox.com/asset/?id=10147821284", marketId = 10147924028}
    _list[#_list + 1] = {name = "The Weeknd - 首演之夜", origName = "The Weeknd Opening Night", animId = "http://www.roblox.com/asset/?id=133110725387025", marketId = 105098895743105}
    _list[#_list + 1] = {name = "秘密握手舞", origName = "Secret Handshake Dance", animId = "http://www.roblox.com/asset/?id=71243990877913", marketId = 120642514156293}
    _list[#_list + 1] = {name = "摇滚巨星表情", origName = "Rock Star Royal Blood Face", animId = "http://www.roblox.com/asset/?id=10714400171", marketId = 10724745555}
    _list[#_list + 1] = {name = "Olivia Rodrigo - 点头舞", origName = "Olivia Rodrigo Head Bop", animId = "http://www.roblox.com/asset/?id=15517864808", marketId = 15554010118}
    _list[#_list + 1] = {name = "TWICE - Nayeon ABCD", origName = "TWICE ABCD by Nayeon", animId = "http://www.roblox.com/asset/?id=18933706381", marketId = 18933761755}
    _list[#_list + 1] = {name = "困惑", origName = "Confused", animId = "http://www.roblox.com/asset/?id=4940561610", marketId = 4940592718}
    _list[#_list + 1] = {name = "ericdoa - 舞蹈", origName = "ericdoa - dance", animId = "http://www.roblox.com/asset/?id=15698402762", marketId = 15698510244}
    _list[#_list + 1] = {name = "伤心", origName = "Sad", animId = "http://www.roblox.com/asset/?id=10714392876", marketId = 4849502101}
    _list[#_list + 1] = {name = "假日舞 - Lil Nas X", origName = "HOLIDAY Dance - Lil Nas X (LNX)", animId = "http://www.roblox.com/asset/?id=10714365721", marketId = 5938396308}
    _list[#_list + 1] = {name = "秀肌肉行走", origName = "Flex Walk", animId = "http://www.roblox.com/asset/?id=15505459811", marketId = 15506506103}
    _list[#_list + 1] = {name = "TWICE - 擒拿 第二部", origName = "TWICE Takedown pt 2 from KPop Demon Hunters", animId = "http://www.roblox.com/asset/?id=127104635954695", marketId = 85623000473425}
    _list[#_list + 1] = {name = "小鸡舞", origName = "Chicken Dance", animId = "http://www.roblox.com/asset/?id=10714020158", marketId = 4849493309}
    _list[#_list + 1] = {name = "d4vd - 后空翻", origName = "d4vd - Backflip", animId = "http://www.roblox.com/asset/?id=15693621070", marketId = 15694504637}
    _list[#_list + 1] = {name = "跑步动画", origName = "Run Animation", animId = "http://www.roblox.com/asset/?id=4417979645", marketId = 4418324223}
    _list[#_list + 1] = {name = "英雄落地", origName = "Hero Landing", animId = "http://www.roblox.com/asset/?id=10714360164", marketId = 5104377791}
    _list[#_list + 1] = {name = "BLACKPINK - Don't Know What To Do", origName = "BLACKPINK Don't know what to do", animId = "http://www.roblox.com/asset/?id=18855531354", marketId = 18855609889}
    _list[#_list + 1] = {name = "庆祝", origName = "Celebrate", animId = "http://www.roblox.com/asset/?id=10714016223", marketId = 3994127840}
    _list[#_list + 1] = {name = "时尚衣橱 - 我的T台", origName = "Fashion Klossette - Runway my way", animId = "http://www.roblox.com/asset/?id=80995190624232", marketId = 126683684984862}
    _list[#_list + 1] = {name = "Sol de Janeiro - 桑巴", origName = "Sol de Janeiro - Samba", animId = "http://www.roblox.com/asset/?id=16270690701", marketId = 16276506814}
    _list[#_list + 1] = {name = "Rthro重跑", origName = "Rthro Heavy Run", animId = "http://www.roblox.com/asset/?id=3236836670", marketId = 3236849826}
    _list[#_list + 1] = {name = "哈哈表情", origName = "Haha Face", animId = "http://www.roblox.com/asset/?id=10714350889", marketId = 10724563898}
    _list[#_list + 1] = {name = "架子鼓独奏表情", origName = "Drum Solo Royal Blood Face", animId = "http://www.roblox.com/asset/?id=10714074218", marketId = 10724539752}
    _list[#_list + 1] = {name = "BLACKPINK Pink Venom - I Bring the Pain", origName = "BLACKPINK Pink Venom - I Bring the Pain Like…", animId = "http://www.roblox.com/asset/?id=14548620495", marketId = 14548710952}
    _list[#_list + 1] = {name = "拖步表情", origName = "Shuffle Face", animId = "http://www.roblox.com/asset/?id=10714371274", marketId = 10724775065}
    _list[#_list + 1] = {name = "Ay-Yo舞步 - NCT 127", origName = "Ay-Yo Dance Move - NCT 127", animId = "http://www.roblox.com/asset/?id=12804157977", marketId = 12804173616}
    _list[#_list + 1] = {name = "BLACKPINK Jennie - You and Me", origName = "BLACKPINK JENNIE You and Me", animId = "http://www.roblox.com/asset/?id=15439356296", marketId = 15439457146}
    _list[#_list + 1] = {name = "叫醒服务表情", origName = "Wake Up Call Face", animId = "http://www.roblox.com/asset/?id=10714168145", marketId = 10724092508}
    _list[#_list + 1] = {name = "三明治舞表情", origName = "Sandwhich Dance Face", animId = "http://www.roblox.com/asset/?id=10714384494", marketId = 10724757383}
    _list[#_list + 1] = {name = "出去", origName = "Get Out", animId = "http://www.roblox.com/asset/?id=10714345862", marketId = 3934984583}
    _list[#_list + 1] = {name = "胜利表情", origName = "Victory ### #### Face", animId = "http://www.roblox.com/asset/?id=10714171628", marketId = 10724098469}
    _list[#_list + 1] = {name = "Na Na Na表情", origName = "Na Na Na Face", animId = "http://www.roblox.com/asset/?id=10714389873", marketId = 10724720732}
    _list[#_list + 1] = {name = "秀手腕 - KSI", origName = "Show Dem Wrists - KSI", animId = "http://www.roblox.com/asset/?id=10714377090", marketId = 7202898984}
    _list[#_list + 1] = {name = "拖步", origName = "Shuffle", animId = "http://www.roblox.com/asset/?id=10714371274", marketId = 4391208058}
    _list[#_list + 1] = {name = "时尚表情", origName = "Fashionable Face", animId = "http://www.roblox.com/asset/?id=10714091938", marketId = 10724545513}
    _list[#_list + 1] = {name = "MS2", origName = "ms2", animId = "http://www.roblox.com/asset/?id=16584481352", marketId = 16584496763}
    _list[#_list + 1] = {name = "TWICE Moonlight Sunrise", origName = "TWICE Moonlight Sunrise", animId = "http://www.roblox.com/asset/?id=12714233242", marketId = 12715393154}
    _list[#_list + 1] = {name = "BURBERRY LOLA ATTITUDE - GEM", origName = "BURBERRY LOLA ATTITUDE - GEM", animId = "http://www.roblox.com/asset/?id=10714008655", marketId = 10147916560}
    _list[#_list + 1] = {name = "NBA怪兽扣篮", origName = "NBA Monster Dunk", animId = "http://www.roblox.com/asset/?id=132748833449150", marketId = 82163305721376}
    _list[#_list + 1] = {name = "头晕表情", origName = "Dizzy Face", animId = "http://www.roblox.com/asset/?id=10714066964", marketId = 10724126829}
    _list[#_list + 1] = {name = "鼓手动作表情", origName = "Drummer Moves Face", animId = "http://www.roblox.com/asset/?id=10714072822", marketId = 10724137593}
    _list[#_list + 1] = {name = "Uprise - Tommy Hilfiger", origName = "Uprise - Tommy Hilfiger", animId = "http://www.roblox.com/asset/?id=10275008655", marketId = 10275057230}
    _list[#_list + 1] = {name = "T", origName = "T", animId = "http://www.roblox.com/asset/?id=10714347453", marketId = 3576719440}
    _list[#_list + 1] = {name = "乡村排舞 - Lil Nas X", origName = "Country Line Dance - Lil Nas X (LNX)", animId = "http://www.roblox.com/asset/?id=5915712534", marketId = 5915780563}
    _list[#_list + 1] = {name = "旋转表情", origName = "Twirl Face", animId = "http://www.roblox.com/asset/?id=10714293450", marketId = 10724150438}
    _list[#_list + 1] = {name = "时尚路杀", origName = "Fashion Roadkill", animId = "http://www.roblox.com/asset/?id=136831243854748", marketId = 73683655527605}
    emoteList = _list
end

-- Animation pack data embedded directly
do
    local _packs = {}
    _packs[#_packs + 1] = {name = "自信", origName = "Confident", bundleId = 0, anims = {
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=1070017263"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=1070012133"},
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=1069977950"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=1069987858"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=1069946257"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=1069984524"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=1069973677"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=1070001516"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=1070009914"},
    }}
    _packs[#_packs + 1] = {name = "流行巨星", origName = "Popstar", bundleId = 0, anims = {
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=1212980338"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=1212998578"},
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=1212900985"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=1212954651"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=1213044953"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=1212954642"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=1212900995"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=1212980348"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=1212852603"},
    }}
    _packs[#_packs + 1] = {name = "巡逻", origName = "Patrol", bundleId = 0, anims = {
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=1151231493"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=1151221899"},
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=1149612882"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=1150842221"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=1148811837"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=1150944216"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=1148863382"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=1150967949"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=1151204998"},
    }}
    _packs[#_packs + 1] = {name = "鬼鬼祟祟", origName = "Sneaky", bundleId = 0, anims = {
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=1132510133"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=1132506407"},
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=1132473842"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=1132477671"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=1132461372"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=1132489853"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=1132469004"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=1132494274"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=1132500520"},
    }}
    _packs[#_packs + 1] = {name = "公主", origName = "Princess", bundleId = 0, anims = {
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=941028902"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=941025398"},
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=941003647"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=941013098"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=940996062"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=941008832"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=941000007"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=941015281"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=941018893"},
    }}
    _packs[#_packs + 1] = {name = "牛仔", origName = "Cowboy", bundleId = 0, anims = {
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=1014421541"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=1014411816"},
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=1014390418"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=1014398616"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=1014380606"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=1014394726"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=1014384571"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=1014401683"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=1014406523"},
    }}
    _packs[#_packs + 1] = {name = "时尚女性", origName = "Stylized Female", bundleId = 0, anims = {
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=4708193840"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=4708190607"},
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=4708191566"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=4708192150"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=4708184253"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=4708188025"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=4708186162"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=4708192705"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=4708189360"},
    }}
    _packs[#_packs + 1] = {name = "老派", origName = "Oldschool", bundleId = 667, anims = {
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=10921232093"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=10921230744"},
        ["jump"] = {["jump"] = "http://www.roblox.com/asset/?id=10921242013"},
        ["run"] = {["run"] = "http://www.roblox.com/asset/?id=10921240218"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=10921243048"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=10921244018"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=10921229866"},
        ["fall"] = {["fall"] = "http://www.roblox.com/asset/?id=10921241244"},
        ["pose"] = {["Animation"] = "http://www.roblox.com/asset/?id=10921233298"},
        ["walk"] = {["walk"] = "http://www.roblox.com/asset/?id=10921244891"},
    }}
    _packs[#_packs + 1] = {name = "邪恶流行", origName = "Wicked Popular", bundleId = 1189398, anims = {
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=76049494037641"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=118832222982049"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=131326830509784"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=72301599441680"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=99384245425157"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=113199415118199"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=104325245285198"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=121152442762481"},
        ["pose"] = {["StylishPose"] = "http://www.roblox.com/asset/?id=138255200176080"},
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=92072849924640"},
    }}
    _packs[#_packs + 1] = {name = "Rthro", origName = "Rthro", bundleId = 356, anims = {
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=10921258489"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=10921259953"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=10921257536"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=10921261968"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=10921264784"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=10921265698"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=10921263860"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=10921262864"},
        ["pose"] = {["RthroIdlePose"] = "rbxassetid://10921261056"},
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=10921269718"},
    }}
    _packs[#_packs + 1] = {name = "时尚", origName = "Stylish", bundleId = 83, anims = {
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=10921273958"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=10921272275"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=10921271391"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=10921276116"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=10921281000"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=10921281964"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=10921279832"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=10921278648"},
        ["pose"] = {["StylishPose"] = "http://www.roblox.com/asset/?id=10921275151"},
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=10921283326"},
    }}
    _packs[#_packs + 1] = {name = "机器人", origName = "Robot", bundleId = 82, anims = {
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=10921248831"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=10921248039"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=10921247141"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=10921250460"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=10921253142"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=10921253767"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=10921252123"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=10921251156"},
        ["pose"] = {["RobotPose"] = "http://www.roblox.com/asset/?id=10921249579"},
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=10921255446"},
    }}
    _packs[#_packs + 1] = {name = "玩具", origName = "Toy", bundleId = 43, anims = {
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=10921302207"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=10921301576"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=10921308158"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=10921306285"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=10921309319"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=10921310341"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=10921300839"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=10921307241"},
        ["pose"] = {["ToyPose"] = "http://www.roblox.com/asset/?id=10921303913"},
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=10921312010"},
    }}
    _packs[#_packs + 1] = {name = "Bold - e.l.f.", origName = "Bold  by e.l.f.", bundleId = 331856, anims = {
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=16738334710"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=16738333868"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=16738332169"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=16738337225"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=16738339158"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=16738339817"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=16738336650"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=16738333171"},
        ["pose"] = {["BoldPose"] = "http://www.roblox.com/asset/?id=16738335517"},
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=16738340646"},
    }}
    _packs[#_packs + 1] = {name = "阿迪达斯运动", origName = "adidas Sports", bundleId = 427999, anims = {
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=18537371272"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=18537376492"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=18537380791"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=18537384940"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=18537389531"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=18537387180"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=18537363391"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=18537367238"},
        ["pose"] = {["StylishPose"] = "http://www.roblox.com/asset/?id=18537374150"},
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=18537392113"},
    }}
    _packs[#_packs + 1] = {name = "僵尸", origName = "Zombie", bundleId = 80, anims = {
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=10921345304"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=10921344533"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=10921343576"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=616163682"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=10921352344"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=10921353442"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=10921351278"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=10921350320"},
        ["pose"] = {["ZombiePose"] = "http://www.roblox.com/asset/?id=10921347258"},
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=10921355261"},
    }}
    _packs[#_packs + 1] = {name = "法师", origName = "Mage", bundleId = 63, anims = {
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=10921145797"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=10921144709"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=10921149743"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=10921148209"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=10921150788"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=10921151661"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=10921143404"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=10921148939"},
        ["pose"] = {["MagePose"] = "http://www.roblox.com/asset/?id=10921146941"},
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=10921152678"},
    }}
    _packs[#_packs + 1] = {name = "Catwalk Glam - e.l.f.", origName = "Catwalk Glam  by e.l.f.", bundleId = 1601900, anims = {
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=94970088341563"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=133806214992291"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=119377220967554"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=81024476153754"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=134591743181628"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=98854111361360"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=116936326516985"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=92294537340807"},
        ["pose"] = {["StylishPose"] = "http://www.roblox.com/asset/?id=87105332133518"},
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=109168724482748"},
    }}
    _packs[#_packs + 1] = {name = "卡通", origName = "Cartoony", bundleId = 56, anims = {
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=10921072875"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=10921071918"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=10921078135"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=10921076136"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=10921079380"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=10921081059"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=10921070953"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=10921077030"},
        ["pose"] = {["CartoonyPose"] = "http://www.roblox.com/asset/?id=10921074502"},
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=10921082452"},
    }}
    _packs[#_packs + 1] = {name = "活泼", origName = "Bubbly", bundleId = 39, anims = {
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=10921055107"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=10921054344"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=10921062673"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=10921057244"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=10921063569"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=10922582160"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=10921053544"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=10921061530"},
        ["pose"] = {["PoseAnim"] = "http://www.roblox.com/asset/?id=10921056055"},
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=10980888364"},
    }}
    _packs[#_packs + 1] = {name = "长者", origName = "Elder", bundleId = 48, anims = {
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=10921102574"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=10921101664"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=10921107367"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=10921104374"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=10921108971"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=10921110146"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=10921100400"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=10921105765"},
        ["pose"] = {["ElderPose"] = "http://www.roblox.com/asset/?id=10921103538"},
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=10921111375"},
    }}
    _packs[#_packs + 1] = {name = "No Boundaries - Walmart", origName = "No Boundaries  by Walmart", bundleId = 455003, anims = {
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=18747063918"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=18747067405"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=18747060903"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=18747070484"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=18747073181"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=18747071682"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=18747069148"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=18747062535"},
        ["pose"] = {["Pose"] = "http://www.roblox.com/asset/?id=18747065848"},
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=18747074203"},
    }}
    _packs[#_packs + 1] = {name = "吸血鬼", origName = "Vampire", bundleId = 33, anims = {
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=10921316709"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=10921315373"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=10921322186"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=10921320299"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=10921324408"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=10921325443"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=10921314188"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=10921321317"},
        ["pose"] = {["PoseAnim"] = "http://www.roblox.com/asset/?id=10921317792"},
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=10921326949"},
    }}
    _packs[#_packs + 1] = {name = "忍者", origName = "Ninja", bundleId = 75, anims = {
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=10921155867"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=10921155160"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=10921160088"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=10921157929"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=10921161002"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=10922757002"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=10921154678"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=10921159222"},
        ["pose"] = {["NinjaPose"] = "http://www.roblox.com/asset/?id=10921156883"},
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=10921162768"},
    }}
    _packs[#_packs + 1] = {name = "超级英雄", origName = "Superhero", bundleId = 81, anims = {
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=10921290167"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=10921288909"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=10921286911"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=10921291831"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=10921295495"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=10921297391"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=10921294559"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=10921293373"},
        ["pose"] = {["SuperheroPose"] = "http://www.roblox.com/asset/?id=10921290942"},
        ["walk"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=10921298616"},
    }}
    _packs[#_packs + 1] = {name = "悬浮", origName = "Levitation", bundleId = 79, anims = {
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=10921133721"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=10921132962"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=10921132092"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=10921135644"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=10921138209"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=10921139478"},
        ["jump"] = {["!ID!"] = "http://www.roblox.com/asset/?id=10921137402"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=10921136539"},
        ["pose"] = {["LevitationPose"] = "http://www.roblox.com/asset/?id=10921134514"},
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=10921140719"},
    }}
    _packs[#_packs + 1] = {name = "NFL", origName = "NFL", bundleId = 932296, anims = {
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=74451233229259"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=92080889861410"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=134630013742019"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=117333533048078"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=132697394189921"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=79090109939093"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=119846112151352"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=129773241321032"},
        ["pose"] = {["Pose"] = "http://www.roblox.com/asset/?id=80884010501210"},
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=110358958299415"},
    }}
    _packs[#_packs + 1] = {name = "狼人", origName = "Werewolf", bundleId = 32, anims = {
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=10921333667"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=10921330408"},
        ["jump"] = {["!ID!"] = "http://www.roblox.com/asset/?id=1083218792"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=10921336997"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=10921340419"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=10921341319"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=10921329322"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=10921337907"},
        ["pose"] = {["PoseAnim"] = "http://www.roblox.com/asset/?id=10921334755"},
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=10921342074"},
    }}
    _packs[#_packs + 1] = {name = "骑士", origName = "Knight", bundleId = 68, anims = {
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=10921118894"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=10921117521"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=10921123517"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=10921121197"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=10921125160"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=10921125935"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=10921116196"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=10921122579"},
        ["pose"] = {["KnightPose"] = "http://www.roblox.com/asset/?id=10921119700"},
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=10921127095"},
    }}
    _packs[#_packs + 1] = {name = "宇航员", origName = "Astronaut", bundleId = 34, anims = {
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=10921036806"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=10921034824"},
        ["jump"] = {["JumpAnim"] = "http://www.roblox.com/asset/?id=10921042494"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=10921039308"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=10921044000"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=10921045006"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=10921032124"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=10921040576"},
        ["pose"] = {["PoseAnim"] = "http://www.roblox.com/asset/?id=10921038149"},
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=10921046031"},
    }}
    _packs[#_packs + 1] = {name = "海盗", origName = "Pirate", bundleId = 55, anims = {
        ["idle"] = {["Animation2"] = "http://www.roblox.com/asset/?id=750782770"},
        ["idle"] = {["Animation1"] = "http://www.roblox.com/asset/?id=750781874"},
        ["jump"] = {["!ID!"] = "http://www.roblox.com/asset/?id=750782230"},
        ["run"] = {["RunAnim"] = "http://www.roblox.com/asset/?id=750783738"},
        ["swim"] = {["Swim"] = "http://www.roblox.com/asset/?id=750784579"},
        ["swimidle"] = {["SwimIdle"] = "http://www.roblox.com/asset/?id=750785176"},
        ["climb"] = {["ClimbAnim"] = "http://www.roblox.com/asset/?id=750779899"},
        ["fall"] = {["FallAnim"] = "http://www.roblox.com/asset/?id=750780242"},
        ["pose"] = {["PiratePose"] = "http://www.roblox.com/asset/?id=885515365"},
        ["walk"] = {["WalkAnim"] = "http://www.roblox.com/asset/?id=750785693"},
    }}
    packList = _packs
end

local emSec1 = Tabs.Emote:Section({ Title = "搜索ID" })

emSec1:Button({
    Title = "停止当前动作",
    Callback = function() emStopAll() end
})

emSec1:Button({
    Title = "搜索并播放动作",
    Desc = "打开搜索面板输入动画ID",
    Callback = function()
        pcall(function()
            if not emSearchGui then
                emSearchGui = Instance.new("ScreenGui")
                emSearchGui.Name = "EmoteSearch"
                emSearchGui.ResetOnSpawn = false
                pcall(function() emSearchGui.Parent = game:GetService("CoreGui") end)
                if not emSearchGui.Parent then
                    emSearchGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
                end
                emSearchGui.IgnoreGuiInset = true

                local panel = Instance.new("Frame")
                panel.Name = "Panel"
                panel.Size = UDim2.new(0, 350, 0, 160)
                panel.Position = UDim2.new(0.5, -175, 0.5, -80)
                panel.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
                panel.BackgroundTransparency = 0.05
                panel.Parent = emSearchGui

                local pc = Instance.new("UICorner")
                pc.CornerRadius = UDim.new(0, 12)
                pc.Parent = panel

                local ps = Instance.new("UIStroke")
                ps.Color = Color3.fromRGB(60, 60, 65)
                ps.Thickness = 1
                ps.Parent = panel

                local title = Instance.new("TextLabel")
                title.Size = UDim2.new(1, 0, 0, 30)
                title.Position = UDim2.new(0, 0, 0, 5)
                title.BackgroundTransparency = 1
                title.Text = "搜索动作ID"
                title.TextColor3 = Color3.fromRGB(200, 200, 200)
                title.Font = Enum.Font.GothamBold
                title.TextScaled = true
                title.Parent = panel

                local inputBg = Instance.new("Frame")
                inputBg.Size = UDim2.new(0.9, 0, 0, 35)
                inputBg.Position = UDim2.new(0.05, 0, 0, 40)
                inputBg.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
                inputBg.Parent = panel
                local ibc = Instance.new("UICorner")
                ibc.CornerRadius = UDim.new(0, 8)
                ibc.Parent = inputBg

                local inputBox = Instance.new("TextBox")
                inputBox.Name = "Input"
                inputBox.Size = UDim2.new(1, -16, 1, 0)
                inputBox.Position = UDim2.new(0, 8, 0, 0)
                inputBox.BackgroundTransparency = 1
                inputBox.Text = ""
                inputBox.PlaceholderText = "输入动画ID或Asset ID..."
                inputBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
                inputBox.TextColor3 = Color3.new(1, 1, 1)
                inputBox.TextScaled = true
                inputBox.Font = Enum.Font.Gotham
                inputBox.TextXAlignment = Enum.TextXAlignment.Left
                inputBox.ClearTextOnFocus = false
                inputBox.Parent = inputBg

                local thumb = Instance.new("ImageLabel")
                thumb.Name = "Thumb"
                thumb.Size = UDim2.new(0, 60, 0, 60)
                thumb.Position = UDim2.new(0.05, 0, 0, 85)
                thumb.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
                thumb.BackgroundTransparency = 0.2
                thumb.Parent = panel
                local tc = Instance.new("UICorner")
                tc.CornerRadius = UDim.new(0, 8)
                tc.Parent = thumb

                local playBtn = Instance.new("TextButton")
                playBtn.Name = "Play"
                playBtn.Size = UDim2.new(0.55, 0, 0, 35)
                playBtn.Position = UDim2.new(0.3, 0, 0, 100)
                playBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
                playBtn.Text = "播放动作"
                playBtn.TextColor3 = Color3.new(1, 1, 1)
                playBtn.TextScaled = true
                playBtn.Font = Enum.Font.GothamBold
                playBtn.AutoButtonColor = true
                playBtn.Parent = panel
                local pbc = Instance.new("UICorner")
                pbc.CornerRadius = UDim.new(0, 8)
                pbc.Parent = playBtn

                local closeBtn = Instance.new("TextButton")
                closeBtn.Name = "Close"
                closeBtn.Size = UDim2.new(0, 25, 0, 25)
                closeBtn.Position = UDim2.new(1, -30, 0, 5)
                closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
                closeBtn.Text = "X"
                closeBtn.TextColor3 = Color3.new(1, 1, 1)
                closeBtn.TextScaled = true
                closeBtn.Font = Enum.Font.GothamBold
                closeBtn.AutoButtonColor = true
                closeBtn.Parent = panel
                local cbc = Instance.new("UICorner")
                cbc.CornerRadius = UDim.new(0, 6)
                cbc.Parent = closeBtn

                closeBtn.MouseButton1Click:Connect(function()
                    panel.Visible = false
                end)

                playBtn.MouseButton1Click:Connect(function()
                    local id = inputBox.Text
                    if id and id ~= "" then
                        if not id:find("://") then
                            if tonumber(id) then
                                id = "rbxassetid://" .. id
                            else
                                id = "http://www.roblox.com/asset/?id=" .. id
                            end
                        end
                        emPlay(id)
                        thumb.Image = "rbxthumb://type=Asset&id=" .. inputBox.Text .. "&w=150&h=150"
                    end
                end)

                inputBox.FocusLost:Connect(function(enterPressed)
                    if enterPressed then
                        playBtn.MouseButton1Click:Fire()
                    end
                end)

                inputBox:GetPropertyChangedSignal("Text"):Connect(function()
                    local t = inputBox.Text
                    if t and tonumber(t) then
                        thumb.Image = "rbxthumb://type=Asset&id=" .. t .. "&w=150&h=150"
                    else
                        thumb.Image = ""
                    end
                end)
            end
            emSearchGui.Panel.Visible = not emSearchGui.Panel.Visible
        end)
    end
})

local emSec2 = Tabs.Emote:Section({ Title = "全部动作 (" .. #emoteList .. "个)" })

for i = 1, #emoteList do
    local e = emoteList[i]
    emSec2:Button({
        Title = e.name,
        Desc = e.origName,
        Callback = function() emPlay(e.animId) end
    })
end

local emSec3 = Tabs.Emote:Section({ Title = "动画包 (" .. #packList .. "个)" })

for i = 1, #packList do
    local p = packList[i]
    emSec3:Button({
        Title = p.name,
        Desc = p.origName,
        Callback = function()
            pcall(function()
                local char = LocalPlayer.Character
                if not char then return end
                local hum = char:FindFirstChildOfClass("Humanoid")
                if not hum or hum.RigType.Name ~= "R15" then
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "动作包",
                        Text = "需要R15角色才能使用动画包",
                        Duration = 3
                    })
                    return
                end
                local animScript = char:FindFirstChild("Animate")
                if not animScript then
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "动作包",
                        Text = "找不到Animate脚本",
                        Duration = 3
                    })
                    return
                end
                local animations = p.anims
                if not animations then
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "动作包",
                        Text = "动画包数据不完整",
                        Duration = 3
                    })
                    return
                end
                for _, animObj in ipairs(animScript:GetChildren()) do
                    if animations[animObj.Name] then
                        for _, animAsset in ipairs(animObj:GetChildren()) do
                            if animations[animObj.Name][animAsset.Name] then
                                animAsset.AnimationId = animations[animObj.Name][animAsset.Name]
                            end
                        end
                    end
                end
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "动作包",
                    Text = "已应用: " .. p.name,
                    Duration = 2
                })
            end)
        end
    })
end

