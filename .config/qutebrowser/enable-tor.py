c.content.proxy = 'socks://localhost:9050/'
c.statusbar.widgets = ["keypress" ,"text:   TOR ENABLED", "search_match" ,"url" ,"scroll" ,"history" ,"tabs" ,"progress"]
config.bind('tt', 'config-source ~/.config/qutebrowser/disable-tor.py ;; message-info "Disabled Tor"')
