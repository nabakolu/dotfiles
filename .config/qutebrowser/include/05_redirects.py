from PyQt6.QtCore import QUrl

from qutebrowser.api import interceptor
from qutebrowser.extensions import interceptors
from qutebrowser.api import cmdutils
from qutebrowser.utils import message
import re


REDIRECTS_ENABLED = True


@cmdutils.register(name="toggle-redirects")
def toggle_redirects():
    """Toggle URL redirects."""
    global REDIRECTS_ENABLED
    REDIRECTS_ENABLED = not REDIRECTS_ENABLED
    message.info(
        f"Redirects {'enabled' if REDIRECTS_ENABLED else 'disabled'}"
    )

def twitter(url: QUrl) -> QUrl | None:
    new_url = QUrl(url)
    new_url.setHost("xcancel.com")
    return new_url


def youtube(url: QUrl) -> QUrl | None:
    if "watch?v=" not in url.toString():
        return None

    new_url = QUrl(url)
    new_url.setHost("youtube.ttools.io")
    return new_url


def reddit(url: QUrl) -> QUrl | None:
    host = url.host()
    path = url.path()

    if (
        host == "old.reddit.com"
        or host == "preview.redd.it"
        or path.startswith("/media")
        or re.match(r"^/r/[^/]+/s/[^/]+$", path)
    ):
        return None

    new_url = QUrl(url)
    new_url.setHost("old.reddit.com")
    return new_url


def fandom(url: QUrl) -> QUrl | None:
    host = url.host()

    if not host.endswith(".fandom.com"):
        return None

    subdomain = host.removesuffix(".fandom.com")
    if not subdomain:
        return None

    new_url = QUrl(url)
    new_url.setScheme("https")
    new_url.setHost("breezewiki.com")
    new_url.setPath(f"/{subdomain}{url.path()}")

    return new_url


def rewrite(info: interceptor.Request):
    if not REDIRECTS_ENABLED:
        return

    # Only rewrite top-level navigations.
    if info.resource_type is not interceptor.ResourceType.main_frame:
        return

    url = info.request_url
    host = url.host()

    new_url = None

    if host in {"youtube.com", "www.youtube.com"}:
        new_url = youtube(url)
    elif host in {"reddit.com", "www.reddit.com"}:
        new_url = reddit(url)
    elif host in {"twitter.com", "www.twitter.com", "x.com", "www.x.com"}:
        new_url = twitter(url)
    elif host.endswith(".fandom.com"):
        new_url = fandom(url)

    if new_url is not None and new_url != url:
        try:
            info.redirect(new_url)
        except interceptors.RedirectException:
            # Another interceptor already redirected this request.
            pass


interceptor.register(rewrite)
