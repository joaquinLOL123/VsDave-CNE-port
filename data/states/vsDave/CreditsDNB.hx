import funkin.menus.credits.CreditsMain;

//very WIP!!!

var bg:FlxSprite;
var barL:FlxSprite;
var barR:FlxSprite;

function create() {
    bg = CoolUtil.loadAnimatedGraphic(new FlxSprite(), (Paths.image('menus/menuDesat')));
    bg.color = FlxColor.LIME;
    bg.scrollFactor.set();
    bg.screenCenter();
    bg.antialiasing = true;
    add(bg);



    var bars = [barL, barR];
    for (i in 0...bars.length) {
        var bar = bars[i];
        bar = new FlxSprite().loadGraphic(Paths.image('menus/credits/CoolOverlay'));
        bar.x = (FlxG.width - bar.width) * i;
        bg.scrollFactor.set();
        bar.color = FlxColor.LIME;
        add(bar);
    }

}

function update() {
    if (controls.BACK)
        FlxG.switchState(new CreditsMain());
}
