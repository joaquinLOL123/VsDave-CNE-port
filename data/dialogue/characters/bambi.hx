var defaultTypeSFX:Array<FlxSound>; //the box sfx

function show() {
    if (defaultTypeSFX == null)
        defaultTypeSFX = cutscene.dialogueBox.defaultTextTypeSFX;
    cutscene.dialogueBox.defaultTextTypeSFX = [
        FlxG.sound.load(Paths.sound("dialogue/bambiDialogue/1")), 
        FlxG.sound.load(Paths.sound("dialogue/bambiDialogue/2")), 
        FlxG.sound.load(Paths.sound("dialogue/bambiDialogue/3"))
    ];
}

function hide() {
    cutscene.dialogueBox.defaultTextTypeSFX = defaultTypeSFX;
}

//i guess that's one way to make random character dialogue sounds, sigh.