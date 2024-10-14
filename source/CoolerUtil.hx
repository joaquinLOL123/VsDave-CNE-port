//
import Xml;

class CoolerUtil extends flixel.FlxBasic {
    public function new() {

    }

    public static function getXMLAtt(node:Xml, att:String):Null<String> {
        return node.exists(att) ? node.get(att) : null;
    }


}