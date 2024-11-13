//named after infamous modding engine of the hit indie rhythm game Friday Night Funkin' named Kade Engine.
//fixes positioning so i dont have to calculate everything related to character positions.

public static function repositionChars(chars:Array<Character>):Void {
    for (char in chars) {
        var actualX = char.extra["actualX"];
        var actualY = char.extra["actualY"];

        char.x += (char.globalOffset.x - actualX) * (char.isPlayer != char.playerOffsets ? 1 : -1);
        char.y += -(char.globalOffset.y - actualY);
    }
}

function postCreate() {
    for (strumline in strumLines.members) {
        repositionChars(strumline.characters);
    }
}