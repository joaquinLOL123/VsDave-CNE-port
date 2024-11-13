//
var pulseShader:CustomShader;
var shakeCam:Bool = false;
var shapeNoteWarning:FlxSprite;

var threeDBF = player.characters[1];
var threeDGF = strumLines.members[2].characters[1];
var normalDave = cpu.characters[1];

function create() {
    importScript("data/scripts/redirectUtil");

    shapeNoteWarning = new FlxSprite(0, FlxG.height * 2).loadGraphic(Paths.image("game/shapeNoteWarning"));
    shapeNoteWarning.cameras = [camHUD];
    shapeNoteWarning.antialiasing = false;
    shapeNoteWarning.alpha = 0;
    add(shapeNoteWarning);

    FlxTween.tween(shapeNoteWarning, {alpha: 1}, 1);
    FlxTween.tween(shapeNoteWarning, {y: 450}, 1, {ease: FlxEase.backOut, 
        onComplete: function(tween:FlxTween)
        {
            new FlxTimer().start(2, function()
            {
                FlxTween.tween(shapeNoteWarning, {alpha: 0}, 1);
                FlxTween.tween(shapeNoteWarning, {y: FlxG.height * 2}, 1, {
                    ease: FlxEase.backIn,
                    onComplete: function(tween:FlxTween)
                    {
                        remove(shapeNoteWarning);
                    }
                });
            });
        }
    });

    for (char in [threeDBF, threeDGF, normalDave])
        char.visible = false;

    if (FlxG.save.data.eyesores && Options.gameplayShaders) {
        pulseShader = new CustomShader("pulseShader");
        pulseShader.uWaveAmplitude = 0.5;
        pulseShader.uFrequency = 1.0;
        pulseShader.uSpeed = 1.0;
        pulseShader.uampmul = 0.0;
        camGame.addShader(pulseShader);
    }
}

function stepHit(curStep) {
    switch(curStep) {
        case 1024 | 1312:
            shakeCam = true;

            threeDBF.visible = true;
            threeDGF.visible = true;

            boyfriend.visible = false;
            gf.visible = false;

        case 1152 | 1408:
            shakeCam = false;
            threeDBF.visible = false;
            threeDGF.visible = false;

            boyfriend.visible = true;
            gf.visible = true;
        case 2432:
            dad.visible = false;
            normalDave.visible = true;
            
            normalDave.setPosition(50, 270);
            boyfriend.setPosition(843, 270);
            gf.setPosition(300, -60);

            normalDave.playAnim("hey", true, "LOCK"); //dave does his silly v-pose in this port :3
            boyfriend.playAnim("hey", true, "LOCK");
            gf.playAnim("cheer", true, "LOCK");

            repositionChars([normalDave, boyfriend, gf]);

            iconP2.setIcon(normalDave.icon);
            var leftColor:Int = normalDave != null && normalDave.iconColor != null && Options.colorHealthBar ? normalDave.iconColor : (opponentMode ? 0xFF66FF33 : 0xFFFF0000);
		    var rightColor:Int = boyfriend != null && boyfriend.iconColor != null && Options.colorHealthBar ? boyfriend.iconColor : (opponentMode ? 0xFFFF0000 : 0xFF66FF33); // switch the colors
            healthBar.createFilledBar(leftColor, rightColor);
		    healthBar.updateFilledBar();
    }
}

var time:Float = FlxG.random.float(-100000, 100000);
function update(elapsed) {
    if (FlxG.save.data.eyesores && Options.gameplayShaders) {
        time += elapsed;

        if (shakeCam) {
            FlxG.camera.shake(0.010, 0.010);
            pulseShader.uampmul = 1.0;
        } else {
            pulseShader.uampmul -= (elapsed / 2);
        }

        pulseShader.hset("uTime", time);
    }
}

function onGameOver(event) {
    if (shakeCam) {
        event.cancel();
        FlxG.switchState(new ModState("vsDave/EndingState", {ending: "rtx"}));
    }

    if (FlxG.save.data.eyesores && Options.gameplayShaders)
        pulseShader.uampmul = 0;
}

function onSongEnd() {
    if (PlayState.isStoryMode)
        if (health >= 1) {
            setRedirectStates("StoryMenuState", "vsDave/EndingState", {ending: "good"});
        } else if (health < 0.1) {
            //CharacterSelectState.unlockCharacter('dave-angey');
            setRedirectStates("StoryMenuState", "vsDave/EndingState", {ending: "worst"});
        } else {
            setRedirectStates("StoryMenuState", "vsDave/EndingState", {ending: "bad"});
        }
}
