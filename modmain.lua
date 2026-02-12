GLOBAL.setmetatable(env, { __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end })

local EVENT_COUNT = 3
local NEWS_STYLE = "formal"

local function GetConfig()
    EVENT_COUNT = GetModConfigData("event_count") or 3
    NEWS_STYLE = GetModConfigData("news_style") or "formal"
end

local NEWS_EVENTS = {
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
    
    {
        news = {
            formal = "【蜜蜂狂欢】今天会有大量蜜蜂飞舞！",
            playful = "【嗡嗡嗡】小蜜蜂今天开派对，到处嗡嗡嗡飞来飞去！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 10 do
                    local bee = SpawnPrefab("bee")
                    if bee then
                        bee.Transform:SetPosition(x + math.random(-15, 15), 0, z + math.random(-15, 15))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【蜘蛛出没】今天蜘蛛活动频繁，小心应对！",
            playful = "【八脚怪来了】蜘蛛们今天组团出门，准备好打蜘蛛啦！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 8 do
                    local spider = SpawnPrefab("spider")
                    if spider then
                        spider.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【兔子繁殖季】今天兔子数量激增！",
            playful = "【兔兔满地跑】到处都是小兔子，蹦蹦跳跳超可爱！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 12 do
                    local rabbit = SpawnPrefab("rabbit")
                    if rabbit then
                        rabbit.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【鼹鼠活跃日】今天鼹鼠频繁出没！",
            playful = "【鼹鼠挖挖挖】鼹鼠们今天疯狂挖洞，到处都是小土堆！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 6 do
                    local mole = SpawnPrefab("mole")
                    if mole then
                        mole.Transform:SetPosition(x + math.random(-15, 15), 0, z + math.random(-15, 15))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【黄金时代】今天地面上会出现黄金！",
            playful = "【发财啦】地上到处都是金块，今天要发大财啦！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 8 do
                    local gold = SpawnPrefab("goldnugget")
                    if gold then
                        gold.Transform:SetPosition(x + math.random(-30, 30), 0, z + math.random(-30, 30))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【木材富足】今天地面上会出现大量木头！",
            playful = "【木头堆成山】到处都是木头，盖房子的材料够够的！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 20 do
                    local log = SpawnPrefab("log")
                    if log then
                        log.Transform:SetPosition(x + math.random(-30, 30), 0, z + math.random(-30, 30))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【岩石遍地】今天地面上会出现大量石头！",
            playful = "【石头大丰收】到处都是石头，建墙建到手软！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 15 do
                    local rocks = SpawnPrefab("rocks")
                    if rocks then
                        rocks.Transform:SetPosition(x + math.random(-30, 30), 0, z + math.random(-30, 30))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【蘑菇大爆发】今天会长出大量蘑菇！",
            playful = "【蘑菇满地长】红的绿的蓝的蘑菇，到处都是，采蘑菇啦！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                local mushrooms = {"red_cap", "green_cap", "blue_cap"}
                for i = 1, 15 do
                    local mushroom = SpawnPrefab(mushrooms[math.random(1, 3)])
                    if mushroom then
                        mushroom.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【种子丰收】今天地面上会出现大量种子！",
            playful = "【种子满地】到处都是种子，种田种到停不下来！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 20 do
                    local seeds = SpawnPrefab("seeds")
                    if seeds then
                        seeds.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【蜂蜜流淌】今天会出现大量蜂蜜！",
            playful = "【甜蜜蜜】到处都是蜂蜜，甜到心里去啦！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 10 do
                    local honey = SpawnPrefab("honey")
                    if honey then
                        honey.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【肉食盛宴】今天会出现大量肉类！",
            playful = "【肉肉满地】到处都是肉，吃肉吃到饱！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 12 do
                    local meat = SpawnPrefab("meat")
                    if meat then
                        meat.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【鸟蛋遍地】今天会出现大量鸟蛋！",
            playful = "【蛋蛋满地】到处都是鸟蛋，煎蛋煮蛋炒蛋随便做！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 15 do
                    local egg = SpawnPrefab("bird_egg")
                    if egg then
                        egg.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【曼德拉草现身】今天会出现珍稀的曼德拉草！",
            playful = "【小人参出没】曼德拉草今天到处跑，抓住它发大财！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 3 do
                    local mandrake = SpawnPrefab("mandrake")
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
            formal = "【机械零件】今天会出现珍贵的齿轮！",
            playful = "【齿轮满地】到处都是齿轮，机器人都不够用啦！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 5 do
                    local gears = SpawnPrefab("gears")
                    if gears then
                        gears.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【猪皮丰收】今天会出现大量猪皮！",
            playful = "【猪皮满地】到处都是猪皮，做帽子做到手软！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 8 do
                    local pigskin = SpawnPrefab("pigskin")
                    if pigskin then
                        pigskin.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【蜘蛛丝飘飘】今天会出现大量蜘蛛丝！",
            playful = "【丝丝满天飞】到处都是蜘蛛丝，做网做到停不下来！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 15 do
                    local silk = SpawnPrefab("silk")
                    if silk then
                        silk.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【暗影涌动】今天会出现神秘的噩梦燃料！",
            playful = "【黑黑的东西】到处都是噩梦燃料，暗影装备做起来！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 8 do
                    local fuel = SpawnPrefab("nightmarefuel")
                    if fuel then
                        fuel.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【冰雪降临】今天会出现大量冰块！",
            playful = "【冰冰凉凉】到处都是冰块，做冰箱做到爽！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 12 do
                    local ice = SpawnPrefab("ice")
                    if ice then
                        ice.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【松果满地】今天会出现大量松果！",
            playful = "【松果掉不停】到处都是松果，种树种到森林成片！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 15 do
                    local pinecone = SpawnPrefab("pinecone")
                    if pinecone then
                        pinecone.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【宝石奇迹】今天会出现珍贵的宝石！",
            playful = "【宝石满地捡】红宝石蓝宝石紫宝石，到处都是，发大财啦！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                local gems = {"redgem", "bluegem", "purplegem"}
                for i = 1, 6 do
                    local gem = SpawnPrefab(gems[math.random(1, 3)])
                    if gem then
                        gem.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【萤火虫之夜】今天晚上会有大量萤火虫出现！",
            playful = "【小灯笼飞呀飞】晚上到处都是萤火虫，亮晶晶的超漂亮！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 12 do
                    local firefly = SpawnPrefab("fireflies")
                    if firefly then
                        firefly.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【高鸟蛋现世】今天会出现珍贵的高鸟蛋！",
            playful = "【大鸟蛋来啦】高鸟蛋出现了，小心高鸟追你哦！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 3 do
                    local talbirdegg = SpawnPrefab("tallbirdegg")
                    if talbirdegg then
                        talbirdegg.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【蜂巢丰收】今天会出现蜂巢和蜂窝！",
            playful = "【蜜蜂的家】到处都是蜂巢，小心被蜜蜂蜇哦！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 4 do
                    local honeycomb = SpawnPrefab("honeycomb")
                    if honeycomb then
                        honeycomb.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【怪物肉堆积】今天会出现大量怪物肉！",
            playful = "【黑黑的肉】到处都是怪物肉，喂猪人正好！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 10 do
                    local monstermeat = SpawnPrefab("monstermeat")
                    if monstermeat then
                        monstermeat.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【鱼人出没】今天鱼人活动频繁！",
            playful = "【鱼鱼人来了】鱼人们今天组团出门，小心被围攻！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 6 do
                    local merm = SpawnPrefab("merm")
                    if merm then
                        merm.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【猪人聚会】今天猪人数量增加！",
            playful = "【猪猪开派对】猪人们今天开大会，可以招募好多帮手啦！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 5 do
                    local pig = SpawnPrefab("pigman")
                    if pig then
                        pig.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【木炭丰收】今天会出现大量木炭！",
            playful = "【黑黑的炭】到处都是木炭，做火药做到爽！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 15 do
                    local charcoal = SpawnPrefab("charcoal")
                    if charcoal then
                        charcoal.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【硝石富矿】今天会出现大量硝石！",
            playful = "【黄色石头】到处都是硝石，做火药做炸药随便做！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 12 do
                    local nitre = SpawnPrefab("nitre")
                    if nitre then
                        nitre.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【芦苇丛生】今天会出现大量芦苇！",
            playful = "【芦苇满地长】到处都是芦苇，做纸做到停不下来！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 10 do
                    local cutreeds = SpawnPrefab("cutreeds")
                    if cutreeds then
                        cutreeds.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【猎犬来袭】今天会有猎犬群出现，注意防御！",
            playful = "【汪汪队出动】一群凶猛的狗狗要来了，快准备武器！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 5 do
                    local hound = SpawnPrefab("hound")
                    if hound then
                        hound.Transform:SetPosition(x + math.random(-15, 15), 0, z + math.random(-15, 15))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【触手危机】今天会有触手从地下冒出！",
            playful = "【章鱼脚出没】小心地上的触手，会把你抓住打！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 6 do
                    local tentacle = SpawnPrefab("tentacle")
                    if tentacle then
                        tentacle.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【蜘蛛战士】今天会出现强大的蜘蛛战士！",
            playful = "【大蜘蛛来了】超大只的蜘蛛战士出现了，快跑啊！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 4 do
                    local spiderwarrior = SpawnPrefab("spider_warrior")
                    if spiderwarrior then
                        spiderwarrior.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【发条骑士】今天会有发条骑士出现！",
            playful = "【机器人来了】叮叮当当的发条骑士要来打架了！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 3 do
                    local knight = SpawnPrefab("knight")
                    if knight then
                        knight.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【发条主教】今天会有发条主教出现！",
            playful = "【激光炮来了】会发射激光的主教机器人出现了！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 3 do
                    local bishop = SpawnPrefab("bishop")
                    if bishop then
                        bishop.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【发条战车】今天会有发条战车出现！",
            playful = "【小坦克来了】会冲撞的战车机器人出现了，小心被撞飞！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 2 do
                    local rook = SpawnPrefab("rook")
                    if rook then
                        rook.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【暗影怪物】今天理智值下降时会出现更多暗影生物！",
            playful = "【小黑人来了】今天暗影怪物特别多，保持理智很重要！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 4 do
                    local shadowcreature = SpawnPrefab("crawlinghorror")
                    if shadowcreature then
                        shadowcreature.Transform:SetPosition(x + math.random(-15, 15), 0, z + math.random(-15, 15))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【杀人蜂群】今天会有危险的杀人蜂出现！",
            playful = "【红眼蜜蜂】杀人蜂来了，被蜇到会很痛的！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 8 do
                    local killerbee = SpawnPrefab("killerbee")
                    if killerbee then
                        killerbee.Transform:SetPosition(x + math.random(-15, 15), 0, z + math.random(-15, 15))
                    end
                end
            end
        end,
        target = "world"
    },
    
    {
        news = {
            formal = "【蚊子成灾】今天会有大量蚊子出现！",
            playful = "【嗡嗡嗡吸血】讨厌的蚊子要来吸血了，快躲开！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 10 do
                    local mosquito = SpawnPrefab("mosquito")
                    if mosquito then
                        mosquito.Transform:SetPosition(x + math.random(-15, 15), 0, z + math.random(-15, 15))
                    end
                end
            end
        end,
        target = "world"
    },
}


local current_events = {}
local last_day = -1 --一天时间生成 每天白天记录

local function SelectDailyEvents()
    local selected = {}
    local available = {}
    
    for i, event in ipairs(NEWS_EVENTS) do
        table.insert(available, i)
    end
    
    for i = 1, math.min(EVENT_COUNT, #available) do
        if #available > 0 then
            local index = math.random(1, #available)
            table.insert(selected, NEWS_EVENTS[available[index]])
            table.remove(available, index)
        end
    end
    
    return selected
end

local function AnnounceNews(news_text)
    if TheWorld.ismastersim then
        TheNet:Announce(news_text)
    end
end

local function ApplyEventEffects(event)
    if event.effect then
        event.effect()
    end
end

local function GetNewsText(event)
    if type(event.news) == "table" then
        return event.news[NEWS_STYLE] or event.news.formal
    else
        return event.news
    end
end

local function CheckDailyNews()
    if not TheWorld.ismastersim then return end
    
    local current_day = TheWorld.state.cycles
    
    if current_day ~= last_day and TheWorld.state.isday then
        last_day = current_day
        current_events = SelectDailyEvents()
        
        TheWorld:DoTaskInTime(3, function()
            AnnounceNews("================   每日新闻 Daily News   ================")
            
            for i, event in ipairs(current_events) do
                TheWorld:DoTaskInTime(i * 2, function()
                    local news_text = GetNewsText(event)
                    AnnounceNews(string.format("【新闻 %d】%s", i, news_text))
                    ApplyEventEffects(event)
                end)
            end
            
            TheWorld:DoTaskInTime((#current_events + 1) * 2, function()
                AnnounceNews("====================================================")
            end)
        end)
    end
end

AddPrefabPostInit("world", function(inst)
    if not TheWorld.ismastersim then return end
    
    GetConfig()
    
    inst:DoPeriodicTask(30, CheckDailyNews)
    
    inst:DoTaskInTime(5, CheckDailyNews)
end)