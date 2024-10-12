import funkin.options.OptionsScreen;
import funkin.options.type.TextOption;

function create() {

    items.insert(0, new TextOption("OG mod credits >", "Select this to see the original Vs dave and bambi credits menu", function() {
        FlxG.switchState(new ModState("vsDave/CreditsDNB"));
    }));

    main = new OptionsScreen('Credits', 'The people who made this possible!', items); //holy shit this actually works
}