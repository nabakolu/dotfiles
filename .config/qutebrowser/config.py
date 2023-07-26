from qutebrowser.api import interceptor
import os
os.system("bisc")


config.load_autoconfig()

c.tabs.background = True
c.downloads.position = 'bottom'

c.qt.args = ["ppapi-widevine-path=/usr/lib/chromium/WidevineCdm/_platform_specific/linux_x64/libwidevinecdm.so", "lang=en-GB"] # temporary fix

############
# keybinds #
############

# bind some stylesheets
config.bind('cm', 'config-list-add content.user_stylesheets "~/.config/qutebrowser/css/monospace.css"')
config.bind('Cm', 'config-list-remove content.user_stylesheets "~/.config/qutebrowser/css/monospace.css"')

config.unbind('m')
config.unbind('M')
config.unbind('b')
config.unbind('B')

# bookmarks bindings
config.bind('bb', 'open qute://bookmarks/')
config.bind('Bb', 'open -t qute://bookmarks/')
config.bind('BB', 'open -t qute://bookmarks/')
config.bind('ba', 'bookmark-add')
config.bind('bd', 'bookmark-del')
config.bind('bA', 'set-cmd-text -s :bookmark-add {url}')

# history bindings
config.bind('bh', 'open qute://history/')
config.bind('Bh', 'open -t qute://history/')
config.bind('BH', 'open -t qute://history/')


# download videos
config.bind('<Space>m', 'hint links spawn --detach yt-download.sh {hint-url}')

# Open link in preferred application
config.bind('<Space>s', 'hint all spawn --detach urlopener.sh {hint-url}')

# spawn mpv with hint links
config.bind('m', 'hint links spawn --detach mpv {hint-url}')
config.bind('M', 'spawn --detach mpv {url}')

# spawn umpv with hint links when pressing ctrl m
config.bind('<Ctrl-m>', 'hint links spawn --detach umpv {hint-url}')
config.bind('<Ctrl-shift-m>', 'spawn --detach umpv {url}')


config.bind('yf', 'hint all yank')

config.unbind('D')
config.bind('D1', 'set colors.webpage.darkmode.enabled true;; set colors.webpage.preferred_color_scheme dark;; spawn sh /home/lukas/.config/qutebrowser/enable-dark-buttons.sh;; spawn sh /home/lukas/.config/qutebrowser/disable_dark.sh;; restart')
config.bind('D2', 'set colors.webpage.darkmode.enabled false;; set colors.webpage.preferred_color_scheme light;; spawn sh /home/lukas/.config/qutebrowser/disable-dark-buttons.sh;; spawn sh /home/lukas/.config/qutebrowser/disable_dark.sh;; restart')
config.bind('D3', 'set colors.webpage.darkmode.enabled false;; set colors.webpage.preferred_color_scheme dark;; spawn sh /home/lukas/.config/qutebrowser/disable-dark-buttons.sh;; spawn sh /home/lukas/.config/qutebrowser/enable_dark.sh;; restart')

config.bind('gd', 'download-open')
config.bind('gi', 'hint inputs')

config.set('hints.selectors', {'reddit-gallery': ['.gallery-navigation'],'expand-comment': ['.expand'],'preview': ['.expando-button'], **c.hints.selectors},pattern='*://*.reddit.com/*')
config.bind('<space>j', 'hint preview')
config.bind('<space>k', 'hint expand-comment')
config.bind('<space>J', 'hint reddit-gallery')
config.bind('<space>w', 'jseval (function () { '+
'  var i, elements = document.querySelectorAll("body *");'+
''+
'  for (i = 0; i < elements.length; i++) {'+
'    var pos = getComputedStyle(elements[i]).position;'+
'    if (pos === "fixed" || pos == "sticky") {'+
'      elements[i].parentNode.removeChild(elements[i]);'+
'    }'+
'  }'+
'})();');


config.bind('<space>q', 'spawn --userscript qr.sh {url}')
config.bind('<space>t', 'spawn --userscript translate')
config.bind('<space>r', 'spawn --userscript readability')

config.bind('<Ctrl-n>', 'completion-item-focus next', mode='command')
config.bind('<Ctrl-p>', 'completion-item-focus prev', mode='command')

config.bind('<Ctrl-h>', 'fake-key <Backspace>', mode='insert')
config.bind('<Ctrl-j>', 'fake-key <Enter>', mode='insert')


####################
# general settings #
####################

# set website dark mode
# config.set("colors.webpage.darkmode.enabled", True)
config.set("colors.webpage.darkmode.policy.images", "never")
config.set("colors.webpage.darkmode.threshold.background", 100)

# disable javascript
#c.content.javascript.enabled = False

# disable autoplay
c.content.autoplay = False

# dont store cookies
c.content.cookies.store = True

# set custom css
c.content.user_stylesheets = ["~/.config/qutebrowser/css/none.css", "~/.config/qutebrowser/css/block.css", "~/.config/qutebrowser/css/monospace.css", "~/.config/qutebrowser/css/dark-button.css"]

# enable pdf viewing
c.content.pdfjs = False

# disable webgl
c.content.webgl = False

# set nvim in st as default editor
c.editor.command = ['st','-e','nvim', '{}']

# set lf to be the program in which downloads can be opened
c.downloads.open_dispatcher = "st -e /usr/local/bin/lf {}"

# make hint chars upper case
c.hints.uppercase = False

# set input timeout to 20s
c.input.partial_timeout = 20000

# make tabs vertical
c.tabs.position = "left"

# make tabs 32 pixel wide
c.tabs.width = 32

# no wrapping when changin tabs
c.tabs.wrap = True

# set bookmarks as default page
c.url.default_page = "about:blank"

# open search engine url, when no search query is made
c.url.open_base_url = True


# set some searchengines
c.url.searchengines['duckduckgo'] = 'https://duckduckgo.com/?q={}&kk=-1'
c.url.searchengines['archwiki'] = 'https://wiki.archlinux.org/index.php?search={}'
c.url.searchengines['google'] = 'https://www.google.de/search?q={}'
c.url.searchengines['deepld'] = 'https://www.deepl.com/translator#de/en/{}'
c.url.searchengines['deepldf'] = 'https://www.deepl.com/translator#de/fr/{}'
c.url.searchengines['deeplfd'] = 'https://www.deepl.com/translator#fr/de/{}'
c.url.searchengines['deepl'] = 'https://www.deepl.com/translator#en/de/{}'
c.url.searchengines['wiki'] = 'https://en.wikipedia.org/wiki/{}'
c.url.searchengines['wikid'] = 'https://de.wikipedia.org/wiki/{}'
c.url.searchengines['youtube'] = 'https://yewtu.be/search?q={}'
c.url.searchengines['qwant'] = 'https://www.qwant.com/?theme=-1&hc=0&hti=0&vt=1&b=0&s=0&l=en&locale=de_DE&home=daily&si=0&c=blue&ch=none&eco_suggest=1&q={}'
c.url.searchengines['searx'] = 'https://searx.be/?preferences=eJxtV8tu7DYM_ZrOxsig7V0UXcyqQLct0Ls3aIljM5ZFRQ_POF9fyo-xHGcRJzqiJOqQPFQURGzZE4ZbixY9mIsB2yZo8QZGBqzA4A3tBVJkxYMzGPHWMrcGLzSIXe08P6fbT5_wMmDsWN_-_ee_n5cAdwwIXnW3Xy-xwwFvHBT4i8eQTAw129rio47Q3P4GE_CimWqZZDOivzHI8Mq-vcyr3kKcxBHDLSnWOF4CZV_qBc7OXRTaiL4GQ60d5O_FJdAjWIW6Xn1ZjvpI6KeabB0pyvrZkuydLEXZU3k2ZgE1BWiMLEfbkhWa_myhrevAisBUA2qCX37_C6yFUOX9acS6vpPBkGHXVwN5z77ExO1KvlWI7EvjZXVFoa7XWMxoJFXXM9OL1ZNGOV8Ryq0EaMi25YI8rhbzYtmMjqSRBV1-z2hskuoximWUsVLqLY6FATu0EoyAxVZCTgge76UTgj30SBLNwpMJXTlUyRvCEtGInxKwekiB1DweCWyUKxfHad1WGufIENsDNw_qSUOEw55yn_zT8vfomZolIAM4AeUrSJRATwdPf3sWC-7aM-k9cHdDqvelgUesAt_jAzxWmjwqCfW0knz3ZHuCMqitJCE0WxAkvRv07TpcSq0KqmMDviR9nXEGppxPYfeonBlY4lIGvXWsdUl7B42H_FlPJAuFeS-Xg1BsbkjM_VRldgJ9M8H3SrFtpZJLmg03IeLVh_UU-DSTJxV2P0Q8QDmwq4F1w_bXBLAfk3PSo-PiZAfiY0thy2OXmqsk0z6SOi2Z-3hImpXxnYFzaizwqWwCOoJFTg5oBnL0qvx5RRsGyMxsQMBBNiX1XURDzn2XNbXwLXI_ceTQcZ-52e4cHxSz3H2VomSDxD10xTUm6PhQDhOnmBosnH8hr1oEMtPAueYKs5EG5GL8oGY6qJXBJ1jtCb7WacPcn4pX5F-w_F2Bj8QRv1oFTl6d0CxLFKcTzNMX_jSp-Mn2WM8_fvzx3LkM-GlhKA0GfkfsS8TCmNneAZ-aqcVhy2eH6L-QOodEOl-flfGBTTHl0yBd5cBkT4OI3EHKPYwHt51UiNkS71v4nMOSe3vRLVR2Ke7i8trogvbY6eb9DNn0rLJ365JG4qtgcHuq5EmXr3pqQ4f4NlFT2-6kSz_wkveHCGqWbuSrLm1iiNJYstay0OiPQv7AzK3f51CCtjnywqIksZVL4I7JcZQK3ZFxzDwsjFDcT190tHRwVdYTyyt-uPCKneSjW3ddxHbQze4aWbEiTqV5gW0ev5Oowb7q822V3lKLbTseAjLQUxlOutBbkD6Em-pnWQVpVbmhBpTnWaFL25woqfQ6WBvxcT5E6XpRGujWRZ3OxbAbuU5UzL5mycvTs4HCZze5LckW4T2wKZ5piie5k4yWfDxeTGRU9Szlejf82NpN6FOTbExbJSSHPoXX9eXVSVq6tKRkLDrLLJ3VV53KBMx0bxF4sFmE3nVF8g3TIDkpHTF6sMHIfQ-ZrNGWO3htqS-BJ_VspY9VYbJsZa99Mry7q3uUy2P0V9qA_dXqTJJiDresDs_rOroy1Mtb--Hlvbv2rn06oLnL2_jOpxkhqFYdqv40I52hlgD3OIWXkHx_eJeb0zI47dJxiKLEKK5JE1PfuTaLn-SRWv5zmeRdb-R9dXbVQ9aSWl6dstuQ0-EirVQS9fY_HGHmCw==&q={}'
#c.url.searchengines['youtube'] = 'https://www.youtube.com/results?search_query={}'
c.url.searchengines['opgg'] = 'https://euw.op.gg/champions/{}'
c.url.searchengines['DEFAULT'] = c.url.searchengines['searx']

# set bookmarks as start page
c.url.start_pages = "about:blank"

# make url be the window title (makes keepassxc work)
c.window.title_format = "{current_url}"

# set ad blocker to use braves adblock and the hosts file
c.content.blocking.method = "both"
# set ad block lists
c.content.blocking.adblock.lists = ['https://easylist.to/easylist/easylist.txt', 'https://easylist.to/easylist/easyprivacy.txt', 'https://easylist-downloads.adblockplus.org/easylistdutch.txt', 'https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt', 'https://www.i-dont-care-about-cookies.eu/abp/', 'https://secure.fanboy.co.nz/fanboy-cookiemonster.txt']

# add youtube ad block
def filter_yt(info: interceptor.Request):
    url = info.request_url
    if (
            url.host() == "www.youtube.com"
            and url.path() == "/get_video_info"
            and "&adformat=" in url.query()
    ):
        info.block()

interceptor.register(filter_yt)

#c.content.headers.user_agent = "Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101 Firefox/68.0"
#c.content.headers.user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.79 Safari/537.36 Edge/14.14393"
c.content.headers.accept_language = "en-US,en;q=0.5"
#c.content.headers.custom = {"accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"}
#c.content.canvas_reading = False

c.fonts.default_family = "nabakolu"

# pywal integration
config.source('qutewal.py')

# url redirection
config.source('redirects.py')

