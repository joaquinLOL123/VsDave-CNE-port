//
import CoolerUtil;
import funkin.backend.utils.WindowUtils;
import lime.graphics.Image;
import lime.utils.Assets;
import Type;

public static var CoolerUtil:CoolerUtil = new CoolerUtil();


public var redirectStates:Map<String, String> = [
	"TitleState" => "vsDave/DaveTitleState"
]; // Base State => Mod State
public var redirectStateData:Map<String, Dynamic> = []; // Mod State => Data

public static var reqStateName:String;

function new() {
	window.setIcon(Image.fromBytes(Assets.getBytes(Paths.getPath('icon.png'))));
	WindowUtils.set_winTitle("Friday Night Funkin' | VS. Dave and Bambi 3.0 CNE");

	//SAVE DATA INIT
	if (FlxG.save.data.transDither == null)
		FlxG.save.data.transDither = true;
	if (FlxG.save.data.eyesores == null)
		FlxG.save.data.eyesores = true;
	if (FlxG.save.data.blockedGlitch == null)
		FlxG.save.data.blockedGlitch = true;
}

function update(elapsed:Float) {
	if (FlxG.keys.justPressed.F5) FlxG.resetState();
}

function preStateSwitch() {
	var stateClassName = Type.getClassName(Type.getClass(FlxG.game._requestedState));
	reqStateName = stateClassName.substr(stateClassName.lastIndexOf(".") + 1);

	for (redirect in redirectStates.keys()) {
        if (reqStateName == redirect) {
			var daModState = redirectStates.get(redirect);
            FlxG.game._requestedState = new ModState(daModState, redirectStateData.get(daModState)); 
        }
    }
}
