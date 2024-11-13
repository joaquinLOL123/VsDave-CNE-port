import openfl.display.BlendMode;

var overlay:FunkinSprite = new FunkinSprite().makeSolid(FlxG.width, FlxG.height, FlxColor.BLACK);

final SUNSET_COLOR = FlxColor.fromRGB(255, 143, 178);
final NIGHT_COLOR = 0xFF878787;

final SPOTLIGHT_SCALE:Float = 1.3;
var spotlight:FunkinSprite;
var spotlightPart:Bool = false;



function postCreate() {
    var sunsetSky:FunkinSprite = new FunkinSprite(-600, -200).loadGraphic(Paths.image("stages/shared/sky_sunset"));
    sunsetSky.scrollFactor.set(0.6, 0.6);
    sunsetSky.alpha = 0;
    insert(members.indexOf(stage.stageSprites["bg"]) + 1, sunsetSky);
    stage.stageSprites.set("sunsetSky", sunsetSky);

    var nightSky:FunkinSprite = new FunkinSprite(-600, -200).loadGraphic(Paths.image("stages/shared/sky_night"));
    nightSky.scrollFactor.set(0.6, 0.6);
    nightSky.alpha = 0;
    insert(members.indexOf(stage.stageSprites["bg"]) + 1, nightSky);
    stage.stageSprites.set("nightSky", nightSky);

    overlay.scrollFactor.set(0, 0);
    overlay.zoomFactor = 0;
    overlay.alpha = 0;
    add(overlay);

    spotlight = new FunkinSprite().loadGraphic(Paths.image("game/spotLight"));
    spotlight.blend = BlendMode.ADD;
    spotlight.scale.set((dad.frameWidth / spotlight.frameWidth) * SPOTLIGHT_SCALE, 1.0);
    spotlight.alpha = 0;
    spotlight.origin.set(spotlight.origin.x, spotlight.origin.y - (spotlight.frameHeight / 2));
    add(spotlight);
    
    
    spotlight.setPosition(dad.x / 2, -500);
}

function onSongStart() {
    var tweenTime = CoolerUtil.measuresToMS(25);
    for (char in [gf, boyfriend, dad])
        FlxTween.color(char, tweenTime, FlxColor.WHITE, SUNSET_COLOR, {onComplete: function() {
            FlxTween.color(char, tweenTime, SUNSET_COLOR, NIGHT_COLOR);
        }});
    for (stageSprite=>spr in stage.stageSprites) {
        switch (stageSprite) {
            case "bg":
                FlxTween.tween(spr, {alpha: 0}, tweenTime);
            case "sunsetSky":
                FlxTween.tween(spr, {alpha: 1}, tweenTime, {onComplete: function() {
                    FlxTween.tween(spr, {alpha: 0}, tweenTime);
                }});
            case "nightSky":
                FlxTween.tween(spr, {alpha: 0}, tweenTime, {onComplete: function() {
                    FlxTween.tween(spr, {alpha: 1}, tweenTime);
                }});
            default:
                FlxTween.color(spr, tweenTime, FlxColor.WHITE, SUNSET_COLOR, {onComplete: function() {
                    FlxTween.color(spr, tweenTime, SUNSET_COLOR, NIGHT_COLOR);
                }});
        }
    }
    
}

function beatHit(curBeat) {
    if (spotlightPart && curBeat % 3 == 0) {
        if (spotlight.health != 3)
        {
            FlxTween.tween(spotlight, {angle: 2}, (Conductor.crochet / 1000) * 3, {ease: FlxEase.expoInOut});
            spotlight.health = 3;
        }
        else
        {
            FlxTween.tween(spotlight, {angle: -2}, (Conductor.crochet / 1000) * 3, {ease: FlxEase.expoInOut});
            spotlight.health = 1;
        }
    }
}

function stepHit(curStep) {
    switch (curStep) {
        case 466:
            FlxTween.tween(overlay, {alpha: 0.6}, 1); 
            notesAlpha(0, 0);
        case 510:
            notesAlpha(1, 0.6);
        case 528:
            overlay.alpha = 0;
        case 832:
            FlxTween.tween(overlay, {alpha: 0.4}, 1);
        case 838:
            notesAlpha(0, 0);
        case 902:
            notesAlpha(1, 0.6);
        case 908:
            FlxTween.tween(overlay, {alpha: 1}, CoolerUtil.stepsToMS(4));
        case 912:
            FlxTween.tween(overlay, {alpha: 0.6}, 1);
            FlxTween.tween(spotlight, {alpha: 1}, 1);
            setSpotlightTarget(dad);
            spotlightPart = true;
        case 1168:
            spotlightPart = false;
            FlxTween.tween(spotlight, {alpha: 0}, 1);
            FlxTween.tween(overlay, {alpha: 0}, 1);
    }
}

function notesAlpha(val:Float, susVal:Float) {
    for (strumLine in [player, cpu]) {
        for (strum in strumLine) {
            FlxTween.cancelTweensOf(strum);
            FlxTween.tween(strum, {alpha: val}, 1);
        }
        for (note in strumLine.notes) {
            FlxTween.cancelTweensOf(note);
            FlxTween.tween(note, {alpha: note.isSustainNote ? susVal : val}, 1);
        }
    }
}

var lastTarget:Character;
function setSpotlightTarget(char:Character) {
    if (lastTarget != char) {
        var targetPosition = FlxPoint.weak((char.globalOffset.x + char.x - char.extra["actualX"]) - (char.frameWidth / 4), (char.globalOffset.y) - (spotlight.height / 2));
        FlxTween.tween(spotlight, {x: targetPosition.x, y: targetPosition.y, "scale.x": (char.frameWidth / spotlight.frameWidth) * SPOTLIGHT_SCALE}, 0.66, {ease: FlxEase.circOut});

        gf.playAnim((targetPosition.x - spotlight.width / 2) <= gf.getGraphicMidpoint().x ? "singLEFT" : "singRIGHT");
		lastTarget = char;
    }
}

function onEvent(e) {
    var event = e.event;
    if (event.name == "Camera Movement") {
        if (spotlightPart) {
            FlxTween.cancelTweensOf(spotlight);
            setSpotlightTarget(strumLines.members[event.params[0]].characters[0]);
        }
    }
}