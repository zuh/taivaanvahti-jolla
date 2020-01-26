import QtQuick 2.2
import Sailfish.Silica 1.0

Page {
    id: page

    function setResponse(message) {
        errmsg.enabled = true
        errmsg.text = message
    }

    function clearFields() {
        namefield.text = ""
        emailfield.text = ""
        commentarea.text = ""
    }

    function leaveComment() {

        if (namefield.text === "" || emailfield.text === ""
                || commentarea.text === "") {
            setResponse("Täytä kaikki kentät")
        } else if (emailfield.text.indexOf("@")==-1) {
            setResponse("Sähköpostiosoite ei ole kelvollinen")
        } else {
            var xhr = new XMLHttpRequest
            var query = "https://www.taivaanvahti.fi/api"
            xhr.open("POST",query)
            var xmlrequest = "<?xml version='1.0'?>
                        <Request>
                        <source>Sailfish Client</source>
                        <Action>ObservationAddCommentRequest</Action>
                        <comment>
                            <observation_id>" + taivas.havainnot.get(havainto).id + "</observation_id>"
                            + "<user_email>" + emailfield.text + "</user_email>"
                            + "<user_name>" + namefield.text + "</user_name>"
                            + "<comment_message>" + commentarea.text + "</comment_message>"
                        + "</comment></Request>"

            xhr.onreadystatechange = function() {

                if (xhr.readyState === XMLHttpRequest.DONE) {
                    // successs
                    setResponse("Kommentti lähetettiin onnistuneesti")
                    clearFields()
                } else {
                    setResponse("Kommentointi ei onnistunut, tarkista tiedot tai ilmoita
                        virheestä ylläpitäjälle")
                }
            }
            xhr.setRequestHeader('Content-Type','text/xml')
            xhr.send(xmlrequest)
        }
    }

    SilicaFlickable {
        id: flick
        anchors.fill: parent
        contentHeight: header.height + col.height + Theme.paddingLarge

        ScrollDecorator { flickable: flick }

        PullDownMenu {
            id: pulley

            MenuItem {
                id: commentnow
                text: "Lähetä"
                onClicked: leaveComment()
            }
        }

        PageHeader {
            id: header
            title: "Jätä kommentti"
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

            Label {
                id: sovellus
                width: parent.width
                wrapMode: Text.WordWrap
                maximumLineCount: 1024
                text: "Muista täyttää kaikki kentät ja antaa kelvollinen sähköpostiosoite."
                    + "Otathan myös huomioon, että kommentti ei tule saman tien näkyville, sillä "
                    + "Taivaanvahdin ylläpidon tulee ensiksi hyväksyä se."
                    + " Jos kommentointi epäonnistuu ja olet varma, ettei tiedoissa ole virheitä, "
                    + "ilmoita sovelluksen ylläpitäjälle."
            }

            Label {
                id: name
                anchors.left: parent.left
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.highlightColor
                font.family: Theme.fontFamilyHeading
                text: "Nimesi"
            }

            TextField {
                id: namefield
                width: parent.width
                focus: false
                placeholderText: "Koko nimesi"

                EnterKey.iconSource: "image://theme/icon-m-enter-close"
                EnterKey.onClicked: focus = false
            }

            Label {
                id: email
                anchors.left: parent.left
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.highlightColor
                font.family: Theme.fontFamilyHeading
                text: "Sähköposti"
            }

            TextField {
                id: emailfield
                width: parent.width
                focus: false
                placeholderText: "Sähköpostisi"

                EnterKey.iconSource: "image://theme/icon-m-enter-close"
                EnterKey.onClicked: focus = false
            }

            Label {
                id: comment
                anchors.left: parent.left
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.highlightColor
                font.family: Theme.fontFamilyHeading
                text: "Kommentti"
            }

            TextArea {
                id: commentarea
                width: parent.width
                focus: false
                placeholderText: "Kommenttisi tähän"

                EnterKey.iconSource: "image://theme/icon-m-enter-close"
                EnterKey.onClicked: focus = false
            }

            Button {
                text: "Lähetä"
                onClicked: leaveComment()
            }

            Label {
                id: errmsg
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.highlightColor
                font.family: Theme.fontFamilyHeading
                enabled: false
                text: ""
            }
        }

    }
}

