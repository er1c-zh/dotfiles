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
    let video_div = document.getElementById("videos");
    if (video_div) {
        video_div.style.display = 'none';
    }
    Array.from(document.getElementsByClassName("dictlink")).forEach(function(dic) {
        if (!dic) {
            return;
        }
        let title_container = dic.getElementsByClassName("title_frequency_container")[0];
        let btn = document.createElement("BUTTON");
        btn.textContent = "export";
        btn.type = "button";
        btn.onclick = function() {
            export_as_json(dic, this);
        };
        title_container.appendChild(btn);
    });
})();

function elog(s) {
    GM_log("eric: " + s);
}

function export_as_json(dic, btn) {
    let word = dic.getElementsByClassName("orth")[0].innerHTML;
    let ipa = function(){
        var _ipa = "";
        Array.from(dic.getElementsByClassName("pron")[0].childNodes).forEach(function(ele) {
            if (ele.classList && ele.classList.contains("ptr")) {
                return;
            }
            _ipa += ele.outerHTML ? ele.outerHTML : ele.textContent;
        });
        return _ipa;
    }();
    var meaning = [];
    let def_container = dic.getElementsByClassName("content definitions")[0];
    Array.from(def_container.getElementsByClassName("hom")).forEach(function(ele){
        var mean = "";
        let pos = ele.getElementsByClassName("pos")[0];
        if (pos) {
            mean += "[" + pos.innerHTML + "]";
        }
        var serial = 1;
        Array.from(ele.getElementsByClassName("def")).forEach(function(def){
            if (!def) {
                return;
            }
            if (serial > 1) {
                mean += "<br>";
            }
            mean += serial + ". ";
            serial += 1

            Array.from(def.childNodes).forEach(function(ele){
                mean += (ele.innerHTML ? ele.innerHTML : ele.textContent);
            });
        });
        meaning.push(mean);
    });
    let j = JSON.stringify({
        "action": "addNote",
        "version": 6,
        "params": {
            "note": {
                "deckName": "daily word",
                "modelName": "daily word",
                "fields": {
                    "Front": word,
                    "Back": "<ol><li>" + meaning.join("</li><li>") + "</li></ol>",
                    "Phonetic": ipa,
                },
                "options": {
                    "allowDuplicate": false,
                    "duplicateScope": "deck",
                    "duplicateScopeOptions": {
                        "deckName": "daily word",
                        "checkChildren": false,
                        "checkAllModels": false
                    }
                },
                "tags": [
                    "alfred",
                    "collins"
                ]
            }
        }
    });
    elog(j);
    GM_setClipboard(j);
    btn.textContent = "done";
}
