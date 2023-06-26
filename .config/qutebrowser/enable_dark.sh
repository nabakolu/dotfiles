#!/bin/sh
mv ~/.config/qutebrowser/greasemonkey/dark.js.disabled ~/.config/qutebrowser/greasemonkey/dark.js

echo ' button, input, input[type="file"]{
        background-color: #000000;
        color: #ffffff;
}'  > ~/.config/qutebrowser/css/dark-button.css
