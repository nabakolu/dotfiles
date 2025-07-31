import operator
from qutebrowser.api import interceptor, message


# Any return value other than a literal 'False' means we redirected
REDIRECT_MAP = {
    # "www.reddit.com": operator.methodcaller('setHost', 'old.reddit.com'),
    "x.com": operator.methodcaller('setHost', 'nitter.net'),
    "www.x.com": operator.methodcaller('setHost', 'nitter.net'),
    "twitter.com": operator.methodcaller('setHost', 'nitter.net'),
    "www.twitter.com": operator.methodcaller('setHost', 'nitter.net'),
    "mobile.twitter.com": operator.methodcaller('setHost', 'nitter.net'),
    "www.mobile.twitter.com": operator.methodcaller('setHost', 'nitter.net'),

}  # type: typing.Dict[str, typing.Callable[..., typing.Optional[bool]]]


def int_fn(info: interceptor.Request):
    """Block the given request if necessary."""
    if (info.resource_type != interceptor.ResourceType.main_frame or
            info.request_url.scheme() in {"data", "blob"}):
        return
    url = info.request_url
    redir = REDIRECT_MAP.get(url.host())
    if redir is not None and redir(url) is not False:
        if "reddit.com/media" in url.toString():  # dont redirect reddit media links
            return
        message.info("Redirecting to " + url.toString())
        info.redirect(url)


interceptor.register(int_fn)
