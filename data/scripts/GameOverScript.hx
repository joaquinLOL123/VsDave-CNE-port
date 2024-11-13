function postCreate() {
    switch (character.curCharacter) {
        case "dave-angey" | "bf-3d":
            FlxTween.tween(character, {alpha: 0, "scale.x": 0, "scale.y": 0}, 2, {
                ease: FlxEase.expoInOut,
                onUpdate: function(tween:FlxTween) {
                    character.angle += FlxG.elapsed * 250;
                }
            });
    }
}
