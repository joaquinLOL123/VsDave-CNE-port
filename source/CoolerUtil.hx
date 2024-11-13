//
import Xml;

class CoolerUtil extends flixel.FlxBasic {
    public function new() {

    }

    public static function getXMLAtt(node:Xml, att:String):Null<String> {
        return node.exists(att) ? node.get(att) : null;
    }

    public static function measuresToMS(measures:Int) {
        return (((Conductor.stepsPerBeat * Conductor.beatsPerMeasure) * measures) * Conductor.stepCrochet) / 1000;
    }

    public static function stepsToMS(steps:Int):Float {
        return (Conductor.stepCrochet / 1000) * steps;
    }

    public static function beatsToMS(beats:Int):Float {
        return ((Conductor.stepCrochet / 1000) * beats) / 4;
    }


}