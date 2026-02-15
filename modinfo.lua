local MOD_VERSION = "0.7.2"

name = "每日新闻"
description = [[
每天白天播报新闻，预告特殊事件。

版本: ]]..MOD_VERSION..[[

100种事件 (80正面 + 10负面 + 10中立)

请大家看一下自定义喵~

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
            {description = "DEBUG-播报所有新闻", data = 999},
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
            {description = "每个白天播报", data = 0.33},
            {description = "每半天播报", data = 0.5},
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
        default = false,
    },
    {
        name = "enable_neutral",
        label = "启用中立新闻",
        hover = "是否生成中立新闻事件",
        options = {
            {description = "启用", data = true},
            {description = "禁用", data = false},
        },
        default = false,
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
        default = "simple",
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
        default = false,
    },
    {
        name = "warning_time",
        label = "预警提前时间",
        hover = "新闻播报前多少帧进行预警",
        options = {
            {description = "10", data = 10},
            {description = "20", data = 20},
            {description = "30", data = 30},
            {description = "40", data = 40},
            {description = "50", data = 50},
            {description = "60", data = 60},
        },
        default = 60,
    },
    
    Title(""),
    Title("========== 实验性功能 =========="),
    Title("警告：以下功能可能无法正常工作！"),
    {
        name = "enable_no_repeat",
        label = "启用新闻不重复",
        hover = "【实验性】出现过的新闻达到指定次数后不再出现（可能无效）",
        options = {
            {description = "启用", data = true},
            {description = "禁用", data = false},
        },
        default = false,
    },
    {
        name = "repeat_limit",
        label = "新闻重复次数限制",
        hover = "【实验性】同一条新闻最多出现几次后不再出现（可能无效）",
        options = {
            {description = "1次", data = 1},
            {description = "2次", data = 2},
            {description = "3次", data = 3},
            {description = "4次", data = 4},
            {description = "5次", data = 5},
            {description = "6次", data = 6},
            {description = "7次", data = 7},
            {description = "8次", data = 8},
            {description = "9次", data = 9},
            {description = "10次", data = 10},
        },
        default = 5,
    },
    
    Title(""),
    Title("========== 模组信息 =========="),
    Title("版本: "..MOD_VERSION.." | 事件: 100"),
    Title("正面: 80 | 负面: 10 | 中立: 10"),
    Title("祝大家新年快乐，恭喜发财。"),
    Title("作者：橙小幸"),
    Title("Q群:1042944194 欢迎联机交流。"),
    Title("感谢您的大力支持！")

}
