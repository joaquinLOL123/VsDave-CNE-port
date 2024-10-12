var evilDave = cpu.characters[1];

function postCreate() {
    evilDave.x = dad.x;
    evilDave.y = dad.y - 50;
    evilDave.visible = false;
}


function stepHit(curStep) {
    switch(curStep) {
        case 660 | 680:
            glitchBG.visible = true;
            FlxG.sound.play(Paths.sound('static'), 0.1);
            evilDave.visible = true;
            dad.visible = false;
            iconP2.setIcon(evilDave.icon);
        case 664 | 684:
            glitchBG.visible = false;
            evilDave.visible = false;
            dad.visible = true;
            iconP2.setIcon(dad.icon);
        case 1176:
            FlxG.sound.play(Paths.sound('static'), 0.1);
            evilDave.visible = true;
            dad.visible = false;
            glitchBG.loadGraphic(Paths.image('stages/void/redsky'));
            glitchBG.alpha = 1;
            glitchBG.visible = true;
            iconP2.setIcon(evilDave.icon);
        case 1180:
            evilDave.visible = false;
            dad.visible = true;
            iconP2.setIcon(dad.icon);
    }
}