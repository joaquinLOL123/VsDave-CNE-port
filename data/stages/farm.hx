var cornBag:FunkinSprite;

function create() {
    var bagType = FlxG.random.int(0, 1000) == 0 ? 'popeye' : 'cornbag';
    cornBag = new FunkinSprite(1200, 550).loadGraphic(Paths.image("stages/farm/" + bagType));
    cornBag.antialiasing = true;
    insert(members.indexOf(sign), cornBag);
    stage.stageSprites.set("cornBag", cornBag);

    dad.y += 350;
    dad.x += dad.x * 2;
    boyfriend.y += 350;
}