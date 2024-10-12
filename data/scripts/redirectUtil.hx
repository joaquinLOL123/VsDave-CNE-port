//
import Type;

public function setRedirectStates(oldState:String, newState:String, data:Dynamic) {
	redirectStates.set(oldState, newState);
	redirectStateData.set(newState, data);
	trace("SET REDIRECT: (" + redirectStates + " - " + redirectStateData + ")");
}

public function removeRedirectStates(oldState:String) {
	var newState:String;
	for (redirect in redirectStates.keys()) {
		if (redirect == oldState)
			newState = redirectStates.get(redirect);
	}
	trace("REMOVE REDIRECT: " + oldState);
	redirectStates.remove(oldState);
	redirectStateData.remove(newState);
}