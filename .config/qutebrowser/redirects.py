import qutebrowser.api.interceptor

def rewrite(request: qutebrowser.api.interceptor.Request):
    url = request.request_url.host()

    if url == 'reddit.com' or url == 'www.reddit.com':
        request.request_url.setHost('teddit.net')
        request.redirect(request.request_url)

qutebrowser.api.interceptor.register(rewrite)
