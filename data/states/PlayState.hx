//
import flixel.text.FlxTextAlign;
import flixel.text.FlxTextBorderStyle;

public var songWatermark:FunkinText;

function postCreate() {
    for (text in [accuracyTxt, missesTxt, scoreTxt]) {
        text.font = Paths.font("comic.ttf");
        text.size = 20;
        text.borderSize = 1.5;
    }
    accuracyTxt.x -= 60;
    scoreTxt.x += 60;
    //adjust the texts

    songWatermark = new FunkinText(4, healthBarBG.y + 50, 0, PlayState.SONG.meta.displayName, 16);

    songWatermark.setFormat(Paths.font("comic.ttf"), 16, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    songWatermark.borderSize = 1.25;
    songWatermark.cameras = [camHUD];
    add(songWatermark);

    remove(healthBar);
    insert(members.indexOf(healthBarBG), healthBar);
}



