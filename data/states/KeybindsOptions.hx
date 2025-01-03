//a
import flixel.input.keyboard.FlxKey;

import flixel.effects.FlxFlicker;
import funkin.options.Options;

var __volumeUp = "Vol Up";
var __volumeDown = "Vol Down";
function new() {
    categories.push({
        name: 'Volume',
        settings: [
            {
                name: __volumeUp,
                control: 'SWITCHMOD'
            }, {
                name: __volumeDown,
                control: 'SWITCHMOD'
            },
        ]
    });
}

function postCreate() {
    for (item in alphabets.members) {
        if (item.title.text == __volumeUp) {
            keyUpdate(item, FlxG.save.data.volumeUpKeys);
            continue;
        } 
        if (item.title.text == __volumeDown) {
            keyUpdate(item, FlxG.save.data.volumeDownKeys);
            continue;
        }
    }
}

function keyUpdate(item, options) {
    var updateText = () -> {};
    for (idx=>data in options) {
        switch (data) {
            case FlxKey.NUMPADPLUS:
                var bind = (idx == 0) ? item.bind1 : item.bind2;
                options[idx] = FlxKey.PLUS;
                updateText = () -> options[idx] = FlxKey.NUMPADPLUS;
            case FlxKey.NUMPADMINUS:
                options[idx] = FlxKey.MINUS;
                updateText = () -> options[idx] = FlxKey.NUMPADMINUS;
        }
    }
    item.option1 = options[0];
    item.option2 = options[1];
    item.updateText();
    updateText();
}

var init = false;
var flicker:FlxFlicker;
function preUpdate() {
    var text = alphabets.members[curSelected].title.text;

    if (!canSelect && FlxG.keys.justPressed.ANY) {
        flicker?.stop();
        canSelect = skipThisFrame = true;
        var index = alphabets.members[curSelected].p2Selected ? 1 : 0;
        switch (text) {
            case __volumeUp:
                FlxG.save.data.volumeUpKeys[index] = FlxG.keys.firstJustPressed();
                keyUpdate(alphabets.members[curSelected], FlxG.save.data.volumeUpKeys);
            case __volumeDown:
                FlxG.save.data.volumeDownKeys[index] = FlxG.keys.firstJustPressed();
                keyUpdate(alphabets.members[curSelected], FlxG.save.data.volumeDownKeys);
        }
    }
    
    if (controls.ACCEPT && !skipThisFrame && canSelect && init) {
        if (text == __volumeUp || text == __volumeDown) skipThisFrame = true;
        else return;
        CoolUtil.playMenuSFX(1);
        flicker = FlxFlicker.flicker(alphabets.members[curSelected], 0, Options.flashingMenu ? 0.06 : 0.15, true, false, function(t) {});
        canSelect = false;
        switch (text) {
            case __volumeUp:
                // trace('Volume Up');
        }
    }


    if (!init) init = true;
}