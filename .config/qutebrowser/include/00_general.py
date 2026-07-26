import os
os.system("bisc")

# satisfy lsp
if False:
    c = None
    config = None

c.tabs.background = True
c.tabs.new_position.related = 'next'
c.tabs.new_position.unrelated = 'next'
c.downloads.position = 'bottom'

home = os.environ["HOME"]
c.qt.args += [
    f"stylesheet={home}/.config/qutebrowser/qss/fix-tooltips.qss",
    "ppapi-widevine-path=/usr/lib/chromium/WidevineCdm/_platform_specific/linux_x64/libwidevinecdm.so",
    "lang=en-GB"
]


# set website dark mode
config.set("colors.webpage.darkmode.policy.images", "never")
config.set("colors.webpage.darkmode.threshold.background", 100)

# disable autoplay
c.content.autoplay = False

# store cookies
c.content.cookies.store = True

# disable pdf viewing
c.content.pdfjs = False

# enable webgl
c.content.webgl = True

# set nvim in st as default editor
c.editor.command = ['kitty', '-e', 'nvim', '{}']

# set lf to be the program in which downloads can be opened
c.downloads.open_dispatcher = "kitty -e /usr/local/bin/lf {}"

# set input timeout to 20s
c.input.partial_timeout = 20000

# no wrapping when changin tabs
c.tabs.wrap = True

# set bookmarks as default page
c.url.default_page = "about:blank"

# open search engine url, when no search query is made
c.url.open_base_url = True

# set blank page as start page
c.url.start_pages = "about:blank"

# make url be the window title (makes keepassxc work)
c.window.title_format = "{current_url}"

# Configure the filepicker
filepicker = [
    "kitty",
    "--class",
    "FLOATING",
    "--title",
    "File-Picker",
    "-e",
    "lf",
    "-command",
    "set nohidden",
    "-selection-path={}",
]
c.fileselect.handler = "external"
c.fileselect.folder.command = filepicker
c.fileselect.multiple_files.command = filepicker
c.fileselect.single_file.command = filepicker

# set ad blocker to use braves adblock and the hosts file
c.content.blocking.method = "both"
# set ad block lists
c.content.blocking.adblock.lists = ['https://easylist.to/easylist/easylist.txt', 'https://easylist.to/easylist/easyprivacy.txt', 'https://easylist-downloads.adblockplus.org/easylistdutch.txt',
                                    'https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt', 'https://www.i-dont-care-about-cookies.eu/abp/', 'https://secure.fanboy.co.nz/fanboy-cookiemonster.txt']

c.content.headers.accept_language = "en-US,en;q=0.5"
