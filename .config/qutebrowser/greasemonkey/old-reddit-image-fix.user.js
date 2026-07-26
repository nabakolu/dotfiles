// ==UserScript==
// @name         Old Reddit Image Fix
// @namespace    http://tampermonkey.net/
// @version      1.1
// @description  Fixes images in comments and posts on the old Reddit website
// @author       fruitsnack01
// @match        *://www.reddit.com/*
// @match        *://old.reddit.com/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    const link = document.querySelectorAll('a');

    link.forEach((element) => {
        if (element.innerHTML == '&lt;image&gt;'){
            const img = document.createElement('img');
            img.src = element.href;
            img.style.width = '240px';
            img.style.maxWidth = '100%';
            element.replaceWith(img);

            img.addEventListener('mouseover', function() {
                img.style.cursor = 'pointer';
            });

            img.addEventListener('click', function() {
                const img_src = img.src;
                window.open(img_src, '_blank');
            });
        }

        if (element && element.textContent.includes('https://preview.redd.it/')) {
            const img2 = document.createElement('img');
            img2.src = element.href;
            //img2.style.width = '240px';
            img2.style.maxWidth = '100%';
            element.replaceWith(img2);

            img2.addEventListener('mouseover', function() {
                img2.style.cursor = 'pointer';
            });

            img2.addEventListener('click', function() {
                const img2_src = img2.src;
                window.open(img2_src, '_blank');
            });
        }
    });
})();
