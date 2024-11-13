//
final threeDType = SONG.noteTypes.indexOf("3D") + 1;

function onNoteCreation(event) {

    var char = strumLines.members[event.strumLineID].characters[0];
    var isThreeD = char.extra["threeD"];

    if ((isThreeD == "true" || ((event.note.strumTime / 50) % 20 > 10 && isThreeD != "true" && if(dad.xml.exists("threeD")) dad.xml.get("threeD") == "true"))) { //fuck my stupid chud life
        
        if (event.noteType == null) {
            event.note.noteTypeID = threeDType; //set note type to 3d
            event.noteSprite = "game/notes/3D";
            event.note.antialiasing = false;
            //graphic changing handled here instead because i'm stupid :(
        }
    }
}

function onStrumCreation(event) {
    var char = strumLines.members[event.player].characters[0];
    var isThreeD = char.extra["threeD"];

    if (isThreeD == "true") event.sprite = "game/notes/3D";
}

function onPostStrumCreation(event) {
    var char = strumLines.members[event.player].characters[0];
    var isThreeD = char.extra["threeD"];

    if (isThreeD == "true") event.strum.antialiasing = false;
}