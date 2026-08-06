# satisfy lsp
if False:
    c = None
    config = None

config.bind('tt', 'toggle-tor')

config.bind('PP', 'open -t -- {clipboard}')
config.bind('pP', 'open -- {clipboard}')

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
config.bind('<Space>M', 'spawn --detach yt-download.sh {url}')

# Open link in preferred application
config.bind('<Space>s', 'hint all spawn --detach urlopener.sh {hint-url}')

# spawn mpv with hint links
config.bind('m', 'hint links spawn --detach mpv {hint-url}')
config.bind('M', 'spawn --detach mpv {url}')

# spawn unique_mpv with hint links when pressing ctrl m
config.bind('<Ctrl-m>', 'hint links spawn --detach unique_mpv {hint-url}')
config.bind('<Ctrl-shift-m>', 'spawn --detach unique_mpv {url}')


config.bind('yf', 'hint all yank')

config.bind('D', 'config-cycle colors.webpage.darkmode.enabled ;; config-cycle colors.webpage.bg #FFFFFF #000000')

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
config.bind('<space>R', 'spawn --userscript readability')
config.bind('<space>a', 'spawn --userscript paywall')
config.bind("<space>r", "toggle-redirects")

config.bind('<Ctrl-n>', 'completion-item-focus next', mode='command')
config.bind('<Ctrl-p>', 'completion-item-focus prev', mode='command')

config.bind('<Ctrl-h>', 'fake-key <Backspace>', mode='insert')
config.bind('<Ctrl-j>', 'fake-key <Enter>', mode='insert')
config.bind('<Ctrl-n>', 'fake-key <Down>', mode='insert')
config.bind('<Ctrl-p>', 'fake-key <Up>', mode='insert')
