//
import flixel.text.FlxTextBorderStyle;
import Xml;

var extraData:Array<Array<Dynamic>> = [];
var weekBackgroundArt:FlxSprite;

var targetX:Array<Int> = [0];

var canSelectCustom = true;

function create() {
    getExtraData();
    canSelect = false;

    weekBackgroundArt = new FlxSprite();
}

function postCreate() {
    weekBackgroundArt.setPosition(weekBG.x, weekBG.y);
    weekBackgroundArt.antialiasing = true;
    add(weekBackgroundArt);

    for (diff=>sprite in difficultySprites)
        remove(sprite);
    for (arrow in [leftArrow, rightArrow]) 
        remove(arrow); 

    for(i=>week in weeks) {
        for (sprite in weekSprites) {
            targetX[i] = i;
        }
    }

    for (text in [scoreText, weekTitle]) {
        text.font = Paths.font("comic.ttf");
        text.y -= 5;
    }

    tracklist.font = Paths.font("comic.ttf");
    tracklist.y = weekBG.y + weekBG.height - 5;
    tracklist.size = 28;
    tracklist.fieldWidth = FlxG.width;
    tracklist.borderStyle = FlxTextBorderStyle.NONE;
    tracklist.screenCenter(FlxAxes.X);
    tracklist.updateHitbox();
}

function update() {
    if (canSelectCustom) {
        changeWeek((controls.LEFT_P ? -1 : 0) + (controls.RIGHT_P ? 1 : 0));

        if (controls.BACK) {
            goBack();
        }

        if (controls.ACCEPT)
            selectWeek();
    }

    for(k=>e in weekSprites.members) {
        e.targetY = 0.46;
        e.x = CoolUtil.fpsLerp(e.x, (targetX[k] * 450) + 420, 0.17);
    }
}

function onChangeWeek(event) {
    curWeek = event.value;

    FlxTween.color(weekBG, 0.25, weekBG.color, extraData[event.value][0]);

    if (extraData[event.value][1] != null) {
        weekBackgroundArt.visible = true;
        weekBackgroundArt.loadGraphic(Paths.image("menus/storymenu/backgrounds/" + extraData[event.value][1]));
    } else {
        weekBackgroundArt.visible = false;
    }

    CoolUtil.playMenuSFX();
    
    for(k=>e in weekSprites.members) {
        targetX[k] = k - curWeek;
    }

    var list = [];

    for(e in weeks[event.value].songs) 
        if (e.hide != true) 
            list.push(e.name);

    tracklist.text = 'TRACKS\n' + list.join(" - ");
	weekTitle.text = weeks[event.value].name;

    changeDifficulty(0, true);

    MemoryUtil.clearMinor();

    event.cancel();
}

function getExtraData() {
    var weeks:Array<String> = [];
    if (getWeeksFromSource(weeks, false))
        getWeeksFromSource(weeks, true);

    for(k=>weekName in weeks) {
        var week:Xml = null;
        var data:Array<Dynamic> = []; //Color, Background

        week = Xml.parse(Assets.getText(Paths.xml('weeks/weeks/' + weekName))).firstElement();

        if (week.exists("color"))
            data.push(FlxColor.fromString(week.get("color")));
        else 
            data.push(0xFFF9CF51);

        if (week.exists("background"))
            data.push(week.get("background"));

        extraData.push(data);
    }
}

function onWeekSelect() {
    canSelectCustom = false;
}