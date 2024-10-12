//
function create() {
    doIconBop = false; //disable default icon bop for the custom one
}

function update() {
    var thingy = 0.44;
    iconP1.scale.set(lerp(iconP1.scale.x, 1.0, thingy), lerp(iconP1.scale.y, 1.0, thingy));
    iconP1.updateHitbox();

    iconP2.scale.set(lerp(iconP2.scale.x, 1.0, thingy), lerp(iconP2.scale.y, 1.0, thingy));
    iconP2.updateHitbox();
}

function beatHit(curBeat) {
    var funny:Float = Math.max(Math.min(healthBar.value, 1.9), 0.1) / 10;//Math.clamp(healthBar.value,0.02,1.98);//Math.min(Math.min(healthBar.value,1.98),0.02);

    iconP1.scale.set(iconP1.scale.x + (5 * (funny + 0.01)), iconP1.scale.y - (2.5 * funny));
	iconP2.scale.set(iconP2.scale.x + (5 * ((0.2 - funny) + 0.01)), iconP2.scale.y - (2.5 * ((0.2 - funny) + 0.01)));


    iconP1.updateHitbox();
	iconP2.updateHitbox();
}