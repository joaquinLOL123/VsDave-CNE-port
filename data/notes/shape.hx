//
function onNoteCreation(event) {
    if (event.noteType != "shape") return;
    event.cancel(); //to hopefully fix the broken animations

    var note = event.note;

    note.frames = Paths.getFrames("game/notes/shape");

    switch(note.noteData) {
        case 0:
            note.animation.addByPrefix('scroll', 'purple0');
            note.animation.addByPrefix('hold', 'purple hold piece');
            note.animation.addByPrefix('holdend', 'purple hold piece');
        case 1:
            note.animation.addByPrefix('scroll', 'blue0');
            note.animation.addByPrefix('hold', 'blue hold piece');
            note.animation.addByPrefix('holdend', 'blue hold piece');
        case 2:
            note.animation.addByPrefix('scroll', 'green0');
            note.animation.addByPrefix('hold', 'green hold piece');
            note.animation.addByPrefix('holdend', 'green hold piece');
        case 3:
            note.animation.addByPrefix('scroll', 'red0');
            note.animation.addByPrefix('hold', 'red hold piece');
            note.animation.addByPrefix('holdend', 'red hold piece');
    }

    note.scale.set(event.noteScale, event.noteScale);
    note.antialiasing = false;
}

function update() {
    if (FlxG.keys.pressed.SPACE) {
        for (note in player.notes) {
            if (note.noteType == "shape")
                note.alpha = 1;
            else 
                note.alpha = 0.5;
        }
    } else {
        for (note in player.notes) {
            if (note.noteType == "shape")
                note.alpha = 0.5;
            else 
                note.alpha = 1;
        }
    }
}

function onPlayerHit(event) {
    if (FlxG.keys.pressed.SPACE) {
        if (event.noteType != "shape") {
            disableNote(event);
        }
    } else {
        if (event.noteType == "shape") {
            disableNote(event);
        }
    }

    if (event.noteType == "shape")
        event.ratingPrefix = "game/score/3D/";
}

function disableNote(event) {
    event.preventDeletion();
    event.preventVocalsUnmute();
    event.note.wasGoodHit = false;
    event.cancel();
}