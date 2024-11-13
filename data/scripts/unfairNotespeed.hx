function onNoteCreation(event) {
    if (!event.note.isSustainNote)
        if (FlxG.random.int(0, 120) == 1)
        {
            event.note.scrollSpeed = 0.1;
        }
        else
        {
            if (!event.note.isSustainNote)
                event.note.scrollSpeed = FlxG.random.float(1, 3);
        }
    else 
        event.note.scrollSpeed = event.note.prevNote.scrollSpeed;
}