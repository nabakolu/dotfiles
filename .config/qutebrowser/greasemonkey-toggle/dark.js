// ==UserScript==
// @name         Auto Dark Mode
// @namespace    https://rksh.me/
// @version      1.3
// @description  Applies a dark mode theme to every website while enabled.
// @author       Rakesh Gautam
// @homepageURL  https://github.com/rkshrksh/dark-mode-userscript
// @supportURL   https://github.com/rkshrksh/dark-mode-userscript/issues
// @updateURL    https://raw.githubusercontent.com/rkshrksh/dark-mode-userscript/main/dark-mode-userscript.js
// @downloadURL  https://raw.githubusercontent.com/rkshrksh/dark-mode-userscript/main/dark-mode-userscript.js
// @match        *://*/*
// @run-at       document-start
// ==/UserScript==

(function () {
    'use strict';

    const css = `
        html {
            transition: filter 0.3s ease, background-color 0.3s ease;
        }

        html.extension-dark-mode {
            filter: invert(1) hue-rotate(180deg) brightness(0.9) contrast(1.1) !important;
            background-color: white !important;
            color-scheme: dark !important;
        }

        html.extension-dark-mode img,
        html.extension-dark-mode video,
        html.extension-dark-mode iframe,
        html.extension-dark-mode canvas,
        html.extension-dark-mode svg {
            filter: invert(1) hue-rotate(180deg) !important;
        }
    `;

    function enableDarkMode() {
        if (!document.documentElement) {
            return;
        }

        if (!document.getElementById('dark-mode-core-css')) {
            const style = document.createElement('style');
            style.id = 'dark-mode-core-css';
            style.textContent = css;
            document.documentElement.appendChild(style);
        }

        document.documentElement.classList.add('extension-dark-mode');
    }

    enableDarkMode();
})();
