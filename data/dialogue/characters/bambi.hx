function show() {
    cutscene.dialogueBox.defaultTextTypeSFX = [
        FlxG.sound.load(Paths.sound("dialogue/bambiDialogue/1")), 
        FlxG.sound.load(Paths.sound("dialogue/bambiDialogue/2")), 
        FlxG.sound.load(Paths.sound("dialogue/bambiDialogue/3"))
    ];
}