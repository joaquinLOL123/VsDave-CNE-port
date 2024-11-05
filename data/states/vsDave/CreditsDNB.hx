//
import flixel.FlxObject;
import flixel.text.FlxTextAlign;
import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxTextFormat;
import funkin.menus.credits.CreditsMain;
import Xml;

var xml:Xml;

var bg:FlxSprite;
var barL:FlxSprite;
var barR:FlxSprite;

var camFollow:FlxObject;

var curSelected:Int = 1;
public static var socialSubStateOpen:Bool;

var credArray:Array<CreditText> = [];
var creditData:Map<String, Map<String, Dynamic>> = [];

function create() {
    socialSubStateOpen = false;

    bg = CoolUtil.loadAnimatedGraphic(new FlxSprite(), (Paths.image('menus/menuDesat')));
    bg.color = FlxColor.LIME;
    bg.scrollFactor.set();
    bg.screenCenter();
    bg.antialiasing = true;
    add(bg);

    parseXML();

    var bars = [barL, barR];
    for (i in 0...bars.length) {
        var bar = bars[i];
        bar = new FlxSprite().loadGraphic(Paths.image('menus/credits/CoolOverlay'));
        bar.x = (FlxG.width - bar.width) * i;
        bar.scrollFactor.set();
        bar.color = FlxColor.LIME;
        add(bar);
    }

    camFollow = new FlxObject(0, 0, 1, 1);
	add(camFollow);
    FlxG.camera.follow(camFollow, 0, 0.2);

    changeSelection(0, true);
}

function update() {
    var currentText = credArray[curSelected];
    
    if (!socialSubStateOpen) {
        if (controls.BACK)
            FlxG.switchState(new CreditsMain());
        if (controls.ACCEPT) {
            socialSubStateOpen = true;
            var data = creditData.get(currentText.credText.text);
            openSubState(new ModSubState("vsDave/SocialSubState", data));
        }
        changeSelection((controls.UP_P ? -1 : 0) + (controls.DOWN_P ? 1 : 0));
    }

    if (credArray != null) {
        var selection = currentText.group;
        var midPoint = FlxPoint.weak(selection.x + selection.width / 2, selection.y + selection.height / 2);
        camFollow.setPosition(midPoint.x, midPoint.y);
    }
}

public static function tweenCreditsAlpha(val:Float, time:Float) {
    for (cred in credArray)
        FlxTween.tween(cred.group, {alpha: val}, time);
}

function changeSelection(change:Int = 0, force:Bool = false) {
    if (change == 0 && !force) return;

    var value = curSelected + change;
    var nextSelection = credArray[FlxMath.wrap(value, 0, credArray.length-1)];
    var actualChange:Int = (value) + (nextSelection.canSelect ? 0 : FlxMath.signOf(change));

    curSelected = FlxMath.wrap(actualChange, 0, credArray.length-1);
    CoolUtil.playMenuSFX(0.7);

    for (i in 0...credArray.length) {
        var curCredit = credArray[i];
        var text = curCredit.credText;

        if (curCredit.canSelect)
            if (i == curSelected) {
                text.color = FlxColor.YELLOW;
                text.borderSize = 2;
            } else {
                text.color = FlxColor.WHITE;
                text.borderSize = 1;
            }
    }
}

function parseXML() {
    xml = Xml.parse(Assets.getText(Paths.xml("config/creditsDNB")));
    var current:Int = 0;

    for (node in xml.elements()) {
        if (node.nodeName == "section") {
            var currentInSection = 0;
            var title:CreditText = new CreditText(0, 0, CoolerUtil.getXMLAtt(node, "name"), CoolerUtil.getXMLAtt(node, "icon"), true);
            title.group.screenCenter(FlxAxes.X);

            add(title.group);
            credArray.push(title);

            if (current > 0) {
                var prev = credArray[current - 1];
                title.group.y = (prev.credText.y + prev.group.height);
            }

            current++;
            trace("WAOW");

            for (person in node.elements()) {
                var text:CreditText = new CreditText(0, 0, CoolerUtil.getXMLAtt(person, "name"), CoolerUtil.getXMLAtt(person, "icon"), false);
                text.group.screenCenter(FlxAxes.X);

                add(text.group);
                credArray.push(text);

                text.group.y = (title.group.y + (title.group.height)) + (120 * currentInSection);

                var dataMap:Map<String, Dynamic> = [];

                for (att in person.attributes())
                        dataMap.set(att, CoolerUtil.getXMLAtt(person, att));
                dataMap.set("socials", [
                    for (social in person.elements())
                        [CoolerUtil.getXMLAtt(social, "type"), CoolerUtil.getXMLAtt(social, "link")]
                ]);

                creditData.set(CoolerUtil.getXMLAtt(person, "name"), dataMap);

                currentInSection++;
                
                trace(currentInSection);
            }

            current += currentInSection;
        } 
    }
}

class CreditText extends flixel.FlxBasic {

    public static var group:FlxSpriteGroup;
    public static var credText:FlxText;
    public static var icon:FlxSprite;

    public static var canSelect:Bool = true;

    public function new(x:Float, y:Float, text:String, iconPath:String, isTitle:Bool) {
        group = new FlxSpriteGroup();

        credText = new FlxText(0, 0, 0, text);
        credText.setFormat(Paths.font("comic.ttf"), isTitle ? 64 : 32, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        credText.borderSize = isTitle ? 3 : 1;
        credText.antialiasing = true;
        credText.scrollFactor.set(0, 1);
        group.add(credText);

        icon = new FlxSprite().loadGraphic(Paths.image("menus/credits/icons/" + iconPath));
        icon.x = credText.x + credText.width;
        icon.y = ((credText.y - credText.height) / 2) - (!isTitle ? 20 : 0);
        icon.antialiasing = true;
        group.add(icon);

        group.setPosition(x, y);

        canSelect = !isTitle;
    }
}