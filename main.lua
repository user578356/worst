local game = game
local GetService = game.GetService
if (not game.IsLoaded(game)) then
    local Loaded = game.Loaded
    Loaded.Wait(Loaded);
end

local Players = Services.Players

--IMPORT [var]
local Services = {
    Workspace = GetService(game, "Workspace");
    UserInputService = GetService(game, "UserInputService");
    ReplicatedStorage = GetService(game, "ReplicatedStorage");
    StarterPlayer = GetService(game, "StarterPlayer");
    StarterPack = GetService(game, "StarterPack");
    StarterGui = GetService(game, "StarterGui");
    TeleportService = GetService(game, "TeleportService");
    CoreGui = GetService(game, "CoreGui");
    TweenService = GetService(game, "TweenService");
    HttpService = GetService(game, "HttpService");
    TextService = GetService(game, "TextService");
    MarketplaceService = GetService(game, "MarketplaceService");
    Chat = GetService(game, "Chat");
    Teams = GetService(game, "Teams");
    SoundService = GetService(game, "SoundService");
    Lighting = GetService(game, "Lighting");
    ScriptContext = GetService(game, "ScriptContext");
    Stats = GetService(game, "Stats");
}

local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)

Players.LocalPlayer.OnTeleport:Connect(function(State)
	if State == Enum.TeleportState.Started then
		if queueteleport then
			queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/user578356/worst/main/main.lua'))();")
		end
	end
end)

local _L = {}

_L.start = start or tick();
local Debug = true

do
    local F_A = getgenv().F_A
    if (F_A) then
        local Notify, GetConfig = F_A.Utils.Notify, F_A.GetConfig
        local UserInputService = GetService(game, "UserInputService");
        local CommandBarPrefix = GetConfig().CommandBarPrefix
        local StringKeyCode = UserInputService.GetStringForKeyCode(UserInputService, Enum.KeyCode[CommandBarPrefix]);
    end
end


setmetatable(Services, {
    __index = function(Table, Property)
        local Ret, Service = pcall(GetService, game, Property);
        if (Ret) then
            Services[Property] = Service
            return Service
        end
        return nil
    end,
    __mode = "v"
});

local GetChildren, GetDescendants = game.GetChildren, game.GetDescendants
local IsA = game.IsA
local FindFirstChild, FindFirstChildOfClass, FindFirstChildWhichIsA, WaitForChild = 
    game.FindFirstChild,
    game.FindFirstChildOfClass,
    game.FindFirstChildWhichIsA,
    game.WaitForChild

local GetPropertyChangedSignal, Changed = 
    game.GetPropertyChangedSignal,
    game.Changed
    
local Destroy, Clone = game.Destroy, game.Clone

local Heartbeat, Stepped, RenderStepped;
do
    local RunService = Services.RunService;
    Heartbeat, Stepped, RenderStepped =
        RunService.Heartbeat,
        RunService.Stepped,
        RunService.RenderStepped
end

local GetPlayers = Players.GetPlayers

local JSONEncode, JSONDecode, GenerateGUID = 
    Services.HttpService.JSONEncode, 
    Services.HttpService.JSONDecode,
    Services.HttpService.GenerateGUID

local Camera = Services.Workspace.CurrentCamera

local Tfind, sort, concat, pack, unpack;
do
    local table = table
    Tfind, sort, concat, pack, unpack = 
        table.find, 
        table.sort,
        table.concat,
        table.pack,
        table.unpack
end

local lower, upper, Sfind, split, sub, format, len, match, gmatch, gsub, byte;
do
    local string = string
    lower, upper, Sfind, split, sub, format, len, match, gmatch, gsub, byte = 
        string.lower,
        string.upper,
        string.find,
        string.split, 
        string.sub,
        string.format,
        string.len,
        string.match,
        string.gmatch,
        string.gsub,
        string.byte
end

local random, floor, round, abs, atan, cos, sin, rad;
do
    local math = math
    random, floor, round, abs, atan, cos, sin, rad = 
        math.random,
        math.floor,
        math.round,
        math.abs,
        math.atan,
        math.cos,
        math.sin,
        math.rad
end

local InstanceNew = Instance.new
local CFrameNew = CFrame.new
local Vector3New = Vector3.new

local Inverse, toObjectSpace, components
do
    local CalledCFrameNew = CFrameNew();
    Inverse = CalledCFrameNew.Inverse
    toObjectSpace = CalledCFrameNew.toObjectSpace
    components = CalledCFrameNew.components
end

local Connection = game.Loaded
local CWait = Connection.Wait
local CConnect = Connection.Connect

local Disconnect;
do
    local CalledConnection = CConnect(Connection, function() end);
    Disconnect = CalledConnection.Disconnect
end

local __H = InstanceNew("Humanoid");
local UnequipTools = __H.UnequipTools
local ChangeState = __H.ChangeState
local SetStateEnabled = __H.SetStateEnabled
local GetState = __H.GetState
local GetAccessories = __H.GetAccessories

local LocalPlayer = Players.LocalPlayer
local PlayerGui = FindFirstChildWhichIsA(LocalPlayer, "PlayerGui");
local Mouse = LocalPlayer.GetMouse(LocalPlayer);

local CThread;
do
    local wrap = coroutine.wrap
    CThread = function(Func, ...)
        if (type(Func) ~= 'function') then
            return nil
        end
        local Varag = ...
        return function()
            local Success, Ret = pcall(wrap(Func, Varag));
            if (Success) then
                return Ret
            end
            if (Debug) then
                warn("[FA Error]: " .. debug.traceback(Ret));
            end
        end
    end
end

local startsWith = function(str, searchString, rawPos)
    local pos = rawPos or 1
    return searchString == "" and true or sub(str, pos, pos) == searchString
end

local trim = function(str)
    return gsub(str, "^%s*(.-)%s*$", "%1");
end

local tbl_concat = function(...)
    local new = {}
    for i, v in next, {...} do
        for i2, v2 in next, v do
            new[i] = v2
        end
    end
    return new
end

local indexOf = function(tbl, val)
    if (type(tbl) == 'table') then
        for i, v in next, tbl do
            if (v == val) then
                return i
            end
        end
    end
end

local forEach = function(tbl, ret)
    for i, v in next, tbl do
        ret(i, v);
    end
end

local filter = function(tbl, ret)
    if (type(tbl) == 'table') then
        local new = {}
        for i, v in next, tbl do
            if (ret(i, v)) then
                new[#new + 1] = v
            end
        end
        return new
    end
end

local map = function(tbl, ret)
    if (type(tbl) == 'table') then
        local new = {}
        for i, v in next, tbl do
            local Value, Key = ret(i, v);
            new[Key or #new + 1] = Value
        end
        return new
    end
end

local deepsearch;
deepsearch = function(tbl, ret)
    if (type(tbl) == 'table') then
        for i, v in next, tbl do
            if (type(v) == 'table') then
                deepsearch(v, ret);
            end
            ret(i, v);
        end
    end
end

local deepsearchset;
deepsearchset = function(tbl, ret, value)
    if (type(tbl) == 'table') then
        local new = {}
        for i, v in next, tbl do
            new[i] = v
            if (type(v) == 'table') then
                new[i] = deepsearchset(v, ret, value);
            end
            if (ret(i, v)) then
                new[i] = value(i, v);
            end
        end
        return new
    end
end

local flat = function(tbl)
    if (type(tbl) == 'table') then
        local new = {}
        deepsearch(tbl, function(i, v)
            if (type(v) ~= 'table') then
                new[#new + 1] = v
            end
        end)
        return new
    end
end

local flatMap = function(tbl, ret)
    if (type(tbl) == 'table') then
        local new = flat(map(tbl, ret));
        return new
    end
end

local shift = function(tbl)
    if (type(tbl) == 'table') then
        local firstVal = tbl[1]
        tbl = pack(unpack(tbl, 2, #tbl));
        tbl.n = nil
        return tbl
    end
end

local keys = function(tbl)
    if (type(tbl) == 'table') then
        local new = {}
        for i, v in next, tbl do
            new[#new + 1] = i	
        end
        return new
    end
end

local function clone(toClone, shallow)
    if (type(toClone) == 'function' and clonefunction) then
        return clonefunction(toClone);
    end
    local new = {}
    for i, v in pairs(toClone) do
        if (type(v) == 'table' and not shallow) then
            v = clone(v);
        end
        new[i] = v
    end
    return new
end

local setthreadidentity = setthreadidentity or syn_context_set or setthreadcontext or (syn and syn.set_thread_identity)
local getthreadidentity = getthreadidentity or syn_context_get or getthreadcontext or (syn and syn.get_thread_identity)
--END IMPORT [var]



local GetCharacter = GetCharacter or function(Plr)
    return Plr and Plr.Character or LocalPlayer.Character
end

local Utils = {}

--IMPORT [extend]
local Stats = Services.Stats
local ContentProvider = Services.ContentProvider

local firetouchinterest, hookfunction;
do
    local GEnv = getgenv();
    local touched = {}
    firetouchinterest = GEnv.firetouchinterest or function(part1, part2, toggle)
        if (part1 and part2) then
            if (toggle == 0) then
                touched[1] = part1.CFrame
                part1.CFrame = part2.CFrame
            else
                part1.CFrame = touched[1]
                touched[1] = nil
            end
        end
    end
    local newcclosure = newcclosure or function(f)
        return f
    end

    hookfunction = GEnv.hookfunction or function(func, newfunc, applycclosure)
        if (replaceclosure) then
            replaceclosure(func, newfunc);
            return func
        end
        func = applycclosure and newcclosure or newfunc
        return func
    end
end

if (not syn_context_set) then
    local CachedConnections = setmetatable({}, {
        __mode = "v"
    });

    GEnv = getgenv();
    getconnections = function(Connection, FromCache, AddOnConnect)
        local getconnections = GEnv.getconnections
        if (not getconnections) then
            return {}
        end

        local CachedConnection;
        for i, v in next, CachedConnections do
            if (i == Connection) then
                CachedConnection = v
                break;
            end
        end
        if (CachedConnection and FromCache) then
            return CachedConnection
        end

        local Connections = GEnv.getconnections(Connection);
        CachedConnections[Connection] = Connections
        return Connections
    end
end

local getrawmetatable = getrawmetatable or function()
    return setmetatable({}, {});
end

local getnamecallmethod = getnamecallmethod or function()
    return ""
end

local checkcaller = checkcaller or function()
    return false
end

local Hooks = {
    AntiKick = false,
    AntiTeleport = false,
    NoJumpCooldown = false,
}

local mt = getrawmetatable(game);
local OldMetaMethods = {}
setreadonly(mt, false);
for i, v in next, mt do
    OldMetaMethods[i] = v
end
setreadonly(mt, true);
local MetaMethodHooks = {}

local ProtectInstance, SpoofInstance, SpoofProperty;
local pInstanceCount = {0, 0}; -- instancecount, primitivescount
local ProtectedInstances = setmetatable({}, {
    __mode = "v"
});
local FocusedTextBox = nil
do
    local SpoofedInstances = setmetatable({}, {
        __mode = "v"
    });
    local SpoofedProperties = {}
    Hooks.SpoofedProperties = SpoofedProperties

    local otherCheck = function(instance, n)
        if (IsA(instance, "ImageLabel") or IsA(instance, "ImageButton")) then
            ProtectedInstances[#ProtectedInstances + 1] = instance
            return;
        end

        if (IsA(instance, "BasePart")) then
            pInstanceCount[2] = math.max(pInstanceCount[2] + (n or 1), 0);
        end
    end

    ProtectInstance = function(Instance_)
        if (not Tfind(ProtectedInstances, Instance_)) then
            ProtectedInstances[#ProtectedInstances + 1] = Instance_
            local descendants = Instance_:GetDescendants();
            pInstanceCount[1] += 1 + #descendants;
            for i = 1, #descendants do
                otherCheck(descendants[i]);
            end
            local dAdded = Instance_.DescendantAdded:Connect(function(descendant)
                pInstanceCount[1] += 1
                otherCheck(descendant);
            end);
            local dRemoving = Instance_.DescendantRemoving:Connect(function(descendant)
                pInstanceCount[1] = math.max(pInstanceCount[1] - 1, 0);
                otherCheck(descendant, -1);
            end);
            otherCheck(Instance_);

            Instance_.Name = sub(gsub(GenerateGUID(Services.HttpService, false), '-', ''), 1, random(25, 30));
            Instance_.Archivable = false
        end
    end

    SpoofInstance = function(Instance_, Instance2)
        if (not SpoofedInstances[Instance_]) then
            SpoofedInstances[Instance_] = Instance2 and Instance2 or Clone(Instance_);
        end
    end

    UnSpoofInstance = function(Instance_)
        if (SpoofedInstances[Instance_]) then
            SpoofedInstances[Instance_] = nil
        end
    end
    
    local ChangedSpoofedProperties = {}
    SpoofProperty = function(Instance_, Property, NoClone)
        if (SpoofedProperties[Instance_]) then
            local SpoofedPropertiesForInstance = SpoofedProperties[Instance_]
            local Properties = map(SpoofedPropertiesForInstance, function(i, v)
                return v.Property
            end)
            if (not Tfind(Properties, Property)) then
                SpoofedProperties[Instance_][#SpoofedPropertiesForInstance + 1] = {
                    SpoofedProperty = SpoofedPropertiesForInstance[1].SpoofedProperty,
                    Property = Property,
                };
            end
        else
            local Cloned;
            if (not NoClone and IsA(Instance_, "Instance") and not Services[tostring(Instance_)] and Instance_.Archivable) then
                local Success, Ret = pcall(Clone, Instance_);
                if (Success) then
                    Cloned = Ret
                end
            end
            SpoofedProperties[Instance_] = {{
                SpoofedProperty = Cloned and Cloned or {[Property]=Instance_[Property]},
                Property = Property,
            }}
            ChangedSpoofedProperties[Instance_] = {}
        end
    end

    local GetAllParents = function(Instance_, NIV)
        if (typeof(Instance_) == "Instance") then
            local Parents = {}
            local Current = NIV or Instance_
            if (NIV) then
                Parents[#Parents + 1] = Current
            end
            repeat
                local Parent = Current.Parent
                Parents[#Parents + 1] = Parent
                Current = Parent
            until not Current
            return Parents
        end
        return {}
    end

    local Methods = {
        "FindFirstChild",
        "FindFirstChildWhichIsA",
        "FindFirstChildOfClass",
        "IsA"
    }

    local lockedInstances = {};
    setmetatable(lockedInstances, { __mode = "k" });
    local isProtected = function(instance)
        if (lockedInstances[instance]) then
            return true;
        end

        local good2 = pcall(tostring, instance);
        if (not good2) then
            lockedInstances[instance] = true
            return true;
        end

        for i2 = 1, #ProtectedInstances do
            local pInstance = ProtectedInstances[i2]
            if (pInstance == instance) then
                return true;
            end
        end
        return false;
    end

    MetaMethodHooks.Namecall = function(...)
        local __Namecall = OldMetaMethods.__namecall;
        local Args = {...}
        local self = Args[1]
        local Method = getnamecallmethod() or "";

        if (Method ~= "") then
            local Success, result = pcall(OldMetaMethods.__index, self, Method);
            if (not Success or Success and type(result) ~= "function") then
                return __Namecall(...);
            end
        end

        if (Hooks.AntiKick and lower(Method) == "kick") then
            local Player, Message = self, Args[2]
            if (Hooks.AntiKick and Player == LocalPlayer) then
                local Notify = Utils.Notify
                local Context;
                if (setthreadidentity) then
                    Context = getthreadidentity();
                    setthreadidentity(3);
                end
                if (Notify and Context) then
                    Notify(nil, "Attempt to kick", format("attempt to kick %s", (Message and type(Message) == 'number' or type(Message) == 'string') and ": " .. Message or ""));
                    setthreadidentity(Context);
                end
                return
            end
        end

        if (Hooks.AntiTeleport and Method == "Teleport" or Method == "TeleportToPlaceInstance") then
            local Player, PlaceId = self, Args[2]
            if (Hooks.AntiTeleport and Player == LocalPlayer) then
                local Notify = Utils.Notify
                local Context;
                if (setthreadidentity) then
                    Context = getthreadidentity();
                    setthreadidentity(3);
                end
                if (Notify and Context) then
                    Notify(nil, "Attempt to teleport", format("attempt to teleport to place %s", PlaceId and PlaceId or ""));
                    setthreadidentity(Context);
                end
                return
            end
        end

        if (checkcaller()) then
            return __Namecall(...);
        end

        if (Tfind(Methods, Method)) then
            local ReturnedInstance = __Namecall(...);
            if (Tfind(ProtectedInstances, ReturnedInstance)) then
                return Method == "IsA" and false or nil
            end
        end

        -- ik this is horrible but fates admin v3 has a better way of doing hooks
        if (Method == "children" or Method == "GetChildren" or Method ==  "getChildren" or Method == "GetDescendants" or Method == "getDescendants") then
            return filter(__Namecall(...), function(i, instance)
                return not isProtected(instance);
            end);
        end

        if (self == Services.UserInputService and (Method == "GetFocusedTextBox" or Method == "getFocusedTextBox")) then
            local focused = __Namecall(...);
            if (focused) then
                for i = 1, #ProtectedInstances do
                    local ProtectedInstance = ProtectedInstances[i]
                    local iden = getthreadidentity();
                    setthreadidentity(7);
                    local pInstance = Tfind(ProtectedInstances, focused) or focused.IsDescendantOf(focused, ProtectedInstance);
                    setthreadidentity(iden);
                    if (pInstance) then
                        return nil;
                    end
                end
            end
            return focused;
        end

        if (Hooks.NoJumpCooldown and (Method == "GetState" or Method == "GetStateEnabled")) then
            local State = __Namecall(...);
            if (Method == "GetState" and (State == Enum.HumanoidStateType.Jumping or State == "Jumping")) then
                return Enum.HumanoidStateType.RunningNoPhysics
            end
            if (Method == "GetStateEnabled" and (self == Enum.HumanoidStateType.Jumping or self == "Jumping")) then
                return false
            end
        end

        return __Namecall(...);
    end

    local AllowedIndexes = {
        "RootPart",
        "Parent"
    }
    local AllowedNewIndexes = {
        "Jump"
    }
    MetaMethodHooks.Index = function(...)
        local __Index = OldMetaMethods.__index;
        local called = __Index(...);

        if (checkcaller()) then
            return __Index(...);
        end
        local Instance_, Index = ...

        local SanitisedIndex = Index
        if (typeof(Instance_) == 'Instance' and type(Index) == 'string') then
            SanitisedIndex = gsub(sub(Index, 0, 100), "%z.*", "");
        end
        local SpoofedInstance = SpoofedInstances[Instance_]
        local SpoofedPropertiesForInstance = SpoofedProperties[Instance_]

        if (SpoofedInstance) then
            if (Tfind(AllowedIndexes, SanitisedIndex)) then
                return __Index(Instance_, Index);
            end
            return __Index(SpoofedInstance, Index);
        end

        if (SpoofedPropertiesForInstance) then
            for i, SpoofedProperty in next, SpoofedPropertiesForInstance do
                local SanitisedIndex = gsub(SanitisedIndex, "^%l", upper);
                if (SanitisedIndex == SpoofedProperty.Property) then
                    local ClientChangedData = ChangedSpoofedProperties[Instance_][SanitisedIndex]
                    local IndexedSpoofed = __Index(SpoofedProperty.SpoofedProperty, Index);
                    local Indexed = __Index(Instance_, Index);
                    if (ClientChangedData.Caller and ClientChangedData.Value ~= Indexed) then
                        OldMetaMethods.__newindex(SpoofedProperty.SpoofedProperty, Index, Indexed);
                        OldMetaMethods.__newindex(Instance_, Index, ClientChangedData.Value);
                        return Indexed
                    end
                    return IndexedSpoofed
                end
            end
        end

        if (Hooks.NoJumpCooldown and SanitisedIndex == "Jump") then
            if (IsA(Instance_, "Humanoid")) then
                return false
            end
        end

        if (Instance_ == Stats and (SanitisedIndex == "InstanceCount" or SanitisedIndex == "instanceCount")) then
            return called - pInstanceCount[1];
        end

        if (Instance_ == Stats and (SanitisedIndex == "PrimitivesCount" or SanitisedIndex == "primitivesCount")) then
            return called - pInstanceCount[2];
        end

        return called;
    end

    MetaMethodHooks.NewIndex = function(...)
        local __NewIndex = OldMetaMethods.__newindex;
        local __Index = OldMetaMethods.__index;
        local Instance_, Index, Value = ...

        local SpoofedInstance = SpoofedInstances[Instance_]
        local SpoofedPropertiesForInstance = SpoofedProperties[Instance_]

        if (checkcaller()) then
            if (Index == "Parent" and Value) then
                local ProtectedInstance
                for i = 1, #ProtectedInstances do
                    local ProtectedInstance_ = ProtectedInstances[i]
                    if (Instance_ == ProtectedInstance_ or Instance_.IsDescendantOf(Value, ProtectedInstance_)) then
                        ProtectedInstance = true
                    end
                end
                if (ProtectedInstance) then
                    local Parents = GetAllParents(Instance_, Value);
                    local child1 = getconnections(Parents[1].ChildAdded, true);
                    local descendantconnections = {}
                    for i, v in next, child1 do
                        v.Disable(v);
                    end
                    for i = 1, #Parents do
                        local Parent = Parents[i]
                        for i2, v in next, getconnections(Parent.DescendantAdded, true) do
                            v.Disable(v);
                            descendantconnections[#descendantconnections + 1] = v
                        end
                    end
                    local good, Ret = pcall(__NewIndex, ...);
                    for i, v in pairs(descendantconnections) do
                        v:Enable();
                    end
                    for i, v in next, child1 do
                        v.Enable(v);
                    end
                    if (not good) then
                        return __NewIndex(...);
                    end
                    return Ret;
                end
            end
            if (SpoofedInstance or SpoofedPropertiesForInstance) then
                if (SpoofedPropertiesForInstance) then
                    ChangedSpoofedProperties[Instance_][Index] = {
                        Caller = true,
                        BeforeValue = Instance_[Index],
                        Value = Value
                    }
                end
                local Connections = tbl_concat(
                    getconnections(GetPropertyChangedSignal(Instance_, SpoofedPropertiesForInstance and SpoofedPropertiesForInstance.Property or Index), true),
                    getconnections(Instance_.Changed, true),
                    getconnections(game.ItemChanged, true)
                )
                
                if (not next(Connections)) then
                    return __NewIndex(Instance_, Index, Value);
                end
                for i, v in next, Connections do
                    v.Disable(v);
                end
                local Ret = __NewIndex(Instance_, Index, Value);
                for i, v in next, Connections do
                    v.Enable(v);
                end
                return Ret
            end
            return __NewIndex(...);
        end

        local SanitisedIndex = Index
        if (typeof(Instance_) == 'Instance' and type(Index) == 'string') then
            local len = select(2, gsub(Index, "%z", ""));
            if (len > 255) then
                return __Index(...);
            end

            SanitisedIndex = gsub(sub(Index, 0, 100), "%z.*", "");
        end

        if (SpoofedInstance) then
            if (Tfind(AllowedNewIndexes, SanitisedIndex)) then
                return __NewIndex(...);
            end
            return __NewIndex(SpoofedInstance, Index, __Index(SpoofedInstance, Index));
        end

        if (SpoofedPropertiesForInstance) then
            for i, SpoofedProperty in next, SpoofedPropertiesForInstance do
                if (SpoofedProperty.Property == SanitisedIndex and not Tfind(AllowedIndexes, SanitisedIndex)) then
                    ChangedSpoofedProperties[Instance_][SanitisedIndex] = {
                        Caller = false,
                        BeforeValue = Instance_[Index],
                        Value = Value
                    }
                    return __NewIndex(SpoofedProperty.SpoofedProperty, Index, Value);
                end
            end
        end

        return __NewIndex(...);
    end

    local hookmetamethod = hookmetamethod or function(metatable, metamethod, func)
        setreadonly(metatable, false);
        Old = hookfunction(metatable[metamethod], func, true);
        setreadonly(metatable, true);
        return Old
    end

    OldMetaMethods.__index = hookmetamethod(game, "__index", MetaMethodHooks.Index);
    OldMetaMethods.__newindex = hookmetamethod(game, "__newindex", MetaMethodHooks.NewIndex);
    OldMetaMethods.__namecall = hookmetamethod(game, "__namecall", MetaMethodHooks.Namecall);

    Hooks.Destroy = hookfunction(game.Destroy, function(...)
        local instance = ...
        local protected = table.find(ProtectedInstances, instance);
        if (checkcaller() and protected) then
            otherCheck(instance, -1);
            local Parents = GetAllParents(instance);
            for i, v in next, getconnections(Parents[1].ChildRemoved, true) do
                v.Disable(v);
            end
            for i = 1, #Parents do
                local Parent = Parents[i]
                for i2, v in next, getconnections(Parent.DescendantRemoving, true) do
                    v.Disable(v);
                end
            end
            local destroy = Hooks.Destroy(...);
            for i = 1, #Parents do
                local Parent = Parents[i]
                for i2, v in next, getconnections(Parent.DescendantRemoving, true) do
                    v.Enable(v);
                end
            end
            for i, v in next, getconnections(Parents[1].ChildRemoved, true) do
                v.Enable(v);
            end
            table.remove(ProtectedInstances, protected);
            return destroy;
        end
        return Hooks.Destroy(...);
    end);
end

Hooks.OldGetChildren = hookfunction(game.GetChildren, newcclosure(function(...)
    if (not checkcaller()) then
        local Children = Hooks.OldGetChildren(...);
        return filter(Children, function(i, v)
            return not Tfind(ProtectedInstances, v);
        end)
    end
    return Hooks.OldGetChildren(...);
end));

Hooks.OldGetDescendants = hookfunction(game.GetDescendants, newcclosure(function(...)
    if (not checkcaller()) then
        local Descendants = Hooks.OldGetDescendants(...);
        return filter(Descendants, function(i, v)
            local Protected = false
            for i2 = 1, #ProtectedInstances do
                local ProtectedInstance = ProtectedInstances[i2]
                Protected = v and ProtectedInstance == v or v.IsDescendantOf(v, ProtectedInstance)
                if (Protected) then
                    break;
                end
            end
            return not Protected
        end)
    end
    return Hooks.OldGetDescendants(...);
end));

Hooks.FindFirstChild = hookfunction(game.FindFirstChild, newcclosure(function(...)
    if (not checkcaller()) then
        local ReturnedInstance = Hooks.FindFirstChild(...);
        if (ReturnedInstance and Tfind(ProtectedInstances, ReturnedInstance)) then
            return nil
        end
    end
    return Hooks.FindFirstChild(...);
end));
Hooks.FindFirstChildOfClass = hookfunction(game.FindFirstChildOfClass, newcclosure(function(...)
    if (not checkcaller()) then
        local ReturnedInstance = Hooks.FindFirstChildOfClass(...);
        if (ReturnedInstance and Tfind(ProtectedInstances, ReturnedInstance)) then
            return nil
        end
    end
    return Hooks.FindFirstChildOfClass(...);
end));
Hooks.FindFirstChildWhichIsA = hookfunction(game.FindFirstChildWhichIsA, newcclosure(function(...)
    if (not checkcaller()) then
        local ReturnedInstance = Hooks.FindFirstChildWhichIsA(...);
        if (ReturnedInstance and Tfind(ProtectedInstances, ReturnedInstance)) then
            return nil
        end
    end
    return Hooks.FindFirstChildWhichIsA(...);
end));
Hooks.IsA = hookfunction(game.IsA, newcclosure(function(...)
    if (not checkcaller()) then
        local Args = {...}
        local IsACheck = Args[1]
        if (IsACheck) then
            local ProtectedInstance = Tfind(ProtectedInstances, IsACheck);
            if (ProtectedInstance and Args[2]) then
                return false
            end
        end
    end
    return Hooks.IsA(...);
end));

Hooks.OldGetFocusedTextBox = hookfunction(Services.UserInputService.GetFocusedTextBox, newcclosure(function(...)
    if (not checkcaller() and ... == Services.UserInputService) then
        local FocusedTextBox = Hooks.OldGetFocusedTextBox(...);
        if(FocusedTextBox) then
            local Protected = false
            for i = 1, #ProtectedInstances do
                local ProtectedInstance = ProtectedInstances[i]
                Protected = Tfind(ProtectedInstances, FocusedTextBox) or FocusedTextBox.IsDescendantOf(FocusedTextBox, ProtectedInstance);
            end
            if (Protected) then
                return nil
            end
        end
        return FocusedTextBox;
    end
    return Hooks.OldGetFocusedTextBox(...);
end));

Hooks.OldKick = hookfunction(LocalPlayer.Kick, newcclosure(function(...)
    local Player, Message = ...
    if (Hooks.AntiKick and Player == LocalPlayer) then
        local Notify = Utils.Notify
        local Context;
        if (setthreadidentity) then
            Context = getthreadidentity();
            setthreadidentity(3);
        end
        if (Notify and Context) then
            Notify(nil, "Attempt to kick", format("attempt to kick %s", (Message and type(Message) == 'number' or type(Message) == 'string') and ": " .. Message or ""));
            setthreadidentity(Context)
        end
        return
    end
    return Hooks.OldKick(...);
end))

Hooks.OldTeleportToPlaceInstance = hookfunction(Services.TeleportService.TeleportToPlaceInstance, newcclosure(function(...)
    local Player, PlaceId = ...
    if (Hooks.AntiTeleport and Player == LocalPlayer) then
        local Notify = Utils.Notify
        local Context;
        if (setthreadidentity) then
            Context = getthreadidentity();
            setthreadidentity(3);
        end
        if (Notify and Context) then
            Notify(nil, "Attempt to teleport", format("attempt to teleport to place %s", PlaceId and PlaceId or ""));
            setthreadidentity(Context)
        end
        return
    end
    return Hooks.OldTeleportToPlaceInstance(...);
end))
Hooks.OldTeleport = hookfunction(Services.TeleportService.Teleport, newcclosure(function(...)
    local Player, PlaceId = ...
    if (Hooks.AntiTeleport and Player == LocalPlayer) then
        local Notify = Utils.Notify
        local Context;
        if (setthreadidentity) then
            Context = getthreadidentity();
            setthreadidentity(3);
        end
        if (Notify and Context) then
            Notify(nil, "Attempt to teleport", format("attempt to teleport to place \"%s\"", PlaceId and PlaceId or ""));
            setthreadidentity(Context);
        end
        return
    end
    return Hooks.OldTeleport(...);
end))

Hooks.GetState = hookfunction(GetState, function(...)
    local Humanoid, State = ..., Hooks.GetState(...);
    local Parent, Character = Humanoid.Parent, LocalPlayer.Character
    if (Hooks.NoJumpCooldown and (State == Enum.HumanoidStateType.Jumping or State == "Jumping") and Parent and Character and Parent == Character) then
        return Enum.HumanoidStateType.RunningNoPhysics
    end
    return State
end)

Hooks.GetStateEnabled = hookfunction(__H.GetStateEnabled, function(...)
    local Humanoid, State = ...
    local Ret = Hooks.GetStateEnabled(...);
    local Parent, Character = Humanoid.Parent, LocalPlayer.Character
    if (Hooks.NoJumpCooldown and (State == Enum.HumanoidStateType.Jumping or State == "Jumping") and Parent and Character and Parent == Character) then
        return false
    end
    return Ret
end)
--END IMPORT [extend]



local GetRoot = function(Plr, Char)
    local LCharacter = GetCharacter();
    local Character = Char or GetCharacter(Plr);
    return Plr and Character and (FindFirstChild(Character, "HumanoidRootPart") or FindFirstChild(Character, "Torso") or FindFirstChild(Character, "UpperTorso")) or LCharacter and (FindFirstChild(LCharacter, "HumanoidRootPart") or FindFirstChild(LCharacter, "Torso") or FindFirstChild(LCharacter, "UpperTorso"));
end

local GetHumanoid = function(Plr, Char)
    local LCharacter = GetCharacter();
    local Character = Char or GetCharacter(Plr);
    return Plr and Character and FindFirstChildWhichIsA(Character, "Humanoid") or LCharacter and FindFirstChildWhichIsA(LCharacter, "Humanoid");
end

local GetMagnitude = function(Plr, Char)
    local LRoot = GetRoot();
    local Root = GetRoot(Plr, Char);
    return Plr and Root and (Root.Position - LRoot.Position).magnitude or math.huge
end

local Settings = {
    Prefix = "!",
    CommandBarPrefix = "Semicolon",
    ChatPrediction = false,
    Macros = {},
    Aliases = {},
}
local PluginSettings = {
    PluginsEnabled = true,
    PluginDebug = false,
    DisabledPlugins = {
        ["PluginName"] = true
    },
    SafePlugins = false
}

local WriteConfig = function(Destroy)
    local JSON = JSONEncode(Services.HttpService, Settings);
    local PluginJSON = JSONEncode(Services.HttpService, PluginSettings);
    if (isfolder("fates-admin") and Destroy) then
        delfolder("fates-admin");
        writefile("fates-admin/config.json", JSON);
        writefile("fates/admin/pluings/plugin-conf.json", PluginJSON);
    else
        makefolder("fates-admin");
        makefolder("fates-admin/plugins");
        makefolder("fates-admin/chatlogs");
        writefile("fates-admin/config.json", JSON);
        writefile("fates-admin/plugins/plugin-conf.json", PluginJSON);
    end
end

local GetConfig = function()
    if (isfolder("fates-admin") and isfile("fates-admin/config.json")) then
        return JSONDecode(Services.HttpService, readfile("fates-admin/config.json"));
    else
        WriteConfig();
        return JSONDecode(Services.HttpService, readfile("fates-admin/config.json"));
    end
end

local GetPluginConfig = function()
    if (isfolder("fates-admin") and isfolder("fates-admin/plugins") and isfile("fates-admin/plugins/plugin-conf.json")) then
        local JSON = JSONDecode(Services.HttpService, readfile("fates-admin/plugins/plugin-conf.json"));
        return JSON
    else
        WriteConfig();
        return JSONDecode(Services.HttpService, readfile("fates-admin/plugins/plugin-conf.json"));
    end
end

local SetPluginConfig = function(conf)
    if (isfolder("fates-admin") and isfolder("fates-admin/plugins") and isfile("fates-admin/plugins/plugin-conf.json")) then
        WriteConfig();
    end
    local NewConfig = GetPluginConfig();
    for i, v in next, conf do
        NewConfig[i] = v
    end
    writefile("fates-admin/plugins/plugin-conf.json", JSONEncode(Services.HttpService, NewConfig));
end

local SetConfig = function(conf)
    if (not isfolder("fates-admin") and isfile("fates-admin/config.json")) then
        WriteConfig();
    end
    local NewConfig = GetConfig();
    for i, v in next, conf do
        NewConfig[i] = v
    end
    writefile("fates-admin/config.json", JSONEncode(Services.HttpService, NewConfig));
end

local CurrentConfig = GetConfig();
local Prefix = isfolder and CurrentConfig.Prefix or "!"
local Macros = CurrentConfig.Macros or {}
local AdminUsers = AdminUsers or {}
local Exceptions = Exceptions or {}
local Connections = {
    Players = {}
}
_L.CLI = false
_L.ChatLogsEnabled = true
_L.GlobalChatLogsEnabled = false
_L.HttpLogsEnabled = true

local GetPlayer;
GetPlayer = function(str, noerror)
    local CurrentPlayers = filter(GetPlayers(Players), function(i, v)
        return not Tfind(Exceptions, v);
    end)
    if (not str) then
        return {}
    end
    str = lower(trim(str));
    if (Sfind(str, ",")) then
        return flatMap(split(str, ","), function(i, v)
            return GetPlayer(v, noerror);
        end)
    end

    local Magnitudes = map(CurrentPlayers, function(i, v)
        return {v,(GetRoot(v).CFrame.p - GetRoot().CFrame.p).Magnitude}
    end)

    local PlayerArgs = {
        ["all"] = function()
            return filter(CurrentPlayers, function(i, v) -- removed all arg (but not really) due to commands getting messed up and people getting confused
                return v ~= LocalPlayer
            end)
        end,
        ["others"] = function()
            return filter(CurrentPlayers, function(i, v)
                return v ~= LocalPlayer
            end)
        end,
        ["nearest"] = function()
            sort(Magnitudes, function(a, b)
                return a[2] < b[2]
            end)
            return {Magnitudes[2][1]}
        end,
        ["farthest"] = function()
            sort(Magnitudes, function(a, b)
                return a[2] > b[2]
            end)
            return {Magnitudes[2][1]}
        end,
        ["random"] = function()
            return {CurrentPlayers[random(2, #CurrentPlayers)]}
        end,
        ["allies"] = function()
            local LTeam = LocalPlayer.Team
            return filter(CurrentPlayers, function(i, v)
                return v.Team == LTeam
            end)
        end,
        ["enemies"] = function()
            local LTeam = LocalPlayer.Team
            return filter(CurrentPlayers, function(i, v)
                return v.Team ~= LTeam
            end)
        end,
        ["npcs"] = function()
            local NPCs = {}
            local Descendants = GetDescendants(Workspace);
            local GetPlayerFromCharacter = Players.GetPlayerFromCharacter
            for i = 1, #Descendants do
                local Descendant = Descendants[i]
                local DParent = Descendant.Parent
                if (IsA(Descendant, "Humanoid") and IsA(DParent, "Model") and (FindFirstChild(DParent, "HumanoidRootPart") or FindFirstChild(DParent, "Head")) and GetPlayerFromCharacter(Players, DParent) == nil) then
                    local FakePlr = InstanceNew("Player"); -- so it can be compatible with commands
                    FakePlr.Character = DParent
                    FakePlr.Name = format("%s %s", DParent.Name, "- " .. Descendant.DisplayName);
                    NPCs[#NPCs + 1] = FakePlr
                end
            end
            return NPCs
        end,
        ["me"] = function()
            return {LocalPlayer}
        end
    }

    if (PlayerArgs[str]) then
        return PlayerArgs[str]();
    end

    local Players = filter(CurrentPlayers, function(i, v)
        return (sub(lower(v.Name), 1, #str) == str) or (sub(lower(v.DisplayName), 1, #str) == str);
    end)
    if (not next(Players) and not noerror) then
        Utils.Notify(LocalPlayer, "Fail", format("Couldn't find player %s", str));
    end
    return Players
end

local AddConnection = function(Connection, CEnv, TblOnly)
    if (CEnv) then
        CEnv[#CEnv + 1] = Connection
        if (TblOnly) then
            return Connection
        end
    end
    Connections[#Connections + 1] = Connection
    return Connection
end

local LastCommand = {}

--IMPORT [ui]
Guis = {}
ParentGui = function(Gui, Parent)
    Gui.Name = sub(gsub(GenerateGUID(Services.HttpService, false), '-', ''), 1, random(25, 30))
    ProtectInstance(Gui);
    if (syn and syn.protect_gui) then syn.protect_gui(Gui); end -- for preload
    Gui.Parent = Parent or Services.CoreGui
    Guis[#Guis + 1] = Gui
    return Gui
end
UI = Clone(Services.InsertService:LoadLocalAsset("rbxassetid://7882275026"));
UI.Enabled = true

local CommandBarPrefix;

local ConfigUI = UI.Config
local ConfigElements = ConfigUI.GuiElements
local CommandBar = UI.CommandBar
local Commands = UI.Commands
local ChatLogs = UI.ChatLogs
local Console = UI.Console
local GlobalChatLogs = Clone(UI.ChatLogs);
local HttpLogs = Clone(UI.ChatLogs);
local Notification = UI.Notification
local Command = UI.Command
local ChatLogMessage = UI.Message
local GlobalChatLogMessage = Clone(UI.Message);
local NotificationBar = UI.NotificationBar

CommandBarOpen = false
CommandBarTransparencyClone = Clone(CommandBar);
ChatLogsTransparencyClone = Clone(ChatLogs);
ConsoleTransparencyClone = Clone(Console);
GlobalChatLogsTransparencyClone = Clone(GlobalChatLogs);
HttpLogsTransparencyClone = Clone(HttpLogs);
CommandsTransparencyClone = nil
ConfigUIClone = Clone(ConfigUI);
PredictionText = ""
do
    local UIParent = CommandBar.Parent
    GlobalChatLogs.Parent = UIParent
    GlobalChatLogMessage.Parent = UIParent
    GlobalChatLogs.Name = "GlobalChatLogs"
    GlobalChatLogMessage.Name = "GlobalChatLogMessage"

    HttpLogs.Parent = UIParent
    HttpLogs.Name = "HttpLogs"
    HttpLogs.Size = UDim2.new(0, 421, 0, 260);
    HttpLogs.Search.PlaceholderText = "Search"
end
-- position CommandBar
CommandBar.Position = UDim2.new(0.5, -100, 1, 5);

local UITheme, Values;
do
    local BaseBGColor = Color3.fromRGB(32, 33, 36);
    local BaseTransparency = 0.25
    local BaseTextColor = Color3.fromRGB(220, 224, 234);
    local BaseValues = { BackgroundColor = BaseBGColor, Transparency = BaseTransparency, TextColor = BaseTextColor }
    Values = { Background = clone(BaseValues), CommandBar = clone(BaseValues), CommandList = clone(BaseValues), Notification = clone(BaseValues), ChatLogs = clone(BaseValues), Config = clone(BaseValues) }
    local Objects = keys(Values);
    local GetBaseMT = function(Object)
        return setmetatable({}, {
            __newindex = function(self, Index, Value)
                local type = typeof(Value);
                if (Index == "BackgroundColor") then
                    if (Value == "Reset") then
                        Value = BaseBGColor
                        type = "Color3"
                    end
                    assert(type == 'Color3', format("invalid argument #3 (Color3 expected, got %s)", type));
                    if (Object == "Background") then
                        CommandBar.BackgroundColor3 = Value
                        Notification.BackgroundColor3 = Value
                        Command.BackgroundColor3 = Value
                        ChatLogs.BackgroundColor3 = Value
                        ChatLogs.Frame.BackgroundColor3 = Value
                        Console.BackgroundColor3 = Value
                        Console.Frame.BackgroundColor3 = Value
                        HttpLogs.BackgroundColor3 = Value
                        HttpLogs.Frame.BackgroundColor3 = Value
                        UI.ToolTip.BackgroundColor3 = Value
                        ConfigUI.BackgroundColor3 = Value
                        ConfigUI.Container.BackgroundColor3 = Value
                        Commands.BackgroundColor3 = Value
                        Commands.Frame.BackgroundColor3 = Value
                        local Children = GetChildren(UI.NotificationBar);
                        for i = 1, #Children do
                            local Child = Children[i]
                            if (IsA(Child, "GuiObject")) then
                                Child.BackgroundColor3 = Value
                            end
                        end
                        local Children = GetChildren(Commands.Frame.List);
                        for i = 1, #Children do
                            local Child = Children[i]
                            if (IsA(Child, "GuiObject")) then
                                Child.BackgroundColor3 = Value
                            end
                        end
                        for i, v in next, Values do
                            Values[i].BackgroundColor = Value
                        end
                    elseif (Object == "CommandBar") then
                        CommandBar.BackgroundColor3 = Value
                    elseif (Object == "Notification") then
                        Notification.BackgroundColor3 = Value
                        local Children = GetChildren(UI.NotificationBar);
                        for i = 1, #Children do
                            local Child = Children[i]
                            if (IsA(Child, "GuiObject")) then
                                Child.BackgroundColor3 = Value
                            end
                        end
                    elseif (Object == "CommandList") then
                        Commands.BackgroundColor3 = Value
                        Commands.Frame.BackgroundColor3 = Value
                    elseif (Object == "Command") then
                        Command.BackgroundColor3 = Value
                    elseif (Object == "ChatLogs") then
                        ChatLogs.BackgroundColor3 = Value
                        ChatLogs.Frame.BackgroundColor3 = Value
                        HttpLogs.BackgroundColor3 = Value
                        HttpLogs.Frame.BackgroundColor3 = Value
                    elseif (Object == "Console") then
                        Console.BackgroundColor3 = Value
                        Console.Frame.BackgroundColor3 = Value
                    elseif (Object == "Config") then
                        ConfigUI.BackgroundColor3 = Value
                        ConfigUI.Container.BackgroundColor3 = Value
                    end
                    Values[Object][Index] = Value
                elseif (Index == "TextColor") then
                    if (Value == "Reset") then
                        Value = BaseTextColor
                        type = "Color3"
                    end
                    assert(type == 'Color3', format("invalid argument #3 (Color3 expected, got %s)", type));
                    if (Object == "Notification") then
                        Notification.Title.TextColor3 = Value
                        Notification.Message.TextColor3 = Value
                        Notification.Close.TextColor3 = Value
                    elseif (Object == "CommandBar") then
                        CommandBar.Input.TextColor3 = Value
                        CommandBar.Arrow.TextColor3 = Value
                    elseif (Object == "CommandList") then
                        Command.CommandText.TextColor3 = Value
                        local Descendants = GetDescendants(Commands);
                        for i = 1, #Descendants do
                            local Descendant = Descendants[i]
                            local IsText = IsA(Descendant, "TextBox") or IsA(Descendant, "TextLabel") or IsA(Descendant, "TextButton");
                            if (IsText) then
                                Descendant.TextColor3 = Value
                            end
                        end
                    elseif (Object == "ChatLogs") then
                        UI.Message.TextColor3 = Value
                    elseif (Object == "Config") then
                        local Descendants = GetDescendants(ConfigUI);
                        for i = 1, #Descendants do
                            local Descendant = Descendants[i]
                            local IsText = IsA(Descendant, "TextBox") or IsA(Descendant, "TextLabel") or IsA(Descendant, "TextButton");
                            if (IsText) then
                                Descendant.TextColor3 = Value
                            end
                        end
                    elseif (Object == "Background") then
                        Notification.Title.TextColor3 = Value
                        Notification.Message.TextColor3 = Value
                        Notification.Close.TextColor3 = Value
                        CommandBar.Input.TextColor3 = Value
                        CommandBar.Arrow.TextColor3 = Value
                        Command.CommandText.TextColor3 = Value
                        UI.Message.TextColor3 = Value
                        local Descendants = GetDescendants(ConfigUI);
                        for i = 1, #Descendants do
                            local Descendant = Descendants[i]
                            local IsText = IsA(Descendant, "TextBox") or IsA(Descendant, "TextLabel") or IsA(Descendant, "TextButton");
                            if (IsText) then
                                Descendant.TextColor3 = Value
                            end
                        end
                        local Descendants = GetDescendants(Commands);
                        for i = 1, #Descendants do
                            local Descendant = Descendants[i]
                            local IsText = IsA(Descendant, "TextBox") or IsA(Descendant, "TextLabel") or IsA(Descendant, "TextButton");
                            if (IsText) then
                                Descendant.TextColor3 = Value
                            end
                        end
                        for i, v in next, Values do
                            Values[i].TextColor = Value
                        end
                    end
                    Values[Object][Index] = Value
                elseif (Index == "Transparency") then
                    if (Value == "Reset") then
                        Value = BaseTransparency
                        type = "number"
                    end
                    assert(type == 'number', format("invalid argument #3 (Color3 expected, got %s)", type));
                    if (Object == "Background") then
                        CommandBar.Transparency = Value
                        Notification.Transparency = Value
                        Command.Transparency = Value + .5
                        ChatLogs.Transparency = Value
                        ChatLogs.Frame.Transparency = Value
                        HttpLogs.Transparency = Value
                        HttpLogs.Frame.Transparency = Value
                        UI.ToolTip.Transparency = Value
                        ConfigUI.Transparency = Value
                        ConfigUI.Container.Transparency = Value + .5
                        Commands.Transparency = Value
                        Commands.Frame.Transparency = Value + .5
                        Values[Object][Index] = Value
                    elseif (Object == "Notification") then
                        Notification.Transparency = Value
                        local Children = GetChildren(UI.NotificationBar);
                        for i = 1, #Children do
                            local Child = Children[i]
                            if (IsA(Child, "GuiObject")) then
                                Child.Transparency = Value
                            end
                        end
                    end
                    Values[Object][Index] = Value
                end
            end,
            __index = function(self, Index)
                return Values[Object][Index]
            end
        })
    end
    UITheme = setmetatable({}, {
        __index = function(self, Index)
            if (Tfind(Objects, Index)) then
                local BaseMt = GetBaseMT(Index);
                self[Index] = BaseMt
                return BaseMt
            end
        end
    })
end

local IsSupportedExploit = isfile and isfolder and writefile and readfile

local GetThemeConfig
local WriteThemeConfig = function(Conf)
    if (IsSupportedExploit and isfolder("fates-admin")) then
        local ToHSV = Color3.new().ToHSV
        local ValuesToEncode = deepsearchset(Values, function(i, v)
            return typeof(v) == 'Color3'
        end, function(i, v)
            local H, S, V = ToHSV(v);
            return {H, S, V, "Color3"}
        end)
        local Data = JSONEncode(Services.HttpService, ValuesToEncode);
        writefile("fates-admin/Theme.json", Data);
    end
end

GetThemeConfig = function()
    if (IsSupportedExploit and isfolder("fates-admin")) then
        if (isfile("fates-admin/Theme.json")) then
            local Success, Data = pcall(JSONDecode, Services.HttpService, readfile("fates-admin/Theme.json"));
            if (not Success or type(Data) ~= 'table') then
                WriteThemeConfig();
                return Values
            end
            local DecodedData = deepsearchset(Data, function(i, v)
                return type(v) == 'table' and #v == 4 and v[4] == "Color3"
            end, function(i,v)
                return Color3.fromHSV(v[1], v[2], v[3]);
            end)
            return DecodedData            
        else
            WriteThemeConfig();
            return Values
        end
    else
        return Values
    end
end

local LoadTheme;
do
    local Config = GetConfig();
    CommandBarPrefix = isfolder and (Config.CommandBarPrefix and Enum.KeyCode[Config.CommandBarPrefix] or Enum.KeyCode.Semicolon) or Enum.KeyCode.Semicolon

    local Theme = GetThemeConfig();
    LoadTheme = function(Theme)
        UITheme.Background.BackgroundColor = Theme.Background.BackgroundColor
        UITheme.Background.Transparency = Theme.Background.Transparency

        UITheme.ChatLogs.BackgroundColor = Theme.ChatLogs.BackgroundColor
        UITheme.CommandBar.BackgroundColor = Theme.CommandBar.BackgroundColor
        UITheme.Config.BackgroundColor = Theme.Config.BackgroundColor
        UITheme.Notification.BackgroundColor = Theme.Notification.BackgroundColor
        UITheme.CommandList.BackgroundColor = Theme.Notification.BackgroundColor
        
        UITheme.ChatLogs.TextColor = Theme.ChatLogs.TextColor
        UITheme.CommandBar.TextColor = Theme.CommandBar.TextColor
        UITheme.Config.TextColor = Theme.Config.TextColor
        UITheme.Notification.TextColor = Theme.Notification.TextColor
        UITheme.CommandList.TextColor = Theme.Notification.TextColor

        UITheme.ChatLogs.Transparency = Theme.ChatLogs.Transparency
        UITheme.CommandBar.Transparency = Theme.CommandBar.Transparency
        UITheme.Config.Transparency = Theme.Config.Transparency
        UITheme.Notification.Transparency = Theme.Notification.Transparency
        UITheme.CommandList.Transparency = Theme.Notification.Transparency
    end
    LoadTheme(Theme);
end
--END IMPORT [ui]



--IMPORT [utils]
Utils.Tween = function(Object, Style, Direction, Time, Goal)
    local TweenService = Services.TweenService
    local TInfo = TweenInfo.new(Time, Enum.EasingStyle[Style], Enum.EasingDirection[Direction])
    local Tween = TweenService.Create(TweenService, Object, TInfo, Goal)

    Tween.Play(Tween)

    return Tween
end

Utils.MultColor3 = function(Color, Delta)
    local clamp = math.clamp
    return Color3.new(clamp(Color.R * Delta, 0, 1), clamp(Color.G * Delta, 0, 1), clamp(Color.B * Delta, 0, 1));
end

Utils.Click = function(Object, Goal) -- Utils.Click(Object, "BackgroundColor3")
    local Hover = {
        [Goal] = Utils.MultColor3(Object[Goal], 0.9)
    }

    local Press = {
        [Goal] = Utils.MultColor3(Object[Goal], 1.2)
    }

    local Origin = {
        [Goal] = Object[Goal]
    }

    AddConnection(CConnect(Object.MouseEnter, function()
        Utils.Tween(Object, "Sine", "Out", .5, Hover);
    end));

    AddConnection(CConnect(Object.MouseLeave, function()
        Utils.Tween(Object, "Sine", "Out", .5, Origin);
    end));

    AddConnection(CConnect(Object.MouseButton1Down, function()
        Utils.Tween(Object, "Sine", "Out", .3, Press);
    end));

    AddConnection(CConnect(Object.MouseButton1Up, function()
        Utils.Tween(Object, "Sine", "Out", .4, Hover);
    end));
end

Utils.Blink = function(Object, Goal, Color1, Color2) -- Utils.Click(Object, "BackgroundColor3", NormalColor, OtherColor)
    local Normal = {
        [Goal] = Color1
    }

    local Blink = {
        [Goal] = Color2
    }

    local Tween = Utils.Tween(Object, "Sine", "Out", .5, Blink)
    CWait(Tween.Completed);

    Tween = Utils.Tween(Object, "Sine", "Out", .5, Normal)
    CWait(Tween.Completed);
end

Utils.Hover = function(Object, Goal)
    local Hover = {
        [Goal] = Utils.MultColor3(Object[Goal], 0.9)
    }

    local Origin = {
        [Goal] = Object[Goal]
    }

    AddConnection(CConnect(Object.MouseEnter, function()
        Utils.Tween(Object, "Sine", "Out", .5, Hover);
    end));

    AddConnection(CConnect(Object.MouseLeave, function()
        Utils.Tween(Object, "Sine", "Out", .5, Origin);
    end));
end

Utils.Draggable = function(Ui, DragUi)
    local DragSpeed = 0
    local StartPos
    local DragToggle, DragInput, DragStart, DragPos

    DragUi = Dragui or Ui
    local TweenService = Services.TweenService

    local function UpdateInput(Input)
        local Delta = Input.Position - DragStart
        local Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)

        Utils.Tween(Ui, "Linear", "Out", .25, {
            Position = Position
        });
        local Tween = TweenService.Create(TweenService, Ui, TweenInfo.new(0.25), {Position = Position});
        Tween.Play(Tween);
    end

    AddConnection(CConnect(Ui.InputBegan, function(Input)
        if ((Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) and Services.UserInputService.GetFocusedTextBox(Services.UserInputService) == nil) then
            DragToggle = true
            DragStart = Input.Position
            StartPos = Ui.Position

            AddConnection(CConnect(Input.Changed, function()
                if (Input.UserInputState == Enum.UserInputState.End) then
                    DragToggle = false
                end
            end));
        end
    end));

    AddConnection(CConnect(Ui.InputChanged, function(Input)
        if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
            DragInput = Input
        end
    end));

    AddConnection(CConnect(Services.UserInputService.InputChanged, function(Input)
        if (Input == DragInput and DragToggle) then
            UpdateInput(Input)
        end
    end));
end

Utils.SmoothScroll = function(content, SmoothingFactor) -- by Elttob
    -- get the 'content' scrolling frame, aka the scrolling frame with all the content inside
    -- if smoothing is enabled, disable scrolling
    content.ScrollingEnabled = false

    -- create the 'input' scrolling frame, aka the scrolling frame which receives user input
    -- if smoothing is enabled, enable scrolling
    local input = Clone(content)

    input.ClearAllChildren(input);
    input.BackgroundTransparency = 1
    input.ScrollBarImageTransparency = 1
    input.ZIndex = content.ZIndex + 1
    input.Name = "_smoothinputframe"
    input.ScrollingEnabled = true
    input.Parent = content.Parent

    -- keep input frame in sync with content frame
    local function syncProperty(prop)
        AddConnection(CConnect(GetPropertyChangedSignal(content, prop), function()
            if prop == "ZIndex" then
                -- keep the input frame on top!
                input[prop] = content[prop] + 1
            else
                input[prop] = content[prop]
            end
        end));
    end

    syncProperty "CanvasSize"
    syncProperty "Position"
    syncProperty "Rotation"
    syncProperty "ScrollingDirection"
    syncProperty "ScrollBarThickness"
    syncProperty "BorderSizePixel"
    syncProperty "ElasticBehavior"
    syncProperty "SizeConstraint"
    syncProperty "ZIndex"
    syncProperty "BorderColor3"
    syncProperty "Size"
    syncProperty "AnchorPoint"
    syncProperty "Visible"

    -- create a render stepped connection to interpolate the content frame position to the input frame position
    local smoothConnection = AddConnection(CConnect(RenderStepped, function()
        local a = content.CanvasPosition
        local b = input.CanvasPosition
        local c = SmoothingFactor
        local d = (b - a) * c + a

        content.CanvasPosition = d
    end));

    AddConnection(CConnect(content.AncestryChanged, function()
        if content.Parent == nil then
            Destroy(input);
            Disconnect(smoothConnection);
        end
    end));
end

Utils.TweenAllTransToObject = function(Object, Time, BeforeObject) -- max transparency is max object transparency, swutched args bc easier command
    local Descendants = GetDescendants(Object);
    local OldDescentants = GetDescendants(BeforeObject);
    local Tween -- to use to wait

    Tween = Utils.Tween(Object, "Sine", "Out", Time, {
        BackgroundTransparency = BeforeObject.BackgroundTransparency
    })

    for i = 1, #Descendants do
        local v = Descendants[i]
        local IsText = IsA(v, "TextBox") or IsA(v, "TextLabel") or IsA(v, "TextButton")
        local IsImage = IsA(v, "ImageLabel") or IsA(v, "ImageButton")
        local IsScrollingFrame = IsA(v, "ScrollingFrame")

        if (IsA(v, "GuiObject")) then
            if (IsText) then
                Utils.Tween(v, "Sine", "Out", Time, {
                    TextTransparency = OldDescentants[i].TextTransparency,
                    TextStrokeTransparency = OldDescentants[i].TextStrokeTransparency,
                    BackgroundTransparency = OldDescentants[i].BackgroundTransparency
                })
            elseif (IsImage) then
                Utils.Tween(v, "Sine", "Out", Time, {
                    ImageTransparency = OldDescentants[i].ImageTransparency,
                    BackgroundTransparency = OldDescentants[i].BackgroundTransparency
                })
            elseif (IsScrollingFrame) then
                Utils.Tween(v, "Sine", "Out", Time, {
                    ScrollBarImageTransparency = OldDescentants[i].ScrollBarImageTransparency,
                    BackgroundTransparency = OldDescentants[i].BackgroundTransparency
                })
            else
                Utils.Tween(v, "Sine", "Out", Time, {
                    BackgroundTransparency = OldDescentants[i].BackgroundTransparency
                })
            end
        end
    end

    return Tween
end

Utils.SetAllTrans = function(Object)
    Object.BackgroundTransparency = 1

    local Descendants = GetDescendants(Object);
    for i = 1, #Descendants do
        local v = Descendants[i]
        local IsText = IsA(v, "TextBox") or IsA(v, "TextLabel") or IsA(v, "TextButton")
        local IsImage = IsA(v, "ImageLabel") or IsA(v, "ImageButton")
        local IsScrollingFrame = IsA(v, "ScrollingFrame")

        if (IsA(v, "GuiObject")) then
            v.BackgroundTransparency = 1

            if (IsText) then
                v.TextTransparency = 1
            elseif (IsImage) then
                v.ImageTransparency = 1
            elseif (IsScrollingFrame) then
                v.ScrollBarImageTransparency = 1
            end
        end
    end
end

Utils.TweenAllTrans = function(Object, Time)
    local Tween -- to use to wait

    Tween = Utils.Tween(Object, "Sine", "Out", Time, {
        BackgroundTransparency = 1
    })

    local Descendants = GetDescendants(Object);
    for i = 1, #Descendants do
        local v = Descendants[i]
        local IsText = IsA(v, "TextBox") or IsA(v, "TextLabel") or IsA(v, "TextButton")
        local IsImage = IsA(v, "ImageLabel") or IsA(v, "ImageButton")
        local IsScrollingFrame = IsA(v, "ScrollingFrame")

        if (IsA(v, "GuiObject")) then
            if (IsText) then
                Utils.Tween(v, "Sine", "Out", Time, {
                    TextTransparency = 1,
                    BackgroundTransparency = 1
                })
            elseif (IsImage) then
                Utils.Tween(v, "Sine", "Out", Time, {
                    ImageTransparency = 1,
                    BackgroundTransparency = 1
                })
            elseif (IsScrollingFrame) then
                Utils.Tween(v, "Sine", "Out", Time, {
                    ScrollBarImageTransparency = 1,
                    BackgroundTransparency = 1
                })
            else
                Utils.Tween(v, "Sine", "Out", Time, {
                    BackgroundTransparency = 1
                })
            end
        end
    end

    return Tween
end

Utils.TextSize = function(Object)
    local TextService = Services.TextService
    return TextService.GetTextSize(TextService, Object.Text, Object.TextSize, Object.Font, Vector2.new(Object.AbsoluteSize.X, 1000)).Y
end

Utils.Notify = function(Caller, Title, Message, Time)
    if (not Caller or Caller == LocalPlayer) then
        local Notification = UI.Notification
        local NotificationBar = UI.NotificationBar

        local Clone = Clone(Notification)

        local function TweenDestroy()
            if (Utils and Clone) then
                local Tween = Utils.TweenAllTrans(Clone, .25)

                CWait(Tween.Completed)
                Destroy(Clone);
            end
        end

        Clone.Message.Text = Message
        Clone.Title.Text = Title or "Notification"
        Utils.SetAllTrans(Clone)
        Utils.Click(Clone.Close, "TextColor3")
        Clone.Visible = true
	    Clone.Size = UDim2.fromOffset(Clone.Size.X.Offset, Utils.TextSize(Clone.Message) + Clone.Size.Y.Offset - Clone.Message.TextSize);
        Clone.Parent = NotificationBar

        coroutine.wrap(function()
            local Tween = Utils.TweenAllTransToObject(Clone, .5, Notification)

            CWait(Tween.Completed);
            wait(Time or 5);

            if (Clone) then
                TweenDestroy();
            end
        end)()

        AddConnection(CConnect(Clone.Close.MouseButton1Click, TweenDestroy));
        if (Title ~= "Warning" and Title ~= "Error") then
            Utils.Print(format("%s - %s", Title, Message), Caller, true);
        end

        return Clone
    else
        local ChatRemote = Services.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest
        ChatRemote.FireServer(ChatRemote, format("/w %s [FA] %s: %s", Caller.Name, Title, Message), "All");
    end
end

Utils.MatchSearch = function(String1, String2)
    return String1 == sub(String2, 1, #String1);
end

Utils.StringFind = function(Table, String)
    for _, v in ipairs(Table) do
        if (Utils.MatchSearch(String, v)) then
            return v
        end
    end
end

Utils.GetPlayerArgs = function(Arg)
    Arg = lower(Arg);
    local SpecialCases = {"all", "others", "random", "me", "nearest", "farthest", "npcs", "allies", "enemies"}
    if (Utils.StringFind(SpecialCases, Arg)) then
        return Utils.StringFind(SpecialCases, Arg);
    end

    local CurrentPlayers = GetPlayers(Players);
    for i, v in next, CurrentPlayers do
        local Name, DisplayName = v.Name, v.DisplayName
        if (Name ~= DisplayName and Utils.MatchSearch(Arg, lower(DisplayName))) then
            return lower(DisplayName);
        end
        if (Utils.MatchSearch(Arg, lower(Name))) then
            return lower(Name);
        end
    end
end

Utils.ToolTip = function(Object, Message)
    local CloneToolTip
    local TextService = Services.TextService

    AddConnection(CConnect(Object.MouseEnter, function()
        if (Object.BackgroundTransparency < 1 and not CloneToolTip) then
            local TextSize = TextService.GetTextSize(TextService, Message, 12, Enum.Font.Gotham, Vector2.new(200, math.huge)).Y > 24

            CloneToolTip = Clone(UI.ToolTip)
            CloneToolTip.Text = Message
            CloneToolTip.TextScaled = TextSize
            CloneToolTip.Visible = true
            CloneToolTip.Parent = UI
        end
    end))

    AddConnection(CConnect(Object.MouseLeave, function()
        if (CloneToolTip) then
            Destroy(CloneToolTip);
            CloneToolTip = nil
        end
    end))

    if (LocalPlayer) then
        AddConnection(CConnect(Mouse.Move, function()
            if (CloneToolTip) then
                CloneToolTip.Position = UDim2.fromOffset(Mouse.X + 10, Mouse.Y + 10)
            end
        end))
    else
        delay(3, function()
            LocalPlayer = Players.LocalPlayer
            AddConnection(CConnect(Mouse.Move, function()
                if (CloneToolTip) then
                    CloneToolTip.Position = UDim2.fromOffset(Mouse.X + 10, Mouse.Y + 10)
                end
            end))
        end)
    end
end

Utils.ClearAllObjects = function(Object)
    local Children = GetChildren(Object);
    for i = 1, #Children do
        local Child = Children[i]
        if (IsA(Child, "GuiObject")) then
            Destroy(Child);
        end
    end
end

Utils.Rainbow = function(TextObject)
    local Text = TextObject.Text
    local Frequency = 1 -- determines how quickly it repeats
    local TotalCharacters = 0
    local Strings = {}

    TextObject.RichText = true

    for Character in gmatch(Text, ".") do
        if match(Character, "%s") then
            Strings[#Strings + 1] = Character
        else
            TotalCharacters = TotalCharacters + 1
            Strings[#Strings + 1] = {'<font color="rgb(%i, %i, %i)">' .. Character .. '</font>'}
        end
    end

    local Connection = AddConnection(CConnect(Heartbeat, function()
        local String = ""
        local Counter = TotalCharacters

        for _, CharacterTable in ipairs(Strings) do
            local Concat = ""

            if (type(CharacterTable) == "table") then
                Counter = Counter - 1
                local Color = Color3.fromHSV(-atan(math.tan((tick() + Counter/math.pi)/Frequency))/math.pi + 0.5, 1, 1)

                CharacterTable = format(CharacterTable[1], floor(Color.R * 255), floor(Color.G * 255), floor(Color.B * 255))
            end

            String = String .. CharacterTable
        end

        TextObject.Text = String .. " "
    end));
    delay(150, function()
        Disconnect(Connection);
    end)

end

Utils.Vector3toVector2 = function(Vector)
    local Tuple = WorldToViewportPoint(Camera, Vector);
    return Vector2New(Tuple.X, Tuple.Y);
end

Utils.AddTag = function(Tag)
    if (not Tag) then
        return
    end
    local PlrCharacter = GetCharacter(Tag.Player)
    if (not PlrCharacter) then
        return
    end
    local Billboard = InstanceNew("BillboardGui");
    Billboard.Parent = UI
    Billboard.Name = GenerateGUID(Services.HttpService);
    Billboard.AlwaysOnTop = true
    Billboard.Adornee = FindFirstChild(PlrCharacter, "Head") or nil
    Billboard.Enabled = FindFirstChild(PlrCharacter, "Head") and true or false
    Billboard.Size = UDim2.new(0, 200, 0, 50)
    Billboard.StudsOffset = Vector3New(0, 4, 0);

    local TextLabel = InstanceNew("TextLabel", Billboard);
    TextLabel.Name = GenerateGUID(Services.HttpService);
    TextLabel.TextStrokeTransparency = 0.6
    TextLabel.BackgroundTransparency = 1
    TextLabel.TextColor3 = Color3.new(0, 255, 0);
    TextLabel.Size = UDim2.new(0, 200, 0, 50);
    TextLabel.TextScaled = false
    TextLabel.TextSize = 15
    TextLabel.Text = format("%s (%s)", Tag.Name, Tag.Tag);

    if (Tag.Rainbow) then
        Utils.Rainbow(TextLabel)
    end
    if (Tag.Colour) then
        local TColour = Tag.Colour
        TextLabel.TextColor3 = Color3.fromRGB(TColour[1], TColour[2], TColour[3]);
    end

    local Added = AddConnection(CConnect(Tag.Player.CharacterAdded, function()
        Billboard.Adornee = WaitForChild(Tag.Player.Character, "Head");
    end));

    AddConnection(CConnect(Players.PlayerRemoving, function(plr)
        if (plr == Tag.Player) then
            Disconnect(Added);
            Destroy(Billboard);
        end
    end))
end

Utils.TextFont = function(Text, RGB)
    RGB = concat(RGB, ",")
    local New = {}
    gsub(Text, ".", function(x)
        New[#New + 1] = x
    end)
    return concat(map(New, function(i, letter)
        return format('<font color="rgb(%s)">%s</font>', RGB, letter)
    end)) .. " "
end

Utils.Thing = function(Object)
    local Container = InstanceNew("Frame");
    local Hitbox = InstanceNew("ImageButton");
    local UDim2fromOffset = UDim2.fromOffset

    Container.Name = "Container"
    Container.Parent = Object.Parent
    Container.BackgroundTransparency = 1.000
    Container.BorderSizePixel = 0
    Container.Position = Object.Position
    Container.ClipsDescendants = true
    Container.Size = UDim2fromOffset(Object.AbsoluteSize.X, Object.AbsoluteSize.Y);
    Container.ZIndex = Object
    
    Object.AutomaticSize = Enum.AutomaticSize.X
    Object.Size = UDim2.fromScale(1, 1)
    Object.Position = UDim2.fromScale(0, 0)
    Object.Parent = Container
    Object.TextTruncate = Enum.TextTruncate.None
    Object.ZIndex = Object.ZIndex + 2
    
    Hitbox.Name = "Hitbox"
    Hitbox.Parent = Container.Parent
    Hitbox.BackgroundTransparency = 1.000
    Hitbox.Size = Container.Size
    Hitbox.Position = Container.Position
    Hitbox.ZIndex = Object.ZIndex + 2
    
    local MouseOut = true
    
    AddConnection(CConnect(Hitbox.MouseEnter, function()
        if Object.AbsoluteSize.X > Container.AbsoluteSize.X then
            MouseOut = false
            repeat
                local Tween1 = Utils.Tween(Object, "Quad", "Out", .5, {
                    Position = UDim2fromOffset(Container.AbsoluteSize.X - Object.AbsoluteSize.X, 0);
                })
                CWait(Tween1.Completed);
                wait(.5);
                local Tween2 = Utils.Tween(Object, "Quad", "Out", .5, {
                    Position = UDim2fromOffset(0, 0);
                })
                CWait(Tween2.Completed);
                wait(.5);
            until MouseOut
        end
    end))

    AddConnection(CConnect(Hitbox.MouseLeave, function()
        MouseOut = true
        Utils.Tween(Object, "Quad", "Out", .25, {
            Position = UDim2fromOffset(0, 0);
        });
    end))
    
    return Object
end

function Utils.Intro(Object)
	local Frame = InstanceNew("Frame");
	local UICorner = InstanceNew("UICorner");
	local CornerRadius = FindFirstChild(Object, "UICorner") and Object.UICorner.CornerRadius or UDim.new(0, 0)
    local UDim2fromOffset  = UDim2.fromOffset

	Frame.Name = "IntroFrame"
	Frame.ZIndex = 1000
	Frame.Size = UDim2fromOffset(Object.AbsoluteSize.X, Object.AbsoluteSize.Y)
	Frame.AnchorPoint = Vector2.new(.5, .5)
	Frame.Position = UDim2.new(Object.Position.X.Scale, Object.Position.X.Offset + (Object.AbsoluteSize.X / 2), Object.Position.Y.Scale, Object.Position.Y.Offset + (Object.AbsoluteSize.Y / 2))
	Frame.BackgroundColor3 = Object.BackgroundColor3
	Frame.BorderSizePixel = 0

	UICorner.CornerRadius = CornerRadius
	UICorner.Parent = Frame

	Frame.Parent = Object.Parent

	if (Object.Visible) then
		Frame.BackgroundTransparency = 1

		local Tween = Utils.Tween(Frame, "Quad", "Out", .25, {
			BackgroundTransparency = 0
		});

		CWait(Tween.Completed);
		Object.Visible = false

		local Tween = Utils.Tween(Frame, "Quad", "Out", .25, {
			Size = UDim2fromOffset(0, 0);
		});

		Utils.Tween(UICorner, "Quad", "Out", .25, {
			CornerRadius = UDim.new(1, 0)
		});

		CWait(Tween.Completed);
		Destroy(Frame);
	else
		Frame.Visible = true
		Frame.Size = UDim2fromOffset(0, 0)
		UICorner.CornerRadius = UDim.new(1, 0)

		local Tween = Utils.Tween(Frame, "Quad", "Out", .25, {
			Size = UDim2fromOffset(Object.AbsoluteSize.X, Object.AbsoluteSize.Y)
		});

		Utils.Tween(UICorner, "Quad", "Out", .25, {
			CornerRadius = CornerRadius
		});

		CWait(Tween.Completed);
		Object.Visible = true

		local Tween = Utils.Tween(Frame, "Quad", "Out", .25, {
			BackgroundTransparency = 1
		})

		CWait(Tween.Completed);
		Destroy(Frame);
	end
end

Utils.MakeGradient = function(ColorTable)
	local Table = {}
    local ColorSequenceKeypointNew = ColorSequenceKeypoint.new
	for Time, Color in next, ColorTable do
		Table[#Table + 1] = ColorSequenceKeypointNew(Time - 1, Color);
	end
	return ColorSequence.new(Table)
end

Utils.Debounce = function(Func)
	local Debounce = false

	return function(...)
		if (not Debounce) then
			Debounce = true
			Func(...);
			Debounce = false
		end
	end
end

Utils.ToggleFunction = function(Container, Enabled, Callback) -- fpr color picker
    local Switch = Container.Switch
    local Hitbox = Container.Hitbox
    local Color3fromRGB = Color3.fromRGB
    local UDim2fromOffset = UDim2.fromOffset

    Container.BackgroundColor3 = Color3fromRGB(255, 79, 87);

    if not Enabled then
        Switch.Position = UDim2fromOffset(2, 2)
        Container.BackgroundColor3 = Color3fromRGB(25, 25, 25);
    end

    AddConnection(CConnect(Hitbox.MouseButton1Click, function()
        Enabled = not Enabled
        
        Utils.Tween(Switch, "Quad", "Out", .25, {
            Position = Enabled and UDim2.new(1, -18, 0, 2) or UDim2fromOffset(2, 2)
        });
        Utils.Tween(Container, "Quad", "Out", .25, {
            BackgroundColor3 = Enabled and Color3fromRGB(255, 79, 87) or Color3fromRGB(25, 25, 25);
        });
        
        Callback(Enabled);
    end));
end

do
    local AmountPrint, AmountWarn, AmountError = 0, 0, 0;

    Utils.Warn = function(Text, Plr)
        local TimeOutputted = os.date("%X");
        local Clone = Clone(UI.MessageOut);
    
        Clone.Name = "W" .. tostring(AmountWarn + 1);
        Clone.Text = format("%s -- %s", TimeOutputted, Text);
        Clone.TextColor3 = Color3.fromRGB(255, 218, 68);
        Clone.Visible = true
        Clone.TextTransparency = 1
        Clone.Parent = Console.Frame.List
    
        Utils.Tween(Clone, "Sine", "Out", .25, {
            TextTransparency = 0
        })
    
        Console.Frame.List.CanvasSize = UDim2.fromOffset(0, Console.Frame.List.UIListLayout.AbsoluteContentSize.Y);
        AmountWarn = AmountWarn + 1
        Utils.Notify(Plr, "Warning", Text);
    end
    
    Utils.Error = function(Text, Caller, FromNotif)
        local TimeOutputted = os.date("%X");
        local Clone = Clone(UI.MessageOut);
    
        Clone.Name = "E" .. tostring(AmountError + 1);
        Clone.Text = format("%s -- %s", TimeOutputted, Text);
        Clone.TextColor3 = Color3.fromRGB(215, 90, 74);
        Clone.Visible = true
        Clone.TextTransparency = 1
        Clone.Parent = Console.Frame.List
    
        Utils.Tween(Clone, "Sine", "Out", .25, {
            TextTransparency = 0
        })
    
        Console.Frame.List.CanvasSize = UDim2.fromOffset(0, Console.Frame.List.UIListLayout.AbsoluteContentSize.Y);
        AmountError = AmountError + 1
    end
    
    Utils.Print = function(Text, Caller, FromNotif)
        local TimeOutputted = os.date("%X");
        local Clone = Clone(UI.MessageOut);
    
        Clone.Name = "P" .. tostring(AmountPrint + 1);
        Clone.Text = format("%s -- %s", TimeOutputted, Text);
        Clone.Visible = true
        Clone.TextTransparency = 1
        Clone.Parent = Console.Frame.List
    
        Utils.Tween(Clone, "Sine", "Out", .25, {
            TextTransparency = 0
        })
    
        Console.Frame.List.CanvasSize = UDim2.fromOffset(0, Console.Frame.List.UIListLayout.AbsoluteContentSize.Y);
        AmountPrint = AmountPrint + 1
        if (len(Text) <= 35 and not FromNotif) then
            Utils.Notify(Caller, "Output", Text);
        end
    end
end
--END IMPORT [utils]



-- commands table
local CommandsTable = {}
local RespawnTimes = {}

local HasTool = function(plr)
    plr = plr or LocalPlayer
    local CharChildren, BackpackChildren = GetChildren(GetCharacter(plr)), GetChildren(plr.Backpack);
    local ToolFound = false
    local tbl = tbl_concat(CharChildren, BackpackChildren);
    for i = 1, #tbl do
        local v = tbl[i]
        if (IsA(v, "Tool")) then
            ToolFound = true
            break;
        end
    end
    return ToolFound
end

local isR6 = function(plr)
    plr = plr or LocalPlayer
    local Humanoid = GetHumanoid(plr);
    if (Humanoid) then
        return Humanoid.RigType == Enum.HumanoidRigType.R6
    end
    return false
end

local isSat = function(plr)
    plr = plr or LocalPlayer
    local Humanoid = GetHumanoid(plr)
    if (Humanoid) then
        return Humanoid.Sit
    end
end

local DisableAnimate = function()
    local Animate = GetCharacter().Animate
    Animate = IsA(Animate, "LocalScript") and Animate or nil
    if (Animate) then
        SpoofProperty(Animate, "Disabled");
        Animate.Disabled = true
    end
end

local GetCorrectToolWithHandle = function()
    local Tools = filter(tbl_concat(GetChildren(LocalPlayer.Backpack), GetChildren(LocalPlayer.Character)), function(i, Tool)
        local Correct = IsA(Tool, "Tool");
        if (Correct and (Tool.RequiresHandle or FindFirstChild(Tool, "Handle"))) then
            local Descendants = GetDescendants(Tool);
            for i = 1, #Descendants do
                local Descendant = Descendants[i]
                if (IsA(Descendant, "Sound") or IsA(Descendant, "Camera") or IsA(Descendant, "LocalScript")) then
                    Destroy(Descendant);
                end
            end
            return true
        end
        return false
    end)

    return Tools[1]
end

local CommandRequirements = {
    [1] = {
        Func = HasTool,
        Message = "You need a tool for this command"
    },
    [2] = {
        Func = isR6,
        Message = "You need to be R6 for this command"
    },
    [3] = {
        Func = function()
            return GetCharacter() ~= nil
        end,
        Message = "You need to be spawned for this command"
    }
}

local AddCommand = function(name, aliases, description, options, func, isplugin)
    local Cmd = {
        Name = name,
        Aliases = aliases,
        Description = description,
        Options = options,
        Function = function()
            for i, v in next, options do
                if (type(v) == 'function' and v() == false) then
                    Utils.Warn("You are missing something that is needed for this command", LocalPlayer);
                    return nil
                elseif (type(v) == 'number' and CommandRequirements[v].Func() == false) then
                    Utils.Warn(CommandRequirements[v].Message, LocalPlayer);
                    return nil
                end
            end
            return func
        end,
        ArgsNeeded = tonumber(filter(options, function(i,v)
            return type(v) == "string"
        end)[1]) or 0,
        Args = filter(options, function(i, v)
            return type(v) == "table"
        end)[1] or {},
        CmdEnv = {},
        IsPlugin = isplugin == true
    }

    CommandsTable[name] = Cmd
    if (type(aliases) == 'table') then
        for i, v in next, aliases do
            CommandsTable[v] = Cmd
        end
    end
    return Success
end

local RemoveCommand = function(Name)
    local Command = LoadCommand(Name);
    if (Command) then
        CommandsTable[Name] = nil
        local CommandsList = Commands.Frame.List
        local CommandLabel = FindFirstChild(CommandsList, Name);
        if (CommandLabel) then
            Destroy(CommandLabel);
        end
        return true
    end
    return false
end

local LoadCommand = function(Name)
    return rawget(CommandsTable, Name);
end

local PluginConf;
local ExecuteCommand = function(Name, Args, Caller)
    local Command = LoadCommand(Name);
    if (Command) then
        if (Command.ArgsNeeded > #Args) then
            return Utils.Warn(format("Insuficient Args (you need %d)", Command.ArgsNeeded), LocalPlayer);
        end

        local Context;
        local sett, gett = syn and syn_context_set or setidentity, syn and syn_context_get or getidentity
        if (Command.IsPlugin and sett and gett and PluginConf.SafePlugins) then
            Context = gett();
            sett(2);
        end
        local Success, Ret = xpcall(function()
            local Func = Command.Function();
            if (Func) then
                local Executed = Func(Caller, Args, Command.CmdEnv);
                if (Executed) then
                    Utils.Notify(Caller, "Command", Executed);
                end
                if (Command.Name ~= "lastcommand") then
                    if (#LastCommand == 3) then
                        LastCommand = shift(LastCommand);
                    end
                    LastCommand[#LastCommand + 1] = {Command.Name, Args, Caller, Command.CmdEnv}
                end
            end
            Success = true
        end, function(Err)
            if (Debug) then
                Utils.Error(format("[FA CMD Error]: Command = '%s' Traceback = '%s'", Name, debug.traceback(Err)), Caller);
                Utils.Notify(Caller, "Error", format("error in the '%s' command, more info shown in console", Name));
            end
        end);
        if (Command.IsPlugin and sett and PluginConf.SafePlugins and Context) then
            sett(Context);
        end
    else
        Utils.Warn("couldn't find the command " .. Name, Caller);
    end
end

local ReplaceHumanoid = function(Hum, R)
    local Humanoid = Hum or GetHumanoid();
    local NewHumanoid = Clone(Humanoid);
    if (R) then
        NewHumanoid.Name = "1"
    end
    NewHumanoid.Parent = Humanoid.Parent
    NewHumanoid.Name = Humanoid.Name
    Services.Workspace.Camera.CameraSubject = NewHumanoid
    Destroy(Humanoid);
    SpoofInstance(NewHumanoid);
    return NewHumanoid
end

local ReplaceCharacter = function()
    local Char = LocalPlayer.Character
    local Model = InstanceNew("Model");
    LocalPlayer.Character = Model
    LocalPlayer.Character = Char
    Destroy(Model);
    return Char
end

local CFrameTool = function(tool, pos)
    local RightArm = FindFirstChild(GetCharacter(), "RightLowerArm") or FindFirstChild(GetCharacter(), "Right Arm");
    local Arm = RightArm.CFrame * CFrameNew(0, -1, 0, 1, 0, 0, 0, 0, 1, 0, -1, 0);
    local Frame = Inverse(toObjectSpace(Arm, pos));

    tool.Grip = Frame
end

local Sanitize = function(value)
    if typeof(value) == 'CFrame' then
        local components = {components(value)}
        for i,v in pairs(components) do
            components[i] = floor(v * 10000 + .5) / 10000
        end
        return 'CFrame.new('..concat(components, ', ')..')'
    end
end

local AddPlayerConnection = function(Player, Connection, CEnv)
    if (CEnv) then
        CEnv[#CEnv + 1] = Connection
    else
        Connections.Players[Player.Name].Connections[#Connections.Players[Player.Name].Connections + 1] = Connection
    end
    return Connection
end


local DisableAllCmdConnections = function(Cmd)
    local Command = LoadCommand(Cmd)
    if (Command and Command.CmdEnv) then
        for i, v in next, flat(Command.CmdEnv) do
            if (type(v) == 'userdata' and v.Disconnect) then
                Disconnect(v);
            end
        end
    end
    return Command
end

local Keys = {}

do
    local UserInputService = Services.UserInputService
    local IsKeyDown = UserInputService.IsKeyDown
    local WindowFocused = true
    AddConnection(CConnect(UserInputService.WindowFocusReleased, function()
        WindowFocused = false
    end));
    AddConnection(CConnect(UserInputService.WindowFocused, function()
        WindowFocused = true
    end));
    local GetFocusedTextBox = UserInputService.GetFocusedTextBox
    AddConnection(CConnect(UserInputService.InputBegan, function(Input, GameProcessed)
        Keys["GameProcessed"] = GameProcessed and WindowFocused and not (not GetFocusedTextBox(UserInputService));
        Keys["LastEntered"] = Input.KeyCode
        if (GameProcessed) then return end
        local KeyCode = split(tostring(Input.KeyCode), ".")[3]
        Keys[KeyCode] = true
        for i = 1, #Macros do
            local Macro = Macros[i]
            if (Tfind(Macro.Keys, Input.KeyCode)) then
                if (#Macro.Keys == 2) then
                    if (IsKeyDown(UserInputService, Macro.Keys[1]) and IsKeyDown(UserInputService, Macro.Keys[2]) --[[and Macro.Keys[1] == Input.KeyCode]]) then
                        ExecuteCommand(Macro.Command, Macro.Args);
                    end
                else
                    ExecuteCommand(Macro.Command, Macro.Args);
                end
            end
        end

        if (Input.KeyCode == Enum.KeyCode.F8) then
            if (Console.Visible) then
                local Tween = Utils.TweenAllTrans(Console, .25)
                CWait(Tween.Completed);
                Console.Visible = false
            else
                local MessageClone = Clone(Console.Frame.List);
    
                Utils.ClearAllObjects(Console.Frame.List)
                Console.Visible = true
            
                local Tween = Utils.TweenAllTransToObject(Console, .25, ConsoleTransparencyClone)
            
                Destroy(Console.Frame.List)
                MessageClone.Parent = Console.Frame
            
                for i, v in next, GetChildren(Console.Frame.List) do
                    if (not IsA(v, "UIListLayout")) then
                        Utils.Tween(v, "Sine", "Out", .25, {
                            TextTransparency = 0
                        })
                    end
                end
            
                local ConsoleListLayout = Console.Frame.List.UIListLayout
            
                CConnect(GetPropertyChangedSignal(ConsoleListLayout, "AbsoluteContentSize"), function()
                    local CanvasPosition = Console.Frame.List.CanvasPosition
                    local CanvasSize = Console.Frame.List.CanvasSize
                    local AbsoluteSize = Console.Frame.List.AbsoluteSize
            
                    if (CanvasSize.Y.Offset - AbsoluteSize.Y - CanvasPosition.Y < 20) then
                       wait();
                       Console.Frame.List.CanvasPosition = Vector2.new(0, CanvasSize.Y.Offset + 1000);
                    end
                end)
            
                Utils.Tween(Console.Frame.List, "Sine", "Out", .25, {
                    ScrollBarImageTransparency = 0
                })
            end
        end
    end));
    AddConnection(CConnect(UserInputService.InputEnded, function(Input, GameProcessed)
        if (GameProcessed) then return end
        local KeyCode = split(tostring(Input.KeyCode), ".")[3]
        if (Keys[KeyCode] or Keys[Input.KeyCode]) then
            Keys[KeyCode] = false
        end
    end));
end

AddCommand("config", {"conf"}, "shows fates admin config", {}, function(Caller, Args, CEnv)
    if (not ConfigLoaded) then
        if (not CEnv[1]) then
            LoadConfig();
        end
        Utils.SetAllTrans(ConfigUI);
        ConfigUI.Visible = true
        Utils.TweenAllTransToObject(ConfigUI, .25, ConfigUIClone);
        ConfigLoaded = true
        CEnv[1] = true
        return "config loaded"
    end
end)

AddCommand("console", {"errors", "warns", "outputs"}, "shows the outputs fates admin has made", {}, function()
    local MessageClone = Clone(Console.Frame.List);
    
    Utils.ClearAllObjects(Console.Frame.List)
    Console.Visible = true

    local Tween = Utils.TweenAllTransToObject(Console, .25, ConsoleTransparencyClone)

    Destroy(Console.Frame.List)
    MessageClone.Parent = Console.Frame

    for i, v in next, GetChildren(Console.Frame.List) do
        if (not IsA(v, "UIListLayout")) then
            Utils.Tween(v, "Sine", "Out", .25, {
                TextTransparency = 0
            })
        end
    end

    local ConsoleListLayout = Console.Frame.List.UIListLayout

    CConnect(GetPropertyChangedSignal(ConsoleListLayout, "AbsoluteContentSize"), function()
        local CanvasPosition = Console.Frame.List.CanvasPosition
        local CanvasSize = Console.Frame.List.CanvasSize
        local AbsoluteSize = Console.Frame.List.AbsoluteSize

        if (CanvasSize.Y.Offset - AbsoluteSize.Y - CanvasPosition.Y < 20) then
           wait();
           Console.Frame.List.CanvasPosition = Vector2.new(0, CanvasSize.Y.Offset + 1000);
        end
    end)

    Utils.Tween(Console.Frame.List, "Sine", "Out", .25, {
        ScrollBarImageTransparency = 0
    })
end)

task.spawn(function()
    local chatted = function(plr, raw)
        local message = raw

        if (_L.ChatLogsEnabled) then

            local time = os.date("%X");
            local Text = format("%s - [%s]: %s", time, plr.Name, raw);
            local Clone = Clone(ChatLogMessage);

            Clone.Text = Text
            Clone.Visible = true
            Clone.TextTransparency = 1
            Clone.Parent = ChatLogs.Frame.List

            Utils.Tween(Clone, "Sine", "Out", .25, {
                TextTransparency = 0
            })

            ChatLogs.Frame.List.CanvasSize = UDim2.fromOffset(0, ChatLogs.Frame.List.UIListLayout.AbsoluteContentSize.Y);
        end

        if (startsWith(raw, "/e")) then
            raw = sub(raw, 4);
        elseif (startsWith(raw, "/w")) then
            raw = shift(shift(split(message, " ")));
        elseif (startsWith(raw, Prefix)) then
            raw = sub(raw, #Prefix + 1);
        else
            return
        end

        message = trim(raw);

        if (Tfind(AdminUsers, plr) or plr == LocalPlayer) then
            local CommandArgs = split(message, " ");
            local Command = CommandArgs[1]
            local Args = shift(CommandArgs);

            ExecuteCommand(Command, Args, plr);
        end
    end

    CConnect(LocalPlayer.Chatted, function(raw)
        chatted(LocalPlayer, raw);
    end);

    if (Services.TextChatService.ChatVersion == Enum.ChatVersion.TextChatService) then
        Services.TextChatService.OnIncomingMessage = function(message)
            chatted(Services.Players:FindFirstChild(message.TextSource.Name), message.Text);
        end
        return;
    end

    local DefaultChatSystemChatEvents = Services.ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents");
    if (not DefaultChatSystemChatEvents) then return; end
    local OnMessageDoneFiltering = DefaultChatSystemChatEvents:WaitForChild("OnMessageDoneFiltering", 5);
    if (not OnMessageDoneFiltering) then return; end
    if (typeof(OnMessageDoneFiltering) ~= "Instance" or OnMessageDoneFiltering.ClassName ~= "RemoteEvent") then return; end


    CConnect(OnMessageDoneFiltering.OnClientEvent, function(messageData)
        if (type(messageData) ~= "table") then return; end
        local plr = Services.Players:FindFirstChild(messageData.FromSpeaker);
        local raw = messageData.Message
        if (not plr or not raw or plr == LocalPlayer) then return; end

        if (messageData.OriginalChannel == "Team") then
            raw = "/team " .. raw
        else
            local whisper = string.match(messageData.OriginalChannel, "To (.+)");
            if (whisper) then
                raw = string.format("/w %s %s", whisper, raw);
            end
        end

        chatted(plr, raw);
    end);

end);

--IMPORT [uimore]
Notification.Visible = false
Utils.SetAllTrans(CommandBar);
Utils.SetAllTrans(ChatLogs);
Utils.SetAllTrans(GlobalChatLogs);
Utils.SetAllTrans(HttpLogs);
Utils.SetAllTrans(Console);
Commands.Visible = false
ChatLogs.Visible = false
Console.Visible = false
GlobalChatLogs.Visible = false
HttpLogs.Visible = false

Utils.Draggable(Commands);
Utils.Draggable(ChatLogs);
Utils.Draggable(Console);
Utils.Draggable(GlobalChatLogs);
Utils.Draggable(HttpLogs);
Utils.Draggable(ConfigUI);

ParentGui(UI);
Connections.UI = {}

local Times = #LastCommand
AddConnection(CConnect(Services.UserInputService.InputBegan, function(Input, GameProccesed)
    if (Input.KeyCode == CommandBarPrefix and (not GameProccesed)) then
        CommandBarOpen = not CommandBarOpen

        local TransparencyTween = CommandBarOpen and Utils.TweenAllTransToObject or Utils.TweenAllTrans
        local Tween = TransparencyTween(CommandBar, .5, CommandBarTransparencyClone);
        local UserInputService = Services.UserInputService

        if (CommandBarOpen) then
            if (not Draggable) then
                Utils.Tween(CommandBar, "Quint", "Out", .5, {
                    Position = UDim2.new(0.5, WideBar and -200 or -100, 1, -110)
                })
            end

            CommandBar.Input.CaptureFocus(CommandBar.Input);
            CThread(function()
                wait()
                CommandBar.Input.Text = ""
                FocusedTextBox = UserInputService.GetFocusedTextBox(UserInputService);
                local TextBox = CommandBar.Input
                while (FocusedTextBox ~= TextBox) do
                    FocusedTextBox.ReleaseFocus(FocusedTextBox);
                    CommandBar.Input.CaptureFocus(TextBox);
                    FocusedTextBox = UserInputService.GetFocusedTextBox(UserInputService);
                    CWait(Heartbeat);
                end
            end)()
        else
            if (not Draggable) then
                Utils.Tween(CommandBar, "Quint", "Out", .5, {
                    Position = UDim2.new(0.5, WideBar and -200 or -100, 1, 5)
                })
            end
        end
    elseif (not GameProccesed and ChooseNewPrefix) then
        CommandBarPrefix = Input.KeyCode
        Utils.Notify(LocalPlayer, "New Prefix", "Your new prefix is: " .. split(tostring(Input.KeyCode), ".")[3]);
        ChooseNewPrefix = false
        if (writefile) then
            Utils.Notify(LocalPlayer, nil, "use command saveprefix to save your prefix");
        end
    elseif (GameProccesed and CommandBarOpen) then
        if (Input.KeyCode == Enum.KeyCode.Up) then
            Times = Times >= 3 and Times or Times + 1
            CommandBar.Input.Text = LastCommand[Times][1] .. " "
            CommandBar.Input.CursorPosition = #CommandBar.Input.Text + 2
        end
        if (Input.KeyCode == Enum.KeyCode.Down) then
            Times = Times <= 1 and 1 or Times - 1
            CommandBar.Input.Text = LastCommand[Times][1] .. " "
            CommandBar.Input.CursorPosition = #CommandBar.Input.Text + 2
        end
    end
end), Connections.UI, true);

Utils.Click(Commands.Close, "TextColor3")
Utils.Click(ChatLogs.Clear, "BackgroundColor3")
Utils.Click(ChatLogs.Save, "BackgroundColor3")
Utils.Click(ChatLogs.Toggle, "BackgroundColor3")
Utils.Click(ChatLogs.Close, "TextColor3")

Utils.Click(Console.Clear, "BackgroundColor3");
Utils.Click(Console.Save, "BackgroundColor3");
Utils.Click(Console.Close, "TextColor3");

Utils.Click(GlobalChatLogs.Clear, "BackgroundColor3")
Utils.Click(GlobalChatLogs.Save, "BackgroundColor3")
Utils.Click(GlobalChatLogs.Toggle, "BackgroundColor3")
Utils.Click(GlobalChatLogs.Close, "TextColor3")

Utils.Click(HttpLogs.Clear, "BackgroundColor3")
Utils.Click(HttpLogs.Save, "BackgroundColor3")
Utils.Click(HttpLogs.Toggle, "BackgroundColor3")
Utils.Click(HttpLogs.Close, "TextColor3")

AddConnection(CConnect(Commands.Close.MouseButton1Click, function()
    local Tween = Utils.TweenAllTrans(Commands, .25)

    CWait(Tween.Completed);
    Commands.Visible = false
end), Connections.UI, true);

AddConnection(CConnect(GetPropertyChangedSignal(Commands.Search, "Text"), function()
    local Text = Commands.Search.Text
    local Children = GetChildren(Commands.Frame.List);
    for i = 1, #Children do
        local v = Children[i]
        if (IsA(v, "Frame")) then
            local Command = v.CommandText.Text
            v.Visible = Sfind(lower(Command), Text, 1, true)
        end
    end
    Commands.Frame.List.CanvasSize = UDim2.fromOffset(0, Commands.Frame.List.UIListLayout.AbsoluteContentSize.Y)
end), Connections.UI, true);

AddConnection(CConnect(ChatLogs.Close.MouseButton1Click, function()
    local Tween = Utils.TweenAllTrans(ChatLogs, .25)

    CWait(Tween.Completed);
    ChatLogs.Visible = false
end), Connections.UI, true);
AddConnection(CConnect(GlobalChatLogs.Close.MouseButton1Click, function()
    local Tween = Utils.TweenAllTrans(GlobalChatLogs, .25)

    CWait(Tween.Completed);
    GlobalChatLogs.Visible = false
end), Connections.UI, true);
AddConnection(CConnect(HttpLogs.Close.MouseButton1Click, function()
    local Tween = Utils.TweenAllTrans(HttpLogs, .25)

    CWait(Tween.Completed);
    HttpLogs.Visible = false
end), Connections.UI, true);

AddConnection(CConnect(Console.Close.MouseButton1Click, function()
    local Tween = Utils.TweenAllTrans(Console, .25)

    CWait(Tween.Completed);
    Console.Visible = false
end), Connections.UI, true);

ChatLogs.Toggle.Text = _L.ChatLogsEnabled and "Enabled" or "Disabled"
GlobalChatLogs.Toggle.Text = _L.ChatLogsEnabled and "Enabled" or "Disabled"
HttpLogs.Toggle.Text = _L.HttpLogsEnabled and "Enabled" or "Disabled"

AddConnection(CConnect(ChatLogs.Toggle.MouseButton1Click, function()
    _L.ChatLogsEnabled = not _L.ChatLogsEnabled
    ChatLogs.Toggle.Text = _L.ChatLogsEnabled and "Enabled" or "Disabled"
end), Connections.UI, true);
AddConnection(CConnect(GlobalChatLogs.Toggle.MouseButton1Click, function()
    _L.GlobalChatLogsEnabled = not _L.GlobalChatLogsEnabled
    GlobalChatLogs.Toggle.Text = _L.GlobalChatLogsEnabled and "Enabled" or "Disabled"
end), Connections.UI, true);
AddConnection(CConnect(HttpLogs.Toggle.MouseButton1Click, function()
    _L.HttpLogsEnabled = not _L.HttpLogsEnabled
    HttpLogs.Toggle.Text = _L.HttpLogsEnabled and "Enabled" or "Disabled"
end), Connections.UI, true);

AddConnection(CConnect(ChatLogs.Clear.MouseButton1Click, function()
    Utils.ClearAllObjects(ChatLogs.Frame.List)
    ChatLogs.Frame.List.CanvasSize = UDim2.fromOffset(0, 0)
end), Connections.UI, true);
AddConnection(CConnect(GlobalChatLogs.Clear.MouseButton1Click, function()
    Utils.ClearAllObjects(GlobalChatLogs.Frame.List)
    GlobalChatLogs.Frame.List.CanvasSize = UDim2.fromOffset(0, 0)
end), Connections.UI, true);
AddConnection(CConnect(HttpLogs.Clear.MouseButton1Click, function()
    Utils.ClearAllObjects(HttpLogs.Frame.List)
    HttpLogs.Frame.List.CanvasSize = UDim2.fromOffset(0, 0)
end), Connections.UI, true);

AddConnection(CConnect(Console.Clear.MouseButton1Click, function()
    Utils.ClearAllObjects(Console.Frame.List);
    Console.Frame.List.CanvasSize = UDim2.fromOffset(0, 0);
end), Connections.UI, true);

do
    local ShowWarns, ShowErrors, ShowOutput = true, true, true
    AddConnection(CConnect(Console.Warns.MouseButton1Click, function()
        ShowWarns = not ShowWarns
        local Children = GetChildren(Console.Frame.List);
        for i = 1, #Children do
            local v = Children[i]
            if (not IsA(v, "UIListLayout") and sub(v.Name, 1, 1) == "W") then
                v.Visible = ShowWarns
            end
        end
        Console.Frame.List.CanvasSize = UDim2.fromOffset(0, Console.Frame.List.UIListLayout.AbsoluteContentSize.Y);
        Console.Warns.Text = ShowWarns and "Hide Warns" or "Show Warns"
    end), Connections.UI, true);
    AddConnection(CConnect(Console.Errors.MouseButton1Click, function()
        ShowErrors = not ShowErrors
        local Children = GetChildren(Console.Frame.List);
        for i = 1, #Children do
            local v = Children[i]
            if (not IsA(v, "UIListLayout") and sub(v.Name, 1, 1) == "E") then
                v.Visible = ShowErrors
            end
        end
        Console.Frame.List.CanvasSize = UDim2.fromOffset(0, Console.Frame.List.UIListLayout.AbsoluteContentSize.Y);
        Console.Errors.Text = ShowErrors and "Hide Errors" or "Show Errors"
    end), Connections.UI, true);
    AddConnection(CConnect(Console.Output.MouseButton1Click, function()
        ShowOutput = not ShowOutput
        local Children = GetChildren(Console.Frame.List);
        for i = 1, #Children do
            local v = Children[i]
            if (not IsA(v, "UIListLayout") and sub(v.Name, 1, 1) == "P") then
                v.Visible = ShowOutput
            end
        end
        Console.Frame.List.CanvasSize = UDim2.fromOffset(0, Console.Frame.List.UIListLayout.AbsoluteContentSize.Y);
        Console.Output.Text = ShowOutput and "Hide Output" or "Show Output"
    end), Connections.UI, true);
end

AddConnection(CConnect(GetPropertyChangedSignal(ChatLogs.Search, "Text"), function()
    local Text = ChatLogs.Search.Text
    local Children = GetChildren(ChatLogs.Frame.List);
    for i = 1, #Children do
        local v = Children[i]
        if (not IsA(v, "UIListLayout")) then
            local Message = v.Text
            v.Visible = Sfind(lower(Message), Text, 1, true);
        end
    end
    ChatLogs.Frame.List.CanvasSize = UDim2.fromOffset(0, ChatLogs.Frame.List.UIListLayout.AbsoluteContentSize.Y);
end), Connections.UI, true);

AddConnection(CConnect(GetPropertyChangedSignal(GlobalChatLogs.Search, "Text"), function()
    local Text = GlobalChatLogs.Search.Text

    local Children = GetChildren(GlobalChatLogs.Frame.List);
    for i = 1, #Children do
        local v = Children[i]
        if (not IsA(v, "UIListLayout")) then
            local Message = v.Text

            v.Visible = Sfind(lower(Message), Text, 1, true)
        end
    end
end), Connections.UI, true);

AddConnection(CConnect(GetPropertyChangedSignal(HttpLogs.Search, "Text"), function()
    local Text = HttpLogs.Search.Text

    local Children = GetChildren(HttpLogs.Frame.List);
    for i = 1, #Children do
        local v = Children[i]
        if (not IsA(v, "UIListLayout")) then
            local Message = v.Text
            v.Visible = Sfind(lower(Message), Text, 1, true)
        end
    end
end), Connections.UI, true);

AddConnection(CConnect(GetPropertyChangedSignal(Console.Search, "Text"), function()
    local Text = Console.Search.Text
    local Children = GetChildren(Console.Frame.List);
    for i = 1, #Children do
        local v = Children[i]
        if (not IsA(v, "UIListLayout")) then
            local Message = v.Text
            v.Visible = Sfind(lower(Message), Text, 1, true)
        end
    end
    Console.Frame.List.CanvasSize = UDim2.fromOffset(0, Console.Frame.List.UIListLayout.AbsoluteContentSize.Y)
end), Connections.UI, true);


AddConnection(CConnect(ChatLogs.Save.MouseButton1Click, function()
    local GameName = Services.MarketplaceService.GetProductInfo(Services.MarketplaceService, game.PlaceId).Name
    local String =  format("Fates Admin Chatlogs for %s (%s)\n\n", GameName, os.date());
    local TimeSaved = gsub(tostring(os.date("%x")), "/", "-") .. " " .. gsub(tostring(os.date("%X")), ":", "-");
    local Name = format("fates-admin/chatlogs/%s (%s).txt", GameName, TimeSaved);
    local Children = GetChildren(ChatLogs.Frame.List);
    for i = 1, #Children do
        local v = Children[i]
        if (not IsA(v, "UIListLayout")) then
            String = format("%s%s\n", String, v.Text);
        end
    end
    writefile(Name, String);
    Utils.Notify(LocalPlayer, "Saved", "Chat logs saved!");
end), Connections.UI, true);

AddConnection(CConnect(HttpLogs.Save.MouseButton1Click, function()
    local Children = GetChildren(HttpLogs.Frame.List);
    local Logs =  format("Fates Admin HttpLogs for %s\n\n", os.date());
    for i = 1, #Children do
        local v = Children[i]
        if (not IsA(v, "UIListLayout")) then
            Logs = format("%s%s\n", Logs, v.Text);
        end
    end
    if (not isfolder("fates-admin/httplogs")) then
        makefolder("fates-admin/httplogs");
    end
    writefile(format("fates-admin/httplogs/HttpLogs for %s", gsub(tostring(os.date("%X")), ":", "-")) .. ".txt", gsub(Logs, "%b<>", ""));
    Utils.Notify(LocalPlayer, "Saved", "Http logs saved!");
end), Connections.UI, true);

AddConnection(CConnect(Console.Save.MouseButton1Click, function()
    local GameName = Services.MarketplaceService.GetProductInfo(Services.MarketplaceService, game.PlaceId).Name
    local TimeSaved = gsub(tostring(os.date("%x")), "/", "-") .. " " .. gsub(tostring(os.date("%X")), ":", "-");
    local Children = GetChildren(Console.Frame.List);
    local String =  format("Fates Admin logs %s\nGame: %s - %d\n\n", TimeSaved, GameName, game.PlaceId);
    local Names = { ["P"] = "OUTPUT", ["W"] = "WARNING", ["E"] = "ERROR" }
    for i = 1, #Children do
        local v = Children[i]
        if (not IsA(v, "UIListLayout")) then
            String = format("%s[%s] %s\n", String, Names[sub(v.Name, 1, 1)] or "", v.Text);
        end
    end
    writefile("fates-admin/logs.txt", String);
    Utils.Notify(LocalPlayer, "Saved", "Console Logs saved!");
end), Connections.UI, true);

-- auto correct
AddConnection(CConnect(GetPropertyChangedSignal(CommandBar.Input, "Text"), function() -- make it so that every space a players name will appear
    CommandBar.Input.Text = CommandBar.Input.Text
    local Text = CommandBar.Input.Text
    local Prediction = CommandBar.Input.Predict
    local PredictionText = Prediction.Text

    local Args = split(Text, " ")

    Prediction.Text = ""
    if (Text == "") then
        return
    end

    local FoundCommand = false
    local FoundAlias = false
    CommandArgs = CommandArgs or {}
    if (not CommandsTable[Args[1]]) then
        for _, v in next, CommandsTable do
            local CommandName = v.Name
            local Aliases = v.Aliases
            local FoundAlias
    
            if (Utils.MatchSearch(Args[1], CommandName)) then -- better search
                Prediction.Text = CommandName
                CommandArgs = v.Args or {}
                break
            end
    
            for _, v2 in next, Aliases do
                if (Utils.MatchSearch(Args[1], v2)) then
                    FoundAlias = true
                    Prediction.Text = v2
                    CommandArgs = v2.Args or {}
                    break
                end
    
                if (FoundAlias) then
                    break
                end
            end
        end
    end

    for i, v in next, Args do -- make it get more players after i space out
        if (i > 1 and v ~= "") then
            local Predict = ""
            if (#CommandArgs >= 1) then
                for i2, v2 in next, CommandArgs do
                    if (lower(v2) == "player") then
                        Predict = Utils.GetPlayerArgs(v) or Predict;
                    else
                        Predict = Utils.MatchSearch(v, v2) and v2 or Predict
                    end
                end
            else
                Predict = Utils.GetPlayerArgs(v) or Predict;
            end
            Prediction.Text = sub(Text, 1, #Text - #Args[#Args]) .. Predict
            local split = split(v, ",");
            if (next(split)) then
                for i2, v2 in next, split do
                    if (i2 > 1 and v2 ~= "") then
                        local PlayerName = Utils.GetPlayerArgs(v2)
                        Prediction.Text = sub(Text, 1, #Text - #split[#split]) .. (PlayerName or "")
                    end
                end
            end
        end
    end

    if (Sfind(Text, "\t")) then -- remove tab from preditction text also
        CommandBar.Input.Text = PredictionText
        CommandBar.Input.CursorPosition = #CommandBar.Input.Text + 1
    end
end))


do
    local Enabled = false
    local Connection;
    local Predict;
    ToggleChatPrediction = function()
        if (_L.Frame2) then
            return
        end
        if (not Enabled) then
            local RobloxChat = LocalPlayer.PlayerGui and FindFirstChild(LocalPlayer.PlayerGui, "Chat");
            local RobloxChatBarFrame;
            if (RobloxChat) then
                local RobloxChatFrame = FindFirstChild(RobloxChat, "Frame");
                if (RobloxChatFrame) then
                    RobloxChatBarFrame = FindFirstChild(RobloxChatFrame, "ChatBarParentFrame");
                end
            end
            local PredictionClone, ChatBar
            if (RobloxChatBarFrame) then
                local Frame1 = FindFirstChild(RobloxChatBarFrame, 'Frame');
                if Frame1 then
                    local BoxFrame = FindFirstChild(Frame1, 'BoxFrame');
                    if BoxFrame then
                        _L.Frame2 = FindFirstChild(BoxFrame, 'Frame');
                        if _L.Frame2 then
                            local TextLabel = FindFirstChild(_L.Frame2, 'TextLabel');
                            ChatBar = FindFirstChild(_L.Frame2, 'ChatBar');
                            if TextLabel and ChatBar then
                                PredictionClone = InstanceNew('TextLabel');
                                PredictionClone.Font = TextLabel.Font
                                PredictionClone.LineHeight = TextLabel.LineHeight
                                PredictionClone.MaxVisibleGraphemes = TextLabel.MaxVisibleGraphemes
                                PredictionClone.RichText = TextLabel.RichText
                                PredictionClone.Text = ''
                                PredictionClone.TextColor3 = TextLabel.TextColor3
                                PredictionClone.TextScaled = TextLabel.TextScaled
                                PredictionClone.TextSize = TextLabel.TextSize
                                PredictionClone.TextStrokeColor3 = TextLabel.TextStrokeColor3
                                PredictionClone.TextStrokeTransparency = TextLabel.TextStrokeTransparency
                                PredictionClone.TextTransparency = 0.3
                                PredictionClone.TextTruncate = TextLabel.TextTruncate
                                PredictionClone.TextWrapped = TextLabel.TextWrapped
                                PredictionClone.TextXAlignment = TextLabel.TextXAlignment
                                PredictionClone.TextYAlignment = TextLabel.TextYAlignment
                                PredictionClone.Name = "Predict"
                                PredictionClone.Size = UDim2.new(1, 0, 1, 0);
                                PredictionClone.BackgroundTransparency = 1
                            end
                        end
                    end
                end
            end

            ParentGui(PredictionClone, _L.Frame2);
            Predict = PredictionClone

            Connection = AddConnection(CConnect(GetPropertyChangedSignal(ChatBar, "Text"), function() -- todo: add detection for /e
                local Text = ChatBar.Text
                local Prediction = PredictionClone
                local PredictionText = PredictionClone.Text
            
                local Args = split(concat(shift(split(Text, ""))), " ");
            
                Prediction.Text = ""
                if (not startsWith(Text, Prefix)) then
                    return
                end
            
                local FoundCommand = false
                local FoundAlias = false
                CommandArgs = CommandArgs or {}
                if (not rawget(CommandsTable, Args[1])) then
                    for _, v in next, CommandsTable do
                        local CommandName = v.Name
                        local Aliases = v.Aliases
                        local FoundAlias
                
                        if (Utils.MatchSearch(Args[1], CommandName)) then -- better search
                            Prediction.Text = Prefix .. CommandName
                            FoundCommand = true
                            CommandArgs = v.Args or {}
                            break
                        end
                
                        for _, v2 in next, Aliases do
                            if (Utils.MatchSearch(Args[1], v2)) then
                                FoundAlias = true
                                Prediction.Text = v2
                                CommandArgs = v.Args or {}
                                break
                            end
                
                            if (FoundAlias) then
                                break
                            end
                        end
                    end
                end
            
                for i, v in next, Args do -- make it get more players after i space out
                    if (i > 1 and v ~= "") then
                        local Predict = ""
                        if (#CommandArgs >= 1) then
                            for i2, v2 in next, CommandArgs do
                                if (lower(v2) == "player") then
                                    Predict = Utils.GetPlayerArgs(v) or Predict;
                                else
                                    Predict = Utils.MatchSearch(v, v2) and v2 or Predict
                                end
                            end
                        else
                            Predict = Utils.GetPlayerArgs(v) or Predict;
                        end
                        Prediction.Text = sub(Text, 1, #Text - #Args[#Args]) .. Predict
                        local split = split(v, ",");
                        if (next(split)) then
                            for i2, v2 in next, split do
                                if (i2 > 1 and v2 ~= "") then
                                    local PlayerName = Utils.GetPlayerArgs(v2)
                                    Prediction.Text = sub(Text, 1, #Text - #split[#split]) .. (PlayerName or "")
                                end
                            end
                        end
                    end
                end
            
                if (Sfind(Text, "\t")) then -- remove tab from preditction text also
                    ChatBar.Text = PredictionText
                    ChatBar.CursorPosition = #ChatBar.Text + 2
                end
            end))
            Enabled = true
            return ChatBar
        else
            Disconnect(Connection);
            Destroy(Predict);
            Enabled = false
        end
        return _L.Frame2
    end

    if (CurrentConfig.ChatPrediction) then
        delay(2, ToggleChatPrediction);
    end
end

local ConfigUILib = {}
do
    local GuiObjects = ConfigElements
    local PageCount = 0
    local SelectedPage
    local UserInputService = Services.UserInputService

    local Colors = {
        ToggleEnabled = Color3.fromRGB(5, 5, 6);
        Background = Color3.fromRGB(32, 33, 36);
        ToggleDisabled = Color3.fromRGB(27, 28, 31);
    }

    local ColorElements = ConfigElements.Elements.ColorElements
    local Overlay = ColorElements.Overlay
    local OverlayMain = Overlay.Main
    local ColorPicker = OverlayMain.ColorPicker
    local Settings = OverlayMain.Settings
    local ClosePicker = OverlayMain.Close
    local ColorCanvas = ColorPicker.ColorCanvas
    local ColorSlider = ColorPicker.ColorSlider
    local ColorGradient = ColorCanvas.ColorGradient
    local DarkGradient = ColorGradient.DarkGradient
    local CanvasBar = ColorGradient.Bar
    local RainbowGradient = ColorSlider.RainbowGradient
    local SliderBar = RainbowGradient.Bar
    local CanvasHitbox = ColorCanvas.Hitbox
    local SliderHitbox = ColorSlider.Hitbox
    local ColorPreview = Settings.ColorPreview
    local ColorOptions = Settings.Options
    local RedTextBox = ColorOptions.Red.TextBox
    local BlueTextBox = ColorOptions.Blue.TextBox
    local GreenTextBox = ColorOptions.Green.TextBox
    local RainbowToggle = ColorOptions.Rainbow

    local function UpdateClone()
        ConfigUIClone = Clone(ConfigUI);
    end

    function ConfigUILib.NewPage(Title)
        local Page = Clone(GuiObjects.Page.Container);
        local TextButton = Clone(GuiObjects.Page.TextButton);

        Page.Visible = true
        TextButton.Visible = true

        Utils.Click(TextButton, "BackgroundColor3")
            
        if PageCount == 0 then
            SelectedPage = Page
        end

        AddConnection(CConnect(TextButton.MouseButton1Click, function()
            if SelectedPage.Name ~= TextButton.Name then          
                SelectedPage = Page
                ConfigUI.Container.UIPageLayout:JumpTo(SelectedPage)
            end
        end))
        
        Page.Name = Title
        TextButton.Name = Title
        TextButton.Text = Title
        
        Page.Parent = ConfigUI.Container
        TextButton.Parent = ConfigUI.Selection
        
        PageCount = PageCount + 1


        UpdateClone()

        local function GetKeyName(KeyCode)
            local _, Stringed = pcall(UserInputService.GetStringForKeyCode, UserInputService, KeyCode);
            local IsEnum = Stringed == ""
            return (not IsEnum and _) and Stringed or split(tostring(KeyCode), ".")[3], (IsEnum and not _);
        end

        local PageLibrary = {}

        function PageLibrary.CreateMacroSection(MacrosToAdd, Callback)
            local Macro = Clone(GuiObjects.Elements.Macro);
            local MacroPage = Macro.MacroPage
            local Selection = Page.Selection
            
            Selection.ClearAllChildren(Selection);
            for i,v in next, GetChildren(MacroPage) do
                v.Parent = Selection
            end
            Selection.Container.Visible = true
            local CommandsList = Selection.Container.Commands.Frame.List
            local CurrentMacros = Selection.Container.CurrentMacros
            local AddMacro = Selection.AddMacro
            local BindA, CommandA, ArgsA = AddMacro.Bind, AddMacro.Command, AddMacro["z Args"]
            local Add = AddMacro.AddMacro
            local Keybind = {};
            local Enabled = false
            local Connection
            
            local OnClick = function()
                Enabled = not Enabled
                if Enabled then
                    BindA.Text = "..."
                    local OldShiftLock = LocalPlayer.DevEnableMouseLock
                    LocalPlayer.DevEnableMouseLock = false
                    Keybind = {}
                    Connection = AddConnection(CConnect(UserInputService.InputBegan, function(Input, Processed)
                        if not Processed and Input.UserInputType == Enum.UserInputType.Keyboard then
                            local Input2, Proccessed2;
                            CThread(function()
                                Input2, Proccessed2 = CWait(UserInputService.InputBegan);
                            end)()
                            CWait(UserInputService.InputEnded);
                            if (Input2 and not Processed) then
                                local KeyName, IsEnum = GetKeyName(Input.KeyCode);
                                local KeyName2, IsEnum2 = GetKeyName(Input2.KeyCode); 
                                BindA.Text = format("%s + %s", IsEnum2 and KeyName2 or KeyName, IsEnum2 and KeyName2 or KeyName2);
                                Keybind[1] = Input.KeyCode
                                Keybind[2] = Input2.KeyCode
                            else
                                local KeyName = GetKeyName(Input.KeyCode);
                                BindA.Text = KeyName
                                Keybind[1] = Input.KeyCode
                                Keybind[2] = nil
                            end
                            LocalPlayer.DevEnableMouseLock = OldShiftLock
                        else
                            BindA.Text = "Bind"
                        end
                        Enabled = false
                        Disconnect(Connection);
                    end));
                else
                    BindA.Text = "Bind"
                    Disconnect(Connection);
                end
            end

            AddConnection(CConnect(BindA.MouseButton1Click, OnClick));
            AddConnection(CConnect(Add.MouseButton1Click, function()
                if (BindA.Text == "Bind") then
                    Utils.Notify(nil, nil, "You must assign a keybind");
                    return
                end
                if (not CommandsTable[CommandA.Text]) then
                    Utils.Notify(nil, nil, "You must add a command");
                    return
                end
                Callback(Keybind, CommandA.Text, ArgsA.Text);
            end));

            local Focused = false
            local MacroSection = {
                CommandsList = CommandsList,
                AddCmd = function(Name) 
                    local Command = Clone(Macro.Command);
                    Command.Name = Name
                    Command.Text = Name
                    Command.Parent = CommandsList
                    Command.Visible = true
                    AddConnection(CConnect(Command.MouseButton1Click, function()
                        CommandA.Text = Name
                        ArgsA.CaptureFocus(ArgsA);
                        Focused = true
                        CWait(ArgsA.FocusLost);
                        CWait(UserInputService.InputBegan);
                        Focused = false
                        wait(.2);
                        if (not Focused) then
                            OnClick();
                        end
                    end))
                end,
                AddMacro = function(MacroName, Bind)
                    local NewMacro = Clone(Macro.EditMacro);
                    NewMacro.Bind.Text = Bind
                    NewMacro.Macro.Text = MacroName
                    NewMacro.Parent = CurrentMacros
                    NewMacro.Visible = true

                    Utils.Thing(NewMacro.Bind);
                    Utils.Thing(NewMacro.Macro);

                    FindFirstChild(NewMacro, "Remove").Name = "Delete"
                    AddConnection(CConnect(NewMacro.Delete.MouseButton1Click, function()
                        CWait(Utils.TweenAllTrans(NewMacro, .25).Completed);
                        Destroy(NewMacro);
                        for i = 1, #Macros do
                            if (Macros[i].Command == split(MacroName, " ")[1]) then
                                Macros[i] = nil
                            end
                        end
                        local TempMacros = clone(Macros);
                        for i, v in next, TempMacros do
                            for i2, v2 in next, v.Keys do
                                TempMacros[i]["Keys"][i2] = split(tostring(v2), ".")[3]
                            end
                        end
                        SetConfig({Macros=TempMacros});
                    end))
                end
            }

            for i, v in next, MacrosToAdd do
                local Suc, Err = pcall(concat, v.Args, " ");
                if (not Suc) then
                    SetConfig({Macros={}});
                    Utils.Notify(LocalPlayer, "Error", "Macros were reset due to corrupted data")
                    break;
                end
                local KeyName, IsEnum = GetKeyName(v.Keys[1]);
                local Formatted;
                if (v.Keys[2]) then
                    local KeyName2, IsEnum2 = GetKeyName(v.Keys[2]); 
                    Formatted = format("%s + %s", IsEnum2 and KeyName2 or KeyName, IsEnum2 and KeyName2 or KeyName2);
                else
                    Formatted = KeyName
                end
                MacroSection.AddMacro(v.Command .. " " .. concat(v.Args, " "), Formatted);
            end

            return MacroSection
        end

        function PageLibrary.NewSection(Title)
            local Section = Clone(GuiObjects.Section.Container);
            local SectionOptions = Section.Options
            local SectionUIListLayout = SectionOptions.UIListLayout

            Section.Visible = true

            Utils.SmoothScroll(Section.Options, .14)
            Section.Title.Text = Title
            Section.Parent = Page.Selection
            
            
            SectionOptions.CanvasSize = UDim2.fromOffset(0,0) --// change
            AddConnection(CConnect(GetPropertyChangedSignal(SectionUIListLayout, "AbsoluteContentSize"), function()
                SectionOptions.CanvasSize = UDim2.fromOffset(0, SectionUIListLayout.AbsoluteContentSize.Y + 5);
            end));
            
            UpdateClone();

            local ElementLibrary = {}


            function ElementLibrary.Toggle(Title, Enabled, Callback)
                local Toggle = Clone(GuiObjects.Elements.Toggle);
                local Container = Toggle.Container

                local Switch = Container.Switch
                local Hitbox = Container.Hitbox
                
                if not Enabled then
                    Switch.Position = UDim2.fromOffset(2, 2)
                    Container.BackgroundColor3 = Colors.ToggleDisabled
                end
                local NoCallback = false

                local OnClick = function()
                    Enabled = not Enabled
                    
                    Utils.Tween(Switch, "Quad", "Out", .25, {
                        Position = Enabled and UDim2.new(1, -18, 0, 2) or UDim2.fromOffset(2, 2)
                    })
                    Utils.Tween(Container, "Quad", "Out", .25, {
                        BackgroundColor3 = Enabled and Colors.ToggleEnabled or Colors.ToggleDisabled
                    })
                    
                    if (not NoCallback) then
                        Callback(Enabled);
                    end
                end

                AddConnection(CConnect(Hitbox.MouseButton1Click, OnClick));
                
                Toggle.Visible = true
                Toggle.Title.Text = Title
                Toggle.Parent = Section.Options
                Utils.Thing(Toggle.Title);

                UpdateClone()

                return function()
                    NoCallback = true
                    OnClick();
                    NoCallback = false
                end
            end

            function ElementLibrary.ScrollingFrame(Title, Callback, Elements, Toggles)
                local ScrollingFrame = Clone(GuiObjects.Elements.ScrollingFrame);
                local Frame = ScrollingFrame.Frame
                local Toggle = ScrollingFrame.Toggle

                for ElementTitle, Enabled in next, Elements do
                    local NewToggle = Clone(Toggle);
                    NewToggle.Visible = true
                    NewToggle.Title.Text = ElementTitle
                    NewToggle.Plugins.Text = Enabled and (Toggles and Toggles[1] or "Enabled") or (Toggles and Toggles[2] or "Disabled");


                    Utils.Click(NewToggle.Plugins, "BackgroundColor3")

                    AddConnection(CConnect(NewToggle.Plugins.MouseButton1Click, function()
                        Enabled = not Enabled
                        NewToggle.Plugins.Text = Enabled and (Toggles and Toggles[1] or "Enabled") or (Toggles and Toggles[2] or "Disabled");

                        Callback(ElementTitle, Enabled);
                    end));

                    NewToggle.Parent = Frame.Container
                end

                Frame.Visible = true
                Frame.Title.Text = Title
                Frame.Parent = Section.Options

                for _, NewToggle in next, GetChildren(Frame.Container) do
                    if (IsA(NewToggle, "GuiObject")) then
                        Utils.Thing(NewToggle.Title);
                    end
                end

                UpdateClone()
            end

            function ElementLibrary.Keybind(Title, Bind, Callback)
                local Keybind = Clone(GuiObjects.Elements.Keybind);
                local Enabled = false
                local Connection

                Keybind.Container.Text = Bind
                Keybind.Title.Text = Title

                local Container = Keybind.Container
                AddConnection(CConnect(Container.MouseButton1Click, function()
                    Enabled = not Enabled

                    if Enabled then
                        Container.Text = "..."
                        local OldShiftLock = LocalPlayer.DevEnableMouseLock
                        -- disable shift lock so it doesn't interfere with keybind
                        LocalPlayer.DevEnableMouseLock = false
                        Connection = AddConnection(CConnect(UserInputService.InputBegan, function(Input, Processed)
                            if not Processed and Input.UserInputType == Enum.UserInputType.Keyboard then
                                local Input2, Proccessed2;
                                CThread(function()
                                    Input2, Proccessed2 = CWait(UserInputService.InputBegan);
                                end)()
                                CWait(UserInputService.InputEnded);
                                if (Input2 and not Processed) then
                                    local KeyName, IsEnum = GetKeyName(Input.KeyCode);
                                    local KeyName2, IsEnum2 = GetKeyName(Input2.KeyCode); 
                                    -- Order by if it's an enum first, example 'Shift + K' and not 'K + Shift'
                                    Container.Text = format("%s + %s", IsEnum2 and KeyName2 or KeyName, IsEnum2 and KeyName2 or KeyName2);
                                    Callback(Input.KeyCode, Input2.KeyCode);
                                else
                                    local KeyName = GetKeyName(Input.KeyCode);
                                    Container.Text = KeyName
                                    Callback(Input.KeyCode);
                                end
                                LocalPlayer.DevEnableMouseLock = OldShiftLock
                            else
                                Container.Text = "press"
                            end
                            Enabled = false
                            Disconnect(Connection);
                        end));
                    else
                        Container.Text = "press"
                        Disconnect(Connection);
                    end
                end));

                Utils.Click(Container, "BackgroundColor3");
                Keybind.Visible = true
                Keybind.Parent = Section.Options
                UpdateClone();
            end
            
            function ElementLibrary.TextboxKeybind(Title, Bind, Callback)
                local Keybind = Clone(GuiObjects.Elements.TextboxKeybind);
                
                Keybind.Container.Text = Bind
                Keybind.Title.Text = Title
                
                local Container = Keybind.Container
                AddConnection(CConnect(GetPropertyChangedSignal(Container, "Text"), function(Key)
                    if (#Container.Text >= 1) then
                        Container.Text = sub(Container.Text, 1, 1);
                        Callback(Container.Text);
                        Container.ReleaseFocus(Container);
                    end
                end))
                
                Keybind.Visible = true
                Keybind.Parent = Section.Options
                UpdateClone();
            end

            function ElementLibrary.ColorPicker(Title, DefaultColor, Callback)
                local SelectColor = Clone(ColorElements.SelectColor);
                local CurrentColor = DefaultColor
                local Button = SelectColor.Button
                local ToHSV = DefaultColor.ToHSV
                local Color3New = Color3.new
                local Color3fromHSV = Color3.fromHSV
                local UDim2New = UDim2.new
                local clamp = math.clamp

                local H, S, V = ToHSV(DefaultColor);
                local Opened = false
                local Rainbow = false
                
                local function UpdateText()
                    RedTextBox.PlaceholderText = tostring(math.floor(CurrentColor.R * 255))
                    GreenTextBox.PlaceholderText = tostring(math.floor(CurrentColor.G * 255))
                    BlueTextBox.PlaceholderText = tostring(math.floor(CurrentColor.B * 255))
                end
                
                local function UpdateColor()
                    H, S, V = ToHSV(CurrentColor);
                    
                    SliderBar.Position = UDim2New(0, 0, H, 2);
                    CanvasBar.Position = UDim2New(S, 2, 1 - V, 2);
                    ColorGradient.UIGradient.Color = Utils.MakeGradient({
                        [1] = Color3New(1, 1, 1);
                        [2] = Color3fromHSV(H, 1, 1);
                    })
                    
                    ColorPreview.BackgroundColor3 = CurrentColor
                    UpdateText();
                end
            
                local function UpdateHue(Hue)
                    SliderBar.Position = UDim2New(0, 0, Hue, 2);
                    ColorGradient.UIGradient.Color = Utils.MakeGradient({
                        [1] = Color3New(1, 1, 1);
                        [2] = Color3fromHSV(Hue, 1, 1);
                    });
                    
                    ColorPreview.BackgroundColor3 = CurrentColor
                    UpdateText();
                end
                
                local function ColorSliderInit()
                    local Moving = false
                    
                    local function Update()
                        if Opened and not Rainbow then
                            local LowerBound = SliderHitbox.AbsoluteSize.Y
                            local Position = clamp(Mouse.Y - SliderHitbox.AbsolutePosition.Y, 0, LowerBound);
                            local Value = Position / LowerBound
                            
                            H = Value
                            CurrentColor = Color3fromHSV(H, S, V);
                            ColorPreview.BackgroundColor3 = CurrentColor
                            ColorGradient.UIGradient.Color = Utils.MakeGradient({
                                [1] = Color3New(1, 1, 1);
                                [2] = Color3fromHSV(H, 1, 1);
                            });
                            
                            UpdateText();
                            
                            local Position = UDim2.new(0, 0, Value, 2)
                            local Tween = Utils.Tween(SliderBar, "Linear", "Out", .05, {
                                Position = Position
                            });
                            
                            Callback(CurrentColor);
                            CWait(Tween.Completed);
                        end
                    end
                
                    AddConnection(CConnect(SliderHitbox.MouseButton1Down, function()
                        Moving = true
                        Update()
                    end))
                    
                    AddConnection(CConnect(UserInputService.InputEnded, function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 and Moving then
                            Moving = false
                        end
                    end))
                    
                    AddConnection(CConnect(Mouse.Move, Utils.Debounce(function()
                        if Moving then
                            Update()
                        end
                    end)))
                end
                local function ColorCanvasInit()
                    local Moving = false
                    
                    local function Update()
                        if Opened then
                            local LowerBound = CanvasHitbox.AbsoluteSize.Y
                            local YPosition = clamp(Mouse.Y - CanvasHitbox.AbsolutePosition.Y, 0, LowerBound)
                            local YValue = YPosition / LowerBound
                            local RightBound = CanvasHitbox.AbsoluteSize.X
                            local XPosition = clamp(Mouse.X - CanvasHitbox.AbsolutePosition.X, 0, RightBound)
                            local XValue = XPosition / RightBound
                            
                            S = XValue
                            V = 1 - YValue
                            
                            CurrentColor = Color3fromHSV(H, S, V);
                            ColorPreview.BackgroundColor3 = CurrentColor
                            UpdateText()
                            
                            local Position = UDim2New(XValue, 2, YValue, 2);
                            local Tween = Utils.Tween(CanvasBar, "Linear", "Out", .05, {
                                Position = Position
                            });
                            Callback(CurrentColor);
                            CWait(Tween.Completed);
                        end
                    end
                
                    AddConnection(CConnect(CanvasHitbox.MouseButton1Down, function()
                        Moving = true
                        Update()
                    end))
                    
                    AddConnection(CConnect(UserInputService.InputEnded, function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 and Moving then
                            Moving = false
                        end
                    end))
                    
                    AddConnection(CConnect(Mouse.Move, Utils.Debounce(function()
                        if Moving then
                            Update()
                        end
                    end)))
                end
                
                ColorSliderInit()
                ColorCanvasInit()
                
                AddConnection(CConnect(Button.MouseButton1Click, function()
                    if not Opened then
                        Opened = true
                        UpdateColor()
                        RainbowToggle.Container.Switch.Position = Rainbow and UDim2New(1, -18, 0, 2) or UDim2.fromOffset(2, 2)
                        RainbowToggle.Container.BackgroundColor3 = Color3.fromRGB(25, 25, 25);
                        Overlay.Visible = true
                        OverlayMain.Visible = false
                        Utils.Intro(OverlayMain)
                    end
                end))
                
                AddConnection(CConnect(ClosePicker.MouseButton1Click, Utils.Debounce(function()
                    Button.BackgroundColor3 = CurrentColor
                    Utils.Intro(OverlayMain)
                    Overlay.Visible = false
                    Opened = false
                end)))
                
                AddConnection(CConnect(RedTextBox.FocusLost, function()
                    if Opened then
                        local Number = tonumber(RedTextBox.Text)
                        if Number then
                            Number = clamp(floor(Number), 0, 255)
                            CurrentColor = Color3New(Number / 255, CurrentColor.G, CurrentColor.B)
                            UpdateColor()
                            RedTextBox.PlaceholderText = tostring(Number)
                            Callback(CurrentColor)
                        end
                        RedTextBox.Text = ""
                    end
                end))
                
                AddConnection(CConnect(GreenTextBox.FocusLost, function()
                    if Opened then
                        local Number = tonumber(GreenTextBox.Text)
                        if Number then
                            Number = clamp(floor(Number), 0, 255)
                            CurrentColor = Color3New(CurrentColor.R, Number / 255, CurrentColor.B)
                            UpdateColor()
                            GreenTextBox.PlaceholderText = tostring(Number)
                            Callback(CurrentColor)
                        end
                        GreenTextBox.Text = ""
                    end
                end))
                
                AddConnection(CConnect(BlueTextBox.FocusLost, function()
                    if Opened then
                        local Number = tonumber(BlueTextBox.Text)
                        if Number then
                            Number = clamp(floor(Number), 0, 255)
                            CurrentColor = Color3New(CurrentColor.R, CurrentColor.G, Number / 255)
                            UpdateColor()
                            BlueTextBox.PlaceholderText = tostring(Number)
                            Callback(CurrentColor)
                        end
                        BlueTextBox.Text = ""
                    end
                end))
                
                Utils.ToggleFunction(RainbowToggle.Container, false, function(Callback)
                    if Opened then
                        Rainbow = Callback
                    end
                end)
                
                AddConnection(CConnect(RenderStepped, function()
                    if Rainbow then
                        local Hue = (tick() / 5) % 1
                        CurrentColor = Color3.fromHSV(Hue, S, V)
                        
                        if Opened then
                            UpdateHue(Hue)
                        end
                        
                        Button.BackgroundColor3 = CurrentColor
                        Callback(CurrentColor, true);
                    end
                end))
                                
                Button.BackgroundColor3 = DefaultColor
                SelectColor.Title.Text = Title
                SelectColor.Visible = true
                SelectColor.Parent = Section.Options
                Utils.Thing(SelectColor.Title);
            end

            return ElementLibrary
        end

        return PageLibrary
    end
end

Utils.Click(ConfigUI.Close, "TextColor3")
AddConnection(CConnect(ConfigUI.Close.MouseButton1Click, function()
    ConfigLoaded = false
    CWait(Utils.TweenAllTrans(ConfigUI, .25).Completed);
    ConfigUI.Visible = false
end))
--END IMPORT [uimore]


--IMPORT [plugin]
PluginConf = IsSupportedExploit and GetPluginConfig();
local Plugins;

PluginLibrary = {
    LocalPlayer = LocalPlayer,
    Services = Services,
    GetCharacter = GetCharacter,
    ProtectInstance = ProtectInstance,
    SpoofInstance = SpoofInstance,
    SpoofProperty = SpoofProperty,
    UnSpoofInstance = UnSpoofInstance,
    ReplaceCharacter = ReplaceCharacter,
    ReplaceHumanoid = ReplaceHumanoid,
    GetCorrectToolWithHandle = GetCorrectToolWithHandle,
    DisableAnimate = DisableAnimate,
    GetPlayer = GetPlayer,
    GetHumanoid = GetHumanoid,
    GetRoot = GetRoot,
    GetMagnitude = GetMagnitude,
    GetCommandEnv = function(Name)
        local Command = LoadCommand(Name);
        if (Command.CmdEnv) then
            return Command.CmdEnv
        end
    end,
    isR6 = isR6,
    ExecuteCommand = ExecuteCommand,
    Notify = Utils.Notify,
    HasTool = HasTool,
    isSat = isSat,
    Request = syn and syn.request or request or game.HttpGet,
    CThread = CThread,
    AddConnection = AddConnection,
    filter = filter,
    map = map,
    clone = clone,
    firetouchinterest = firetouchinterest,
    fireproximityprompt = fireproximityprompt,
    decompile = decompile,
    getnilinstances = getnilinstances,
    getinstances = getinstances,
    Drawing = Drawing
}

do
    local IsDebug = IsSupportedExploit and PluginConf.PluginDebug

    Plugins = IsSupportedExploit and map(filter(listfiles("fates-admin/plugins"), function(i, v)
        return lower(split(v, ".")[#split(v, ".")]) == "lua"
    end), function(i, v)
        local splitted = split(v, "\\");
        if (identifyexecutor and identifyexecutor() == "ScriptWare") then
            return {splitted[#splitted], loadfile("fates-admin/plugins/" .. v)}
        else
            return {splitted[#splitted], loadfile(v)}
        end
    end) or {}

    if (SafePlugins) then
        local Renv = clone(getrenv(), true);
        for i, v in next, Renv do
            PluginLibrary[i] = v
        end
    end
    PluginLibrary.debug = nil
    PluginLibrary.getfenv = nil
    PluginLibrary.loadstring = loadstring

    if (PluginConf.SafePlugins) then
        local Funcs = {}
        for i, v in next, PluginLibrary do
            if (type(v) == 'function') then
                Funcs[#Funcs + 1] = v
            end
        end
        local FateEnv = getfenv(1);
        PluginLibrary.getfenv = newcclosure(function(...)
            local f = ({...})[1]
            local Env = getfenv(...);
            if (type(f) == 'function' and Tfind(Funcs, f) or Env == FateEnv and checkcaller()) then
                return PluginLibrary
            end
            return Env
        end)
    end

    if (PluginConf.PluginsEnabled) then
        local LoadPlugin = function(Plugin)
            if (not IsSupportedExploit) then
                return 
            end
        
            if (Plugin and PluginConf.DisabledPlugins[Plugin.Name]) then
                Utils.Notify(LocalPlayer, "Plugin not loaded.", format("Plugin %s was not loaded as it is on the disabled list.", Plugin.Name));
                return "Disabled"
            end
            if (#keys(Plugin) < 3) then
                return Utils.Notify(LocalPlayer, "Plugin Fail", "One of your plugins is missing information.");
            end
            if (IsDebug) then
                Utils.Notify(LocalPlayer, "Plugin loading", format("Plugin %s is being loaded.", Plugin.Name));
            end
            
            local Context;
            local sett, gett = setthreadidentity, getthreadidentity
            if (sett and PluginConf.SafePlugins) then
                Context = gett();
                sett(5);
            end
            local Ran, Return = pcall(Plugin.Init);
            if (sett and Context) then
                sett(Context);
            end
            if (not Ran and Return and IsDebug) then
                return Utils.Notify(LocalPlayer, "Plugin Fail", format("there is an error in plugin Init %s: %s", Plugin.Name, Return));
            end
            
            for i, command in next, Plugin.Commands or {} do -- adding the "or" because some people might have outdated plugins in the dir
                if (#keys(command) < 3) then
                    Utils.Notify(LocalPlayer, "Plugin Command Fail", format("Command %s is missing information", command.Name));
                    continue
                end
                AddCommand(command.Name, command.Aliases or {}, command.Description .. " - " .. Plugin.Author, command.Requirements or {}, command.Func, true);
        
                if (FindFirstChild(Commands.Frame.List, command.Name)) then
                    Destroy(FindFirstChild(Commands.Frame.List, command.Name));
                end
                local Clone = Clone(Command);
                Utils.Hover(Clone, "BackgroundColor3");
                Utils.ToolTip(Clone, format("%s\n%s - %s", command.Name, command.Description, Plugin.Author));
                Clone.CommandText.RichText = true
                Clone.CommandText.Text = format("%s %s %s", command.Name, next(command.Aliases or {}) and format("(%s)", concat(command.Aliases, ", ")) or "", Utils.TextFont("[PLUGIN]", {77, 255, 255}));
                Clone.Name = command.Name
                Clone.Visible = true
                Clone.Parent = Commands.Frame.List
                if (IsDebug) then
                    Utils.Notify(LocalPlayer, "Plugin Command Loaded", format("Command %s loaded successfully", command.Name));
                end
            end
        end
        
        if (IsSupportedExploit) then
            if (not isfolder("fates-admin") and not isfolder("fates-admin/plugins") and not isfolder("fates-admin/plugin-conf.json") or not isfolder("fates-admin/chatlogs")) then
                WriteConfig();
            end
        end

        for i, Plugin in next, Plugins do
            local PluginFunc = Plugin[2]
            if (PluginConf.SafePlugins) then
                setfenv(PluginFunc, PluginLibrary);
            else
                local CurrentEnv = getfenv(PluginFunc);
                for i2, v2 in next, PluginLibrary do
                    CurrentEnv[i2] = v2
                end
            end
            local Success, Ret = pcall(PluginFunc);
            if (Success) then
                LoadPlugin(Ret);
            elseif (PluginConf.PluginDebug) then
                Utils.Notify(LocalPlayer, "Fail", "There was an error Loading plugin (console for more information)");
                warn("[FA Plugin Error]: " .. debug.traceback(Ret));             
            end
        end
        
        AddCommand("refreshplugins", {"rfp", "refreshp", "reloadp"}, "Loads all new plugins.", {}, function()
            if (not IsSupportedExploit) then
                return "your exploit does not support plugins"
            end
            PluginConf = GetPluginConfig();
            IsDebug = PluginConf.PluginDebug
            
            Plugins = map(filter(listfiles("fates-admin/plugins"), function(i, v)
                return lower(split(v, ".")[#split(v, ".")]) == "lua"
            end), function(i, v)
                return {split(v, "\\")[2], loadfile(v)}
            end)
            
            for i, Plugin in next, Plugins do
                local PluginFunc = Plugin[2]
                setfenv(PluginFunc, PluginLibrary);
                local Success, Ret = pcall(PluginFunc);
                if (Success) then
                    LoadPlugin(Ret);
                elseif (PluginConf.PluginDebug) then
                    Utils.Notify(LocalPlayer, "Fail", "There was an error Loading plugin (console for more information)");
                    warn("[FA Plugin Error]: " .. debug.traceback(Ret));             
                end
            end
        end)
    end
end
--END IMPORT [plugin]


WideBar = false
Draggable = false

--IMPORT [config]
do
    local UserInputService = Services.UserInputService
    local GetStringForKeyCode = UserInputService.GetStringForKeyCode
    local function GetKeyName(KeyCode)
        local _, Stringed = pcall(GetStringForKeyCode, UserInputService, KeyCode);
        local IsEnum = Stringed == ""
        return (not IsEnum and _) and Stringed or split(tostring(KeyCode), ".")[3], (IsEnum and not _);
    end

    local SortKeys = function(Key1, Key2)
        local KeyName, IsEnum = GetKeyName(Key1);
        if (Key2) then
            local KeyName2, IsEnum2 = GetKeyName(Key2);
            return format("%s + %s", IsEnum2 and KeyName2 or KeyName, IsEnum2 and KeyName2 or KeyName2);
        end
        return KeyName
    end

    LoadConfig = function()
        local Script = ConfigUILib.NewPage("Script");
        local Settings = Script.NewSection("Settings");
    
        local CurrentConf = GetConfig();

        Settings.TextboxKeybind("Chat Prefix", Prefix, function(Key)
            if (not match(Key, "%A") or match(Key, "%d") or #Key > 1) then
                Utils.Notify(nil, "Prefix", "Prefix must be a 1 character symbol.");
                return
            end
            Prefix = Key
            Utils.Notify(nil, "Prefix", "Prefix is now " .. Key);
        end)
    
        Settings.Keybind("CMDBar Prefix", GetKeyName(CommandBarPrefix), function(KeyCode1, KeyCode2)
            CommandBarPrefix = KeyCode1
            Utils.Notify(nil, "Prefix", "CommandBar Prefix is now " .. GetKeyName(KeyCode1));
        end)
    
        local ToggleSave;
        ToggleSave = Settings.Toggle("Save Prefix's", false, function(Callback)
            SetConfig({["Prefix"]=Prefix,["CommandBarPrefix"]=split(tostring(CommandBarPrefix), ".")[3]});
            wait(.5);
            ToggleSave();
            Utils.Notify(nil, "Prefix", "saved prefix's");
        end)
    
        local Misc = Script.NewSection("Misc");

        Misc.Toggle("Chat Prediction", CurrentConf.ChatPrediction or false, function(Callback)
            local ChatBar = ToggleChatPrediction();
            if (Callback) then
                ChatBar.CaptureFocus(ChatBar);
                wait();
                ChatBar.Text = Prefix
            end
            SetConfig({ChatPrediction=Callback});
            Utils.Notify(nil, nil, format("ChatPrediction %s", Callback and "enabled" or "disabled"));
        end)

        Misc.Toggle("Anti Kick", Hooks.AntiKick, function(Callback)
            Hooks.AntiKick = Callback
            Utils.Notify(nil, nil, format("AntiKick %s", Hooks.AntiKick and "enabled" or "disabled"));
        end)

        Misc.Toggle("Anti Teleport", Hooks.AntiTeleport, function(Callback)
            Hooks.AntiTeleport = Callback
            Utils.Notify(nil, nil, format("AntiTeleport %s", Hooks.AntiTeleport and "enabled" or "disabled"));
        end)

        Misc.Toggle("wide cmdbar", WideBar, function(Callback)
            WideBar = Callback
            if (not Draggable) then
                Utils.Tween(CommandBar, "Quint", "Out", .5, {
                    Position = UDim2.new(0.5, WideBar and -200 or -100, 1, 5) -- tween -110
                })
            end
            Utils.Tween(CommandBar, "Quint", "Out", .5, {
                Size = UDim2.new(0, WideBar and 400 or 200, 0, 35) -- tween -110
            })
            SetConfig({WideBar=Callback});
            Utils.Notify(nil, nil, format("widebar %s", WideBar and "enabled" or "disabled"));
        end)

        Misc.Toggle("draggable cmdbar", Draggable, function(Callback)
            Draggable = Callback
            CommandBarOpen = true
            Utils.Tween(CommandBar, "Quint", "Out", .5, {
                Position = UDim2.new(0, Mouse.X, 0, Mouse.Y + 36);
            })
            Utils.Draggable(CommandBar);
            local TransparencyTween = CommandBarOpen and Utils.TweenAllTransToObject or Utils.TweenAllTrans
            local Tween = TransparencyTween(CommandBar, .5, CommandBarTransparencyClone);
            CommandBar.Input.Text = ""
            if (not Callback) then
                Utils.Tween(CommandBar, "Quint", "Out", .5, {
                    Position = UDim2.new(0.5, WideBar and -200 or -100, 1, 5) -- tween 5
                })
            end
            Utils.Notify(nil, nil, format("draggable command bar %s", Draggable and "enabled" or "disabled"));
        end)

        Misc.Toggle("KillCam when killing", CurrentConf.KillCam, function(Callback)
            SetConfig({KillCam=Callback});
            _L.KillCam = Callback
        end)

        local OldFireTouchInterest = firetouchinterest
        Misc.Toggle("cframe touchinterest", firetouchinterest == nil, function(Callback)
            firetouchinterest = Callback and function(part1, part2, toggle)
                if (part1 and part2) then
                    if (toggle == 0) then
                        touched[1] = part1.CFrame
                        part1.CFrame = part2.CFrame
                    else
                        part1.CFrame = touched[1]
                        touched[1] = nil
                    end
                end
            end or OldFireTouchInterest
        end)

        local MacrosPage = ConfigUILib.NewPage("Macros");
        local MacroSection;
        MacroSection = MacrosPage.CreateMacroSection(Macros, function(Bind, Command, Args)
            local AlreadyAdded = false
            for i = 1, #Macros do
                if (Macros[i].Command == Command) then
                    AlreadyAdded = true
                end
            end
            if (CommandsTable[Command] and not AlreadyAdded) then
                MacroSection.AddMacro(Command .. " " .. Args, SortKeys(Bind[1], Bind[2]));
                Args = split(Args, " ");
                if (sub(Command, 1, 2) == "un" or CommandsTable["un" .. Command]) then
                    local Shifted = {Command, unpack(Args)}
                    Macros[#Macros + 1] = {
                        Command = "toggle",
                        Args = Shifted,
                        Keys = Bind
                    }
                else
                    Macros[#Macros + 1] = {
                        Command = Command,
                        Args = Args,
                        Keys = Bind
                    }
                end
                local TempMacros = clone(Macros);
                for i, v in next, TempMacros do
                    for i2, v2 in next, v.Keys do
                        TempMacros[i]["Keys"][i2] = split(tostring(v2), ".")[3]
                    end
                end
                SetConfig({Macros=TempMacros});
            end
        end)
        local UIListLayout = MacroSection.CommandsList.UIListLayout
        for i, v in next, CommandsTable do
            if (not FindFirstChild(MacroSection.CommandsList, v.Name)) then
                MacroSection.AddCmd(v.Name);
            end
        end
        MacroSection.CommandsList.CanvasSize = UDim2.fromOffset(0, UIListLayout.AbsoluteContentSize.Y);
        local Search = FindFirstChild(MacroSection.CommandsList.Parent.Parent, "Search");

        AddConnection(CConnect(GetPropertyChangedSignal(Search, "Text"), function()
            local Text = Search.Text
            for _, v in next, GetChildren(MacroSection.CommandsList) do
                if (IsA(v, "TextButton")) then
                    local Command = v.Text
                    v.Visible = Sfind(lower(Command), Text, 1, true)
                end
            end
            MacroSection.CommandsList.CanvasSize = UDim2.fromOffset(0, UIListLayout.AbsoluteContentSize.Y);
        end), Connections.UI, true);
        
        local PluginsPage = ConfigUILib.NewPage("Plugins");
        
        local CurrentPlugins = PluginsPage.NewSection("Current Plugins");
        local PluginSettings = PluginsPage.NewSection("Plugin Settings");
    
        local CurrentPluginConf = GetPluginConfig();
    
        CurrentPlugins.ScrollingFrame("plugins", function(Option, Enabled)
            CurrentPluginConf = GetPluginConfig();
            for i = 1, #Plugins do
                local Plugin = Plugins[i]
                if (Plugin[1] == Option) then
                    local DisabledPlugins = CurrentPluginConf.DisabledPlugins
                    local PluginName = Plugin[2]().Name
                    if (Enabled) then
                        DisabledPlugins[PluginName] = nil
                        SetPluginConfig({DisabledPlugins=DisabledPlugins});
                        Utils.Notify(nil, "Plugin Enabled", format("plugin %s successfully enabled", PluginName));
                    else
                        DisabledPlugins[PluginName] = true
                        SetPluginConfig({DisabledPlugins=DisabledPlugins});
                        Utils.Notify(nil, "Plugin Disabled", format("plugin %s successfully disabled", PluginName));
                    end
                end
            end
        end, map(Plugins, function(Key, Plugin)
            return not PluginConf.DisabledPlugins[Plugin[2]().Name], Plugin[1]
        end));
    
        PluginSettings.Toggle("Plugins Enabled", CurrentPluginConf.PluginsEnabled, function(Callback)
            SetPluginConfig({PluginsEnabled = Callback});
        end)

        PluginSettings.Toggle("Plugins Debug", CurrentPluginConf.PluginDebug, function(Callback)
            SetPluginConfig({PluginDebug = Callback});
        end)

        PluginSettings.Toggle("Safe Plugins", CurrentPluginConf.SafePlugins, function(Callback)
            SetPluginConfig({SafePlugins = Callback});
        end)

        local Themes = ConfigUILib.NewPage("Themes");

        local Color = Themes.NewSection("Colors");
        local Options = Themes.NewSection("Options");

        local RainbowEnabled = false
        Color.ColorPicker("All Background", UITheme.Background.BackgroundColor, function(Callback, IsRainbow)
            UITheme.Background.BackgroundColor = Callback
            RainbowEnabled = IsRainbow
        end)
        Color.ColorPicker("CommandBar", UITheme.CommandBar.BackgroundColor, function(Callback)
            if (not RainbowEnabled) then
                UITheme.CommandBar.BackgroundColor = Callback
            end
        end)
        Color.ColorPicker("Notification", UITheme.Notification.BackgroundColor, function(Callback)
            if (not RainbowEnabled) then
                UITheme.Notification.BackgroundColor = Callback
            end
        end)
        Color.ColorPicker("ChatLogs", UITheme.ChatLogs.BackgroundColor, function(Callback)
            if (not RainbowEnabled) then
                UITheme.ChatLogs.BackgroundColor = Callback
            end
        end)
        Color.ColorPicker("CommandList", UITheme.CommandList.BackgroundColor, function(Callback)
            if (not RainbowEnabled) then
                UITheme.CommandList.BackgroundColor = Callback
            end
        end)
        Color.ColorPicker("Config", UITheme.Config.BackgroundColor, function(Callback)
            if (not RainbowEnabled) then
                UITheme.Config.BackgroundColor = Callback
            end
        end)

        Color.ColorPicker("All Text", UITheme.Background.TextColor, function(Callback)
            UITheme.Background.TextColor = Callback
        end)

        local ToggleSave;
        ToggleSave = Options.Toggle("Save Theme", false, function(Callback)
            WriteThemeConfig();
            wait(.5);
            ToggleSave();
            Utils.Notify(nil, "Theme", "saved theme");
        end)

        local ToggleLoad;
        ToggleLoad = Options.Toggle("Load Theme", false, function(Callback)
            LoadTheme(GetThemeConfig());
            wait(.5);
            ToggleLoad();
            Utils.Notify(nil, "Theme", "Loaded theme");
        end)

        local ToggleReset;
        ToggleReset = Options.Toggle("Reset Theme", false, function(Callback)
            UITheme.Background.BackgroundColor = "Reset"
            UITheme.Notification.TextColor = "Reset"
            UITheme.CommandBar.TextColor = "Reset"
            UITheme.CommandList.TextColor = "Reset"
            UITheme.ChatLogs.TextColor = "Reset"
            UITheme.Config.TextColor = "Reset"
            UITheme.Notification.Transparency = "Reset"
            UITheme.CommandBar.Transparency = "Reset"
            UITheme.CommandList.Transparency = "Reset"
            UITheme.ChatLogs.Transparency = "Reset"
            UITheme.Config.Transparency = "Reset"
            wait(.5);
            ToggleReset();
            Utils.Notify(nil, "Theme", "reset theme");
        end)

    end

    delay(1, function()
        for i = 1, #Macros do
            local Macro = Macros[i]
            for i2 = 1, #Macro.Keys do
                Macros[i].Keys[i2] = Enum.KeyCode[Macros[i].Keys[i2]]
            end
        end
        if (CurrentConfig.WideBar) then
            WideBar = true
            Utils.Tween(CommandBar, "Quint", "Out", .5, {
                Size = UDim2.new(0, WideBar and 400 or 200, 0, 35) -- tween -110
            })
        end
        KillCam = CurrentConfig.KillCam
        local Aliases = CurrentConfig.Aliases
        if (Aliases) then
            for i, v in next, Aliases do
                if (CommandsTable[i]) then
                    for i2 = 1, #v do
                        local Alias = v[i2]
                        local Add = CommandsTable[i]
                        Add.Name = Alias
                        CommandsTable[Alias] = Add
                    end
                end
            end
        end
    end)
end
--END IMPORT [config]


AddConnection(CConnect(CommandBar.Input.FocusLost, function()
    local Text = trim(CommandBar.Input.Text);
    local CommandArgs = split(Text, " ");

    CommandBarOpen = false

    if (not Draggable) then
        Utils.TweenAllTrans(CommandBar, .5)
        Utils.Tween(CommandBar, "Quint", "Out", .5, {
            Position = UDim2.new(0.5, WideBar and -200 or -100, 1, 5); -- tween 5
        })
    end

    local Command = CommandArgs[1]
    local Args = shift(CommandArgs);

    if (Command ~= "") then
        ExecuteCommand(Command, Args, LocalPlayer);
    end
end), Connections.UI, true);

local PlayerAdded = function(plr)
    RespawnTimes[plr.Name] = tick();
    AddConnection(CConnect(plr.CharacterAdded, function()
        RespawnTimes[plr.Name] = tick();
    end));
end

forEach(GetPlayers(Players), function(i,v)
    PlayerAdded(v);
end);

AddConnection(CConnect(Players.PlayerAdded, function(plr)
    PlayerAdded(plr);
end))

AddConnection(CConnect(Players.PlayerRemoving, function(plr)
    if (Connections.Players[plr.Name]) then
        if (Connections.Players[plr.Name].ChatCon) then
            Disconnect(Connections.Players[plr.Name].ChatCon);
        end
        Connections.Players[plr.Name] = nil
    end
    if (RespawnTimes[plr.Name]) then
        RespawnTimes[plr.Name] = nil
    end
end))

getgenv().F_A = {
    Utils = Utils,
    PluginLibrary = PluginLibrary,
    GetConfig = GetConfig
}
