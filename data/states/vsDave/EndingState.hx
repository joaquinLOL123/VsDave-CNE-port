//
import funkin.menus.StoryMenuState;
import haxe.Json;
import openfl.utils.Assets as OpenFlAssets;

var endingData = {
    image: "goodEnding",
    music: "goodEnding"
};
var endingImage:FlxSprite;

function create() {
    importScript("data/scripts/redirectUtil");

    for (redirect in redirectStates.keys())
        if (redirect == "StoryMenuState")
            removeRedirectStates("StoryMenuState");

    loadEndingData(data.ending);
    
    endingImage = new FlxSprite().loadGraphic(Paths.image("game/endings/" + endingData.image));
    add(endingImage);
    CoolUtil.playMusic(Paths.music(endingData.music));

    FlxG.camera.fade(FlxColor.BLACK, 0.8, true);
}

function loadEndingData(name:String) {
    var json:Json = Json.parse(OpenFlAssets.getText(Paths.json("endings/" + name)));
    endingData = json;
}

function update() {
    if (controls.ACCEPT) {
        FlxG.switchState(new StoryMenuState());
    }
}