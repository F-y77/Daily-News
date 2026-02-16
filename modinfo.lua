local function GetLanguage()
    return locale ~= nil and locale or "zh"
end

local is_chinese = GetLanguage():find("zh") ~= nil

local MOD_VERSION = "0.7.5"

name = is_chinese and "每日新闻" or "Daily News"
description = is_chinese and [[
每天白天播报新闻，预告特殊事件。

版本: ]]..MOD_VERSION..[[

100种事件 (80正面 + 10负面 + 10中立)

请大家看一下自定义喵~

推荐开荒使用
]] or [[
Broadcast daily news and special events every day.

Version: ]]..MOD_VERSION..[[

100 events (80 positive + 10 negative + 10 neutral)

Please check the customization options~

Recommended for early game
]]

author = is_chinese and "橙小幸" or "Orange Xiaoxing"
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

server_filter_tags = is_chinese and {"daily_news", "每日新闻", "橙小幸"} or {"daily_news", "Daily News", "Orange Xiaoxing"}

local function Title(title)
    return {
        name = title,
        hover = "",
        options = {{description = "", data = 0}},
        default = 0,
    }
end

local labels = {
    basic_settings = is_chinese and "========== 基础设置 ==========" or "========== Basic Settings ==========",
    event_count = is_chinese and "每日事件数量" or "Daily Event Count",
    event_count_hover = is_chinese and "每天播报的新闻事件数量" or "Number of news events to broadcast daily",
    events = function(n) return is_chinese and n.."个事件" or n.." events" end,
    debug_all = is_chinese and "DEBUG-播报所有新闻" or "DEBUG-Broadcast All News",
    news_style = is_chinese and "新闻播报风格" or "News Style",
    news_style_hover = is_chinese and "选择新闻播报的语言风格" or "Choose the language style of news broadcast",
    formal = is_chinese and "正式播报" or "Formal",
    playful = is_chinese and "调皮趣味" or "Playful",
    news_language = is_chinese and "新闻语言" or "News Language",
    news_language_hover = is_chinese and "选择游戏内新闻播报的语言" or "Choose the language for in-game news broadcast",
    chinese = is_chinese and "中文" or "Chinese",
    english = is_chinese and "英语" or "English",
    news_interval = is_chinese and "新闻播报间隔" or "Broadcast Interval",
    news_interval_hover = is_chinese and "每隔多少天播报一次新闻" or "How often to broadcast news",
    every_day = is_chinese and "每个白天播报" or "Every Daytime",
    half_day = is_chinese and "每半天播报" or "Every Half Day",
    daily = is_chinese and "每天播报" or "Daily",
    days = function(n) return is_chinese and "每"..n.."天播报" or "Every "..n.." days" end,
    event_types = is_chinese and "========== 事件类型 ==========" or "========== Event Types ==========",
    enable_negative = is_chinese and "启用负面新闻" or "Enable Negative News",
    enable_negative_hover = is_chinese and "是否生成负面新闻事件" or "Whether to generate negative news events",
    enable_neutral = is_chinese and "启用中立新闻" or "Enable Neutral News",
    enable_neutral_hover = is_chinese and "是否生成中立新闻事件" or "Whether to generate neutral news events",
    enable = is_chinese and "启用" or "Enable",
    disable = is_chinese and "禁用" or "Disable",
    broadcast_style = is_chinese and "========== 播报样式 ==========" or "========== Broadcast Style ==========",
    news_header = is_chinese and "新闻标题样式" or "News Header Style",
    news_header_hover = is_chinese and "选择新闻播报的标题样式" or "Choose the header style of news broadcast",
    beautiful = is_chinese and "美观" or "Beautiful",
    simple = is_chinese and "简约" or "Simple",
    elegant = is_chinese and "大方" or "Elegant",
    solemn = is_chinese and "庄重" or "Solemn",
    warning_settings = is_chinese and "========== 预警设置 ==========" or "========== Warning Settings ==========",
    enable_warning = is_chinese and "启用新闻预警" or "Enable News Warning",
    enable_warning_hover = is_chinese and "在新闻播报前提前预警" or "Warn before news broadcast",
    warning_time = is_chinese and "预警提前时间" or "Warning Time",
    warning_time_hover = is_chinese and "新闻播报前多少帧进行预警" or "How many frames before news broadcast to warn",
    experimental = is_chinese and "========== 实验性功能 ==========" or "========== Experimental Features ==========",
    experimental_warning = is_chinese and "警告：以下功能可能无法正常工作！" or "Warning: The following features may not work properly!",
    enable_no_repeat = is_chinese and "启用新闻不重复" or "Enable No Repeat",
    enable_no_repeat_hover = is_chinese and "【实验性】出现过的新闻达到指定次数后不再出现（可能无效）" or "[Experimental] News will not appear again after reaching the specified count (may not work)",
    repeat_limit = is_chinese and "新闻重复次数限制" or "Repeat Limit",
    repeat_limit_hover = is_chinese and "【实验性】同一条新闻最多出现几次后不再出现（可能无效）" or "[Experimental] Maximum times a news can appear (may not work)",
    times = function(n) return is_chinese and n.."次" or n.." times" end,
    mod_info = is_chinese and "========== 模组信息 ==========" or "========== Mod Info ==========",
    version_info = is_chinese and "版本: "..MOD_VERSION.." | 事件: 100" or "Version: "..MOD_VERSION.." | Events: 100",
    event_breakdown = is_chinese and "正面: 80 | 负面: 10 | 中立: 10" or "Positive: 80 | Negative: 10 | Neutral: 10",
    greeting = is_chinese and "祝大家新年快乐，恭喜发财。" or "Happy New Year and Best Wishes!",
    author_info = is_chinese and "作者：橙小幸" or "Author: Orange Xiaoxing",
    contact = is_chinese and "Q群:1042944194 欢迎交流。" or "QQ Group: 1042944194 Welcome!",
    thanks = is_chinese and "感谢您的大力支持！" or "Thank you for your support!",
}

configuration_options = {
    Title(labels.basic_settings),
    {
        name = "event_count",
        label = labels.event_count,
        hover = labels.event_count_hover,
        options = {
            {description = labels.events(1), data = 1},
            {description = labels.events(2), data = 2},
            {description = labels.events(3), data = 3},
            {description = labels.events(4), data = 4},
            {description = labels.events(5), data = 5},
            {description = labels.events(6), data = 6},
            {description = labels.events(7), data = 7},
            {description = labels.events(8), data = 8},
            {description = labels.events(9), data = 9},
            {description = labels.events(10), data = 10},
            {description = labels.debug_all, data = 999},
        },
        default = 3,
    },
    {
        name = "news_style",
        label = labels.news_style,
        hover = labels.news_style_hover,
        options = {
            {description = labels.formal, data = "formal"},
            {description = labels.playful, data = "playful"},
        },
        default = "formal",
    },
    {
        name = "news_language",
        label = labels.news_language,
        hover = labels.news_language_hover,
        options = {
            {description = labels.chinese, data = "zh"},
            {description = labels.english, data = "en"},
        },
        default = "zh",
    },
    {
        name = "news_interval",
        label = labels.news_interval,
        hover = labels.news_interval_hover,
        options = {
            {description = labels.every_day, data = 0.33},
            {description = labels.half_day, data = 0.5},
            {description = labels.daily, data = 1},
            {description = labels.days(2), data = 2},
            {description = labels.days(3), data = 3},
            {description = labels.days(4), data = 4},
            {description = labels.days(5), data = 5},
            {description = labels.days(7), data = 7},
            {description = labels.days(10), data = 10},
        },
        default = 1,
    },
    
    Title(""),
    Title(labels.event_types),
    {
        name = "enable_negative",
        label = labels.enable_negative,
        hover = labels.enable_negative_hover,
        options = {
            {description = labels.enable, data = true},
            {description = labels.disable, data = false},
        },
        default = false,
    },
    {
        name = "enable_neutral",
        label = labels.enable_neutral,
        hover = labels.enable_neutral_hover,
        options = {
            {description = labels.enable, data = true},
            {description = labels.disable, data = false},
        },
        default = false,
    },
    
    Title(""),
    Title(labels.broadcast_style),
    {
        name = "news_header",
        label = labels.news_header,
        hover = labels.news_header_hover,
        options = {
            {description = labels.beautiful, data = "beautiful"},
            {description = labels.simple, data = "simple"},
            {description = labels.elegant, data = "elegant"},
            {description = labels.solemn, data = "solemn"},
        },
        default = "simple",
    },
    
    Title(""),
    Title(labels.warning_settings),
    {
        name = "enable_warning",
        label = labels.enable_warning,
        hover = labels.enable_warning_hover,
        options = {
            {description = labels.enable, data = true},
            {description = labels.disable, data = false},
        },
        default = false,
    },
    {
        name = "warning_time",
        label = labels.warning_time,
        hover = labels.warning_time_hover,
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
    Title(labels.experimental),
    Title(labels.experimental_warning),
    {
        name = "enable_no_repeat",
        label = labels.enable_no_repeat,
        hover = labels.enable_no_repeat_hover,
        options = {
            {description = labels.enable, data = true},
            {description = labels.disable, data = false},
        },
        default = false,
    },
    {
        name = "repeat_limit",
        label = labels.repeat_limit,
        hover = labels.repeat_limit_hover,
        options = {
            {description = labels.times(1), data = 1},
            {description = labels.times(2), data = 2},
            {description = labels.times(3), data = 3},
            {description = labels.times(4), data = 4},
            {description = labels.times(5), data = 5},
            {description = labels.times(6), data = 6},
            {description = labels.times(7), data = 7},
            {description = labels.times(8), data = 8},
            {description = labels.times(9), data = 9},
            {description = labels.times(10), data = 10},
        },
        default = 5,
    },
    
    Title(""),
    Title(labels.mod_info),
    Title(labels.version_info),
    Title(labels.event_breakdown),
    Title(labels.greeting),
    Title(labels.author_info),
    Title(labels.contact),
    Title(labels.thanks)

}
