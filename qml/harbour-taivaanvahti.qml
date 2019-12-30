/*
  Copyright (C) 2013 Kalle Vahlman, <zuh@iki.fi>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.2
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow
{
    id: taivas
    initialPage: Qt.createComponent("pages/Havainnot.qml")
    cover: Qt.createComponent("cover/CoverPage.qml")

    property int havainto: 0
    property var havainnot: ListModel {}
    property var kommentit: ListModel {}
    property var viimeiset: ListModel {}

    property bool searchRunning: false
    property bool detailedSearchRunning: false
    property bool commentSearchRunning: false

    property string userName: ""
    property string copyright: "© 2019 "
    property string searchUser: ""
    property string searchUrl: "https://www.taivaanvahti.fi/app/api/search.php?format=json"
    property string defaultColumns: "&columns=id,title,start,city,category,thumbnails,comments"
    property string detailedColumns: "&columns=user,team,description,details,link,equipment,images"
    property string commentUrl: "https://www.taivaanvahti.fi/app/api/comment_search.php?format=json"
    property int dateOffset: 5
    property var startDate: makeOffsetDate()
    property var endDate: new Date()
    property string searchObserver: ""
    property string searchTitle: ""
    property var searchCategories: {
        "all": true,
        "tahtikuva": false,
        "komeetta": false,
        "pimennys": false,
        "tulipallo": false,
        "revontuli": false,
        "yopilvi": false,
        "myrsky": false,
        "halo": false,
        "muu": false
    }

    function reset() {
        havainnot.clear()
        kommentit.clear()
        viimeiset.clear()

        taivas.havaitse()
    }

    function detailInfo(index) {
        var ret = ""

        if (taivas.havainnot.get(index).thumbs && taivas.havainnot.get(index).thumbs.count)

            if (taivas.havainnot.get(index).thumbs.count === "1")
                ret += taivas.havainnot.get(index).thumbs.count + " kuva "
            else
                ret += taivas.havainnot.get(index).thumbs.count + " kuvaa "

        if (taivas.havainnot.get(index).comments && taivas.havainnot.get(index).comments !== "0")

            if (taivas.havainnot.get(index).comments === "1")
                ret += taivas.havainnot.get(index).comments + " kommentti"
            else
                ret += taivas.havainnot.get(index).comments + " kommenttia"

        return ret
    }

    function makeOffsetDate() {
        var d = new Date();
        d.setDate(d.getDate() - dateOffset)
        return d;
    }

    function havaitseTarkemmin() {
        detailedSearchRunning = true
        var xhr = new XMLHttpRequest
        var query = searchUrl + searchUser + detailedColumns + "&id=" + havainnot.get(havainto).id
        xhr.open("GET", query);

        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                userName = ""
                detailedSearchRunning = false
                if (xhr.responseText.match("^No") !== null)
                    return
                var results = JSON.parse(xhr.responseText)

                userName = results.observation[0].user[0]

                if (results.observation[0].images) {
                    var photos = results.observation[0].images
                    results.observation[0].photos = []
                    for (var p in photos) {
                        results.observation[0].photos[p] = { "url" : photos[p] }
                    }
                }

                havainnot.set(havainto, results.observation[0])
            } // TODO: handle errors
        }
        xhr.send();
    }

    function havaitse() {
        searchRunning = true
        havainnot.clear()
        viimeiset.clear()
        var xhr = new XMLHttpRequest
        var query = searchUrl + searchUser + defaultColumns
        query += "&start=" + Qt.formatDate(startDate, "yyyy-MM-dd")
        query += "&end=" + Qt.formatDate(endDate, "yyyy-MM-dd")
        xhr.open("GET", query);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {

                searchRunning = false
                if (xhr.responseText.match("^No") !== null)
                    return
                var results = JSON.parse(xhr.responseText)
                for (var i in results.observation) {
                    if (results.observation[i].thumbnails) {
                        var thumbs = results.observation[i].thumbnails
                        results.observation[i].thumbs = []
                        for (var p in thumbs) {
                            results.observation[i].thumbs[p] = { "url" : thumbs[p] }
                        }
                    }
                    havainnot.append(results.observation[i])
                }

                if (havainnot.count > 0)
                    viimeiset.append({
                                         "category": havainnot.get(0).category,
                                         "start": havainnot.get(0).start
                                     })
                if (havainnot.count > 1)
                    viimeiset.append({
                                         "category": havainnot.get(1).category,
                                         "start": havainnot.get(1).start
                                     })
            } // TODO: handle errors
        }
        xhr.send();
    }

    function kommentoi() {
        kommentit.clear()
        if (havainnot.get(havainto).comments && havainnot.get(havainto).comments === "0")
            return
        commentSearchRunning = true
        var xhr = new XMLHttpRequest;
        xhr.open("GET", commentUrl + "&observation=" + havainnot.get(havainto).id)
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                commentSearchRunning = false
                if (xhr.responseText.match("^No") !== null)
                    return
                var results = JSON.parse(xhr.responseText)
                for (var i in results.comment) {
                    kommentit.append(results.comment[i])
                }
            } // TODO: handle errors
        }
        xhr.send();

    }

}
