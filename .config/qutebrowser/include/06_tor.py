from qutebrowser.api import cmdutils

# satisfy lsp
if False:
    c = None
    config = None

TOR_PROXY = "socks://localhost:9050/"
SYSTEM_PROXY = "system"
TOR_WIDGET = "text:   TOR ENABLED"

# Initial state
c.content.proxy = SYSTEM_PROXY
c.statusbar.widgets = [w for w in c.statusbar.widgets if w != TOR_WIDGET]


@cmdutils.register(name="toggle-tor")
def toggle_tor():
    """Toggle the Tor proxy and status bar indicator."""

    widgets = [w for w in c.statusbar.widgets if w != TOR_WIDGET]

    if c.content.proxy == TOR_PROXY:
        c.content.proxy = SYSTEM_PROXY
        message = "Disabled Tor"
    else:
        c.content.proxy = TOR_PROXY

        try:
            idx = widgets.index("keypress") + 1
        except ValueError:
            idx = 0

        widgets.insert(idx, TOR_WIDGET)
        message = "Enabled Tor"

    c.statusbar.widgets = widgets
    print(message)
