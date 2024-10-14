//
var glitchShader:CustomShader = new CustomShader("GlitchShader");
public var glitchBG:FunkinSprite = new FunkinSprite(-600, -200).loadGraphic(Paths.image('stages/void/redsky_insanity'));

function create() {
    if (SONG.meta.name == 'insanity') {
        glitchBG.alpha = 0.75;
        glitchBG.visible = false;
        insert(members.indexOf(stageFront) + 1, glitchBG);
        
        glitchBG.shader = glitchShader;
        glitchShader.uWaveAmplitude = 0.1;
		glitchShader.uFrequency = 5.0;
		glitchShader.uSpeed = 2.0;
    }
}

var time:Float = 0.0;
function update(elapsed) {
    //dad.updateHitbox();
    time += elapsed;
    glitchShader.hset("uTime", time);
}