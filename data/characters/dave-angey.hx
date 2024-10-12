//
var furiosityScale:Float = 1.02;

function new() {
    setGraphicSize(Std.int((width * 0.8) / furiosityScale));
    updateHitbox();
}

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

var time = 0.0;
function update(elapsed) {

    time += elapsed;

    y += (Math.sin(time) * 0.2);
}