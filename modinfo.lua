local MOD_VERSION = "0.6.7"

name = "每日新闻"
description = [[
每天白天播报新闻，预告特殊事件。

版本: ]]..MOD_VERSION..[[

70种事件 (50正面 + 10负面 + 10中立)
其中10个属性增益事件

推荐开荒使用
]]

author = "橙小幸"
version = MOD_VERSION

forumthread = ""
api_version = 10

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = false
client_only_mod = false
server_only_mod = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {"daily_news", "每日新闻", "橙小幸"}

local function Title(title)
    return {
        name = title,
        hover = "",
        options = {{description = "", data = 0}},
        default = 0,
    }
end

configuration_options = {
    Title("===== 基础设置 ====="),
    {
        name = "event_count",
        label = "每日事件数量",
        hover = "每天播报的新闻事件数量",
        options = {
            {description = "1个事件", data = 1},
            {description = "2个事件", data = 2},
            {description = "3个事件", data = 3},
        },
        default = 3,
    },
    {
        name = "news_style",
        label = "新闻播报风格",
        hover = "选择新闻播报的语言风格",
        options = {
            {description = "正式播报", data = "formal"},
            {description = "调皮趣味", data = "playful"},
        },
        default = "formal",
    },
    
    Title(""),
    Title("===== 模组信息 ====="),
    Title("版本: "..MOD_VERSION.." | 事件: 80"),
    Title("正面: 60 | 负面: 10 | 中立: 10"),
}
