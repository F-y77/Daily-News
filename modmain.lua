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

-- 新闻事件列表（50个不同的事件）
local NEWS_EVENTS = {
    {
        news = {
            formal = "【猪人节日】今天是猪人的盛大节日！所有猪人都非常友好，招募顺从度大幅提升！",
            playful = "【猪猪狂欢】哇哦！猪猪们今天心情超好，给根胡萝卜就能当你小弟啦~"
        },
        effect = function(inst)
            if inst.components.leader then
                inst.components.leader.loyaltyper_seconds = inst.components.leader.loyaltyper_seconds * 2
            end
        end,
        target = "pigman"
    },
    {
        news = {
            formal = "【兔人狂欢】兔人们今天格外活跃，移动速度提升，但攻击性也增强了！",
            playful = "【兔兔暴走】兔兔们今天嗑了胡萝卜素，跑得贼快但脾气也变差了喔！"
        },
        effect = function(inst)
            if inst.components.locomotor then
                inst.components.locomotor.walkspeed = inst.components.locomotor.walkspeed * 1.3
            end
        end,
        target = "bunnyman"
    },
    {
        news = {
            formal = "【蜘蛛迁徙】蜘蛛们今天不会主动攻击，但蜘蛛巢穴生长速度加快！",
            playful = "【蜘蛛搬家】八脚怪们今天忙着搬家，没空理你，但窝越长越大啦！"
        },
        effect = function(inst)
            if inst.components.combat then
                inst.components.combat:SetRetargetFunction(1, function() return nil end)
            end
        end,
        target = "spider"
    },
    {
        news = {
            formal = "【牛群暴躁】今天的牛群格外暴躁，即使不在发情期也容易被激怒！",
            playful = "【牛牛起床气】牛牛们今天起床气超大，别惹它们，会被顶飞哦！"
        },
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
        news = {
            formal = "【蜜蜂罢工】蜜蜂们今天拒绝工作，蜂箱不会产出蜂蜜，但也不会攻击！",
            playful = "【蜜蜂摆烂】小蜜蜂今天集体躺平，不产蜜也不蜇人，佛系养生中~"
        },
        effect = function(inst)
            if inst.components.childspawner then
                inst.components.childspawner.childreninside = 0
            end
        end,
        target = "beebox"
    },
    {
        news = {
            formal = "【鸟类迁徙】今天会有大量鸟类飞过，捕鸟陷阱效率翻倍！",
            playful = "【鸟鸟大军】天上全是小鸟飞，陷阱都不够用啦，抓鸟抓到手软！"
        },
        effect = function(inst)
            if inst.components.trap then
                inst.components.trap.targettag = "bird"
            end
        end,
        target = "birdtrap"
    },
    {
        news = {
            formal = "【植物生长日】所有农作物今天生长速度加快50%！",
            playful = "【植物打鸡血】农作物今天嗑了化肥，嗖嗖嗖长得飞快！"
        },
        effect = function(inst)
            if inst.components.growable then
                inst.components.growable.targettime = inst.components.growable.targettime * 0.5
            end
        end,
        target = "plant"
    },
    {
        news = {
            formal = "【矿石丰收】今天开采矿石有概率获得双倍产出！",
            playful = "【石头买一送一】今天挖矿手气爆棚，石头都是买一送一哦耶！"
        },
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
        news = {
            formal = "【树木繁茂】今天砍树有额外概率掉落树枝和松果！",
            playful = "【树树大方】树树们今天超大方，砍一棵送树枝送松果，血赚！"
        },
        effect = function(inst)
            if inst.components.lootdropper then
                inst.components.lootdropper:AddChanceLoot("twigs", 0.5)
                inst.components.lootdropper:AddChanceLoot("pinecone", 0.3)
            end
        end,
        target = "tree"
    },
    {
        news = {
            formal = "【猎犬休息日】今天猎犬不会主动来袭，可以安心发展！",
            playful = "【狗狗放假】汪星人今天集体请假，终于可以安心种田啦！"
        },
        effect = function()
            if TheWorld.components.hounded then
                TheWorld.components.hounded:ForceStop()
            end
        end,
        target = "world"
    },
    {
        news = {
            formal = "【青蛙雨季】今天下雨时会有大量青蛙出现！",
            playful = "【呱呱来袭】下雨啦！青蛙大军从天而降，呱呱呱呱呱！"
        },
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
        news = {
            formal = "【蘑菇繁殖】今天所有蘑菇采摘后会立即重新生长！",
            playful = "【蘑菇无限】蘑菇今天开挂了，摘了又长，永远摘不完！"
        },
        effect = function(inst)
            if inst.components.pickable then
                inst.components.pickable.cycles_left = 999
            end
        end,
        target = "mushroom"
    },
    {
        news = {
            formal = "【幽灵活跃】今天晚上幽灵出现频率增加，但掉落物品更丰富！",
            playful = "【鬼鬼派对】今晚幽灵开派对，虽然吓人但送的礼物超多哦！"
        },
        effect = function(inst)
            if inst.components.lootdropper then
                inst.components.lootdropper:AddChanceLoot("nightmarefuel", 1.0)
            end
        end,
        target = "ghost"
    },
    {
        news = {
            formal = "【食物保鲜】今天所有食物腐烂速度减半！",
            playful = "【食物冻龄】食物今天抹了防腐剂，坏得超慢，囤货好时机！"
        },
        effect = function(inst)
            if inst.components.perishable then
                inst.components.perishable:SetPerishTime(inst.components.perishable:GetPercent() * 2)
            end
        end,
        target = "food"
    },
    {
        news = {
            formal = "【火焰节】今天所有火源燃烧时间延长，但更容易引发火灾！",
            playful = "【火火旺盛】火今天烧得特别旺，省燃料但小心别烧家哦！"
        },
        effect = function(inst)
            if inst.components.fueled then
                inst.components.fueled.maxfuel = inst.components.fueled.maxfuel * 1.5
            end
        end,
        target = "fire"
    },
    {
        news = {
            formal = "【冰冻之日】今天温度下降，但冰箱保鲜效果提升！",
            playful = "【冰冰凉凉】今天冷得像冰箱，不过冰箱效果变超强啦！"
        },
        effect = function()
            if TheWorld.components.temperature then
                TheWorld.components.temperature:SetTemperature(TheWorld.components.temperature:GetCurrent() - 10)
            end
        end,
        target = "world"
    },
    {
        news = {
            formal = "【鱼群聚集】今天钓鱼效率大幅提升，更容易钓到稀有鱼类！",
            playful = "【鱼鱼扎堆】鱼儿今天开大会，随便钓都是大丰收，欧皇附体！"
        },
        effect = function(inst)
            if inst.components.fishable then
                inst.components.fishable.maxfish = inst.components.fishable.maxfish * 2
            end
        end,
        target = "pond"
    },
    {
        news = {
            formal = "【蝴蝶漫舞】今天会有大量蝴蝶出现，捕捉它们可以获得更多花瓣！",
            playful = "【蝴蝶满天飞】哇！到处都是小蝴蝶，抓蝴蝶抓到眼花缭乱！"
        },
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
        news = {
            formal = "【机械降临】今天发条生物更加活跃，但掉落的齿轮数量增加！",
            playful = "【机器人暴动】发条怪今天特别嚣张，不过打爆它们齿轮掉一地！"
        },
        effect = function(inst)
            if inst.components.lootdropper then
                inst.components.lootdropper:AddChanceLoot("gears", 0.8)
            end
        end,
        target = "knight"
    },
    {
        news = {
            formal = "【蜘蛛女王】今天有更高概率遇到蜘蛛女王，击败她获得丰厚奖励！",
            playful = "【女王驾到】蜘蛛女王今天出门逛街，打败她能抢到好多宝贝！"
        },
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
        news = {
            formal = "【精神焕发】今天所有玩家精神值恢复速度提升！",
            playful = "【心情美丽】今天心情超好，精神值蹭蹭蹭往上涨！"
        },
        effect = function(inst)
            if inst.components.sanity then
                inst.components.sanity.dapperness = inst.components.sanity.dapperness + 0.1
            end
        end,
        target = "player"
    },
    {
        news = {
            formal = "【饥饿减缓】今天所有玩家饥饿速度降低！",
            playful = "【吃饱饱】今天特别耐饿，一顿饭能顶三顿，省粮食啦！"
        },
        effect = function(inst)
            if inst.components.hunger then
                inst.components.hunger.hungerrate = inst.components.hunger.hungerrate * 0.7
            end
        end,
        target = "player"
    },
    {
        news = {
            formal = "【生命旺盛】今天所有玩家生命恢复速度提升！",
            playful = "【血条回春】今天身体倍儿棒，血量恢复快得像开挂！"
        },
        effect = function(inst)
            if inst.components.health then
                inst.components.health.absorb = 0.1
            end
        end,
        target = "player"
    },
    {
        news = {
            formal = "【工具耐久】今天所有工具耐久消耗减半！",
            playful = "【工具超耐用】工具今天质量爆表，用多久都不会坏！"
        },
        effect = function(inst)
            if inst.components.finiteuses then
                inst.components.finiteuses:SetPercent(1.0)
            end
        end,
        target = "tool"
    },
    {
        news = {
            formal = "【暗影之力】今天制作暗影物品不消耗精神值！",
            playful = "【暗影免费】暗影装备今天免费做，不掉san值，冲冲冲！"
        },
        effect = function(inst)
            if inst.components.sanity then
                inst.components.sanity.no_moisture_penalty = true
            end
        end,
        target = "player"
    },
    {
        news = {
            formal = "【Boss狂暴】今天所有Boss攻击力提升，但掉落物品翻倍！",
            playful = "【Boss发飙】Boss今天超凶，不过打死它们掉落翻倍，值了！"
        },
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
        news = {
            formal = "【月圆之夜】今天晚上月光格外明亮，夜间视野提升！",
            playful = "【月亮超亮】今晚月亮像探照灯，晚上也能看得清清楚楚！"
        },
        effect = function()
            if TheWorld.state.isnight then
                TheWorld:PushEvent("ms_setseason", "spring")
            end
        end,
        target = "world"
    },
    {
        news = {
            formal = "【商人到访】今天猪猪国王收购价格提升50%！",
            playful = "【国王撒币】猪猪国王今天心情好，收购价格涨涨涨，发财啦！"
        },
        effect = function(inst)
            if inst.components.trader then
                inst.components.trader.goldvalue = inst.components.trader.goldvalue * 1.5
            end
        end,
        target = "pigking"
    },
    {
        news = {
            formal = "【魔法涌动】今天使用魔法物品消耗减少！",
            playful = "【魔法省电】魔法装备今天超省，用一次顶两次，赚翻了！"
        },
        effect = function(inst)
            if inst.components.fueled and inst:HasTag("magic") then
                inst.components.fueled.rate = inst.components.fueled.rate * 0.5
            end
        end,
        target = "magic"
    },
    {
        news = {
            formal = "【和平之日】今天所有生物都不会主动攻击，享受宁静的一天吧！",
            playful = "【世界和平】今天大家都是好朋友，没人打架，岁月静好~"
        },
        effect = function(inst)
            if inst.components.combat then
                inst.components.combat:SetRetargetFunction(1, function() return nil end)
            end
        end,
        target = "monster"
    },
    {
        news = {
            formal = "【闪电风暴】今天更容易遭受雷击，但被雷击后获得短暂加速效果！",
            playful = "【天雷滚滚】今天老天爷特别爱劈人，不过被劈了跑得贼快哈哈！"
        },
        effect = function()
            if TheWorld.components.weather then
                TheWorld.components.weather:SetPrecipitationRate(1.0)
            end
        end,
        target = "world"
    },
    {
        news = {
            formal = "【海象迁徙】今天海象营地出现概率增加，击败它们获得更多战利品！",
            playful = "【海象大军】海象们今天组团出门，打败它们能抢到好多宝贝！"
        },
        effect = function()
            local x, y, z = TheSim:FindFirstEntityWithTag("player"):GetPosition():Get()
            local walrus = SpawnPrefab("walrus")
            if walrus then
                walrus.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
            end
        end,
        target = "world"
    },
    {
        news = {
            formal = "【坎普斯警告】今天更容易招来坎普斯，请注意你的顽皮值！",
            playful = "【小偷来了】坎普斯今天特别勤快，别做坏事哦，不然来偷你家！"
        },
        effect = function(inst)
            if inst.components.combat then
                inst.components.combat.playerdamagepercent = 1.2
            end
        end,
        target = "krampus"
    },
    {
        news = {
            formal = "【巨鹿降临】今天有更高概率遇到巨鹿，做好战斗准备！",
            playful = "【大鹿来啦】巨鹿今天要来拆家，赶紧准备武器迎战吧！"
        },
        effect = function()
            if TheWorld.components.deerherdspawner then
                TheWorld.components.deerherdspawner:ReleaseDeerherd()
            end
        end,
        target = "world"
    },
    {
        news = {
            formal = "【蜂王出巢】今天蜂王更加活跃，但掉落的蜂蜜和蜂巢数量增加！",
            playful = "【蜂王暴走】蜂王今天出来散步，打败它蜂蜜多到吃不完！"
        },
        effect = function(inst)
            if inst.components.lootdropper then
                inst.components.lootdropper:AddChanceLoot("honey", 1.0)
                inst.components.lootdropper:AddChanceLoot("honeycomb", 0.8)
            end
        end,
        target = "beequeen"
    },
    {
        news = {
            formal = "【龙蝇苏醒】今天龙蝇更容易被激怒，但掉落的鳞片数量翻倍！",
            playful = "【大虫子醒了】龙蝇今天起床气超大，不过打死它鳞片掉一堆！"
        },
        effect = function(inst)
            if inst.components.lootdropper then
                inst.components.lootdropper:AddChanceLoot("dragon_scales", 1.0)
            end
        end,
        target = "dragonfly"
    },
    {
        news = {
            formal = "【熊獾狂暴】今天熊獾攻击力提升，但掉落的厚毛皮数量增加！",
            playful = "【熊熊发怒】熊獾今天超凶，不过毛皮掉得多，值得一战！"
        },
        effect = function(inst)
            if inst.components.lootdropper then
                inst.components.lootdropper:AddChanceLoot("bearger_fur", 1.0)
            end
        end,
        target = "bearger"
    },
    {
        news = {
            formal = "【鹿角怪出没】今天鹿角怪出现概率增加，击败它获得丰厚奖励！",
            playful = "【独眼怪来了】鹿角怪今天到处乱逛，打败它能拿到好东西！"
        },
        effect = function()
            local x, y, z = TheSim:FindFirstEntityWithTag("player"):GetPosition():Get()
            local deerclops = SpawnPrefab("deerclops")
            if deerclops then
                deerclops.Transform:SetPosition(x + math.random(-30, 30), 0, z + math.random(-30, 30))
            end
        end,
        target = "world"
    },
    {
        news = {
            formal = "【鼹鼠活跃】今天鼹鼠出现频率增加，小心你的农作物！",
            playful = "【鼹鼠偷菜】鼹鼠今天特别饿，到处偷菜，快保护你的农场！"
        },
        effect = function()
            local x, y, z = TheSim:FindFirstEntityWithTag("player"):GetPosition():Get()
            for i = 1, 5 do
                local mole = SpawnPrefab("mole")
                if mole then
                    mole.Transform:SetPosition(x + math.random(-15, 15), 0, z + math.random(-15, 15))
                end
            end
        end,
        target = "world"
    },
    {
        news = {
            formal = "【企鹅聚会】今天企鹅出现数量增加，它们会留下更多的蛋！",
            playful = "【企鹅开会】企鹅们今天开大会，到处都是企鹅蛋，捡到手软！"
        },
        effect = function()
            local x, y, z = TheSim:FindFirstEntityWithTag("player"):GetPosition():Get()
            for i = 1, 8 do
                local penguin = SpawnPrefab("penguin")
                if penguin then
                    penguin.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                end
            end
        end,
        target = "world"
    },
    {
        news = {
            formal = "【火鸡盛宴】今天火鸡出现数量大幅增加，狩猎好时机！",
            playful = "【火鸡满地跑】今天到处都是火鸡，抓都抓不完，大丰收！"
        },
        effect = function()
            local x, y, z = TheSim:FindFirstEntityWithTag("player"):GetPosition():Get()
            for i = 1, 12 do
                local gobbler = SpawnPrefab("perd")
                if gobbler then
                    gobbler.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                end
            end
        end,
        target = "world"
    },
    {
        news = {
            formal = "【高脚鸟繁殖】今天高脚鸟巢穴数量增加，可以获得更多高脚鸟蛋！",
            playful = "【大鸟下蛋】高脚鸟今天疯狂下蛋，到处都是鸟蛋，发财啦！"
        },
        effect = function()
            local x, y, z = TheSim:FindFirstEntityWithTag("player"):GetPosition():Get()
            for i = 1, 5 do
                local tallbird = SpawnPrefab("tallbird")
                if tallbird then
                    tallbird.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                end
            end
        end,
        target = "world"
    },
    {
        news = {
            formal = "【浆果丰收】今天所有浆果丛产量翻倍，采集效率大幅提升！",
            playful = "【浆果爆棚】浆果今天结得超多，摘一次顶两次，赚大了！"
        },
        effect = function(inst)
            if inst.components.pickable and inst.components.pickable.product == "berries" then
                inst.components.pickable.numtoharvest = inst.components.pickable.numtoharvest * 2
            end
        end,
        target = "berrybush"
    },
    {
        news = {
            formal = "【草木繁盛】今天采集草和树枝有额外概率获得双倍产出！",
            playful = "【草草超多】今天草和树枝多到爆，采一次拿两份，血赚！"
        },
        effect = function(inst)
            if inst.components.pickable then
                local old_onpicked = inst.components.pickable.onpickedfn
                inst.components.pickable:SetOnPickedFn(function(inst, picker)
                    if math.random() < 0.5 and inst.components.lootdropper then
                        inst.components.lootdropper:DropLoot()
                    end
                    if old_onpicked then old_onpicked(inst, picker) end
                end)
            end
        end,
        target = "grass"
    },
    {
        news = {
            formal = "【花朵盛开】今天地图上会生成大量花朵，蜜蜂也更加活跃！",
            playful = "【花花世界】今天到处都开满了花，美得像花园，蜜蜂都忙疯了！"
        },
        effect = function()
            local x, y, z = TheSim:FindFirstEntityWithTag("player"):GetPosition():Get()
            for i = 1, 20 do
                local flower = SpawnPrefab("flower")
                if flower then
                    flower.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                end
            end
        end,
        target = "world"
    },
    {
        news = {
            formal = "【胡萝卜丰收】今天挖胡萝卜有概率获得额外产出！",
            playful = "【胡萝卜大丰收】今天挖胡萝卜手气爆棚，一挖一大把！"
        },
        effect = function(inst)
            if inst.components.pickable and inst.components.pickable.product == "carrot" then
                inst.components.pickable.numtoharvest = inst.components.pickable.numtoharvest * 2
            end
        end,
        target = "carrot_planted"
    },
    {
        news = {
            formal = "【曼德拉草之夜】今天晚上更容易找到曼德拉草！",
            playful = "【小人参出没】曼德拉草今天到处乱跑，抓住它们发大财！"
        },
        effect = function()
            if TheWorld.state.isnight then
                local x, y, z = TheSim:FindFirstEntityWithTag("player"):GetPosition():Get()
                for i = 1, 3 do
                    local mandrake = SpawnPrefab("mandrake_planted")
                    if mandrake then
                        mandrake.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    {
        news = {
            formal = "【荧光果丰收】今天洞穴中的荧光果产量增加！",
            playful = "【发光果果】洞穴里的荧光果今天结得超多，亮晶晶的！"
        },
        effect = function(inst)
            if inst.components.pickable and inst.components.pickable.product == "lightbulb" then
                inst.components.pickable.numtoharvest = inst.components.pickable.numtoharvest * 2
            end
        end,
        target = "lightbulb"
    },
    {
        news = {
            formal = "【仙人掌开花】今天仙人掌采集不会受到伤害，且产量增加！",
            playful = "【仙人掌不扎人】仙人掌今天变温柔了，摘它不疼还多给果子！"
        },
        effect = function(inst)
            if inst.components.pickable then
                inst.components.pickable.numtoharvest = inst.components.pickable.numtoharvest * 2
            end
        end,
        target = "cactus"
    },
    {
        news = {
            formal = "【芦苇丰收】今天采集芦苇有概率获得双倍产出！",
            playful = "【芦苇超多】今天芦苇多到爆，做纸做到手软！"
        },
        effect = function(inst)
            if inst.components.pickable and inst.components.pickable.product == "cutreeds" then
                inst.components.pickable.numtoharvest = inst.components.pickable.numtoharvest * 2
            end
        end,
        target = "reeds"
    },
    {
        news = {
            formal = "【冰块不化】今天冰块融化速度减慢，保存时间延长！",
            playful = "【冰冰不化】冰块今天特别耐用，放多久都不会化！"
        },
        effect = function(inst)
            if inst.components.perishable and inst.prefab == "ice" then
                inst.components.perishable:SetPerishTime(inst.components.perishable:GetPercent() * 3)
            end
        end,
        target = "ice"
    },
    {
        news = {
            formal = "【燧石富矿】今天地面上会生成更多燧石！",
            playful = "【石头遍地】今天到处都是燧石，捡都捡不完！"
        },
        effect = function()
            local x, y, z = TheSim:FindFirstEntityWithTag("player"):GetPosition():Get()
            for i = 1, 15 do
                local flint = SpawnPrefab("flint")
                if flint then
                    flint.Transform:SetPosition(x + math.random(-30, 30), 0, z + math.random(-30, 30))
                end
            end
        end,
        target = "world"
    },
    {
        news = {
            formal = "【黄金时代】今天挖掘墓地有更高概率获得黄金！",
            playful = "【挖坟发财】今天挖坟手气超好，黄金多到数不清！"
        },
        effect = function(inst)
            if inst.components.lootdropper and inst.prefab == "mound" then
                inst.components.lootdropper:AddChanceLoot("goldnugget", 0.8)
            end
        end,
        target = "mound"
    },
    {
        news = {
            formal = "【宝石富矿】今天开采岩石有更高概率获得宝石！",
            playful = "【宝石满地】今天挖石头能挖出宝石，欧皇附体！"
        },
        effect = function(inst)
            if inst.components.lootdropper and inst:HasTag("boulder") then
                inst.components.lootdropper:AddChanceLoot("redgem", 0.3)
                inst.components.lootdropper:AddChanceLoot("bluegem", 0.3)
            end
        end,
        target = "rock"
    },
    {
        news = {
            formal = "【幸运日】今天所有随机事件的好运概率提升！",
            playful = "【超级幸运】今天运气爆棚，干啥都顺，欧皇就是你！"
        },
        effect = function(inst)
            if inst.components.luckiness then
                inst.components.luckiness.luck = inst.components.luckiness.luck + 0.5
            end
        end,
        target = "player"
    }
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
    for i = 1, EVENT_COUNT do
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
    elseif event.target == "player" then
        -- 对所有玩家应用效果
        for i, v in ipairs(AllPlayers) do
            if event.effect then
                event.effect(v)
            end
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
