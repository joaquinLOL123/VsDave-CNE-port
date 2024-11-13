var glitchShader = new CustomShader("BlockedGlitchShader");

var overlay:FunkinSprite = new FunkinSprite().makeSolid(FlxG.width, FlxG.height, FlxColor.BLACK);

function create() {
    glitchShader.mult = 0.0;
    camHUD.addShader(glitchShader);
}

function postCreate() {
    overlay.scrollFactor.set(0, 0);
    overlay.zoomFactor = 0;
    overlay.alpha = 0;
    add(overlay);
}


var time:Float = 0.0;
function update(elapsed) {
    time += elapsed;

    glitchShader.hset("time", time);
}

function beatHit(curBeat) {
    switch(curBeat) {
        case 300:
            glitchShader.mult = 1.0;
        case 304:
            glitchShader.mult = 0.0;
    }
}

function stepHit(curStep) {
    switch(curStep) {
        case 128:
            notesAlpha(0, 0);
            FlxTween.tween(overlay, {alpha: 0.6}, 1);
        case 256:
            notesAlpha(1, 0.6);
            FlxTween.tween(overlay, {alpha: 0}, 1);
        case 640:
            overlay.alpha = 0.6;
        case 768:
            overlay.alpha = 0;
        case 1028:
            notesAlpha(0, 0);
        case 1143:
            notesAlpha(1, 0.6);
        case 1152:
            FlxTween.tween(overlay, {alpha: 0.4}, 1);
        case 1200:
            FlxTween.tween(overlay, {alpha: 0.7}, (Conductor.stepCrochet / 1000) * 8);
        case 1216:
            overlay.alpha = 0;
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