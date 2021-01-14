c.tabs.background = True
c.downloads.position = 'bottom'

############
# keybinds #
############

# bind some stylesheets
config.bind(',ca', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/css/apprentice-all-sites.css ""')
config.bind(',cd', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/css/darculized-all-sites.css ""')
config.bind(',cg', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/css/gruvbox-all-sites.css ""')
config.bind(',csd', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/css/solarized-dark-all-sites.css ""')
config.bind(',csl', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/css/solarized-light-all-sites.css ""')
config.bind(',cn', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/css/none.css ""')


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

# spawn mpv with hint links when pressing m
config.bind('m', 'hint links spawn mpv {hint-url}')


####################
# general settings #
####################

# set website dark mode
config.set("colors.webpage.darkmode.enabled", True)

# disable javascript
c.content.javascript.enabled = False

# disable autoplay
c.content.autoplay = False

# dont store cookies
c.content.cookies.store = False

# enable pdf viewing
c.content.pdfjs = True

# set standard stylesheet to gruvbox
#c.content.user_stylesheets = '~/.config/qutebrowser/css/gruvbox-all-sites.css'

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

# set some searchengines
c.url.searchengines['ddg'] = 'https://duckduckgo.com/?q={}'
c.url.searchengines['archwiki'] = 'https://wiki.archlinux.org/index.php?search={}'
c.url.searchengines['google'] = 'https://www.google.de/search?q={}'
c.url.searchengines['deepl'] = 'https://www.deepl.com/translator#de/en/{}'
c.url.searchengines['wiki'] = 'https://en.wikipedia.org/wiki/{}'
c.url.searchengines['youtube'] = 'https://www.youtube.com/results?search_query={}'

# make url be the window title (makes keepassxc work)
c.window.title_format = "{current_url}"




# pywal integration
config.source('qutewal.py')
