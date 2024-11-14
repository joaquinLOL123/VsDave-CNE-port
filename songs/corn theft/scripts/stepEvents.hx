var glitchShader = new CustomShader("BlockedGlitchShader");

var overlay:FunkinSprite = new FunkinSprite().makeSolid(FlxG.width, FlxG.height, FlxColor.BLACK);

function create() {
    playCutscenes = true;
}

function postCreate() {
    overlay.scrollFactor.set(0, 0);
    overlay.zoomFactor = 0;
    overlay.alpha = 0;
    add(overlay);
}


function stepHit(curStep) {
    switch(curStep) {
        case 935:
            FlxTween.tween(overlay, {alpha: 0.6}, 1);
            notesAlpha(0, 0);
        case 1033:
            FlxTween.tween(dad, {alpha: 0}, (Conductor.stepCrochet / 1000) * 6);
            FlxTween.tween(overlay, {alpha: 0}, (Conductor.stepCrochet / 1000) * 6);
            FlxTween.num(defaultCamZoom, defaultCamZoom + 0.2, (Conductor.stepCrochet / 1000) * 6, {}, function(newValue:Float) {
                defaultCamZoom = newValue;
            });
            notesAlpha(1, 0.6);
        case 1040:
            dad.alpha = 1;
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