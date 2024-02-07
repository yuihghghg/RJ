local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))() 
 local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))() 

 wait(1) 
 Notification:Notify( 
     {Title = "RJ脚本v2", Description = "V2"}, 
     {OutlineColor = Color3.fromRGB(80, 80, 80),Time = 5, Type = "image"}, 
     {Image = "http://www.roblox.com/asset/?id=14492607544", ImageColor = Color3.fromRGB(255, 255, 255)} 
 ) 
 wait(2) 
 Notification:Notify( 
     {Title = "Renji", Description = "更新了战争大亨"}, 
     {OutlineColor = Color3.fromRGB(80, 80, 80),Time = 5, Type = "image"}, 
     {Image = "http://www.roblox.com/asset/?id=14492607544", ImageColor = Color3.fromRGB(255, 255, 255)} 
 )
 wait(0.2)
 Notification:Notify( 
     {Title = "Renji", Description = "为什么不玩香肠派对！？"}, 
     {OutlineColor = Color3.fromRGB(255, 255, 255),Time = 10, Type = "image"}, 
     {Image = "http://www.roblox.com/asset/?id=14492607544", ImageColor = Color3.fromRGB(255, 255, 255)} 
 )
 wait(0.4)

local Library = loadstring(game:HttpGet"https://shz.al/kFHGPdmpi53SfDs5REJhFnpT")()
local Window = Library:new("RJV2")

local RJ_0Tab = Window:Tab("关于",'14492607544')
local RJ_0 = RJ_0Tab:section("关于",true)
local RJ_1 = RJ_0Tab:section("UI设置",true)
local RJ_1Tab = Window:Tab("通用",'14492607544')
local RJ_2 = RJ_1Tab:section("通用", true)
local RJ_2Tab = Window:Tab("选择游戏",'14492607544')
local RJ_3 = RJ_2Tab:section("服务器",true)

RJ_0:Label("你的用户名"..game.Players.LocalPlayer.Name)
RJ_0:Label("你的注入器:"..identifyexecutor())
RJ_0:Label("此脚本为RJV2测试版")
RJ_0:Label("后续陆续补充")
RJ_0:Label("作者:1465486886")

RJ_1:Button("摧毁UI", function()
    game:GetService("CoreGui")["frosty"]:Destroy()
end)
RJ_1:Toggle("彩虹UI", "", false, function(v0)
    if v0 then
        game:GetService("CoreGui")["frosty"].Main.Style = "DropShadow"
    else
        game:GetService("CoreGui")["frosty"].Main.Style = "Custom"
    end
end)

RJ_2:Button("测试", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/TQwh73Dx"))()
    end)
RJ_2:Toggle("夜视", "text", false, function(v1)
    if v1 then
	    game.Lighting.Ambient = Color3.new(1, 1, 1)
	else
	    game.Lighting.Ambient = Color3.new(0, 0, 0)
	end
end)
RJ_2:Textbox("自定义范围", "Textbox", "输入", true, function(value)
    print(value)
_G.HeadSize = value
_G.Disabled = true
game:GetService('RunService').RenderStepped:connect(function()
if _G.Disabled then
for i,v in next, game:GetService('Players'):GetPlayers() do
if v.Name ~= game:GetService('Players').LocalPlayer.Name then
pcall(function()
v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
v.Character.HumanoidRootPart.Transparency = 0.7
v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
v.Character.HumanoidRootPart.Material = "Neon"
v.Character.HumanoidRootPart.CanCollide = false
end)
end
end
end
end)
end)
RJ_2:Button("普通范围", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/jiNwDbCN"))()
end)    
RJ_2:Button("中等范围", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/x13bwrFb"))()
end)    
RJ_2:Button("全图范围", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/KKY9EpZU"))()
end)    
RJ_2:Button("终极范围", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/CAQ9x4A7"))()
end)    
RJ_2:Button("飞行", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/gHNFtdZN"))()
end)    
RJ_2:Button("飞车", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/MHE1cbWF"))()
end)    
RJ_2:Button("甩飞别人", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/GnvPVBEi"))()
end)    
RJ_2:Button("死亡笔记", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/yuihghghg/siwangbook/main/%E6%AD%BB%E4%BA%A1%E7%AC%94%E8%AE%B0(1).txt"))()
end)    
RJ_2:Button("4K画质", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/nUrpHG3N"))()
end)    
RJ_2:Button("透视", function()
    loadstring(game:HttpGet('https://pastebin.com/raw/MA8jhPWT'))()
end)    
RJ_2:Button("骂人无违规", function()
    loadstring(game:GetObjects("rbxassetid://1262435912")[1].Source)()
end)    

RJ_3:Button("披萨店食物乱飞", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/TQwh73Dx"))()
end)
RJ_3:Button("51区", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/yuihghghg/hb-studio/main/51%E5%8C%BA.txt'))()
end)
RJ_3:Button("刀刃球", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/yuihghghg/hb-studio/main/%E5%88%80%E5%88%83%E7%90%83.txt'))()
end)
RJ_3:Button("战争大亨",function()
    loadstring(game:HttpGet("https://shz.al/BeXpfwBMh2PbpYm4C3fCAX7t"))()
end)
RJ_3:Button("汽车经销大亨", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/yuihghghg/hb-studio/main/%E6%B1%BD%E8%BD%A6%E7%BB%8F%E9%94%80%E5%A4%A7%E4%BA%A8.txt'))()
end)    
RJ_3:Button("火箭发射", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/yuihghghg/hb-studio/main/%E7%81%AB%E7%AE%AD%E5%8F%91%E5%B0%84.txt'))()
end) 
RJ_3:Button("力量传奇", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/yuihghghg/hb-studio/main/%E5%8A%9B%E9%87%8F%E4%BC%A0%E5%A5%87.txt'))()
end)    
RJ_3:Button("河北唐县", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/yuihghghg/hb-studio/main/%E6%B2%B3%E5%8C%97%E5%94%90%E5%8E%BF.txt'))()
end)
RJ_3:Button("自然灾害", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/yuihghghg/hb-studio/main/%E8%87%AA%E7%84%B6%E7%81%BE%E5%AE%B3.txt'))()
end) 
RJ_3:Button("感染力的微笑", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/yuihghghg/hb-studio/main/%E6%84%9F%E6%9F%93%E5%8A%9B%E7%9A%84%E5%BE%AE%E7%AC%91.txt'))()
end)
RJ_3:Button("俄亥俄州", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/yuihghghg/hb-studio/main/%E4%BF%84%E4%BA%A5%E4%BF%84%E5%B7%9E.txt'))()
end)