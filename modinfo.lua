local MOD_VERSION = "0.7.0"

name = "每日新闻"
description = [[
每天白天播报新闻，预告特殊事件。

版本: ]]..MOD_VERSION..[[

80种事件 (60正面 + 10负面 + 10中立)
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
    Title("========== 基础设置 =========="),
    {
        name = "event_count",
        label = "每日事件数量",
        hover = "每天播报的新闻事件数量",
        options = {
            {description = "1个事件", data = 1},
            {description = "2个事件", data = 2},
            {description = "3个事件", data = 3},
            {description = "4个事件", data = 4},
            {description = "5个事件", data = 5},
            {description = "6个事件", data = 6},
            {description = "7个事件", data = 7},
            {description = "8个事件", data = 8},
            {description = "9个事件", data = 9},
            {description = "10个事件", data = 10},
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
    {
        name = "news_interval",
        label = "新闻播报间隔",
        hover = "每隔多少天播报一次新闻",
        options = {
            {description = "每天播报", data = 1},
            {description = "每2天播报", data = 2},
            {description = "每3天播报", data = 3},
            {description = "每4天播报", data = 4},
            {description = "每5天播报", data = 5},
            {description = "每7天播报", data = 7},
            {description = "每10天播报", data = 10},
        },
        default = 1,
    },
    
    Title(""),
    Title("========== 事件类型 =========="),
    {
        name = "enable_negative",
        label = "启用负面新闻",
        hover = "是否生成负面新闻事件",
        options = {
            {description = "启用", data = true},
            {description = "禁用", data = false},
        },
        default = true,
    },
    {
        name = "enable_neutral",
        label = "启用中立新闻",
        hover = "是否生成中立新闻事件",
        options = {
            {description = "启用", data = true},
            {description = "禁用", data = false},
        },
        default = true,
    },
    
    Title(""),
    Title("========== 播报样式 =========="),
    {
        name = "news_header",
        label = "新闻标题样式",
        hover = "选择新闻播报的标题样式",
        options = {
            {description = "美观", data = "beautiful"},
            {description = "简约", data = "simple"},
            {description = "大方", data = "elegant"},
            {description = "庄重", data = "solemn"},
        },
        default = "beautiful",
    },
    
    Title(""),
    Title("========== 预警设置 =========="),
    {
        name = "enable_warning",
        label = "启用新闻预警",
        hover = "在新闻播报前提前预警",
        options = {
            {description = "启用", data = true},
            {description = "禁用", data = false},
        },
        default = true,
    },
    {
        name = "warning_time",
        label = "预警提前时间",
        hover = "新闻播报前多少秒进行预警",
        options = {
            {description = "10秒", data = 10},
            {description = "20秒", data = 20},
            {description = "30秒", data = 30},
            {description = "40秒", data = 40},
            {description = "50秒", data = 50},
            {description = "60秒", data = 60},
        },
        default = 30,
    },
    
    Title(""),
    Title("========== 模组信息 =========="),
    Title("版本: "..MOD_VERSION.." | 事件: 80"),
    Title("正面: 60 | 负面: 10 | 中立: 10"),
    Title("祝大家新年快乐，这是最近最后的一版了，不会在频繁更新了。")
    Title("作者：橙小幸")
    Title("Q群:1042944194 欢迎饥荒联机交流。")
    Title("感谢您的大力支持！")

}
