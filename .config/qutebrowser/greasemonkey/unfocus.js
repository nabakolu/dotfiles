// ==UserScript==
// @name         Unfocus
// @namespace    unfocus
// @match        *://searx.nabakolu.xyz/*
// @datecreated  2022-04-17
// @lastupdated  2022-04-17
// @version      0.1
// @author       Lukas Nabakowski
// @description  This userscript will unfocus on load
// ==/UserScript==

document.activeElement.blur();
