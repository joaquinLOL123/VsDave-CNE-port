//
import flixel.text.FlxTextBorderStyle;

public var bgFade:FlxSprite;
var bgFadeIntroTween:FlxTween;

function postCreate() {

    bgFade = new FlxSprite(-200, -200).makeSolid(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFF8A9AF5);
	bgFade.scrollFactor.set();
	bgFade.alpha = 0;
	cutscene.insert(0, bgFade);

    text.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xFF00137F, 2); //because the original mod made a separate flxtypedtext instance for the dropshadow... yuck!! /j

	bgFadeIntroTween = FlxTween.tween(bgFade, {alpha: 0.7}, 4.15);
}

function postPlayBubbleAnim() {
    setGraphicSize(Std.int(width / 1.3));
}

var finished = false;
function close(event) {
    if(finished) return;
    else event.cancelled = true;
    cutscene.canProceed = false;

    cutscene.curMusic?.fadeOut(1.2, 0);

    bgFadeIntroTween.cancel();

    FlxTween.tween(bgFade, {alpha: 0}, 1.2, {onComplete: function() {
        finished = true;
		cutscene.close();
    }});

    for (boxElem in [this, text])
        FlxTween.tween(boxElem, {alpha: 0}, 1.2);

    for (character => value in cutscene.charMap) {
        FlxTween.tween(value, {alpha: 0}, 1.2);
    }
}

function startText(event) {
    for (format in event.format) {
        var fmt = format.format;
        if (Reflect.hasField(fmt, "font")) {
            if (fmt.font == "barcode.ttf") {
                text.borderColor = FlxColor.TRANSPARENT;
            } else {
                text.borderColor = 0xFF00137F;
            }
        }
    }
}

