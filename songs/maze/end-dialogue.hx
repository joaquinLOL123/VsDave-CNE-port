var curLineInt:Int = 0;

var bgBlack:FlxSprite = new FlxSprite().makeSolid(FlxG.width, FlxG.height, FlxColor.BLACK);
var bgFade:FlxSprite;

function postCreate() {
    bgFade = dialogueBox.dialogueBoxScript.get("bgFade");
}

function next() {
    if (curLineInt == 21) {
        FlxTween.tween(bgBlack, {alpha: 1}, 0.25);
        remove(bgFade);
        insert(0, bgBlack);
    }

    curLineInt++;
}