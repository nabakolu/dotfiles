from qutebrowser.api import interceptor

config.load_autoconfig()

c.tabs.background = True
c.downloads.position = 'bottom'

############
# keybinds #
############

# bind some stylesheets
config.bind(',ca', 'set content.user_stylesheets "[~/.config/qutebrowser/css/apprentice-all-sites.css, ~/.config/qutebrowser/css/block.css]"')
config.bind(',cd', 'set content.user_stylesheets "[~/.config/qutebrowser/css/darculized-all-sites.css,  ~/.config/qutebrowser/css/block.css]"')
config.bind(',cg', 'set content.user_stylesheets "[~/.config/qutebrowser/css/gruvbox-all-sites.css, ~/.config/qutebrowser/css/block.css]"')
config.bind(',csd', 'set content.user_stylesheets "[~/.config/qutebrowser/css/solarized-dark-all-sites.css, ~/.config/qutebrowser/css/block.css]"')
config.bind(',csl', 'set content.user_stylesheets "[~/.config/qutebrowser/css/solarized-light-all-sites.css, ~/.config/qutebrowser/css/block.css]"')
config.bind(',cn', 'set content.user_stylesheets "[~/.config/qutebrowser/css/none.css, ~/.config/qutebrowser/css/block.css]"')


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

# spawn mpv with hint links when pressing m
config.bind('m', 'hint links spawn --detach mpv {hint-url}')
config.bind('M', 'spawn --detach mpv {url}')


####################
# general settings #
####################

# set website dark mode
config.set("colors.webpage.darkmode.enabled", True)
config.set("colors.webpage.darkmode.policy.images", "never")

# disable javascript
c.content.javascript.enabled = False

# disable autoplay
c.content.autoplay = False

# dont store cookies
c.content.cookies.store = False

# set custom css
c.content.user_stylesheets = ["~/.config/qutebrowser/css/none.css", "~/.config/qutebrowser/css/block.css"]

# enable pdf viewing
c.content.pdfjs = True

# disable webgl
c.content.webgl = False

# set vim in st as default editor
c.editor.command = ['st','-e','vim', '{}']

# make hint chars upper case
c.hints.uppercase = True

# set input timeout to 20s
c.input.partial_timeout = 20000

# make tabs vertical
c.tabs.position = "left"

# make tabs 32 pixel wide
c.tabs.width = 32

# set bookmarks as default page
c.url.default_page = "qute://bookmarks"

# open search engine url, when no search query is made
c.url.open_base_url = True

# set some searchengines
c.url.searchengines['duckduckgo'] = 'https://duckduckgo.com/?q={}'
c.url.searchengines['archwiki'] = 'https://wiki.archlinux.org/index.php?search={}'
c.url.searchengines['google'] = 'https://www.google.de/search?q={}'
c.url.searchengines['deepl'] = 'https://www.deepl.com/translator#de/en/{}'
c.url.searchengines['wiki'] = 'https://en.wikipedia.org/wiki/{}'
c.url.searchengines['youtube'] = 'https://www.youtube.com/results?search_query={}'
c.url.searchengines['opgg'] = 'https://euw.op.gg/champion/{}'

# set bookmarks as start page
c.url.start_pages = "qute://bookmarks"

# make url be the window title (makes keepassxc work)
c.window.title_format = "{current_url}"

# set ad blocker to use braves adblock and the hosts file
c.content.blocking.method = "both"
# set ad block lists
c.content.blocking.adblock.lists = ["https://easylist.to/easylist/easylist.txt", "https://easylist.to/easylist/easyprivacy.txt", "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt"]

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

c.content.headers.accept_language = "en-US,en;q=0.5"
c.content.headers.custom = {"accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"}
c.content.canvas_reading = False

# pywal integration
config.source('qutewal.py')

# url redirection
config.source('redirects.py')

