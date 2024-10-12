//
function create() {
    var oldColor:Int;
    animation.callback = function(name) {
        switch (name) {
            case "singLEFTmiss" | "singDOWNmiss" | "singUPmiss" | "singRIGHTmiss":
                color = 0xFF000084;
            default:
                color = FlxColor.WHITE;
        }
    };
}