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

import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    SilicaFlickable {
        id: flick
        anchors.fill: parent

        contentHeight: header.height + col.height + Theme.paddingLarge

        ScrollDecorator { flickable: flick }

        PageHeader {
            id: header
            title: "Taivaanvahti"
        }

        Column {
            id: col
            spacing: Theme.paddingLarge
            anchors.top: header.bottom
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingLarge
            anchors.right: parent.right
            anchors.rightMargin: Theme.paddingLarge

            BackgroundItem {
                id: tv
                height: Theme.itemSizeSmall
                property string url: "http://www.taivaanvahti.fi"

                Label {
                    anchors.centerIn: parent
                    font.pixelSize: Theme.fontSizeSmall
                    text: tv.url
                }

                onClicked: Qt.openUrlExternally(url)
            }

            Label {
                id: blurb
                width: parent.width
                wrapMode: Text.WordWrap
                maximumLineCount: 1024
                text: "Taivaanvahti on Ursan havaintojärjestelmä, jonka tietokantaan "
                    + "kerätään tähtitieteellisten ja ilmakehän ilmiöiden havaintoja."
            }

            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                maximumLineCount: 1024
                text: "Tämä sovellus ei ole virallinen osa Taivaanvahtijärjestelmää, "
                    + "mutta se on kehitetty Taivaanvahdin ylläpidon avulla. Tähän sovellukseen "
                    + "liittyvät kysymykset voi lähettää kehittäjille (kts. sivun loppu)"
            }

            Label {
                anchors.right: parent.right
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.highlightColor
                font.family: Theme.fontFamilyHeading
                text: "Tekijänoikeuksista"
            }

            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                maximumLineCount: 1024
                text: "Havaintojen kuvien ja tekstien tekijänoikeudet säilyvät havaitsijalla. "
                    + "Lähettäessään havainnon Taivaanvahtiin tekijä luovuttaa vain oikeuden "
                    + "julkaista kuvat ja teksti havaintojärjestelmässä. Tämän vuoksi kuvia ei "
                    + "voi käyttää esimerkiksi taustakuvana ilman erillistä lupaa tekijältä."
            }

            Label {
                anchors.right: parent.right
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.highlightColor
                font.family: Theme.fontFamilyHeading
                text: "Kotisivu"
            }

            BackgroundItem {
                id: homepage
                height: Theme.itemSizeSmall
                property string url: "https://github.com/zuh/taivaanvahti-jolla"

                Label {
                    anchors.centerIn: parent
                    font.pixelSize: Theme.fontSizeTiny
                    text: homepage.url
                }

                onClicked: Qt.openUrlExternally(url)
            }

            Label {
                anchors.right: parent.right
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.highlightColor
                font.family: Theme.fontFamilyHeading
                text: "Kehittäjät"
            }

            BackgroundItem {
                id: kalle
                height: Theme.itemSizeSmall
                property string name: "Kalle Vahlman"
                property string mail: "zuh@iki.fi"
                property string url: "mailto:" + mail

                Label {
                    anchors.centerIn: parent
                    font.pixelSize: Theme.fontSizeSmall
                    text: kalle.name + " <" + kalle.mail + ">"
                }

                onClicked: Qt.openUrlExternally(url)
            }
        }
    }
}
