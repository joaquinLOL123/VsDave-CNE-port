//code for both the phone and phone-alt noteTypes

function postCreate() {
    player.onNoteUpdate.add(onNoteUpdate);
}

function onNoteCreation(event) {
    if (event.noteType == "phone" || event.noteType == "phone-alt") {
        event.noteSprite = "game/notes/phone";
    }
}

function onNoteUpdate(event) {
    if (event.note.noteType == "phone") {
        var note = event.note;
        if (note.strumTime < Conductor.songPosition + 5 && note.strumTime > Conductor.songPosition) //this sucks but hey, it works.
            dad.playAnim("attack", true);
    }
}

function onNoteHit(event) {
    if (event.noteType == "phone") {
        event.preventAnim();
        if (event.player) {
            boyfriend.playAnim("dodge", true);
            dad.playAnim("attack", true);
        } else {
            dad.playAnim("smash", true); 
        }
    } else if (event.noteType == "phone-alt") {
        event.animSuffix = "-alt";
    }
}

function onPlayerMiss(event) {
    if (event.noteType == "phone") {
        event.animCancelled = true;
        event.healthGain = -0.2;
        event.character.playAnim("hit", true);
        var strumLine = event.note.strumLine;

        strumAlphaTween(strumLine, event.direction);
    }
}

function strumAlphaTween(strumLine:StrumLine, direction:Int) {
    var strum = strumLine.members[direction];

    for (note in strumLine.notes) {
        if (note.strumID == direction) {
            FlxTween.cancelTweensOf(note);
            note.alpha = 0.01;

            FlxTween.tween(note, {alpha: 1}, 7, {ease: FlxEase.expoIn});
        }
    }

    FlxTween.cancelTweensOf(strum);
    strum.alpha = 0.01;

    FlxTween.tween(strum, {alpha: 1}, 7, {ease: FlxEase.expoIn});
}