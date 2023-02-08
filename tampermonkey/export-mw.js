// ==UserScript==
// @name         Export MW
// @namespace    https://blog.er1c.dev
// @version      0.1
// @description  Export WB data to clipboard.
// @author       er1cz
// @match        https://www.merriam-webster.com/dictionary/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=merriam-webster.com
// @grant        GM_log
// @grant        GM_setClipboard
// @grant        GM_addElement
// @grant        GM_notification
// ==/UserScript==

(function() {
    'use strict';

    // Your code here...
    let right_ad = document.getElementById("definition-right-rail");
    if (right_ad) {
        right_ad.style.display = "none";
    }
    create_btn();
})();

function create_btn() {
    let header = document.getElementsByClassName("entry-header-content")[0];
    if (header) {
        let btn = document.createElement("BUTTON");
        btn.textContent = "export";
        btn.type = "button";
        btn.style.padding = '8px';
        btn.onclick = function() {
            export_as_json(this);
        };
        header.appendChild(btn);
    }
}

function export_as_json(btn) {
    let word = document.getElementsByClassName("hword")[0].innerHTML;
    let ipa = function() {
        var _ipa = "";
        Array.from(document.getElementsByClassName("play-pron-v2")[0].childNodes).forEach(function(ele) {
            if (ele.nodeType == 3) {
                _ipa += ele.outerHTML ? ele.outerHTML : ele.textContent;
            }
        });
        return _ipa.trim();
    }();

    var meaning = [];
    Array.from(document.getElementsByClassName("entry-word-section-container")).forEach(function(ele) {
        let tmp = export_as_json_one(ele);
        meaning = meaning.concat(tmp);
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

    GM_log(j);
    GM_setClipboard(j);
    btn.textContent = "done";
}

function export_as_json_one(dic) {
    var meaning = [];
    var pos_prefix = ""
    let pos_container0 = dic.getElementsByClassName("parts-of-speech")[0];
    if (pos_container0) {
        let pos = pos_container0.childNodes[0];
        if (pos) {
            pos_prefix = "[" + pos.innerHTML + "]";
        }
    }
    Array.from(dic.getElementsByClassName("vg")).forEach(function(ele) {
        var mean = pos_prefix;
        let pos_container = ele.getElementsByClassName("vd")[0];
        if (pos_container) {
            let pos = pos_container.childNodes[0];
            if (pos) {
                mean += "[" + pos.innerHTML + "]";
            }
        }
        var serial = 1;
        Array.from(ele.getElementsByClassName("vg-sseq-entry-item")).forEach(function(def) {
            mean += "<br>";
            var sub_serial = 1;
            Array.from(def.getElementsByClassName("sb-entry")).forEach(function(row) {
                // find meaning
                if (sub_serial > 1) {
                    mean += "<br>";
                }
                mean += serial + "." + sub_serial;
                Array.from(row.getElementsByClassName("dtText")[0].childNodes).forEach(function(item) {
                    mean += item.outerHTML ? item.outerHTML : item.textContent;
                });
                sub_serial += 1;
                // TODO find examples
            });
            serial += 1;
        });
        meaning.push(mean);
    });
    return meaning;
}
