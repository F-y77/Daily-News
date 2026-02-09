name = "每日新闻 (Daily News)"
description = "每天白天在聊天框显示新闻，预告当天会发生的特殊事件。\n\nDisplays daily news in chat during daytime, announcing special events that will happen today."
author = "Your Name"
version = "1.0.0"

forumthread = ""
api_version = 10

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = false
client_only_mod = false

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {"daily", "news", "events"}

-- 配置选项
configuration_options = {
    {
        name = "event_count",
        label = "每日事件数量",
        hover = "每天播报的新闻事件数量",
        options = {
            {description = "1个事件", data = 1},
            {description = "2个事件", data = 2},
            {description = "3个事件", data = 3},
        },
        default = 1,
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
}
