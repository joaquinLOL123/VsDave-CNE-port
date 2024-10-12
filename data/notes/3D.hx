//
function onPlayerHit(event) {
    if (event.noteType == "3D")
        event.ratingPrefix = "game/score/3D/";
}