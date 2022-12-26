// ==UserScript==
// @name         Export collins
// @namespace    https://blog.er1c.dev
// @version      0.1
// @description  Export collins data to clipboard.
// @author       er1cz
// @match        https://www.collinsdictionary.com/dictionary/english/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=collinsdictionary.com
// @grant        GM_log
// @grant        GM_setClipboard
// @grant        GM_addElement
// @grant        GM_notification
// ==/UserScript==

(function() {
    'use strict';
    let first = document.getElementsByClassName("title_frequency_container")[0];
    if (first) {
        let btn = document.createElement("BUTTON");
        btn.textContent = "export";
        btn.type = "button";
        btn.onclick = function() {
            export_as_json(this);
        };
        first.appendChild(btn);
    }
})();

function elog(s) {
    GM_log("eric: " + s);
}

function export_as_json(btn) {
    let first = document.getElementsByClassName("dictionaries dictionary")[0].children[0];
    let word = first.getElementsByClassName("orth")[0].innerHTML;
    let ipa = function(){
        var _ipa = "";
        Array.from(first.getElementsByClassName("pron")[0].childNodes).slice(0,-1).forEach(function(ele) {
            _ipa += ele.outerHTML ? ele.outerHTML : ele.textContent;
        });
        return _ipa;
    }();
    var meaning = [];
    Array.from(first.getElementsByClassName("hom")).forEach(function(ele){
        var mean = "";
        let pos = ele.getElementsByClassName("pos")[0];
        if (pos) {
            mean += "[" + pos.innerHTML + "]";
        }
        let def = ele.getElementsByClassName("def")[0];
        if (!def) {
            return;
        }
        Array.from(def.childNodes).forEach(function(ele){
            mean += ele.innerHTML ? ele.innerHTML : ele.textContent;
        });
        meaning.push(mean);
    });
    let j = JSON.stringify({
        "word": word,
        "ipa" : ipa,
        "meaning": meaning,
    });
    elog(j);
    GM_setClipboard(j);
    btn.textContent = "done";
}
