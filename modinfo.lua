local MOD_VERSION = "0.6.2"

name = "每日新闻 (Daily News)"
description = [[

每天白天在聊天框显示新闻，预告当天会发生的特殊事件。50种不同事件。
Displays daily news in chat during daytime. 50 different events.

版本 Version: ]]..MOD_VERSION..[[


推荐开荒使用 We recommend using it for The first time. 

因为现版本新闻过于少且全是生成事件，在家的时候就容易乱糟糟，好在新闻播放是每天白天延迟播放，可以在跳出右上角科学机器的时候离开基地。
Because the current version of the news is too limited and all are generated events, it can easily become chaotic when at home. Fortunately, the news is broadcast at a delayed time during the daytime, allowing one to leave the base when the scientific machine pops up in the upper right corner.

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

server_filter_tags = {"daily_news", "每日新闻", "events"}

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
        default = 2,
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
