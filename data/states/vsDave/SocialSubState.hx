//
import sys.Http;
import flixel.text.FlxTextAlign;
import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxTextFormat;
import funkin.backend.utils.DiscordUtil;

var bg:FlxSprite;
var text:FlxText;

var socialGroup:Array<SocialButton> = [];

var canSelect:Bool = false;
var curSelected:Int = 0;

function create() {

    tweenCreditsAlpha(0, 0.4);

    bg = new FlxSprite().makeSolid(FlxG.width, FlxG.height, FlxColor.BLACK);
    bg.alpha = 0;
    add(bg);

    text = new FlxText(0, 100, 0, data.get("name") + "\n" + data.get("desc"));
    text.setFormat(Paths.font("comic.ttf"), 32, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    text.screenCenter(FlxAxes.X);
    text.antialiasing = true;
    text.alpha = 0;
    add(text);

    var socialData:Array<Array<String>> = data.get("socials");

    for (i in 0...socialData.length) {
        var socialType = socialData[i][0];
        var socialLink = socialData[i][1];

        var button:SocialButton = new SocialButton(0, (text.y + text.height) + (i * 110) + 20, socialType, socialLink);
        button.alphaTarget = i == curSelected ? 1 : 0.3;
        button.group.alpha = 0;
        button.group.screenCenter(FlxAxes.X);
        socialGroup.push(button);
        
        if (socialType == "discord") {
            var discordTag:FlxText = new FlxText(button.icon.width, button.icon.height / 2 - 20, 0, socialLink);
            discordTag.setFormat(Paths.font("comic.ttf"), 32, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            button.group.add(discordTag);
        }
    }

    for (group in socialGroup) {
        var actualGroup = group.group;
        trace(group.alphaTarget);
        add(actualGroup);
        
        FlxTween.tween(actualGroup, {alpha: group.alphaTarget}, 0.4, {onComplete: function() {
            changeSelection(0, true);
        }});
    }

    FlxTween.tween(bg, {alpha: 0.7}, 0.4, {onComplete: function() {
        canSelect = true;
    }});

    FlxTween.tween(text, {alpha: 1}, 0.4);

    camera = new FlxCamera();
    camera.bgColor = 0;
    FlxG.cameras.add(camera, false);
}

function update() {
    if (canSelect) {
        var back = controls.BACK;
        var accepted = controls.ACCEPT;
        if (back) {
            closeBullshit();
        }
        if (accepted) {
            for (i => button in socialGroup) {
                if (i == curSelected)
                    if (button.type != "discord")
                        CoolUtil.openURL(button.link);
            }
        }
        changeSelection((controls.UP_P ? -1 : 0) + (controls.DOWN_P ? 1 : 0));
    }
}

public function changeSelection(change:Int = 0, force:Bool = false) {
    if (change == 0 && !force) return;

    curSelected = FlxMath.wrap(curSelected + change, 0, socialGroup.length-1);
    CoolUtil.playMenuSFX(0.7);

    for (i in 0...socialGroup.length) {
        var curButton = socialGroup[i];
        if (i == curSelected)
            curButton.group.alpha = 1;
        else
            curButton.group.alpha = 0.3;
    }

}

function closeBullshit() {
    canSelect = false;
    FlxTween.tween(bg, {alpha: 0}, 0.08, {onComplete: function() {
        if(FlxG.cameras.list.contains(camera))
            FlxG.cameras.remove(camera, true);
        close();

        socialSubStateOpen = false;
    }});

    for (social in socialGroup) {
        FlxTween.tween(social.group, {alpha: 0}, 0.08);
    }

    FlxTween.tween(text, {alpha: 0}, 0.08);
    
    tweenCreditsAlpha(1, 0.08);
}

class SocialButton extends flixel.FlxBasic {
    public static var icon:FlxSprite;
    public static var group:FlxSpriteGroup;
    public static var type:String;
    public static var link:String;
    public var alphaTarget:Float;

    public function new(x:Float, y:Float, socialType:String, socialLink:String) {
        type = socialType;
        link = socialLink;
        group = new FlxSpriteGroup();

        icon = new FlxSprite().loadGraphic(Paths.image("menus/credits/socialMedia/" + socialType));
        icon.antialiasing = true; 
        group.add(icon);

        group.setPosition(x, y);
    }

    public function changeTargetAlpha(val:Float) {
        alphaTarget = val;
        group.alpha = targetAlpha;
    }

}