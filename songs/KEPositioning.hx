//named after infamous modding engine of the hit indie rhythm game Friday Night Funkin' named Kade Engine.
//fixes positioning so i dont have to calculate everything related to character positions.

public static function repositionChars(chars:Array<Character>):Void {
    for (char in chars) {
        trace(char.curCharacter);
        var actualX = Std.parseInt(CoolerUtil.getXMLAtt(char.xml, "actualX"));
        var actualY = Std.parseInt(CoolerUtil.getXMLAtt(char.xml, "actualY"));

        char.x += -(actualX * (char.isPlayer != char.playerOffsets ? 1 : -1) + char.globalOffset.x) * (char.isPlayer != char.playerOffsets ? -1 : 1);
        char.y += -(-actualY + char.globalOffset.y);
    }
}

function postCreate() {
    for (strumline in strumLines.members) {
        repositionChars(strumline.characters);
    }
}