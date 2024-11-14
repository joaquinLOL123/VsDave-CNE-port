final CAM_NOTE_OFFSET = 20;

function create() {
    GameOverSubstate.script = "data/scripts/GameOverScript";

    switch (SONG.meta.name) {
        case "warmup" | "house" | "insanity" | "polygonized":
            introSounds = ['intro/dave/intro3_dave', 'intro/dave/intro2_dave', "intro/dave/intro1_dave", "intro/dave/introGo_dave"];
        case "blocked" | "corn theft" | "maze" | "shredder":
            introSounds = ['intro/bambi/intro3_bambi', 'intro/bambi/intro2_bambi', "intro/bambi/intro1_bambi", "intro/bambi/introGo_bambi"];
    }

    switch (boyfriend.curCharacter) {
        case "dave" | "dave-angey":
            lossSFX = "death/fnf_loss_sfx-dave";
    }
}

function onNoteHit(event) {
    if (event.noteType == "phone") return;
    if (event.character == strumLines.members[curCameraTarget].characters[0]) {
        var xOffset = switch(event.direction) {
            case 0: -CAM_NOTE_OFFSET;
            case 3: CAM_NOTE_OFFSET;
        }

        var yOffset = switch(event.direction) {
            case 1: CAM_NOTE_OFFSET;
            case 2: -CAM_NOTE_OFFSET;
        }
        FlxG.camera.targetOffset = FlxPoint.weak(xOffset, yOffset);
    }
}

function onCameraMove(event) {
    if (event.strumLine.characters[0].lastAnimContext != "SING") {
        FlxG.camera.targetOffset = FlxPoint.weak(0, 0);
    }
}