-- 每日新闻模组 Daily News Mod
GLOBAL.setmetatable(env, { __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end })

-- 新闻事件列表（30个不同的事件）
local NEWS_EVENTS = {
    {
        news = "【猪人节日】今天是猪人的盛大节日！所有猪人都非常友好，招募顺从度大幅提升！",
        effect = function(inst)
            -- 猪人友好度提升
            if inst.components.leader then
                inst.components.leader.loyaltyper_seconds = inst.components.leader.loyaltyper_seconds * 2
            end
        end,
        target = "pigman"
    },
    {
        news = "【兔人狂欢】兔人们今天格外活跃，移动速度提升，但攻击性也增强了！",
        effect = function(inst)
            if inst.components.locomotor then
                inst.components.locomotor.walkspeed = inst.components.locomotor.walkspeed * 1.3
            end
        end,
        target = "bunnyman"
    },
    {
        news = "【蜘蛛迁徙】蜘蛛们今天不会主动攻击，但蜘蛛巢穴生长速度加快！",
        effect = function(inst)
            if inst.components.combat then
                inst.components.combat:SetRetargetFunction(1, function() return nil end)
            end
        end,
        target = "spider"
    },
    {
        news = "【牛群暴躁】今天的牛群格外暴躁，即使不在发情期也容易被激怒！",
        effect = function(inst)
            if inst.components.combat then
                inst.components.combat:SetRetargetFunction(1, function(inst)
                    return FindEntity(inst, 10, function(guy)
                        return guy:HasTag("player")
                    end)
                end)
            end
        end,
        target = "beefalo"
    },
    {
        news = "【蜜蜂罢工】蜜蜂们今天拒绝工作，蜂箱不会产出蜂蜜，但也不会攻击！",
        effect = function(inst)
            if inst.components.childspawner then
                inst.components.childspawner.childreninside = 0
            end
        end,
        target = "beebox"
    },
    {
        news = "【鸟类迁徙】今天会有大量鸟类飞过，捕鸟陷阱效率翻倍！",
        effect = function(inst)
            if inst.components.trap then
                inst.components.trap.targettag = "bird"
            end
        end,
        target = "birdtrap"
    },
    {
        news = "【植物生长日】所有农作物今天生长速度加快50%！",
        effect = function(inst)
            if inst.components.growable then
                inst.components.growable.targettime = inst.components.growable.targettime * 0.5
            end
        end,
        target = "plant"
    },
    {
        news = "【矿石丰收】今天开采矿石有概率获得双倍产出！",
        effect = function(inst)
            if inst.components.workable and inst.components.lootdropper then
                local old_onfinish = inst.components.workable.onfinish
                inst.components.workable:SetOnFinishCallback(function(inst, worker)
                    if math.random() < 0.5 then
                        inst.components.lootdropper:DropLoot()
                    end
                    if old_onfinish then old_onfinish(inst, worker) end
                end)
            end
        end,
        target = "rock"
    },
    {
        news = "【树木繁茂】今天砍树有额外概率掉落树枝和松果！",
        effect = function(inst)
            if inst.components.lootdropper then
                inst.components.lootdropper:AddChanceLoot("twigs", 0.5)
                inst.components.lootdropper:AddChanceLoot("pinecone", 0.3)
            end
        end,
        target = "tree"
    },
    {
        news = "【猎犬休息日】今天猎犬不会主动来袭，可以安心发展！",
        effect = function()
            -- 禁用猎犬袭击
            if TheWorld.components.hounded then
                TheWorld.components.hounded:ForceStop()
            end
        end,
        target = "world"
    },
    {
        news = "【青蛙雨季】今天下雨时会有大量青蛙出现！",
        effect = function()
            if TheWorld.state.israining then
                local x, y, z = TheSim:FindFirstEntityWithTag("player"):GetPosition():Get()
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
    {
        news = "【蘑菇繁殖】今天所有蘑菇采摘后会立即重新生长！",
        effect = function(inst)
            if inst.components.pickable then
                inst.components.pickable.cycles_left = 999
            end
        end,
        target = "mushroom"
    },
    {
        news = "【幽灵活跃】今天晚上幽灵出现频率增加，但掉落物品更丰富！",
        effect = function(inst)
            if inst.components.lootdropper then
                inst.components.lootdropper:AddChanceLoot("nightmarefuel", 1.0)
            end
        end,
        target = "ghost"
    },
    {
        news = "【食物保鲜】今天所有食物腐烂速度减半！",
        effect = function(inst)
            if inst.components.perishable then
                inst.components.perishable:SetPerishTime(inst.components.perishable:GetPercent() * 2)
            end
        end,
        target = "food"
    },
    {
        news = "【火焰节】今天所有火源燃烧时间延长，但更容易引发火灾！",
        effect = function(inst)
            if inst.components.fueled then
                inst.components.fueled.maxfuel = inst.components.fueled.maxfuel * 1.5
            end
        end,
        target = "fire"
    },
    {
        news = "【冰冻之日】今天温度下降，但冰箱保鲜效果提升！",
        effect = function()
            if TheWorld.components.temperature then
                TheWorld.components.temperature:SetTemperature(TheWorld.components.temperature:GetCurrent() - 10)
            end
        end,
        target = "world"
    },
    {
        news = "【鱼群聚集】今天钓鱼效率大幅提升，更容易钓到稀有鱼类！",
        effect = function(inst)
            if inst.components.fishable then
                inst.components.fishable.maxfish = inst.components.fishable.maxfish * 2
            end
        end,
        target = "pond"
    },
    {
        news = "【蝴蝶漫舞】今天会有大量蝴蝶出现，捕捉它们可以获得更多花瓣！",
        effect = function()
            local x, y, z = TheSim:FindFirstEntityWithTag("player"):GetPosition():Get()
            for i = 1, 15 do
                local butterfly = SpawnPrefab("butterfly")
                if butterfly then
                    butterfly.Transform:SetPosition(x + math.random(-15, 15), 0, z + math.random(-15, 15))
                end
            end
        end,
        target = "world"
    },
    {
        news = "【机械降临】今天发条生物更加活跃，但掉落的齿轮数量增加！",
        effect = function(inst)
            if inst.components.lootdropper then
                inst.components.lootdropper:AddChanceLoot("gears", 0.8)
            end
        end,
        target = "knight"
    },
    {
        news = "【蜘蛛女王】今天有更高概率遇到蜘蛛女王，击败她获得丰厚奖励！",
        effect = function()
            local x, y, z = TheSim:FindFirstEntityWithTag("player"):GetPosition():Get()
            local queen = SpawnPrefab("spiderqueen")
            if queen then
                queen.Transform:SetPosition(x + math.random(-30, 30), 0, z + math.random(-30, 30))
            end
        end,
        target = "world"
    },
    {
        news = "【精神焕发】今天所有玩家精神值恢复速度提升！",
        effect = function(inst)
            if inst.components.sanity then
                inst.components.sanity.dapperness = inst.components.sanity.dapperness + 0.1
            end
        end,
        target = "player"
    },
    {
        news = "【饥饿减缓】今天所有玩家饥饿速度降低！",
        effect = function(inst)
            if inst.components.hunger then
                inst.components.hunger.hungerrate = inst.components.hunger.hungerrate * 0.7
            end
        end,
        target = "player"
    },
    {
        news = "【生命旺盛】今天所有玩家生命恢复速度提升！",
        effect = function(inst)
            if inst.components.health then
                inst.components.health.absorb = 0.1
            end
        end,
        target = "player"
    },
    {
        news = "【工具耐久】今天所有工具耐久消耗减半！",
        effect = function(inst)
            if inst.components.finiteuses then
                inst.components.finiteuses:SetPercent(1.0)
            end
        end,
        target = "tool"
    },
    {
        news = "【暗影之力】今天制作暗影物品不消耗精神值！",
        effect = function(inst)
            if inst.components.sanity then
                inst.components.sanity.no_moisture_penalty = true
            end
        end,
        target = "player"
    },
    {
        news = "【Boss狂暴】今天所有Boss攻击力提升，但掉落物品翻倍！",
        effect = function(inst)
            if inst.components.combat then
                inst.components.combat.damagemultiplier = 1.5
            end
            if inst.components.lootdropper then
                inst.components.lootdropper.numrandomloot = inst.components.lootdropper.numrandomloot * 2
            end
        end,
        target = "boss"
    },
    {
        news = "【月圆之夜】今天晚上月光格外明亮，夜间视野提升！",
        effect = function()
            if TheWorld.state.isnight then
                TheWorld:PushEvent("ms_setseason", "spring")
            end
        end,
        target = "world"
    },
    {
        news = "【商人到访】今天猪猪国王收购价格提升50%！",
        effect = function(inst)
            if inst.components.trader then
                inst.components.trader.goldvalue = inst.components.trader.goldvalue * 1.5
            end
        end,
        target = "pigking"
    },
    {
        news = "【魔法涌动】今天使用魔法物品消耗减少！",
        effect = function(inst)
            if inst.components.fueled and inst:HasTag("magic") then
                inst.components.fueled.rate = inst.components.fueled.rate * 0.5
            end
        end,
        target = "magic"
    },
    {
        news = "【和平之日】今天所有生物都不会主动攻击，享受宁静的一天吧！",
        effect = function(inst)
            if inst.components.combat then
                inst.components.combat:SetRetargetFunction(1, function() return nil end)
            end
        end,
        target = "monster"
    }
}

-- 当前激活的事件
local current_events = {}
local last_day = -1

-- 随机选择三个事件
local function SelectDailyEvents()
    local selected = {}
    local available = {}
    
    for i, event in ipairs(NEWS_EVENTS) do
        table.insert(available, i)
    end
    
    -- 随机选择3个不同的事件
    for i = 1, 3 do
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
    if event.target == "world" then
        if event.effect then
            event.effect()
        end
    else
        -- 对特定类型的实体应用效果
        for k, v in pairs(Ents) do
            if v:HasTag(event.target) then
                if event.effect then
                    event.effect(v)
                end
            end
        end
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
            AnnounceNews("========== 📰 每日新闻 Daily News 📰 ==========")
            
            for i, event in ipairs(current_events) do
                TheWorld:DoTaskInTime(i * 2, function()
                    AnnounceNews(string.format("【新闻 %d】%s", i, event.news))
                    ApplyEventEffects(event)
                end)
            end
            
            TheWorld:DoTaskInTime(8, function()
                AnnounceNews("==========================================")
            end)
        end)
    end
end

-- 添加世界组件监听
AddPrefabPostInit("world", function(inst)
    if not TheWorld.ismastersim then return end
    
    -- 每30秒检查一次
    inst:DoPeriodicTask(30, CheckDailyNews)
    
    -- 立即检查一次
    inst:DoTaskInTime(5, CheckDailyNews)
end)

print("每日新闻模组已加载！Daily News Mod Loaded!")
