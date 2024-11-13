//
import openfl.utils.Assets;
import funkin.backend.MusicBeatState;
#if UPDATE_CHECKING
import funkin.backend.system.updating.UpdateUtil;
import funkin.backend.system.updating.UpdateAvailableScreen;
#end

//am i really gonna make a custom titlestate just for the comic sans intro text, intro text change in expunged's version of the mod and the eyesore warning state?
//OFCOURE I FUCKING WILL!!!

var textGroup:FlxGroup;

var randomText:Array<String> = [];

static var initialized:Bool;

var skippedIntro:Bool = false; //this made me realize how useful static vars are
static var checkedUpdates:Bool; //pretty useless since codename doesn't have auto updating YET but i'm still adding it in
var transitioning:Bool = false;

var gf:FunkinSprite;
var logo:FunkinSprite;
var titleText:FunkinSprite;

var introBG:FlxSprite;

function create() {
    randomText = getIntroTextShit()[FlxG.random.int(0, getIntroTextShit().length - 1)];
    MusicBeatState.skipTransIn = true;

    FlxG.mouse.visible = false;

    start();
}

function start() {
    textGroup = new FlxGroup();
    CoolUtil.playMenuSong(true);

    gf = new FunkinSprite(512, 50);
    gf.frames = Paths.getSparrowAtlas("menus/titlescreen/gf");
    gf.animation.addByIndices("danceLeft", "gfDance", [30,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14], null, 24, false);
    gf.animation.addByIndices("danceRight", "gfDance", [15,16,17,18,19,20,21,22,23,24,25,26,27,28,29], null, 24, false);
    gf.beatAnims = [{name: "danceLeft", forced: true}, {name: "danceRight", forced: true}];
    gf.beatInterval = 1;
    gf.antialiasing = true;
    add(gf);

    logo = new FunkinSprite(-25, -50);
    logo.frames = Paths.getSparrowAtlas("menus/titlescreen/logo");
    logo.animation.addByPrefix("bump", "logo bumpin", 24, false);
    logo.beatAnims = [{name: "bump", forced: true}];
    logo.scale.set(1.2, 1.2);
    logo.updateHitbox();
    logo.antialiasing = true;
    add(logo);

    titleText = new FlxSprite(0, FlxG.height * 0.8);
    titleText.frames = Paths.getFrames('menus/titlescreen/titleEnter');
    titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
    titleText.animation.addByPrefix('press', "ENTER PRESSED", 24, false);
    titleText.animation.play('idle');
    titleText.updateHitbox();
    titleText.x = (FlxG.width / 2) - (titleText.width / 2);
    titleText.antialiasing = true;
    add(titleText);

    add(introBG = new FlxSprite().makeSolid(FlxG.width, FlxG.height, FlxColor.BLACK));
    add(textGroup);

    trace(initialized);

    if (initialized)
        skipIntro();
    else
        initialized = true;
}

function update(elapsed) {
    if (FlxG.keys.justPressed.F)  FlxG.fullscreen = !FlxG.fullscreen;

    var pressedEnter:Bool = FlxG.keys.justPressed.ENTER;

    #if mobile
    for (touch in FlxG.touches.list)
    {
        if (touch.justPressed)
        {
            pressedEnter = true;
        }
    }
    #end

    var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

    if (gamepad != null)
    {
        if (gamepad.justPressed.START)
            pressedEnter = true;

        #if switch
        if (gamepad.justPressed.B)
            pressedEnter = true;
        #end
    }

    if (pressedEnter) {
        if (skippedIntro) {
            if (transitioning) {
                FlxG.camera.stopFX();// FlxG.camera.visible = false;
                goToMainMenu();
            } else {
                pressEnter();
            }
        } else {
            skipIntro();
        }
    }
}

function skipIntro() {
    if (!skippedIntro) {
        FlxG.camera.flash(FlxColor.WHITE, 4);
        remove(introBG);
        introBG.destroy();

        remove(textGroup);

        trace("lol");

        skippedIntro = true;
    }
}

function pressEnter() {
    titleText.animation.play('press');

    FlxG.camera.flash(FlxColor.WHITE, 1);
    CoolUtil.playMenuSFX(1, 0.7);

    transitioning = true;

    new FlxTimer().start(2, goToMainMenu);
}

function goToMainMenu() {
    #if UPDATE_CHECKING
    var report = hasCheckedUpdates ? null : UpdateUtil.checkForUpdates();
    hasCheckedUpdates = true;

    if (report != null && report.newUpdate) {
        FlxG.switchState(new UpdateAvailableScreen(report));
    } else {
        FlxG.switchState(new MainMenuState());
    }
    #else
    FlxG.switchState(new MainMenuState());
    #end
}

function getIntroTextShit():Array<Array<String>> {
    var fullText:String = Assets.getText(Paths.txt('titlescreen/introText'));

    var firstArray:Array<String> = fullText.split('\n');
    var swagGoodArray:Array<Array<String>> = [];

    for (i in firstArray)
    {
        swagGoodArray.push(i.split('--'));
    }

    return swagGoodArray;
}

function createCoolText(textArray:Array<String>) {
    for (i=>text in textArray) {
        if (text == "" || text == null) continue;
        var money:FunkinText = new FunkinText(0, (i * 60) + 200, 0, text);
        money.setFormat(Paths.font("comic.ttf"), 48, FlxColor.WHITE);
        money.screenCenter(FlxAxes.X);
        textGroup.add(money);
    }
}

function addMoreText(textArray:Array<String>) {
    for (i=>text in textArray) {
        var coolText:FunkinText = new FunkinText(0, (textGroup.length * 60) + 200, 0, text);
        coolText.setFormat(Paths.font("comic.ttf"), 48, FlxColor.WHITE);
        coolText.screenCenter(FlxAxes.X);
        textGroup.add(coolText);
    }
}

function deleteCoolText() {
    while (textGroup.members.length > 0) {
        textGroup.members[0].destroy();
        textGroup.remove(textGroup.members[0], true);
    }
}

function beatHit(curBeat) {
    switch (curBeat) {
        case 1: createCoolText(["Original mod by:", "MoldyGH", "MissingTextureMan101", "Rapparep LOL"]);
        case 3: addMoreText(["TheBuilderXD", "Erizur, T5mpler"]);
        case 4: addMoreText(["and our wonderful contributors!"]);

        case 5: deleteCoolText();

        case 6: createCoolText(["Supernovae by ArchWk"]);
        case 7: addMoreText(["Glitch by The Boneyard"]);

        case 8: deleteCoolText();

        case 9: createCoolText([randomText[0]]);
        case 10: addMoreText([randomText[1]]);

        case 11: deleteCoolText();

        case 12: createCoolText(["Friday Night Funkin'"]);
        case 13: addMoreText(["VS. Dave"]);
        case 14: addMoreText(["and Bambi"]);
        case 15: addMoreText(["Jikken CNE Port!!!"]);
        case 16: skipIntro();
    }
}