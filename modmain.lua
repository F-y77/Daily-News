
GLOBAL.setmetatable(env, { __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end })

local EVENT_COUNT = 1
local NEWS_STYLE = "playful"

local function GetConfig()
    EVENT_COUNT = GetModConfigData("event_count") or 1
    NEWS_STYLE = GetModConfigData("news_style") or "playful"
end

local NEWS_EVENTS = {
    {
        news = {
            formal = "【青蛙雨季】今天会有大量青蛙出现！",
            playful = "【呱呱来袭】青蛙大军从天而降，呱呱呱呱呱�?
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
            playful = "【蝴蝶满天飞】哇！到处都是小蝴蝶，抓蝴蝶抓到眼花缭乱�?
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
            playful = "【企鹅开会】企鹅们今天开大会，到处都是企鹅蛋�?
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
            playful = "【树枝满地】今天到处都是树枝，捡到手软�?
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
            formal = "【草木繁盛】今天地面上会生成更多草�?,
            playful = "【草草超多】今天到处都是草，采都采不完�?
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
            formal = "【胡萝卜丰收】今天地面上会生成更多胡萝卜�?,
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
            playful = "【嗡嗡嗡】小蜜蜂今天开派对，到处嗡嗡嗡飞来飞去�?
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
            formal = "【蜘蛛出没】今天蜘蛛活动频繁，小心应对�?,
            playful = "【八脚怪来了】蜘蛛们今天组团出门，准备好打蜘蛛啦�?
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
            playful = "【兔兔满地跑】到处都是小兔子，蹦蹦跳跳超可爱�?
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
            playful = "【鼹鼠挖挖挖】鼹鼠们今天疯狂挖洞，到处都是小土堆�?
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
            playful = "【石头大丰收】到处都是石头，建墙建到手软�?
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
            formal = "【蘑菇大爆发】今天会长出大量蘑菇�?,
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
            playful = "【种子满地】到处都是种子，种田种到停不下来�?
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
            formal = "【蜂蜜流淌】今天会出现大量蜂蜜�?,
            playful = "【甜蜜蜜】到处都是蜂蜜，甜到心里去啦�?
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
            formal = "【肉食盛宴】今天会出现大量肉类�?,
            playful = "【肉肉满地】到处都是肉，吃肉吃到饱�?
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
            formal = "【鸟蛋遍地】今天会出现大量鸟蛋�?,
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
            playful = "【齿轮满地】到处都是齿轮，机器人都不够用啦�?
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
            formal = "【猪皮丰收】今天会出现大量猪皮�?,
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
            formal = "【冰雪降临】今天会出现大量冰块�?,
            playful = "【冰冰凉凉】到处都是冰块，做冰箱做到爽�?
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
            formal = "【松果满地】今天会出现大量松果�?,
            playful = "【松果掉不停】到处都是松果，种树种到森林成片�?
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
            playful = "【宝石满地捡】红宝石蓝宝石紫宝石，到处都是，发大财啦�?
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
            formal = "【萤火虫之夜】今天晚上会有大量萤火虫出现�?,
            playful = "【小灯笼飞舞】萤火虫今天开灯光秀，一闪一闪亮晶晶�?
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
            formal = "【高脚鸟繁殖】今天会出现大量高脚鸟蛋�?,
            playful = "【大鸟下蛋啦】高脚鸟今天疯狂下蛋，蛋蛋满地滚�?
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 6 do
                    local egg = SpawnPrefab("tallbirdegg")
                    if egg then
                        egg.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                    end
                end
            end
        end,
        target = "world"
    },
    

    {
        news = {
            formal = "【蜂巢丰收】今天会出现大量蜂巢�?,
            playful = "【蜂巢满地】到处都是蜂巢，养蜂养到停不下来�?
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 5 do
                    local honeycomb = SpawnPrefab("honeycomb")
                    if honeycomb then
                        honeycomb.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    

    {
        news = {
            formal = "【怪物肉丰收】今天会出现大量怪物肉！",
            playful = "【黑黑的肉】到处都是怪物肉，喂猪人喂到饱�?
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
            playful = "【鱼鱼人来了】鱼人们今天组团出门，小心被打哦�?
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
            formal = "【猪人聚会】今天猪人出现数量增加！",
            playful = "【猪猪开会】猪人们今天开大会，到处都是小猪猪�?
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
            formal = "【木炭富足】今天会出现大量木炭�?,
            playful = "【黑黑的炭】到处都是木炭，燃料够用一整年�?
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
            formal = "【硝石富矿】今天会出现大量硝石�?,
            playful = "【硝石满地】到处都是硝石，做炸药做到爽�?
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
            formal = "【芦苇丰收】今天会出现大量芦苇�?,
            playful = "【芦苇满地】到处都是芦苇，做纸做到手软�?
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 12 do
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
            formal = "【活木出现】今天会出现珍贵的活木！",
            playful = "【会动的木头】活木今天到处跑，抓住它做魔法装备！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 4 do
                    local livinglog = SpawnPrefab("livinglog")
                    if livinglog then
                        livinglog.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    

    {
        news = {
            formal = "【紫宝石降临】今天会出现大量紫宝石！",
            playful = "【紫色的宝石】到处都是紫宝石，做传送杖做到爽！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 5 do
                    local purplegem = SpawnPrefab("purplegem")
                    if purplegem then
                        purplegem.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                    end
                end
            end
        end,
        target = "world"
    },
    

    {
        news = {
            formal = "【红宝石降临】今天会出现大量红宝石！",
            playful = "【红色的宝石】到处都是红宝石，做火魔杖做到手软！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 5 do
                    local redgem = SpawnPrefab("redgem")
                    if redgem then
                        redgem.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                    end
                end
            end
        end,
        target = "world"
    },
    

    {
        news = {
            formal = "【蓝宝石降临】今天会出现大量蓝宝石！",
            playful = "【蓝色的宝石】到处都是蓝宝石，做冰魔杖做到爽�?
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 5 do
                    local bluegem = SpawnPrefab("bluegem")
                    if bluegem then
                        bluegem.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                    end
                end
            end
        end,
        target = "world"
    },
    

    {
        news = {
            formal = "【橙宝石出现】今天会出现稀有的橙宝石！",
            playful = "【橙色的宝石】橙宝石今天大放送，做懒人护符啦�?
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 3 do
                    local orangegem = SpawnPrefab("orangegem")
                    if orangegem then
                        orangegem.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    

    {
        news = {
            formal = "【黄宝石出现】今天会出现稀有的黄宝石！",
            playful = "【黄色的宝石】黄宝石今天大放送，做星空啦�?
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 3 do
                    local yellowgem = SpawnPrefab("yellowgem")
                    if yellowgem then
                        yellowgem.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    

    {
        news = {
            formal = "【绿宝石出现】今天会出现稀有的绿宝石！",
            playful = "【绿色的宝石】绿宝石今天大放送，做建筑护符啦�?
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 3 do
                    local greengem = SpawnPrefab("greengem")
                    if greengem then
                        greengem.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    

    {
        news = {
            formal = "【鸟嘴兽出没】今天鸟嘴兽活动频繁�?,
            playful = "【奇怪的生物】鸟嘴兽今天组团出门，好奇怪的动物�?
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 8 do
                    local perd = SpawnPrefab("perd")
                    if perd then
                        perd.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    

    {
        news = {
            formal = "【浆果灌木丛生】今天会出现大量浆果灌木�?,
            playful = "【灌木满地】到处都是浆果灌木，种浆果种到爽�?
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 8 do
                    local berrybush = SpawnPrefab("berrybush")
                    if berrybush then
                        berrybush.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                    end
                end
            end
        end,
        target = "world"
    },
    

    {
        news = {
            formal = "【草丛繁殖】今天会出现大量草丛�?,
            playful = "【草丛满地】到处都是草丛，采草采到停不下来�?
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 10 do
                    local grass = SpawnPrefab("grass")
                    if grass then
                        grass.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                    end
                end
            end
        end,
        target = "world"
    },
    

    {
        news = {
            formal = "【树苗丰收】今天会出现大量树苗�?,
            playful = "【小树苗】到处都是树苗，种树种到森林成片�?
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 10 do
                    local sapling = SpawnPrefab("sapling")
                    if sapling then
                        sapling.Transform:SetPosition(x + math.random(-25, 25), 0, z + math.random(-25, 25))
                    end
                end
            end
        end,
        target = "world"
    },
    

    

    {
        news = {
            formal = "【满月之夜】今天晚上将是美丽的满月�?,
            playful = "【月亮圆圆】今晚月亮又大又圆，赏月好时机！"
        },
        effect = function()
            if TheWorld.components.clock then
                TheWorld.components.clock:SetPhase("night")
            end
            if TheWorld.net and TheWorld.net.components.clock then
                TheWorld.net.components.clock:SetPhase("night")
            end
        end,
        target = "world"
    },
    

    {
        news = {
            formal = "【闪电风暴】今天天气不稳定，小心雷击！",
            playful = "【天雷滚滚】今天老天爷要发威，小心被劈哦�?
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 3 do
                    TheWorld:DoTaskInTime(i * 2, function()
                        local lightning = SpawnPrefab("lightning")
                        if lightning then
                            lightning.Transform:SetPosition(x + math.random(-15, 15), 0, z + math.random(-15, 15))
                        end
                    end)
                end
            end
        end,
        target = "world"
    },
    

    {
        news = {
            formal = "【陨石降临】今天会有陨石从天而降�?,
            playful = "【天上掉石头】陨石雨来啦，小心被砸到头！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 5 do
                    TheWorld:DoTaskInTime(i, function()
                        local meteor = SpawnPrefab("rock1")
                        if meteor then
                            meteor.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                        end
                    end)
                end
            end
        end,
        target = "world"
    },
    

    {
        news = {
            formal = "【宝箱降临】今天会出现神秘的宝箱！",
            playful = "【开箱开箱】天上掉宝箱，里面有什么呢�?
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 3 do
                    local chest = SpawnPrefab("treasurechest")
                    if chest then
                        chest.Transform:SetPosition(x + math.random(-15, 15), 0, z + math.random(-15, 15))
                    end
                end
            end
        end,
        target = "world"
    },
    

    {
        news = {
            formal = "【篝火派对】今天会出现温暖的篝火！",
            playful = "【火火温暖】到处都是篝火，今晚不怕冷啦！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 5 do
                    local firepit = SpawnPrefab("firepit")
                    if firepit then
                        firepit.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    

    {
        news = {
            formal = "【科技降临】今天会出现科学机器�?,
            playful = "【科学怪人】科学机器从天而降，科技发展加速啦�?
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                local science = SpawnPrefab("researchlab")
                if science then
                    science.Transform:SetPosition(x + math.random(-10, 10), 0, z + math.random(-10, 10))
                end
            end
        end,
        target = "world"
    },
    

    {
        news = {
            formal = "【炼金术降临】今天会出现炼金引擎�?,
            playful = "【魔法机器】炼金引擎从天而降，魔法时代来临！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                local alchemy = SpawnPrefab("researchlab2")
                if alchemy then
                    alchemy.Transform:SetPosition(x + math.random(-10, 10), 0, z + math.random(-10, 10))
                end
            end
        end,
        target = "world"
    },
    

    {
        news = {
            formal = "【暗影降临】今天会出现暗影操纵者！",
            playful = "【黑黑的机器】暗影操纵者出现啦，暗影装备做起来�?
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                local shadow = SpawnPrefab("researchlab3")
                if shadow then
                    shadow.Transform:SetPosition(x + math.random(-10, 10), 0, z + math.random(-10, 10))
                end
            end
        end,
        target = "world"
    },
    

    {
        news = {
            formal = "【火炬之光】今天会出现猪人火炬�?,
            playful = "【亮晶晶】到处都是火炬，晚上也不怕黑啦！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 8 do
                    local torch = SpawnPrefab("pigtorch")
                    if torch then
                        torch.Transform:SetPosition(x + math.random(-20, 20), 0, z + math.random(-20, 20))
                    end
                end
            end
        end,
        target = "world"
    },
    

    {
        news = {
            formal = "【传送门开启】今天会出现神秘的传送装置！",
            playful = "【嗖的一下】传送装置出现啦，想去哪就去哪！"
        },
        effect = function()
            local player = TheSim:FindFirstEntityWithTag("player")
            if player then
                local x, y, z = player.Transform:GetWorldPosition()
                for i = 1, 2 do
                    local teleportato = SpawnPrefab("teleportato_base")
                    if teleportato then
                        teleportato.Transform:SetPosition(x + math.random(-15, 15), 0, z + math.random(-15, 15))
                    end
                end
            end
        end,
        target = "world"
    },
}

local current_events = {}
local last_day = -1 

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
            AnnounceNews("===================   每日新闻 Daily News   ===================")
            
            for i, event in ipairs(current_events) do
                TheWorld:DoTaskInTime(i * 2, function()
                    local news_text = GetNewsText(event)
                    AnnounceNews(string.format("【新闻 %d】", i, news_text))
                    ApplyEventEffects(event)
                end)
            end
            
            TheWorld:DoTaskInTime((#current_events + 1) * 2, function()
                AnnounceNews("==========================================================")
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
