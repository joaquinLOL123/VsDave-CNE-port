//
var glitchShader:CustomShader = new CustomShader("GlitchShader");
var revertedBG:Array<FunkinSprite>;
final NIGHT_COLOR = 0xFF878787;

function create() {
    void.shader = glitchShader;
    glitchShader.uWaveAmplitude = 0.1;
    glitchShader.uFrequency = 5.0;
    glitchShader.uSpeed = 2.0;

    dad.y -= 70;

    revertedBG = [bg, stageHills, grassbg, gate, stageFront];

    for (sprite in revertedBG) {
        sprite.alpha = 0;
        sprite.color = NIGHT_COLOR;
    }
}

var time:Float = 0.0;

function update(elapsed) {
    time += elapsed;
    glitchShader.hset("uTime", time);
}

function revertBG() {
    for (sprite in revertedBG)
    {
        FlxTween.tween(sprite, {alpha: 1}, 1);
    }

    for (strumline in strumLines.members)
        for (character in strumline.characters)
            if (character.animateAtlas != null)
                FlxTween.color(character.animateAtlas, 0.6, FlxColor.WHITE, NIGHT_COLOR);
            else
                FlxTween.color(character, 0.6, FlxColor.WHITE, NIGHT_COLOR);

    FlxG.camera.flash(FlxColor.WHITE, 0.25);
}