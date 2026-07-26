# satisfy lsp
if False:
    c = None
    config = None

c.content.proxy = 'system'
c.statusbar.widgets = ["keypress" ,"search_match" ,"url" ,"scroll" ,"history" ,"tabs" ,"progress"]
config.bind('tt', 'config-source ~/.config/qutebrowser/include/tor/enable-tor.py ;; message-info "Enabled Tor"')
