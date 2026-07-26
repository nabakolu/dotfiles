# satisfy lsp
if False:
    c = None
    config = None

c.qt.force_platformtheme = 'gtk3'

# set custom css
c.content.user_stylesheets = ["~/.config/qutebrowser/css/none.css", "~/.config/qutebrowser/css/block.css", "~/.config/qutebrowser/css/monospace.css"]

# make tabs vertical
c.tabs.position = "left"

# make tabs 32 pixel wide
c.tabs.width = 32

# make hint chars upper case
c.hints.uppercase = False

# dont shrink completion window
c.completion.shrink = False

# set font
c.fonts.default_family = "Roboto Mono Nerd Font"
