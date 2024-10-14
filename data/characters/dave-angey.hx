//
function onPlayAnim(event) {
    if (event.context == "MISS")
        color = 0xFF000084;
    else
        color = FlxColor.WHITE;
}

var time = 0.0;
function update(elapsed) {

    time += elapsed;

    y += (Math.sin(time) * 0.2);
}