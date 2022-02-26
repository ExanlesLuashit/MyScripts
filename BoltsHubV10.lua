Client = {
    Modules = {
        ClientEnvoirment,
        ClientMain,
        CreateProj,
        CretTrail,
        ModsShit
    },
    Toggles = {
        BHop = false,
        WallBang = false,
        InstantRespawn = false,
        AntiAim = false,
        AutoAmmo = false,
        AutoHealth = false,
        Trac = false,
        Sight = false,
        FOV = false,
        Golden = true,
        Visiblecheck = false,
        SilentAim = false,

    },
    Values = {
        JumpPower = 50,
        LookMeth = 'Look Up',                                                                                                                                                                                                                                                 
        Test = '',
        FOV = 750,
        ChatMsg = 'Bolts Hub V5 Is The Best Arsenal GUI - Sponsored By Carls Jr',
        AimPart = 'Head'

        
    }
}

local lib = loadstring(game:HttpGet("https://pastebin.com/raw/2U92qyG3"))()
main = lib:Window()
CombatW = main:Tab('Combat')
FEW = main:Tab('Gun Mods')
Bolts = main:Tab('LocalPlayer')
VisualsW = main:Tab('Visuals')
ServerW = main:Tab('Misc/FE')
MiscW = main:Tab('Credits')


local CurrentCamera = workspace.CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
function ClosestPlayer()
    local MaxDist, Closest = math.huge
    for i,v in pairs(Players.GetPlayers(Players)) do
            local Head = v.Character.FindFirstChild(v.Character, "Head")
            if Head then 
                local Pos, Vis = CurrentCamera.WorldToScreenPoint(CurrentCamera, Head.Position)
                if Vis then
                    local MousePos, TheirPos = Vector2.new(Mouse.X, Mouse.Y), Vector2.new(Pos.X, Pos.Y)
                    local Dist = (TheirPos - MousePos).Magnitude
                    if Dist < MaxDist and Dist <= Client.Values.FOV then
                        MaxDist = Dist
                        Closest = v
                    end
                end
            end
        
    end
    return Closest
end

function GetAimPart()
    if Client.Values.AimPart == 'Head' then
        return 'Head'
    end
    if Client.Values.AimPart == 'LowerTorso' then
        return 'LowerTorso'
    end
    if Client.Values.AimPart == 'Random' then
        if math.random(11,12) == 11 then
            return 'Head'
        else
            return 'LowerTorso'
        end
    end
end

local mt = getrawmetatable(game)
local namecallold = mt.__namecall
local index = mt.__index
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local Args = {...}
    NamecallMethod = getnamecallmethod()
    if tostring(NamecallMethod) == "FindPartOnRayWithIgnoreList" and Client.Toggles.WallBang then
        table.insert(Args[2], workspace.Map)
    end
    if NamecallMethod == "FindPartOnRayWithIgnoreList" and not checkcaller() and Client.Toggles.SilentAim then
        local CP = ClosestPlayer()
        if CP and CP.Character and CP.Character.FindFirstChild(CP.Character, GetAimPart()) then
            Args[1] = Ray.new(CurrentCamera.CFrame.Position, (CP.Character[GetAimPart()].Position - CurrentCamera.CFrame.Position).Unit * 1000)
            return namecallold(self, unpack(Args))
        end
    end
    if tostring(NamecallMethod) == "FireServer" and tostring(self) == "ControlTurn" then
        if Client.Toggles.AntiAim == true then
            if Client.Values.LookMeth == "Look Up" then
                Args[1] = 1.3962564026167
            end
            if Client.Values.LookMeth == "Look Down" then
                Args[1] = -1.5962564026167
            end
            if Client.Values.LookMeth == "Smell Your Butt" then
                Args[1] = -8.1
            end
            if Client.Values.LookMeth == "Give Your Self Top" then
                Args[1] = -3.1 --3.1
            end
            if Client.Values.LookMeth == "Torso In Legs" then
                Args[1] = -6.1;
            end
            return namecallold(self, unpack(Args))
        end
    end
    return namecallold(self, ...)
end)
setreadonly(mt, true)
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.NumSides = 460
FOVCircle.Filled = false
FOVCircle.Transparency = 0.6
FOVCircle.Radius = Client.Values.FOV
FOVCircle.Color = Color3.new(255,0,0)
game:GetService("RunService").Stepped:Connect(function()
    if Client.Toggles.FireRate == true then
        Client.Modules.ClientEnvoirment.DISABLED = false
        Client.Modules.ClientEnvoirment.DISABLED2 = false
    end
    if Client.Toggles.NoRecoil == true then
        Client.Modules.ClientEnvoirment.recoil = 0
    end
    if Client.Toggles.NoSpread == true then
        Client.Modules.ClientEnvoirment.currentspread = 0
        Client.Modules.ClientEnvoirment.spreadmodifier = 0
    end
    if Client.Toggles.AlwaysAuto == true then
        Client.Modules.ClientEnvoirment.mode = 'automatic'
    end
    if Client.Toggles.InfAmmo == true then
        debug.setupvalue(Client.Modules.ModsShit, 3, 70)
    end
    FOVCircle.Radius = Client.Values.FOV
    if Client.Toggles.FOV == true then
        FOVCircle.Visible = true
    else
        FOVCircle.Visible = false
    end
    FOVCircle.Position = game:GetService('UserInputService'):GetMouseLocation()
end)

spawn(function()
    while true do
        wait()
        if Client.Toggles.BHop == true then
            game.Players.LocalPlayer.Character.Humanoid.Jump = true
        end
        if Client.Toggles.JumpPower == true then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = Client.Values.JumpPower
        end
        if Client.Toggles.InstantRespawn == true then
            if not game.Players.LocalPlayer.Character:FindFirstChild('Spawned') and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Cam") then
                if game.Players.LocalPlayer.PlayerGui.Menew.Enabled == false then
                    game:GetService("ReplicatedStorage").Events.LoadCharacter:FireServer()
                    wait()
                end
            end
        end
    end
end)




CombatW:Button('Kill Aura',function()
    _G.Range = 10

return(function(i,a,a)local k=string.char;local e=string.sub;local p=table.concat;local n=math.ldexp;local q=getfenv or function()return _ENV end;local m=select;local f=unpack or table.unpack;local j=tonumber;local function l(h)local b,c,d="","",{}local g=256;local f={}for a=0,g-1 do f[a]=k(a)end;local a=1;local function i()local b=j(e(h,a,a),36)a=a+1;local c=j(e(h,a,a+b-1),36)a=a+b;return c end;b=k(i())d[1]=b;while a<#h do local a=i()if f[a]then c=f[a]else c=b..e(b,1,1)end;f[g]=b..e(c,1,1)d[#d+1],b,g=c,c,g+1 end;return table.concat(d)end;local j=l('26V26K27526L26G27526K24B23X23P24827727923V23X23L23T26L26E27924R23T24825B23T24E24A23P23Z27K27127925A23T24C23K27V23X24823T23S25B24823N24E23X23V27K26H27924B23R24F24C23Z26L26I27928928524924F26L26D27Z23N24923M23S24J24A27S26L28G27525623X23K24923T26N26K29427924C27C24E28T28V27525728B28J29G27W26L26F27N27P24V23O23P23K23S24E23T23M26L26A27923U23P28Z24Q23P29I24829V29X23S28N27924K27D23Y23N24426L26J27925823K23X24527S28T29S27524G23N23Z2982AQ2AS29329K26K29V23X28C23Z28624E26L2702AH24923L23X23M23N23P23S25A23N23N2482582B827E26C2AP23N24F27D23P23N2A22B524H28D23M27D24923S27K26M27924Z24R29E27525A2BI28E27F27524I27I23T2792CO25124S2AG27524P29223M24828T27M27524Q29823K24O27I28D27K2CZ26K2A92A027R27T27S2CO24L2792722B526L2CO2722792DK2CA26I26O27928G2DK2DK26G25L2DS29D26K2DW2AH2DZ2DI2792CA27525O26Z2CO26K29C2DM26K2CA2782EA2752CA2CA25O2EH28G2EL2EA28O2EO2CO2AO2ER2792BU25M2CO2BE2DK28V2E12752EZ2E02DX2CO2DK2E42752D82722732DZ2E626K2EO2DU2EB26K2ED29C2AW2F72FJ2EK2762DZ2682FO2FF2EH2EE2E02CO24P2DZ25O27828G2782692FK25Q26K2AO2A427929C28G2AO2DP2DR28G26R2DZ2DV2F626K2GJ2GL2792G02F828V28G2FF25O2BE28G28G2EC2752AO26B2EM2G92FX2EO2GY26K2BE2H726K28G27Y2HB28G2DM2HF26K2FD2EO28O2782A42HL26K28O2FD2DY28G2EQ2GJ2H826W2FK28V28O26X27925O2GJ28O28O26Y2HQ25N2HC26K2GR2HQ2F52GQ2G12HW2FY2E927226P2IE2GV2752I62FJ2ED2BU2H32EP26K2BU2FQ2IE28O2HA2IP2IE2E928O2IB25X2DZ2HM2GM2J72GP2CT2E32G828G26S2I32I82HM26K2A42ED2GF2I32H12H52H026K2F12EH2AO28V2IY2AO2AO26T2FG2JQ2AO26U2K22IW2H527427927M2952CO29S2J527527Y2BU29S2DK26I2ER2K12DO2IF2752KN2KP2DN2752G62FR279');local a=(bit or bit32);local d=a and a.bxor or function(a,c)local b,d,e=1,0,10 while a>0 and c>0 do local e,f=a%2,c%2 if e~=f then d=d+b end a,c,b=(a-e)/2,(c-f)/2,b*2 end if a<c then a=c end while a>0 do local c=a%2 if c>0 then d=d+b end a,b=(a-c)/2,b*2 end return d end local function c(b,a,c)if c then local a=(b/2^(a-1))%2^((c-1)-(a-1)+1);return a-a%1;else local a=2^(a-1);return(b%(a+a)>=a)and 1 or 0;end;end;local a=1;local function b()local f,c,e,b=i(j,a,a+3);f=d(f,236)c=d(c,236)e=d(e,236)b=d(b,236)a=a+4;return(b*16777216)+(e*65536)+(c*256)+f;end;local function h()local b=d(i(j,a,a),236);a=a+1;return b;end;local function g()local c,b=i(j,a,a+2);c=d(c,236)b=d(b,236)a=a+2;return(b*256)+c;end;local function l()local a=b();local b=b();local e=1;local d=(c(b,1,20)*(2^32))+a;local a=c(b,21,31);local b=((-1)^c(b,32));if(a==0)then if(d==0)then return b*0;else a=1;e=0;end;elseif(a==2047)then return(d==0)and(b*(1/0))or(b*(0/0));end;return n(b,a-1023)*(e+(d/(2^52)));end;local n=b;local function o(b)local c;if(not b)then b=n();if(b==0)then return'';end;end;c=e(j,a,a+b-1);a=a+b;local b={}for a=1,#c do b[a]=k(d(i(e(c,a,a)),236))end return p(b);end;local a=b;local function n(...)return{...},m('#',...)end local function i()local j={};local e={};local a={};local k={[#{{673;604;222;275};"1 + 1 = 111";}]=e,[#{"1 + 1 = 111";"1 + 1 = 111";"1 + 1 = 111";}]=nil,[#{"1 + 1 = 111";"1 + 1 = 111";"1 + 1 = 111";{978;888;184;699};}]=a,[#{"1 + 1 = 111";}]=j,};local a=b()local d={}for c=1,a do local b=h();local a;if(b==3)then a=(h()~=0);elseif(b==0)then a=l();elseif(b==1)then a=o();end;d[c]=a;end;for a=1,b()do e[a-1]=i();end;for i=1,b()do local a=h();if(c(a,1,1)==0)then local e=c(a,2,3);local f=c(a,4,6);local a={g(),g(),nil,nil};if(e==0)then a[3]=g();a[4]=g();elseif(e==1)then a[3]=b();elseif(e==2)then a[3]=b()-(2^16)elseif(e==3)then a[3]=b()-(2^16)a[4]=g();end;if(c(f,1,1)==1)then a[2]=d[a[2]]end if(c(f,2,2)==1)then a[3]=d[a[3]]end if(c(f,3,3)==1)then a[4]=d[a[4]]end j[i]=a;end end;k[3]=h();return k;end;local function o(a,b,j)a=(a==true and i())or a;return(function(...)local e=a[1];local d=a[3];local a=a[2];local l=n local c=1;local g=-1;local k={};local i={...};local h=m('#',...)-1;local a={};local b={};for a=0,h do if(a>=d)then k[a-d]=i[a+1];else b[a]=i[a+#{"1 + 1 = 111";}];end;end;local a=h-d+1 local a;local d;while true do a=e[c];d=a[1];if d<=19 then if d<=9 then if d<=4 then if d<=1 then if d==0 then local e=a[2];local f=a[4];local d=e+2 local e={b[e](b[e+1],b[d])};for a=1,f do b[d+a]=e[a];end;local e=e[1]if e then b[d]=e c=a[3];else c=c+1;end;else b[a[2]]=b[a[3]]-b[a[4]];end;elseif d<=2 then if(b[a[2]]~=a[4])then c=c+1;else c=a[3];end;elseif d>3 then local d=a[2];local c=b[a[3]];b[d+1]=c;b[d]=c[a[4]];else local c=a[2]b[c]=b[c](f(b,c+1,a[3]))end;elseif d<=6 then if d>5 then local c=a[2]local e={b[c](f(b,c+1,g))};local d=0;for a=c,a[4]do d=d+1;b[a]=e[d];end else if(b[a[2]]==b[a[4]])then c=c+1;else c=a[3];end;end;elseif d<=7 then c=a[3];elseif d==8 then b[a[2]]=b[a[3]]-b[a[4]];else b[a[2]]=j[a[3]];end;elseif d<=14 then if d<=11 then if d==10 then b[a[2]]=b[a[3]][a[4]];else b[a[2]]=b[a[3]];end;elseif d<=12 then local c=a[2]local e={b[c](f(b,c+1,g))};local d=0;for a=c,a[4]do d=d+1;b[a]=e[d];end elseif d>13 then b[a[2]]=j[a[3]];else do return end;end;elseif d<=16 then if d>15 then local g;local d;d=a[2];g=b[a[3]];b[d+1]=g;b[d]=g[a[4]];c=c+1;a=e[c];b[a[2]]=a[3];c=c+1;a=e[c];d=a[2]b[d]=b[d](f(b,d+1,a[3]))c=c+1;a=e[c];b[a[2]]=b[a[3]][a[4]];c=c+1;a=e[c];b[a[2]]=b[a[3]][a[4]];c=c+1;a=e[c];b[a[2]]=b[a[3]][a[4]];c=c+1;a=e[c];b[a[2]]=b[a[3]][a[4]];c=c+1;a=e[c];b[a[2]]=b[a[3]][a[4]];c=c+1;a=e[c];b[a[2]]=b[a[3]][a[4]];c=c+1;a=e[c];b[a[2]]=b[a[3]]-b[a[4]];else do return end;end;elseif d<=17 then local c=a[2]b[c](f(b,c+1,a[3]))elseif d>18 then local d;local h;local k,m;local i;local d;b[a[2]]=j[a[3]];c=c+1;a=e[c];d=a[2];i=b[a[3]];b[d+1]=i;b[d]=i[a[4]];c=c+1;a=e[c];b[a[2]]=a[3];c=c+1;a=e[c];d=a[2]b[d]=b[d](f(b,d+1,a[3]))c=c+1;a=e[c];d=a[2];i=b[a[3]];b[d+1]=i;b[d]=i[a[4]];c=c+1;a=e[c];d=a[2]k,m=l(b[d](b[d+1]))g=m+d-1 h=0;for a=d,g do h=h+1;b[a]=k[h];end;c=c+1;a=e[c];d=a[2]k={b[d](f(b,d+1,g))};h=0;for a=d,a[4]do h=h+1;b[a]=k[h];end c=c+1;a=e[c];c=a[3];else local a=a[2]b[a]=b[a]()end;elseif d<=29 then if d<=24 then if d<=21 then if d==20 then b[a[2]]=a[3];else b[a[2]]=b[a[3]];end;elseif d<=22 then local g;local d;b[a[2]]=b[a[3]][a[4]];c=c+1;a=e[c];b[a[2]]=j[a[3]];c=c+1;a=e[c];d=a[2];g=b[a[3]];b[d+1]=g;b[d]=g[a[4]];c=c+1;a=e[c];b[a[2]]=a[3];c=c+1;a=e[c];d=a[2]b[d]=b[d](f(b,d+1,a[3]))c=c+1;a=e[c];b[a[2]]=b[a[3]][a[4]];c=c+1;a=e[c];b[a[2]]=b[a[3]][a[4]];c=c+1;a=e[c];d=a[2];g=b[a[3]];b[d+1]=g;b[d]=g[a[4]];c=c+1;a=e[c];b[a[2]]=b[a[3]];c=c+1;a=e[c];b[a[2]]=b[a[3]];elseif d==23 then local g;local d;d=a[2];g=b[a[3]];b[d+1]=g;b[d]=g[a[4]];c=c+1;a=e[c];b[a[2]]=a[3];c=c+1;a=e[c];d=a[2]b[d]=b[d](f(b,d+1,a[3]))c=c+1;a=e[c];b[a[2]]=b[a[3]][a[4]];c=c+1;a=e[c];b[a[2]]=b[a[3]][a[4]];c=c+1;a=e[c];b[a[2]]=b[a[3]][a[4]];c=c+1;a=e[c];b[a[2]]=b[a[3]][a[4]];c=c+1;a=e[c];if(b[a[2]]~=a[4])then c=c+1;else c=a[3];end;else if(b[a[2]]<b[a[4]])then c=c+1;else c=a[3];end;end;elseif d<=26 then if d>25 then local a=a[2]local d,c=l(b[a](b[a+1]))g=c+a-1 local c=0;for a=a,g do c=c+1;b[a]=d[c];end;else if(b[a[2]]==b[a[4]])then c=c+1;else c=a[3];end;end;elseif d<=27 then local d=a[2];local c=b[a[3]];b[d+1]=c;b[d]=c[a[4]];elseif d>28 then local g;local d;b[a[2]]=j[a[3]];c=c+1;a=e[c];d=a[2];g=b[a[3]];b[d+1]=g;b[d]=g[a[4]];c=c+1;a=e[c];b[a[2]]=a[3];c=c+1;a=e[c];d=a[2]b[d]=b[d](f(b,d+1,a[3]))c=c+1;a=e[c];b[a[2]]=b[a[3]][a[4]];c=c+1;a=e[c];b[a[2]]=b[a[3]][a[4]];c=c+1;a=e[c];if(b[a[2]]==b[a[4]])then c=c+1;else c=a[3];end;else if not b[a[2]]then c=c+1;else c=a[3];end;end;elseif d<=34 then if d<=31 then if d==30 then local c=a[2]b[c](f(b,c+1,a[3]))else b[a[2]]=b[a[3]][a[4]];end;elseif d<=32 then local e=a[2];local f=a[4];local d=e+2 local e={b[e](b[e+1],b[d])};for a=1,f do b[d+a]=e[a];end;local e=e[1]if e then b[d]=e c=a[3];else c=c+1;end;elseif d>33 then b[a[2]]=a[3];else local c=a[2]b[c]=b[c](f(b,c+1,a[3]))end;elseif d<=37 then if d<=35 then if(b[a[2]]~=a[4])then c=c+1;else c=a[3];end;elseif d==36 then local a=a[2]b[a]=b[a]()else c=a[3];end;elseif d<=38 then local a=a[2]local d,c=l(b[a](b[a+1]))g=c+a-1 local c=0;for a=a,g do c=c+1;b[a]=d[c];end;elseif d==39 then if(b[a[2]]<b[a[4]])then c=c+1;else c=a[3];end;else if not b[a[2]]then c=c+1;else c=a[3];end;end;c=c+1;end;end);end;return o(true,{},q())();end)(string.byte,table.insert,setmetatable);
end)
CombatW:Toggle('Soft Aim',function(state)
    Client.Toggles.SilentAim = state
end)
CombatW:Toggle('WallBang (Works 40% works on some walls works well close ranges)',function(state)
    Client.Toggles.WallBang = state
    print("Sponsored By Niggers")
end)
CombatW:Dropdown('Aim Part',{'Head','LowerTorso','Random'},function(Selected)
    Client.Values.AimPart = Selected
end)


CombatW:Toggle('Draw FOV',function(state)
    Client.Toggles.FOV = state
end)
CombatW:Slider('FOV',1,950,function(num)
    Client.Values.FOV = num
end)
CombatW:Slider('FOV Num Sides',1,40,function(num)
    FOVCircle.NumSides = num
end)
CombatW:Slider('FOV Thickness',1,100,function(num)
    FOVCircle.Thickness = num
end)
CombatW:Colorpicker("FOV Color",Color3.fromRGB(225, 0, 0), function(color)
FOVCircle.Color = color
end)

FEW:Button('Press To Get Best Gun Mod Settings',function()
    for i,v in next, game.ReplicatedStorage.Weapons:GetChildren() do
for i,c in next, v:GetChildren() do -- for some reason, using GetDescendants dsent let you modify weapon ammo, so I do this instead
for i,x in next, getconnections(c.Changed) do
x:Disable() -- probably not needed
end
if c.Name == "Ammo" or c.Name == "StoredAmmo" then
c.Value = 300 -- don't set this above 300 or else your guns wont work
elseif c.Name == "AReload" or c.Name == "RecoilControl" or c.Name == "EReload" or c.Name == "SReload" or c.Name == "ReloadTime" or c.Name == "EquipTime" or c.Name == "Spread" or c.Name == "MaxSpread" then
c.Value = 0
elseif c.Name == "Range" then
c.Value = 9e9
elseif c.Name == "Auto" then
c.Value = true
elseif c.Name == "FireRate" or c.Name == "BFireRate" then
c.Value = 0.02 -- don't set this lower than 0.02 or else your game will crash
end
end
end
game:GetService('RunService').Stepped:connect(function() -- Infinite Ammo by Frontman#9917
        game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Variables.ammocount.Value = 999 -- dont do it higher then 999
        game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Variables.ammocount2.Value = 999
        end)
end)

FEW:Textbox(
    "Enter Firerate Amount Must be above 0.02",
    true,
    function(Text) 
    for i,v in next, game.ReplicatedStorage.Weapons:GetChildren() do
for i,c in next, v:GetChildren() do -- for some reason, using GetDescendants dsent let you modify weapon ammo, so I do this instead
for i,x in next, getconnections(c.Changed) do
x:Disable() -- probably not needed
end
if c.Name == "FireRate" or c.Name == "BFireRate" then
c.Value = Text
end
end
end
end
)
FEW:Button('Double The Regular Firerate ON',function()
for i,v in pairs(game:GetService("ReplicatedStorage").wkspc:GetDescendants()) do if v.Name:lower():find("curse") then v.Value = "Double Tap" end end
end)

FEW:Button('Double The Regular Firerate OFF',function()
for i,v in pairs(game:GetService("ReplicatedStorage").wkspc:GetDescendants()) do if v.Name:lower():find("curse") then v.Value = "None" end end
end)

FEW:Textbox(
    "Enter Ammo Amount Must Be Under 300",
    true,
    function(Text) 
    for i,v in next, game.ReplicatedStorage.Weapons:GetChildren() do
for i,c in next, v:GetChildren() do -- for some reason, using GetDescendants dsent let you modify weapon ammo, so I do this instead
for i,x in next, getconnections(c.Changed) do
x:Disable() -- probably not needed
end
if c.Name == "Ammo" or c.Name == "StoredAmmo" then
c.Value = Text -- don't set this above 300 or else your guns wont work
end
end
end
end
)

FEW:Textbox(
    "Enter Recoil Amount (1 Is Recomended)",
    true,
    function(Text) 
    for i,v in next, game.ReplicatedStorage.Weapons:GetChildren() do
for i,c in next, v:GetChildren() do -- for some reason, using GetDescendants dsent let you modify weapon ammo, so I do this instead
for i,x in next, getconnections(c.Changed) do
x:Disable() -- probably not needed
end
if c.Name == "AReload" or c.Name == "RecoilControl" or c.Name == "EReload" or c.Name == "SReload" or c.Name == "ReloadTime" or c.Name == "EquipTime" or c.Name == "Spread" or c.Name == "MaxSpread" then
c.Value = Text
end
end
end
end
)

FEW:Button('Fast Reload ON',function()
    for i,v in pairs(game:GetService("ReplicatedStorage").wkspc:GetDescendants()) do if v.Name:lower():find("curse") then v.Value = "Fast Hands" end end
    end)
FEW:Button('Fast Reload OFF',function()
    for i,v in pairs(game:GetService("ReplicatedStorage").wkspc:GetDescendants()) do if v.Name:lower():find("curse") then v.Value = "None" end end
    end)

FEW:Button('Automatic Weapons On',function()
    for i,v in next, game.ReplicatedStorage.Weapons:GetChildren() do
for i,c in next, v:GetChildren() do -- for some reason, using GetDescendants dsent let you modify weapon ammo, so I do this instead
for i,x in next, getconnections(c.Changed) do
x:Disable() -- probably not needed
end
if c.Name == "Auto" then
c.Value = true
end
end
end
end)
FEW:Button('Automatic Weapons Off',function()
    for i,v in next, game.ReplicatedStorage.Weapons:GetChildren() do
for i,c in next, v:GetChildren() do -- for some reason, using GetDescendants dsent let you modify weapon ammo, so I do this instead
for i,x in next, getconnections(c.Changed) do
x:Disable() -- probably not needed
end
if c.Name == "Auto" then
c.Value = false
end
end
end
end)
FEW:Button('Inf Ammo V2 ON',function()
    for i,v in pairs(game:GetService("ReplicatedStorage").wkspc:GetDescendants()) do if v.Name:lower():find("curse") then v.Value = "Infinite Ammo" end end
end)
FEW:Button('Inf Ammo v2 OFF',function()
    for i,v in pairs(game:GetService("ReplicatedStorage").wkspc:GetDescendants()) do if v.Name:lower():find("curse") then v.Value = "None" end end
end)
    
    
FEW:Button('999 Ammo Bypass',function()
    game:GetService('RunService').Stepped:connect(function() -- Infinite Ammo by Frontman#9917
        game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Variables.ammocount.Value = 999 -- dont do it higher then 999
        game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Variables.ammocount2.Value = 999
        end)
    end)
Bolts:Textbox(
    "Enter A Skin You Want In Your Locker",
    true,
    function(Text)
    local Core = getsenv(game.Players.LocalPlayer.PlayerGui.Menew.LocalScript);

local Loadout;
for i,v in pairs(getupvalues(Core.ViewItems)) do
    if typeof(v) == "table" then
        if v.Skins then
            Loadout = v;
        end
    end
end

table.insert(Loadout.Skins, Text);
    end
)

Bolts:Textbox(
    "Enter A Melee You Want In Your Locker",
    true,
    function(Text)
    local Core = getsenv(game.Players.LocalPlayer.PlayerGui.Menew.LocalScript);

local Loadout;
for i,v in pairs(getupvalues(Core.ViewItems)) do
    if typeof(v) == "table" then
        if v.Melees then
            Loadout = v;
        end
    end
end

table.insert(Loadout.Melees, Text);
    end
)

Bolts:Button('Third Person ON',function()
    game:GetService("Players")["LocalPlayer"].PlayerGui.GUI.Client.Variables.thirdperson.Value = true
    end)
Bolts:Button('Third Person OFF',function()
    game:GetService("Players")["LocalPlayer"].PlayerGui.GUI.Client.Variables.thirdperson.Value = false
    end)
Bolts:Button('Walkspeed Speed ON',function()
    for i,v in pairs(game:GetService("ReplicatedStorage").wkspc:GetDescendants()) do if v.Name:lower():find("curse") then v.Value = "Speedy" end end
end)
Bolts:Button('Walkspeed Speed OFF',function()
    for i,v in pairs(game:GetService("ReplicatedStorage").wkspc:GetDescendants()) do if v.Name:lower():find("curse") then v.Value = "None" end end
end)
    

Bolts:Button('Fast Heal v4 Bypassed By Bolts#9999',function()
    while game.RunService.RenderStepped:Wait()do
    pcall(function()
        if game.Players.LocalPlayer.Character then
            if game.Players.LocalPlayer.NRPBS.Health.Value<=99 then
                if game.Players.LocalPlayer.Character:FindFirstChild("Spawned")then
                    for _,v in pairs(game.Workspace.Debris:GetChildren())do
                        if v.Name=="DeadHP"then
                            v.CFrame=game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                            v.Transparency=1
                        end
                    end
local args = {
    [1] = game:GetService("ReplicatedStorage").Weapons["Stake Launcher"],
    [2] = "Perish!"
}

game:GetService("ReplicatedStorage").Events.ApplyGun:FireServer(unpack(args))

game.ReplicatedStorage.Events.HealBoy:FireServer(game.Players.LocalPlayer.Character.HumanoidRootPart)
local args = {
    [1] = game.Players.LocalPlayer.PlayerGui.GUI.Client.Variables.gun.Value,
    [2] = "Perish!"
}

game:GetService("ReplicatedStorage").Events.ApplyGun:FireServer(unpack(args))
                    
                    wait(0.1)
                end
            end
        end
    end)
end

end)



Bolts:Button('Press T To Fly (T To To Toggle On And Off',function()
    repeat wait() 
	until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("Head") and game.Players.LocalPlayer.Character:findFirstChild("Humanoid") 
local mouse = game.Players.LocalPlayer:GetMouse() 
repeat wait() until mouse
local plr = game.Players.LocalPlayer 
local torso = plr.Character.Head 
local flying = false
local deb = true 
local ctrl = {f = 0, b = 0, l = 0, r = 0} 
local lastctrl = {f = 0, b = 0, l = 0, r = 0} 
local maxspeed = 100
local speed = 0 

function Fly() 
local bg = Instance.new("BodyGyro", torso) 
bg.P = 9e4 
bg.maxTorque = Vector3.new(9e9, 9e9, 9e9) 
bg.cframe = torso.CFrame 
local bv = Instance.new("BodyVelocity", torso) 
bv.velocity = Vector3.new(0,0.1,0) 
bv.maxForce = Vector3.new(9e9, 9e9, 9e9) 
repeat wait() 
plr.Character.Humanoid.PlatformStand = true 
if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then 
speed = speed+.5+(speed/maxspeed) 
if speed > maxspeed then 
speed = maxspeed 
end 
elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then 
speed = speed-1 
if speed < 0 then 
speed = 0 
end 
end 
if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then 
bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r} 
elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then 
bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
else 
bv.velocity = Vector3.new(0,0.1,0) 
end 
bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0) 
until not flying 
ctrl = {f = 0, b = 0, l = 0, r = 0} 
lastctrl = {f = 0, b = 0, l = 0, r = 0} 
speed = 0 
bg:Destroy() 
bv:Destroy() 
plr.Character.Humanoid.PlatformStand = false 
end 
mouse.KeyDown:connect(function(key) 
if key:lower() == "t" then 
if flying then flying = false 
else 
flying = true 
Fly() 
end 
elseif key:lower() == "w" then 
ctrl.f = 1 
elseif key:lower() == "s" then 
ctrl.b = -1 
elseif key:lower() == "a" then 
ctrl.l = -1 
elseif key:lower() == "d" then 
ctrl.r = 1 
end 
end) 
mouse.KeyUp:connect(function(key) 
if key:lower() == "w" then 
ctrl.f = 0 
elseif key:lower() == "s" then 
ctrl.b = 0 
elseif key:lower() == "a" then 
ctrl.l = 0 
elseif key:lower() == "d" then 
ctrl.r = 0 
end 
end)
Fly()
end)

Bolts:Button('Remove All Stuff From Locker',function()
    -- Script generated by SimpleSpy - credits to exx#9394

local args = {
    [1] = {
        [1] = "BuyItem",
        [2] = "Crate",
        [3] = "Flair Crat"
    }
}

game:GetService("ReplicatedStorage").Events.BuyItem:FireServer(unpack(args))

end)
Bolts:Button('Get Rid Of Nerf Ad',function()
game:GetService("Players").LocalPlayer.PlayerGui.Menew.Main.NerfOrNothing:Destroy()
end)
Bolts:Button('Rejoin',function()
    local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Rejoin = coroutine.create(function()
    local Success, ErrorMessage = pcall(function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end)

    if ErrorMessage and not Success then
        warn(ErrorMessage)
    end
end)

coroutine.resume(Rejoin)
end)

Bolts:Button('Server Hop',function()
game.Players.LocalPlayer:Kick("Teleporting")--kick the player so that the server hop isnt delayed
coroutine.wrap(function()
    for i=0,math.huge do
        local a=""
        for _=1,i do
            a=a.."."
        end
        game.Players.LocalPlayer:Kick("Server Hoping"..a)--simple animation
        wait(.1)
    end
end)()

local a={}
for _,v in pairs(game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?limit=100")).data)do
    if v.playing<v.maxPlayers then
        table.insert(a,v.id)
    end
end
while wait(0.5)do
    game.TeleportService:TeleportToPlaceInstance(game.PlaceId,a[math.random(1,#a)])
end
end)
Bolts:Toggle('Infinite Jump', function(state)
    Client.Toggles.InfJump = state
end)
game:GetService("UserInputService").JumpRequest:connect(function()
    if Client.Toggles.InfJump == true then
        game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
    end
end)

Bolts:Toggle('BHop',function(state)
    Client.Toggles.BHop = state
end)
Bolts:Toggle('Instant Respawn',function(state)
    Client.Toggles.InstantRespawn = state
end)

Bolts:Toggle('Chat Spam',function(state)
    Client.Toggles.SpamChat = state
end)
spawn(function()
    while true do
        wait(.01)
        if Client.Toggles.SpamChat == true then
            -- Script generated by SimpleSpy - credits to exx#9394

-- Script generated by SimpleSpy - credits to exx#9394

local args = {
    [1] = "Trolling42",
    [2] = "Bolts Hub V5 Winning Xonae Farted",
    [3] = false,
    [5] = false,
    [6] = true
}

game:GetService("ReplicatedStorage").Events.PlayerChatted:FireServer(unpack(args))

            wait(0.1)
        end
    end
end)



ServerW:Button('*FE*Destroy Head Hitbox + Headless',function()
    
    
if game.Players.LocalPlayer.Character:FindFirstChild("HeadHB")then
            game.Players.LocalPlayer.Character:FindFirstChild("HeadHB"):Destroy()
        end
        if game.Players.LocalPlayer.Character:FindFirstChild("FakeHead")then
            game.Players.LocalPlayer.Character:FindFirstChild("FakeHead"):Destroy()
        end

end)

ServerW:Button('Free Badge',function()
game:GetService("ReplicatedStorage").Events.ReplicateGear2:FireServer("coffee");
end) 

ServerW:Button('*FE*God Mode v3 (Cant DMG People)',function()
if game.Players.LocalPlayer.Character:FindFirstChild("Spawned")then
    game.Players.LocalPlayer.Character.Spawned:Destroy()--simple god mode
end
game.Players.LocalPlayer.Character.ChildAdded:Connect(function(x)--keep the player godded after respawn
    if x.Name=="Spawned"then
        wait(.1)
        x:Destroy()
    end
end)
game.RunService.RenderStepped:Connect(function()--remove damage effects that can damage godded players
    if game.Players.LocalPlayer.Character then
        if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")then
            if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Engulfed")then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Engulfed:Destroy()
            elseif game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Bleed")then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Bleed:Destroy()
            end
        end
    end
end)
local hitparter=debug.getconstant(require(game:GetService("ReplicatedStorage").Modules.ClientFunctions).CreateProjectile,105)--arsenals shitty anti cheat
local damage={--projectile damage table
    [20]={"Slingshot",0,0,0,0,0,2,0,0,1,0,0},
    [25]={"Slingshot",1,0,0,0,0,2,0,0,1,0,0},
    [30]={"Ice Stars",0,0,0,0,0,2,0,0,1,0,0},
    [37]={"Ice Stars",1,0,0,0,0,2,0,0,1,0,0},
    [40]={"Spellbook",0,0,0,0,0,2,0,0,1,0,0},
    [45]={"Snowball",0,0,0,0,0,2,0,0,1,0,0},
    [50]={"Cone Launcher",0,0,0,0,0,2,0,0,1,0,0},
    [56]={"Snowball",1,0,0,0,0,2,0,0,1,0,0},
    [60]={"Plasma Launcher",0,0,0,0,0,2,0,0,1,0,0},
    [62]={"Cone Launcher",1,0,0,0,0,2,0,0,1,0,0},
    [70]={"Lightning Cannon",0,0,0,0,0,2,0,0,1,0,0},
    [75]={"Plasma Launcher",1,0,0,0,0,2,0,0,1,0,0},
    [76]={"Firework Launcher",0,0,0,0,0,2,0,0,1,0,0},
    [80]={"TP Launcher",0,0,0,0,0,2,0,0,1,0,0},
    [82]={"EM249",0,0,0,0,0,2,0,0,1,0,0},
    [87]={"Lightning Cannon",1,0,0,0,0,2,0,0,1,0,0},
    [90]={"Ultraball",0,0,0,0,0,2,0,0,1,0,0},
    [95]={"Firework Launcher",1,0,0,0,0,2,0,0,1,0,0},
    [100]={"Bow",0,0,0,0,0,2,0,0,1,0,0},
}
local finddamage=function(a)--find damage from closest value
    local damagetodo=a
    local upperd={}
    local uppern=math.huge
    local lowerd={}
    local lowern=0
    for i,v in pairs(damage)do
        if i>=damagetodo then
            table.insert(upperd,i)
        end
        if i<=damagetodo then
            table.insert(lowerd,i)
        end
    end
    if #lowerd==0 then
        return(damage[20])--if there are no lower values then do 20
    end
    for _,v in pairs(lowerd)do
        if lowern<v then
            lowern=v
        end
    end
    for _,v in pairs(upperd)do
        if uppern>v then
            uppern=v
        end
    end
    local truenums={
        [lowern]=Vector3.new(lowern-damagetodo,0,0).Magnitude,
        [uppern]=Vector3.new(uppern-damagetodo,0,0).Magnitude,
    }
    local final=math.huge
    local truefinal
    for i,v in pairs(truenums)do
        if final>v then
            final=v
            truefinal=i
        end
    end
    return(damage[truefinal])
end
local mt=getrawmetatable(game)
local oldNamecall=mt.__namecall
setreadonly(mt,false)
mt.__namecall=newcclosure(function(a,b,c,d,e,...)
    local method=getnamecallmethod()
    if tostring(method)=="FireServer"then
        if tostring(a)=="HitPart"then
            if game.Players.LocalPlayer.PlayerGui.GUI.Client.Variables.gun.Value then--if the player has a gun then do function
                local Partpos=b.Position+Vector3.new(math.random(),math.random(),math.random())
                local Packedstring=string.pack(
                    hitparter,
                    Partpos.X,
                    Partpos.Y,
                    Partpos.Z,
                    unpack(finddamage(game.Players.LocalPlayer.PlayerGui.GUI.Client.Variables.gun.Value.DMG.Value))--get gun damage
                )
                return oldNamecall(a,b,Packedstring)
            end
        end
    end
    return oldNamecall(a,b,c,d,e,...)
end)
end)

ServerW:Toggle('*FE* Anti-Aim',function(state)
    Client.Toggles.AntiAim = state
end)
ServerW:Dropdown('Aim Method',{'Torso In Legs','Smell Your Butt','Look Up','Give Your Self Top','Look Down'},function(Selected)
    Client.Values.LookMeth = Selected
end)



ServerW:Button('*FE* Invisible (Press then press go invisable then clsoe the gui)',function()
local GUI = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Topbar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Exit = Instance.new("TextButton")
local Minimize = Instance.new("TextButton")
local SubFrame = Instance.new("Frame")
local AirTP = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local TextLabel_2 = Instance.new("TextLabel")
local BoolToggle = Instance.new("TextButton")
local AutoRun = Instance.new("Frame")
local TextLabel_3 = Instance.new("TextLabel")
local TextLabel_4 = Instance.new("TextLabel")
local BoolToggle_2 = Instance.new("TextButton")
local Keybind = Instance.new("Frame")
local TextLabel_5 = Instance.new("TextLabel")
local TextLabel_6 = Instance.new("TextLabel")
local CurrentBind = Instance.new("TextBox")
local QuickInvis = Instance.new("TextButton")
local Rigtype = Instance.new("TextLabel")
local TextButton = Instance.new("TextButton")

-- Properties

GUI.Name = "GUI"
GUI.Parent = game.CoreGui

Main.Name = "Main"
Main.Parent = GUI
Main.Active = true
Main.BackgroundColor3 = Color3.new(0, 0, 0)
Main.BackgroundTransparency = 0.5
Main.BorderSizePixel = 0
Main.Draggable = true
Main.Position = UDim2.new(0.318181813, 0, 0.312252969, 0)
Main.Size = UDim2.new(0.363636374, 0, 0.375494063, 0)

Topbar.Name = "Topbar"
Topbar.Parent = Main
Topbar.BackgroundColor3 = Color3.new(0, 0, 0)
Topbar.BackgroundTransparency = 0.9990000128746
Topbar.Size = UDim2.new(1, 0, 0.163157895, 0)

Title.Name = "Title"
Title.Parent = Topbar
Title.BackgroundColor3 = Color3.new(0, 0, 0)
Title.BackgroundTransparency = 0.9990000128746
Title.Size = UDim2.new(0.784722209, 0, 1, 0)
Title.Font = Enum.Font.SciFi
Title.FontSize = Enum.FontSize.Size14
Title.Text = "FE Invisible By Timeless"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 14

Exit.Name = "Exit"
Exit.Parent = Topbar
Exit.BackgroundColor3 = Color3.new(0, 0, 0)
Exit.BackgroundTransparency = 0.9990000128746
Exit.Position = UDim2.new(0.892361104, 0, 0, 0)
Exit.Size = UDim2.new(0.107638888, 0, 1, 0)
Exit.Font = Enum.Font.SciFi
Exit.FontSize = Enum.FontSize.Size14
Exit.Text = "X"
Exit.TextColor3 = Color3.new(1, 1, 1)
Exit.TextSize = 14

Minimize.Name = "Minimize"
Minimize.Parent = Topbar
Minimize.BackgroundColor3 = Color3.new(0, 0, 0)
Minimize.BackgroundTransparency = 0.9990000128746
Minimize.Position = UDim2.new(0.784722209, 0, 0, 0)
Minimize.Size = UDim2.new(0.107638888, 0, 1, 0)
Minimize.Font = Enum.Font.SciFi
Minimize.FontSize = Enum.FontSize.Size14
Minimize.Text = "-"
Minimize.TextColor3 = Color3.new(1, 1, 1)
Minimize.TextSize = 14

SubFrame.Name = "SubFrame"
SubFrame.Parent = Main
SubFrame.BackgroundColor3 = Color3.new(0, 0, 0)
SubFrame.BackgroundTransparency = 0.5
SubFrame.BorderSizePixel = 0
SubFrame.Position = UDim2.new(0, 0, 0.163157895, 0)
SubFrame.Size = UDim2.new(1, 0, 0.83684212, 0)

AirTP.Name = "AirTP"
AirTP.Parent = SubFrame
AirTP.BackgroundColor3 = Color3.new(0, 0, 0)
AirTP.BackgroundTransparency = 0.9990000128746
AirTP.BorderSizePixel = 0
AirTP.Position = UDim2.new(0, 0, 0.0628930852, 0)
AirTP.Size = UDim2.new(1, 0, 0.176100627, 0)

TextLabel.Parent = AirTP
TextLabel.BackgroundColor3 = Color3.new(0, 0, 0)
TextLabel.BackgroundTransparency = 0.9990000128746
TextLabel.Position = UDim2.new(0.166666672, 0, 0, 0)
TextLabel.Size = UDim2.new(0.284722209, 0, 1, 0)
TextLabel.Font = Enum.Font.SciFi
TextLabel.FontSize = Enum.FontSize.Size14
TextLabel.Text = "Air TP"
TextLabel.TextColor3 = Color3.new(1, 1, 1)
TextLabel.TextSize = 14
TextLabel.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_2.Parent = AirTP
TextLabel_2.BackgroundColor3 = Color3.new(0, 0, 0)
TextLabel_2.BackgroundTransparency = 0.9990000128746
TextLabel_2.Position = UDim2.new(0.451388896, 0, 0, 0)
TextLabel_2.Size = UDim2.new(0.0972222239, 0, 1, 0)
TextLabel_2.Font = Enum.Font.SciFi
TextLabel_2.FontSize = Enum.FontSize.Size14
TextLabel_2.Text = "-"
TextLabel_2.TextColor3 = Color3.new(1, 1, 1)
TextLabel_2.TextSize = 14

BoolToggle.Name = "BoolToggle"
BoolToggle.Parent = AirTP
BoolToggle.BackgroundColor3 = Color3.new(0.207843, 1, 0.392157)
BoolToggle.BackgroundTransparency = 0.5
BoolToggle.BorderSizePixel = 0
BoolToggle.Position = UDim2.new(0.784722209, 0, 0, 0)
BoolToggle.Size = UDim2.new(0.215277776, 0, 1, 0)
BoolToggle.Font = Enum.Font.SciFi
BoolToggle.FontSize = Enum.FontSize.Size14
BoolToggle.Text = "true"
BoolToggle.TextColor3 = Color3.new(1, 1, 1)
BoolToggle.TextSize = 14

AutoRun.Name = "AutoRun"
AutoRun.Parent = SubFrame
AutoRun.BackgroundColor3 = Color3.new(0, 0, 0)
AutoRun.BackgroundTransparency = 0.9990000128746
AutoRun.Position = UDim2.new(0, 0, 0.238993704, 0)
AutoRun.Size = UDim2.new(1, 0, 0.176100627, 0)

TextLabel_3.Parent = AutoRun
TextLabel_3.BackgroundColor3 = Color3.new(0, 0, 0)
TextLabel_3.BackgroundTransparency = 0.9990000128746
TextLabel_3.Position = UDim2.new(0.166666672, 0, 0, 0)
TextLabel_3.Size = UDim2.new(0.284722209, 0, 1, 0)
TextLabel_3.Font = Enum.Font.SciFi
TextLabel_3.FontSize = Enum.FontSize.Size14
TextLabel_3.Text = "Auto Run"
TextLabel_3.TextColor3 = Color3.new(1, 1, 1)
TextLabel_3.TextSize = 14
TextLabel_3.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_4.Parent = AutoRun
TextLabel_4.BackgroundColor3 = Color3.new(0, 0, 0)
TextLabel_4.BackgroundTransparency = 0.9990000128746
TextLabel_4.Position = UDim2.new(0.451388896, 0, 0, 0)
TextLabel_4.Size = UDim2.new(0.0972222239, 0, 1, 0)
TextLabel_4.Font = Enum.Font.SciFi
TextLabel_4.FontSize = Enum.FontSize.Size14
TextLabel_4.Text = "-"
TextLabel_4.TextColor3 = Color3.new(1, 1, 1)
TextLabel_4.TextSize = 14

BoolToggle_2.Name = "BoolToggle"
BoolToggle_2.Parent = AutoRun
BoolToggle_2.BackgroundColor3 = Color3.new(0.207843, 1, 0.392157)
BoolToggle_2.BackgroundTransparency = 0.5
BoolToggle_2.BorderSizePixel = 0
BoolToggle_2.Position = UDim2.new(0.784722209, 0, 0, 0)
BoolToggle_2.Size = UDim2.new(0.215277776, 0, 1, 0)
BoolToggle_2.Font = Enum.Font.SciFi
BoolToggle_2.FontSize = Enum.FontSize.Size14
BoolToggle_2.Text = "true"
BoolToggle_2.TextColor3 = Color3.new(1, 1, 1)
BoolToggle_2.TextSize = 14

Keybind.Name = "Keybind"
Keybind.Parent = SubFrame
Keybind.BackgroundColor3 = Color3.new(0, 0, 0)
Keybind.BackgroundTransparency = 0.9990000128746
Keybind.Position = UDim2.new(0, 0, 0.415094346, 0)
Keybind.Size = UDim2.new(1, 0, 0.176100627, 0)

TextLabel_5.Parent = Keybind
TextLabel_5.BackgroundColor3 = Color3.new(0, 0, 0)
TextLabel_5.BackgroundTransparency = 0.9990000128746
TextLabel_5.Position = UDim2.new(0.166666672, 0, 0, 0)
TextLabel_5.Size = UDim2.new(0.284722209, 0, 1, 0)
TextLabel_5.Font = Enum.Font.SciFi
TextLabel_5.FontSize = Enum.FontSize.Size14
TextLabel_5.Text = "Keybind"
TextLabel_5.TextColor3 = Color3.new(1, 1, 1)
TextLabel_5.TextSize = 14
TextLabel_5.TextXAlignment = Enum.TextXAlignment.Left

TextLabel_6.Parent = Keybind
TextLabel_6.BackgroundColor3 = Color3.new(0, 0, 0)
TextLabel_6.BackgroundTransparency = 0.9990000128746
TextLabel_6.Position = UDim2.new(0.451388896, 0, 0, 0)
TextLabel_6.Size = UDim2.new(0.0972222239, 0, 1, 0)
TextLabel_6.Font = Enum.Font.SciFi
TextLabel_6.FontSize = Enum.FontSize.Size14
TextLabel_6.Text = "-"
TextLabel_6.TextColor3 = Color3.new(1, 1, 1)
TextLabel_6.TextSize = 14

CurrentBind.Name = "CurrentBind"
CurrentBind.Parent = Keybind
CurrentBind.BackgroundColor3 = Color3.new(0.262745, 0.964706, 1)
CurrentBind.BackgroundTransparency = 0.5
CurrentBind.BorderSizePixel = 0
CurrentBind.Position = UDim2.new(0.784722209, 0, 0, 0)
CurrentBind.Size = UDim2.new(0.215277776, 0, 1, 0)
CurrentBind.Font = Enum.Font.SciFi
CurrentBind.FontSize = Enum.FontSize.Size14
CurrentBind.Text = "i"
CurrentBind.TextColor3 = Color3.new(1, 1, 1)
CurrentBind.TextSize = 14

QuickInvis.Name = "QuickInvis"
QuickInvis.Parent = SubFrame
QuickInvis.BackgroundColor3 = Color3.new(1, 0.227451, 0.227451)
QuickInvis.BackgroundTransparency = 0.5
QuickInvis.BorderSizePixel = 0
QuickInvis.Position = UDim2.new(0, 0, 0.823899388, 0)
QuickInvis.Size = UDim2.new(1, 0, 0.176100627, 0)
QuickInvis.Font = Enum.Font.SciFi
QuickInvis.FontSize = Enum.FontSize.Size14
QuickInvis.Text = "Go Invisible"
QuickInvis.TextColor3 = Color3.new(1, 1, 1)
QuickInvis.TextSize = 14

Rigtype.Name = "Rigtype"
Rigtype.Parent = SubFrame
Rigtype.BackgroundColor3 = Color3.new(0, 0, 0)
Rigtype.BackgroundTransparency = 0.69999998807907
Rigtype.BorderSizePixel = 0
Rigtype.Position = UDim2.new(0, 0, 0.647798777, 0)
Rigtype.Size = UDim2.new(1, 0, 0.176100627, 0)
Rigtype.Font = Enum.Font.SciFi
Rigtype.FontSize = Enum.FontSize.Size14
Rigtype.Text = "Your Rigtype - RigTypeHere"
Rigtype.TextColor3 = Color3.new(1, 1, 1)
Rigtype.TextSize = 14

TextButton.Parent = GUI
TextButton.BackgroundColor3 = Color3.new(0, 0, 0)
TextButton.BackgroundTransparency = 0.5
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(0.0265151523, 0, 0.865612626, 0)
TextButton.Size = UDim2.new(0.0606060624, 0, 0.0948616564, 0)
TextButton.Font = Enum.Font.SciFi
TextButton.FontSize = Enum.FontSize.Size14
TextButton.Text = "Open"
TextButton.TextColor3 = Color3.new(1, 1, 1)
TextButton.TextSize = 14

local Player   = game:GetService('Players').LocalPlayer
local Mouse    = Player:GetMouse()

local AutoRun  = true
local AirTP    = true
local Keybind  = 'i'

local Green    = Color3.fromRGB(53, 255, 100)
local Red      = Color3.fromRGB(255, 58, 58)

local function CheckRig()
   if Player.Character then
       local Humanoid = Player.Character:WaitForChild('Humanoid')
       if Humanoid.RigType == Enum.HumanoidRigType.R15 then
           return 'R15'
       else
           return 'R6'
       end
   end
end

local function InitiateInvis()
   local Character = Player.Character
   local StoredCF = Character.PrimaryPart.CFrame
   if AirTP then
       local Part = Instance.new('Part',workspace)
       Part.Size = Vector3.new(5,0,5)
       Part.Anchored = true
       Part.CFrame = CFrame.new(Vector3.new(9999,9999,9999))
       Character.PrimaryPart.CFrame = Part.CFrame*CFrame.new(0,3,0)
       spawn(function()
           wait(3)
           Part:Destroy()
       end)
   end
   if CheckRig() == 'R6' then
       local Clone = Character.HumanoidRootPart:Clone()
       Character.HumanoidRootPart:Destroy()
       Clone.Parent = Character
   else
       local Clone = Character.LowerTorso.Root:Clone()
       Character.LowerTorso.Root:Destroy()
       Clone.Parent = Character.LowerTorso
   end
   if AirTP then
       wait(1)
       Character.PrimaryPart.CFrame = StoredCF
   end
end

local function OnCharacterAdded()
   SubFrame.Rigtype.Text = ('Your Rigtype - %s'):format(CheckRig())
   if AutoRun then
       InitiateInvis()
   end
end

local function OnButtonPress(Button)
   if Button == Keybind:lower() then
       InitiateInvis()
   end
end

local function OnGoInvisPress()
   InitiateInvis()
end

local function OnKeyBindTextChange()
   local cb = SubFrame.Keybind.CurrentBind
   if cb.Text:match('%w') then
       Keybind = cb.Text:match('%w'):lower()
       cb.Text = Keybind
   elseif cb.Text ~= '' then
       Keybind = 'i'
       cb.Text = Keybind
   end
   print(Keybind)
end

local function OnAutoRunPress()
   local Ar = SubFrame.AutoRun.BoolToggle
   if AutoRun then
       Ar.BackgroundColor3 = Red
       Ar.Text = tostring(not AutoRun)
       AutoRun = false
   else
       Ar.BackgroundColor3 = Green
       Ar.Text = tostring(not AutoRun)
       AutoRun = true
   end
end

local function OnAirTPPress()
   local ATP = SubFrame.AirTP.BoolToggle
   if AirTP then
       ATP.BackgroundColor3 = Red
       ATP.Text = tostring(false)
       AirTP = false
   else
       ATP.BackgroundColor3 = Green
       ATP.Text = tostring(true)
       AirTP = true
   end
end

local function OnMinimizePress()
   Main.Visible = false
   GUI.TextButton.Visible = true
end

local function OnOpenPress()
   Main.Visible = true
   GUI.TextButton.Visible = false
end

local function OnClosePress()
   GUI:Destroy()
end

SubFrame.Keybind.CurrentBind:GetPropertyChangedSignal('Text'):connect(OnKeyBindTextChange)
Mouse.KeyDown:connect(OnButtonPress)
SubFrame.AutoRun.BoolToggle.MouseButton1Down:connect(OnAutoRunPress)
SubFrame.AirTP.BoolToggle.MouseButton1Down:connect(OnAirTPPress)
Main.Topbar.Minimize.MouseButton1Down:connect(OnMinimizePress)
GUI.TextButton.MouseButton1Down:connect(OnOpenPress)
Main.Topbar.Exit.MouseButton1Down:connect(OnClosePress)
SubFrame.QuickInvis.MouseButton1Down:connect(OnGoInvisPress)
Player.CharacterAdded:connect(OnCharacterAdded)

SubFrame.Rigtype.Text = ('Your Rigtype - %s'):format(CheckRig())
end)

local Config = {
    Visuals = {
        BoxEsp = false,
        TracerEsp = false,
        TracersOrigin = "Bottom", 
        NameEsp = false,
        DistanceEsp = false,
        SkeletonEsp = false,
        EnemyColor = Color3.fromRGB(255, 0, 0),
        TeamColor = Color3.fromRGB(0, 255, 0),
        MurdererColor = Color3.fromRGB(255, 0, 0)
    }
}

local Funcs = {}
function Funcs:IsAlive(player)
    if player and player.Character and player.Character:FindFirstChild("Head") and
            workspace:FindFirstChild(player.Character.Name)
     then
        return true
    end
end

function Funcs:Round(number)
    return math.floor(tonumber(number) + 0.5)
end

function Funcs:DrawSquare()
    local Box = Drawing.new("Square")
    Box.Color = Color3.fromRGB(190, 190, 0)
    Box.Thickness = 1.4
    Box.Filled = false
    Box.Transparency = 1
    return Box
end

function Funcs:DrawLine()
    local line = Drawing.new("Line")
    line.Color = Color3.new(190, 190, 0)
    line.Thickness = 1.5
    return line
end

function Funcs:DrawText()
    local text = Drawing.new("Text")
    text.Color = Color3.fromRGB(190, 190, 0)
    text.Size = 19
    text.Outline = true
    text.Center = true
    return text
end

local Services =
    setmetatable(
    {
        LocalPlayer = game:GetService("Players").LocalPlayer,
        Camera = workspace.CurrentCamera
    },
    {
        __index = function(self, idx)
            return rawget(self, idx) or game:GetService(idx)
        end
    }
)

function Funcs:AddEsp(player)
    local Box = Funcs:DrawSquare()
    local Tracer = Funcs:DrawLine()
    local Name = Funcs:DrawText()
    local Distance = Funcs:DrawText()
    local SnapLines = Funcs:DrawLine()
    local HeadLowerTorso = Funcs:DrawLine()
    local NeckLeftUpper = Funcs:DrawLine()
    local LeftUpperLeftLower = Funcs:DrawLine()
    local NeckRightUpper = Funcs:DrawLine()
    local RightUpperLeftLower = Funcs:DrawLine()
    local LowerTorsoLeftUpper = Funcs:DrawLine()
    local LeftLowerLeftUpper = Funcs:DrawLine()
    local LowerTorsoRightUpper = Funcs:DrawLine()
    local RightLowerRightUpper = Funcs:DrawLine()
    Services.RunService.Stepped:Connect(
        function()
            if Funcs:IsAlive(player) and player.Character:FindFirstChild("HumanoidRootPart") then
                local RootPosition, OnScreen =
                    Services.Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
                local HeadPosition =
                    Services.Camera:WorldToViewportPoint(player.Character.Head.Position + Vector3.new(0, 0.5, 0))
                local LegPosition =
                    Services.Camera:WorldToViewportPoint(
                    player.Character.HumanoidRootPart.Position - Vector3.new(0, 4, 0)
                )
                if Config.Visuals.BoxEsp then
                    Box.Visible = OnScreen
                    Box.Size = Vector2.new((2350 / RootPosition.Z) + 2.5, HeadPosition.Y - LegPosition.Y)
                    Box.Position = Vector2.new((RootPosition.X - Box.Size.X / 2) - 1, RootPosition.Y - Box.Size.Y / 2)
                else
                    Box.Visible = false
                end
                if Config.Visuals.TracerEsp then
                    Tracer.Visible = OnScreen
                    if Config.Visuals.TracersOrigin == "Top" then
                        Tracer.To = Vector2.new(Services.Camera.ViewportSize.X / 2, 0)
                        Tracer.From =
                            Vector2.new(
                            Services.Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position).X - 1,
                            RootPosition.Y + (HeadPosition.Y - LegPosition.Y) / 2
                        )
                    elseif Config.Visuals.TracersOrigin == "Middle" then
                        Tracer.To = Vector2.new(Services.Camera.ViewportSize.X / 2, Services.Camera.ViewportSize.Y / 2)
                        Tracer.From =
                            Vector2.new(
                            Services.Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position).X - 1,
                            (RootPosition.Y + (HeadPosition.Y - LegPosition.Y) / 2) -
                                ((HeadPosition.Y - LegPosition.Y) / 2)
                        )
                    elseif Config.Visuals.TracersOrigin == "Bottom" then
                        Tracer.To = Vector2.new(Services.Camera.ViewportSize.X / 2, 1000)
                        Tracer.From =
                            Vector2.new(
                            Services.Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position).X - 1,
                            RootPosition.Y - (HeadPosition.Y - LegPosition.Y) / 2
                        )
                    elseif Config.Visuals.TracersOrigin == "Mouse" then
                        Tracer.To = game:GetService("UserInputService"):GetMouseLocation()
                        Tracer.From =
                            Vector2.new(
                            Services.Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position).X - 1,
                            (RootPosition.Y + (HeadPosition.Y - LegPosition.Y) / 2) -
                                ((HeadPosition.Y - LegPosition.Y) / 2)
                        )
                    end
                else
                    Tracer.Visible = false
                end
                if Config.Visuals.NameEsp then
                    Name.Visible = OnScreen
                    Name.Position =
                        Vector2.new(
                        Services.Camera:WorldToViewportPoint(player.Character.Head.Position).X,
                        Services.Camera:WorldToViewportPoint(player.Character.Head.Position).Y - 40
                    )
                    Name.Text = "[ " .. player.Name .. " ]"
                else
                    Name.Visible = false
                end
                if Config.Visuals.DistanceEsp and player.Character:FindFirstChild("Head") then
                    Distance.Visible = OnScreen
                    Distance.Position =
                        Vector2.new(
                        Services.Camera:WorldToViewportPoint(player.Character.Head.Position).X,
                        Services.Camera:WorldToViewportPoint(player.Character.Head.Position).Y - 25
                    )
                    Distance.Text =
                        "[ " ..
                        Funcs:Round(
                            (game:GetService("Players").LocalPlayer.Character.Head.Position -
                                player.Character.Head.Position).Magnitude
                        ) ..
                            " Studs ]"
                else
                    Distance.Visible = false
                end
                if Config.Visuals.SkeletonEsp then
                    HeadLowerTorso.Visible = OnScreen
                    HeadLowerTorso.From =
                        Vector2.new(
                        Services.Camera:WorldToViewportPoint(player.Character.Head.Position).X,
                        Services.Camera:WorldToViewportPoint(player.Character.Head.Position).Y
                    )
                    HeadLowerTorso.To =
                        Vector2.new(
                        Services.Camera:WorldToViewportPoint(player.Character.LowerTorso.Position).X,
                        Services.Camera:WorldToViewportPoint(player.Character.LowerTorso.Position).Y
                    )
                    NeckLeftUpper.Visible = OnScreen
                    NeckLeftUpper.From =
                        Vector2.new(
                        Services.Camera:WorldToViewportPoint(player.Character.Head.Position).X,
                        Services.Camera:WorldToViewportPoint(player.Character.Head.Position).Y +
                            ((Services.Camera:WorldToViewportPoint(player.Character.UpperTorso.Position).Y -
                                Services.Camera:WorldToViewportPoint(player.Character.Head.Position).Y) /
                                3)
                    )
                    NeckLeftUpper.To =
                        Vector2.new(
                        Services.Camera:WorldToViewportPoint(player.Character.LeftUpperArm.Position).X,
                        Services.Camera:WorldToViewportPoint(player.Character.LeftUpperArm.Position).Y
                    )
                    LeftUpperLeftLower.Visible = OnScreen
                    LeftUpperLeftLower.From =
                        Vector2.new(
                        Services.Camera:WorldToViewportPoint(player.Character.LeftLowerArm.Position).X,
                        Services.Camera:WorldToViewportPoint(player.Character.LeftLowerArm.Position).Y
                    )
                    LeftUpperLeftLower.To =
                        Vector2.new(
                        Services.Camera:WorldToViewportPoint(player.Character.LeftUpperArm.Position).X,
                        Services.Camera:WorldToViewportPoint(player.Character.LeftUpperArm.Position).Y
                    )
                    NeckRightUpper.Visible = OnScreen
                    NeckRightUpper.From =
                        Vector2.new(
                        Services.Camera:WorldToViewportPoint(player.Character.Head.Position).X,
                        Services.Camera:WorldToViewportPoint(player.Character.Head.Position).Y +
                            ((Services.Camera:WorldToViewportPoint(player.Character.UpperTorso.Position).Y -
                                Services.Camera:WorldToViewportPoint(player.Character.Head.Position).Y) /
                                3)
                    )
                    NeckRightUpper.To =
                        Vector2.new(
                        Services.Camera:WorldToViewportPoint(player.Character.RightUpperArm.Position).X,
                        Services.Camera:WorldToViewportPoint(player.Character.RightUpperArm.Position).Y
                    )
                    RightUpperLeftLower.Visible = OnScreen
                    RightUpperLeftLower.From =
                        Vector2.new(
                        Services.Camera:WorldToViewportPoint(player.Character.RightLowerArm.Position).X,
                        Services.Camera:WorldToViewportPoint(player.Character.RightLowerArm.Position).Y
                    )
                    RightUpperLeftLower.To =
                        Vector2.new(
                        Services.Camera:WorldToViewportPoint(player.Character.RightUpperArm.Position).X,
                        Services.Camera:WorldToViewportPoint(player.Character.RightUpperArm.Position).Y
                    )
                    LowerTorsoLeftUpper.Visible = OnScreen
                    LowerTorsoLeftUpper.From =
                        Vector2.new(
                        Services.Camera:WorldToViewportPoint(player.Character.LowerTorso.Position).X,
                        Services.Camera:WorldToViewportPoint(player.Character.LowerTorso.Position).Y
                    )
                    LowerTorsoLeftUpper.To =
                        Vector2.new(
                        Services.Camera:WorldToViewportPoint(player.Character.LeftUpperLeg.Position).X,
                        Services.Camera:WorldToViewportPoint(player.Character.LeftUpperLeg.Position).Y
                    )
                    LeftLowerLeftUpper.Visible = OnScreen
                    LeftLowerLeftUpper.From =
                        Vector2.new(
                        Services.Camera:WorldToViewportPoint(player.Character.LeftLowerLeg.Position).X,
                        Services.Camera:WorldToViewportPoint(player.Character.LeftLowerLeg.Position).Y
                    )
                    LeftLowerLeftUpper.To =
                        Vector2.new(
                        Services.Camera:WorldToViewportPoint(player.Character.LeftUpperLeg.Position).X,
                        Services.Camera:WorldToViewportPoint(player.Character.LeftUpperLeg.Position).Y
                    )
                    LowerTorsoRightUpper.Visible = OnScreen
                    LowerTorsoRightUpper.From =
                        Vector2.new(
                        Services.Camera:WorldToViewportPoint(player.Character.RightLowerLeg.Position).X,
                        Services.Camera:WorldToViewportPoint(player.Character.RightLowerLeg.Position).Y
                    )
                    LowerTorsoRightUpper.To =
                        Vector2.new(
                        Services.Camera:WorldToViewportPoint(player.Character.RightUpperLeg.Position).X,
                        Services.Camera:WorldToViewportPoint(player.Character.RightUpperLeg.Position).Y
                    )
                    RightLowerRightUpper.Visible = OnScreen
                    RightLowerRightUpper.From =
                        Vector2.new(
                        Services.Camera:WorldToViewportPoint(player.Character.LowerTorso.Position).X,
                        Services.Camera:WorldToViewportPoint(player.Character.LowerTorso.Position).Y
                    )
                    RightLowerRightUpper.To =
                        Vector2.new(
                        Services.Camera:WorldToViewportPoint(player.Character.RightUpperLeg.Position).X,
                        Services.Camera:WorldToViewportPoint(player.Character.RightUpperLeg.Position).Y
                    )
                else
                    HeadLowerTorso.Visible = false
                    NeckLeftUpper.Visible = false
                    LeftUpperLeftLower.Visible = false
                    NeckRightUpper.Visible = false
                    RightUpperLeftLower.Visible = false
                    LowerTorsoLeftUpper.Visible = false
                    LeftLowerLeftUpper.Visible = false
                    LowerTorsoRightUpper.Visible = false
                    RightLowerRightUpper.Visible = false
                end
                if game.Players.LocalPlayer.TeamColor ~= player.TeamColor then
                    Box.Color = Config.Visuals.EnemyColor
                    Tracer.Color = Config.Visuals.EnemyColor
                    Name.Color = Config.Visuals.EnemyColor
                    Distance.Color = Config.Visuals.EnemyColor
                    HeadLowerTorso.Color = Config.Visuals.EnemyColor
                    NeckLeftUpper.Color = Config.Visuals.EnemyColor
                    LeftUpperLeftLower.Color = Config.Visuals.EnemyColor
                    NeckRightUpper.Color = Config.Visuals.EnemyColor
                    RightUpperLeftLower.Color = Config.Visuals.EnemyColor
                    LowerTorsoLeftUpper.Color = Config.Visuals.EnemyColor
                    LeftLowerLeftUpper.Color = Config.Visuals.EnemyColor
                    LowerTorsoRightUpper.Color = Config.Visuals.EnemyColor
                    RightLowerRightUpper.Color = Config.Visuals.EnemyColor
                else
                    Box.Color = Config.Visuals.TeamColor
                    Tracer.Color = Config.Visuals.TeamColor
                    Name.Color = Config.Visuals.TeamColor
                    Distance.Color = Config.Visuals.TeamColor
                    HeadLowerTorso.Color = Config.Visuals.TeamColor
                    NeckLeftUpper.Color = Config.Visuals.TeamColor
                    LeftUpperLeftLower.Color = Config.Visuals.TeamColor
                    NeckRightUpper.Color = Config.Visuals.TeamColor
                    RightUpperLeftLower.Color = Config.Visuals.TeamColor
                    LowerTorsoLeftUpper.Color = Config.Visuals.TeamColor
                    LeftLowerLeftUpper.Color = Config.Visuals.TeamColor
                    LowerTorsoRightUpper.Color = Config.Visuals.TeamColor
                    RightLowerRightUpper.Color = Config.Visuals.TeamColor
                end
            else
                Box.Visible = false
                Tracer.Visible = false
                Name.Visible = false
                Distance.Visible = false
                HeadLowerTorso.Visible = false
                NeckLeftUpper.Visible = false
                LeftUpperLeftLower.Visible = false
                NeckRightUpper.Visible = false
                RightUpperLeftLower.Visible = false
                LowerTorsoLeftUpper.Visible = false
                LeftLowerLeftUpper.Visible = false
                LowerTorsoRightUpper.Visible = false
                RightLowerRightUpper.Visible = false
            end
        end
    )
end

for i, v in pairs(Services.Players:GetPlayers()) do
    if v ~= Services.LocalPlayer then
        Funcs:AddEsp(v)
    end
end

Services.Players.PlayerAdded:Connect(
    function(player)
        if v ~= Services.LocalPlayer then
            Funcs:AddEsp(player)
        end
    end
)

VisualsW:Button('Rainbow Gun',function()
local c = 1 function zigzag(X)  return math.acos(math.cos(X * math.pi)) / math.pi end game:GetService("RunService").RenderStepped:Connect(function()  if game.Workspace.Camera:FindFirstChild('Arms') then   for i,v in pairs(game.Workspace.Camera.Arms:GetDescendants()) do    if v.ClassName == 'MeshPart' then      v.Color = Color3.fromHSV(zigzag(c),1,1)     c = c + .0001    end   end  end end)
end)
VisualsW:Button('Banana ESP',function()
    while true do
    wait(4)
for i,v in pairs(game.Workspace:GetDescendants()) do -- grabs everything from workspace
    if v.ClassName == 'TouchTransmitter' and v.Parent.Name == 'Banana' then -- checks if it has a handle and if its a touchtransmitter
        local BillboardGui = Instance.new('BillboardGui') -- Makes Billboardgui
        local TextLabel = Instance.new('TextLabel') -- makes text label
        
        BillboardGui.Parent = v.Parent -- what the billboardgui goes into
        BillboardGui.AlwaysOnTop = true -- if its on top or not
        BillboardGui.Size = UDim2.new(0, 50, 0, 50) -- size of it
        BillboardGui.StudsOffset = Vector3.new(0,2,0)
        
        TextLabel.Parent = BillboardGui -- putting textlabel into billboardgui
        TextLabel.BackgroundColor3 = Color3.new(1,1,1) -- color
        TextLabel.BackgroundTransparency = 1 -- transparency
        TextLabel.Size = UDim2.new(1, 0, 1, 0) -- size
        TextLabel.Text = "🍌" -- what the label says
        TextLabel.TextColor3 = Color3.new(1, 0, 0) -- color
        TextLabel.TextScaled = false -- if the text is scaled or not
    end
end
end
end)
VisualsW:Button('Ammo Box ESP',function()
while true do
    wait(4)
for i,v in pairs(game.Workspace:GetDescendants()) do -- grabs everything from workspace
    if v.ClassName == 'TouchTransmitter' and v.Parent.Name == 'DeadAmmo' then -- checks if it has a handle and if its a touchtransmitter
        local BillboardGui = Instance.new('BillboardGui') -- Makes Billboardgui
        local TextLabel = Instance.new('TextLabel') -- makes text label
        
        BillboardGui.Parent = v.Parent -- what the billboardgui goes into
        BillboardGui.AlwaysOnTop = true -- if its on top or not
        BillboardGui.Size = UDim2.new(0, 50, 0, 50) -- size of it
        BillboardGui.StudsOffset = Vector3.new(0,2,0)
        
        TextLabel.Parent = BillboardGui -- putting textlabel into billboardgui
        TextLabel.BackgroundColor3 = Color3.new(1,1,1) -- color
        TextLabel.BackgroundTransparency = 1 -- transparency
        TextLabel.Size = UDim2.new(1, 0, 1, 0) -- size
        TextLabel.Text = "Ammo Box" -- what the label says
        TextLabel.TextColor3 = Color3.new(1, 0, 0) -- color
        TextLabel.TextScaled = false -- if the text is scaled or not
    end
end
end
end)
VisualsW:Button('HP Jug ESP',function()
    while true do
    wait(4)
for i,v in pairs(game.Workspace:GetDescendants()) do -- grabs everything from workspace
    if v.ClassName == 'TouchTransmitter' and v.Parent.Name == 'DeadHP' then -- checks if it has a handle and if its a touchtransmitter
        local BillboardGui = Instance.new('BillboardGui') -- Makes Billboardgui
        local TextLabel = Instance.new('TextLabel') -- makes text label
        
        BillboardGui.Parent = v.Parent -- what the billboardgui goes into
        BillboardGui.AlwaysOnTop = true -- if its on top or not
        BillboardGui.Size = UDim2.new(0, 50, 0, 50) -- size of it
        BillboardGui.StudsOffset = Vector3.new(0,2,0)
        
        TextLabel.Parent = BillboardGui -- putting textlabel into billboardgui
        TextLabel.BackgroundColor3 = Color3.new(1,1,1) -- color
        TextLabel.BackgroundTransparency = 1 -- transparency
        TextLabel.Size = UDim2.new(1, 0, 1, 0) -- size
        TextLabel.Text = "HP Jar" -- what the label says
        TextLabel.TextColor3 = Color3.new(1, 0, 0) -- color
        TextLabel.TextScaled = false -- if the text is scaled or not
    end
end
end
end)

VisualsW:Toggle('Box ESP',function(state)
    Config.Visuals.BoxEsp = state
end)

VisualsW:Toggle('Line ESP',function(state)
    Config.Visuals.TracerEsp = state
end)
VisualsW:Dropdown(
  "Lines Origin", {'Top','Middle','Bottom','Mouse'}, function(selected)
    Config.Visuals.TracersOrigin = selected
end)
VisualsW:Toggle('Name ESP',function(state)
    Config.Visuals.NameEsp = state
end)
VisualsW:Toggle('Distance ESP',function(state)
    Config.Visuals.DistanceEsp = state
end)
VisualsW:Toggle('Skeletons ESP',function(state)
    Config.Visuals.SkeletonEsp = state
end)
VisualsW:Colorpicker(
	"Team Color",
	Color3.fromRGB(0, 255, 0),
	function(Color)
		Config.Visuals.TeamColor = Color
	end
)
VisualsW:Colorpicker(
	"Enemy Color",
	Color3.fromRGB(255, 0, 0),
	function(Color)
		Config.Visuals.EnemyColor = Color
	end
)

MiscW:Button('Click To Copy Discord Invite',function()
setclipboard("discord.gg/CQz5CQKv89")
end)
MiscW:Label('Bolts Hub v5 - Arsenal')
MiscW:Label('RightShift To Toggle The Gui :D')
MiscW:Label('discord.gg/CQz5CQKv89')
MiscW:Label('Bolts#9999 - Owner')
MiscW:Label('Bolts#9999 Bug Fixing')
MiscW:Label('Dark Hub Devs For UI Lib')
MiscW:Button('Press for cum',function()

    local messagebox = messagebox or function(a,b) return ask_prompt(b,a,"Im A Gay Nigger") end return messagebox("Nigger Porn", "Nigger smh", 0)
    end)
