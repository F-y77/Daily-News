-- 每日新闻模组 Daily News Mod
GLOBAL.setmetatable(env, { __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end })

-- 获取配置（使用安全的方式）
local EVENT_COUNT = 1
local NEWS_STYLE = "formal"

-- 延迟获取配置，避免崩溃
local function GetConfig()
    EVENT_COUNT = GetModConfigData("event_count") or 1
    NEWS_STYLE = GetModConfigData("news_style") or "formal"
end

-- 新闻事件列表（精简到真正有效的事件）
local NEWS_EVENTS = {
    -- 1. 生物生成类（立即生效，简单有效）
    {
        news = {
            formal = "【青蛙雨季】今天会有大量青蛙出现！",
            playful = "【呱呱来袭】青蛙大军从天而降，呱呱呱呱呱！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 10 do
                    local frog = SpawnPrefab("frog")
                    if frog then
                        frog.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    
    -- 2. 蝴蝶生成
    {
        news = {
            formal = "【蝴蝶漫舞】今天会有大量蝴蝶出现！",
            playful = "【蝴蝶满天飞】哇！到处都是小蝴蝶，抓蝴蝶抓到眼花缭乱！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 15 do
                    local butterfly = SpawnPrefab("butterfly")
                    if butterfly then
                        butterfly.Transform:SetPosition(x + math.random(-15, 15), 0, z + math.random(-15, 15))
                    end
                end
            end
        end,
        target = "world"
    },
    
    -- 3. 火鸡生成
    {
        news = {
            formal = "【火鸡盛宴】今天火鸡出现数量大幅增加！",
            playful = "【火鸡满地跑】今天到处都是火鸡，抓都抓不完，大丰收！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 12 do
                    local gobbler = SpawnPrefab("perd")
                    if gobbler then
                        gobbler.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    
    -- 4. 企鹅生成
    {
        news = {
            formal = "【企鹅聚会】今天企鹅出现数量增加！",
            playful = "【企鹅开会】企鹅们今天开大会，到处都是企鹅蛋！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 8 do
                    local penguin = SpawnPrefab("penguin")
                    if penguin then
                        penguin.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    
    -- 5. 花朵生成
    {
        news = {
            formal = "【花朵盛开】今天地图上会生成大量花朵！",
            playful = "【花花世界】今天到处都开满了花，美得像花园！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 20 do
                    local flower = SpawnPrefab("flower")
                    if flower then
                        flower.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                    end
                end
            end
        end,
        target = "world"
    },
    
    -- 6. 燧石生成
    {
        news = {
            formal = "【燧石富矿】今天地面上会生成更多燧石！",
            playful = "【石头遍地】今天到处都是燧石，捡都捡不完！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 15 do
                    local flint = SpawnPrefab("flint")
                    if flint then
                        flint.Transform:SetPosition(x + math.random(-30, 30), 0, z + math.random(-30, 30))
                    end
                end
            end
        end,
        target = "world"
    },
    
    -- 7. 树枝生成
    {
        news = {
            formal = "【树枝丰收】今天地面上会生成更多树枝！",
            playful = "【树枝满地】今天到处都是树枝，捡到手软！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 15 do
                    local twig = SpawnPrefab("twigs")
                    if twig then
                        twig.Transform:SetPosition(x + math.random(-30, 30), 0, z + math.random(-30, 30))
                    end
                end
            end
        end,
        target = "world"
    },
    
    -- 8. 草生成
    {
        news = {
            formal = "【草木繁盛】今天地面上会生成更多草！",
            playful = "【草草超多】今天到处都是草，采都采不完！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 15 do
                    local grass = SpawnPrefab("cutgrass")
                    if grass then
                        grass.Transform:SetPosition(x + math.random(-30, 30), 0, z + math.random(-30, 30))
                    end
                end
            end
        end,
        target = "world"
    },
    
    -- 9. 浆果生成
    {
        news = {
            formal = "【浆果丰收】今天地面上会生成更多浆果！",
            playful = "【浆果爆棚】今天到处都是浆果，吃都吃不完！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 12 do
                    local berry = SpawnPrefab("berries")
                    if berry then
                        berry.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                    end
                end
            end
        end,
        target = "world"
    },
    
    -- 10. 胡萝卜生成
    {
        news = {
            formal = "【胡萝卜丰收】今天地面上会生成更多胡萝卜！",
            playful = "【胡萝卜大丰收】今天到处都是胡萝卜，兔兔都吃不完！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 10 do
                    local carrot = SpawnPrefab("carrot")
                    if carrot then
                        carrot.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                    end
                end
            end
        end,
        target = "world"
    },
}

-- 当前激活的事件
local current_events = {}
local last_day = -1

-- 随机选择指定数量的事件
local function SelectDailyEvents()
    local selected = {}
    local available = {}
    
    for i, event in ipairs(NEWS_EVENTS) do
        table.insert(available, i)
    end
    
    -- 随机选择EVENT_COUNT个不同的事件
    for i = 1, math.min(EVENT_COUNT, #available) do
        if #available > 0 then
            local index = math.random(1, #available)
            table.insert(selected, NEWS_EVENTS[available[index]])
            table.remove(available, index)
        end
    end
    
    return selected
end

-- 在聊天框显示新闻
local function AnnounceNews(news_text)
    if TheWorld.ismastersim then
        TheNet:Announce(news_text)
    end
end

-- 应用事件效果
local function ApplyEventEffects(event)
    if event.effect then
        event.effect()
    end
end

-- 获取新闻文本（根据风格）
local function GetNewsText(event)
    if type(event.news) == "table" then
        return event.news[NEWS_STYLE] or event.news.formal
    else
        return event.news
    end
end

-- 检查并触发每日新闻
local function CheckDailyNews()
    if not TheWorld.ismastersim then return end
    
    local current_day = TheWorld.state.cycles
    
    -- 新的一天开始
    if current_day ~= last_day and TheWorld.state.isday then
        last_day = current_day
        current_events = SelectDailyEvents()
        
        -- 延迟几秒后播报新闻
        TheWorld:DoTaskInTime(3, function()
            AnnounceNews("==========   每日新闻 Daily News   ==========")
            
            for i, event in ipairs(current_events) do
                TheWorld:DoTaskInTime(i * 2, function()
                    local news_text = GetNewsText(event)
                    AnnounceNews(string.format("【新闻 %d】%s", i, news_text))
                    ApplyEventEffects(event)
                end)
            end
            
            TheWorld:DoTaskInTime((#current_events + 1) * 2, function()
                AnnounceNews("==========================================")
            end)
        end)
    end
end

-- 添加世界组件监听
AddPrefabPostInit("world", function(inst)
    if not TheWorld.ismastersim then return end
    
    -- 获取配置
    GetConfig()
    
    -- 每30秒检查一次
    inst:DoPeriodicTask(30, CheckDailyNews)
    
    -- 立即检查一次
    inst:DoTaskInTime(5, CheckDailyNews)
end)

print("每日新闻模组已加载！Daily News Mod Loaded!")
