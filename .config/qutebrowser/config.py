from qutebrowser.api import interceptor
import os
os.system("bisc")


config.load_autoconfig()

c.qt.force_platformtheme = 'gtk3'

c.tabs.background = True
c.tabs.new_position.related = 'next'
c.tabs.new_position.unrelated = 'next'
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

config.bind('D', 'config-cycle colors.webpage.darkmode.enabled')

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
config.bind('<space>a', 'spawn --userscript paywall')

config.bind('<Ctrl-n>', 'completion-item-focus next', mode='command')
config.bind('<Ctrl-p>', 'completion-item-focus prev', mode='command')

config.bind('<Ctrl-h>', 'fake-key <Backspace>', mode='insert')
config.bind('<Ctrl-j>', 'fake-key <Enter>', mode='insert')
config.bind('<Ctrl-n>', 'fake-key <Down>', mode='insert')
config.bind('<Ctrl-p>', 'fake-key <Up>', mode='insert')


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
c.content.user_stylesheets = ["~/.config/qutebrowser/css/none.css", "~/.config/qutebrowser/css/block.css", "~/.config/qutebrowser/css/monospace.css"]

# enable pdf viewing
c.content.pdfjs = False

# disable webgl
c.content.webgl = False

# set nvim in st as default editor
c.editor.command = ['kitty','-e','nvim', '{}']

# set lf to be the program in which downloads can be opened
c.downloads.open_dispatcher = "kitty -e /usr/local/bin/lf {}"

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
c.url.searchengines['chatgpt'] = 'https://chat.openai.com/?q={}'
c.url.searchengines['duckduckgo'] = 'https://duckduckgo.com/?q={}&kk=-1'
c.url.searchengines['archwiki'] = 'https://wiki.archlinux.org/index.php?search={}'
c.url.searchengines['google'] = 'https://www.google.de/search?q={}'
c.url.searchengines['scholar'] = 'https://scholar.google.com/scholar?q={}'
c.url.searchengines['deepld'] = 'https://www.deepl.com/translator#de/en/{}'
c.url.searchengines['deepldf'] = 'https://www.deepl.com/translator#de/fr/{}'
c.url.searchengines['deeplfd'] = 'https://www.deepl.com/translator#fr/de/{}'
c.url.searchengines['deepl'] = 'https://www.deepl.com/translator#en/de/{}'
c.url.searchengines['wiki'] = 'https://en.wikipedia.org/wiki/Special:Search?go=Go&search={}'
c.url.searchengines['wikid'] = 'https://de.wikipedia.org/wiki/Special:Search?go=Go&search={}'
c.url.searchengines['invidious'] = 'https://yewtu.be/search?q={}'
c.url.searchengines['qwant'] = 'https://www.qwant.com/?theme=-1&hc=0&hti=0&vt=1&b=0&s=0&l=en&locale=de_DE&home=daily&si=0&c=blue&ch=none&eco_suggest=1&q={}'
c.url.searchengines['searx'] = 'https://search.sapti.me/?preferences=eJx1V0uP3DYM_jWdi5EBkhQoephT0eYP5G7QEsdmLImOHuPx_vpSfqzl8e5hByuS4psfZQURW_aE4daiQw_mYsC1CVq8QYp8MazA4A3dJR8V28FgxNuFrIjUg-fndPvpE14sxo717ce_Py8B7hgQvOpu3y6xQ4u3QPnixWNIJoaaXe1wrCM0t__ABLxoplqYbB7obwxyvLJvL8u1OsTJrP4odBF9DYZaZ-X_xTjoBziFul7NLkp_J_RTTa6OFOX-QiR3J0dRlCrPxmz2KUBjRAG6lpxk4-8W2roOrAhMZVET_PHtH3AOQpUt0APr-k4GQyYPfWXJe_YlTRyv5LcKkX0p7ECx01DXFOXYkKH8V9cP0shhJsUmqR7jJhI1te2uQSn1JT6KCxJICB7v4q8ilDwstFE_SJJcr4UV4oRDeVTJG8KSohHfJLu1TYGUnFG0kK5rlip6OY_Uk4YIhzvia_5ruRoRsuAuv2TBwhBEJwxZo-VfNOR87lJRMj4d_Pj6lNhzh-Xw7tpzdmKL_-4Rq8D3OILHSpNHJSme1mzdPbmeQBUKWik_NCtfscYGfbseW-ZWXBwMTLlaYTdTcixLKkOR8nZgrctMddB4yD-rXrK62SMkB8VlcvIvcQof0zaVvyh0vOvoSfUQCgelcTz4qcppC3RguPZxqJHhJkS8-rB6B29m8qQKYzK-oAZwq4AdbWNKDW6wK8tNALst1lNALALhAZ3HgQt_BhDPWwpbQw-puWp8rKffI7hYLcUqirZMcq5WlX_eqwsWcuAbIaCV66SqoDo24MsZCBF8HDJOFYFE7ieOLKntc7SbjzGbFR2QDsIFVQBrFhwpZgR6xYaRmqm8Kqj5BKc9HQqRB6hh7sMrMWt_t5EJvxNHfJUKA6q5ET8h77FnsmBpoDi9Sj94esnJyGZJ7NAdvP36_ftfzz1HOml0e0MGfHNgS3mZbcT-0DbwyLnaCT41U4t2a8QB0cfUlA00J1RM9Bm9RmwKlk_SlaXsyE_q2Uk3VWFy7CaLpX_Y--qQ2IX0Qa9l8qK10B5-DddhdEf4s7I9DqNFzT5XgZNX2KW4o0spO_TtteWt9y_ojjsnN3wlw5ueVba0zaqX9i6cBf-kR1nqRtpMgR32Yc63V4zdjTeCCq_ncypm6iFnM-WUmzzmub-wuCv7xItP03GjPEgGVIIoBLVuK43zHiZ2h3bWLJvPV13a8HpfL58snVMIGCfLTvJY9MLdCHr6ciegoxJs5RxzsZayUdwdWPZAaXzdDCfDK_2QvZV2yt9K_wC1utXebNygtZMAoLUpJ2ue8SPuLBIpoP-MJ1gcP-NlzRL5mf32ZV0v533Dd7nmWnmulcFbeirDSRcrBWQR47YQc8OA7Or8fAgYD2C18WQxSJ1gbYojP0RZ-1EeEdtLYtAZNnahoRNYd-_cPABFvufzdXZt93AgL-_fBoogxQWbLxZ6p4HKVVV2wrK7DgVfSKd6S-Ca4inNAQeCZdWVwMNJRvqYTVlmqmcZubvhcYOG0KcmuZg2-EkD-twK73BkSMvbyC8l3mJMLsirJnRF9SbojlA1E46RTZxeoPqdsjmpgYwMXy5gIfYgi1yidl5ZM1K-rKZ8b265EnBzi0o_XE_jpknFN3YHJVY2gJXHYBU9uGCkuuXrlb121BeEGP2VCoCXBn8c9M2Es-mFfCryQj6iZ_xze7rvHxmDSYL44ZYL_7yup6uR3RLXzVXSGerl82j0wj-xA5q7fOTc-cSRyteqQ9W_b5qPDXe5F5bDSUcn4CFbHsW89Iz6yPzcvFJwtXxLTvIRZuRJfnbHQ8b2Wr46RJvNvXySkVapZY57nMJFXmoy9rf_AQY0hp8=&q={}'
c.url.searchengines['images'] = 'https://search.sapti.me/?category_images=on&preferences=eJx1V0uP3DYM_jWdi5EBkhQoephT0eYP5G7QEsdmLImOHuPx_vpSfqzl8e5hByuS4psfZQURW_aE4daiQw_mYsC1CVq8QYp8MazA4A3dJR8V28FgxNuFrIjUg-fndPvpE14sxo717ce_Py8B7hgQvOpu3y6xQ4u3QPnixWNIJoaaXe1wrCM0t__ABLxoplqYbB7obwxyvLJvL8u1OsTJrP4odBF9DYZaZ-X_xTjoBziFul7NLkp_J_RTTa6OFOX-QiR3J0dRlCrPxmz2KUBjRAG6lpxk4-8W2roOrAhMZVET_PHtH3AOQpUt0APr-k4GQyYPfWXJe_YlTRyv5LcKkX0p7ECx01DXFOXYkKH8V9cP0shhJsUmqR7jJhI1te2uQSn1JT6KCxJICB7v4q8ilDwstFE_SJJcr4UV4oRDeVTJG8KSohHfJLu1TYGUnFG0kK5rlip6OY_Uk4YIhzvia_5ruRoRsuAuv2TBwhBEJwxZo-VfNOR87lJRMj4d_Pj6lNhzh-Xw7tpzdmKL_-4Rq8D3OILHSpNHJSme1mzdPbmeQBUKWik_NCtfscYGfbseW-ZWXBwMTLlaYTdTcixLKkOR8nZgrctMddB4yD-rXrK62SMkB8VlcvIvcQof0zaVvyh0vOvoSfUQCgelcTz4qcppC3RguPZxqJHhJkS8-rB6B29m8qQKYzK-oAZwq4AdbWNKDW6wK8tNALst1lNALALhAZ3HgQt_BhDPWwpbQw-puWp8rKffI7hYLcUqirZMcq5WlX_eqwsWcuAbIaCV66SqoDo24MsZCBF8HDJOFYFE7ieOLKntc7SbjzGbFR2QDsIFVQBrFhwpZgR6xYaRmqm8Kqj5BKc9HQqRB6hh7sMrMWt_t5EJvxNHfJUKA6q5ET8h77FnsmBpoDi9Sj94esnJyGZJ7NAdvP36_ftfzz1HOml0e0MGfHNgS3mZbcT-0DbwyLnaCT41U4t2a8QB0cfUlA00J1RM9Bm9RmwKlk_SlaXsyE_q2Uk3VWFy7CaLpX_Y--qQ2IX0Qa9l8qK10B5-DddhdEf4s7I9DqNFzT5XgZNX2KW4o0spO_TtteWt9y_ojjsnN3wlw5ueVba0zaqX9i6cBf-kR1nqRtpMgR32Yc63V4zdjTeCCq_ncypm6iFnM-WUmzzmub-wuCv7xItP03GjPEgGVIIoBLVuK43zHiZ2h3bWLJvPV13a8HpfL58snVMIGCfLTvJY9MLdCHr6ciegoxJs5RxzsZayUdwdWPZAaXzdDCfDK_2QvZV2yt9K_wC1utXebNygtZMAoLUpJ2ue8SPuLBIpoP-MJ1gcP-NlzRL5mf32ZV0v533Dd7nmWnmulcFbeirDSRcrBWQR47YQc8OA7Or8fAgYD2C18WQxSJ1gbYojP0RZ-1EeEdtLYtAZNnahoRNYd-_cPABFvufzdXZt93AgL-_fBoogxQWbLxZ6p4HKVVV2wrK7DgVfSKd6S-Ca4inNAQeCZdWVwMNJRvqYTVlmqmcZubvhcYOG0KcmuZg2-EkD-twK73BkSMvbyC8l3mJMLsirJnRF9SbojlA1E46RTZxeoPqdsjmpgYwMXy5gIfYgi1yidl5ZM1K-rKZ8b265EnBzi0o_XE_jpknFN3YHJVY2gJXHYBU9uGCkuuXrlb121BeEGP2VCoCXBn8c9M2Es-mFfCryQj6iZ_xze7rvHxmDSYL44ZYL_7yup6uR3RLXzVXSGerl82j0wj-xA5q7fOTc-cSRyteqQ9W_b5qPDXe5F5bDSUcn4CFbHsW89Iz6yPzcvFJwtXxLTvIRZuRJfnbHQ8b2Wr46RJvNvXySkVapZY57nMJFXmoy9rf_AQY0hp8=&q={}'
c.url.searchengines['youtube'] = 'https://www.youtube.com/results?search_query={}'
c.url.searchengines['opgg'] = 'https://euw.op.gg/champions/{}'
c.url.searchengines['DEFAULT'] = c.url.searchengines['duckduckgo']

# set bookmarks as start page
c.url.start_pages = "about:blank"

# make url be the window title (makes keepassxc work)
c.window.title_format = "{current_url}"

# Configure the filepicker
filepicker = [
    "kitty",
    "--class",
    "FLOATING",
    "--title",
    "File-Picker",
    "-e",
    "lf",
    "-command",
    "set nohidden",
    "-selection-path={}",
]
c.fileselect.handler = "external"
c.fileselect.folder.command = filepicker
c.fileselect.multiple_files.command = filepicker
c.fileselect.single_file.command = filepicker

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

c.fonts.default_family = "Roboto Mono Nerd Font"

# pywal integration
config.source('qutewal.py')

# url redirection
config.source('redirects.py')

