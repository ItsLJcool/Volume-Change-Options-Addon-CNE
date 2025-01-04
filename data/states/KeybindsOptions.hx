//a
import flixel.input.keyboard.FlxKey;

import flixel.effects.FlxFlicker;
import funkin.options.Options;

import Reflect;

var __data = [
    {
        name: "Vol Up",
        save: "volumeUpKeys",
    }, {
        name: "Vol Down",
        save: "volumeDownKeys",
    }, {
        name: "Mute",
        save: "muteKeys",
    }
];

function new() {
    var settingsPEAK = [];
    for (item in __data) settingsPEAK.push({ name: item.name, control: 'SWITCHMOD' });
    categories.push({
        name: 'Volume',
        settings: settingsPEAK
    });
}

function postCreate() {
    for (item in alphabets.members) {
        for (data in __data) {
            if (item.title.text != data.name) continue;
            keyUpdate(item, Reflect.getProperty(FlxG.save.data, data.save));
        }
    }
}

function keyUpdate(item, options) {
    item.option1 = options[0];
    item.option2 = options[1];
    item.updateText();
}

var init = false;
var flicker:FlxFlicker;
function preUpdate() {
    var text = alphabets.members[curSelected].title.text;


    // Cant fix the bug where Flixel uses the input and changes the volume. Sorry chat :(
    if (!canSelect && FlxG.keys.justPressed.ANY) {
        flicker?.stop();
        canSelect = skipThisFrame = true;
        var index = alphabets.members[curSelected].p2Selected ? 1 : 0;
        for (data in __data) {
            if (data.name != text) continue;
            
            var key = FlxG.keys.firstJustPressed();
            var save = Reflect.getProperty(FlxG.save.data, data.save);
            save[index] = key;

            Reflect.setProperty(FlxG.save.data, data.save, save);
            Reflect.setProperty(FlxG.sound, data.save, save);
            FlxG.save.flush();

            keyUpdate(alphabets.members[curSelected], Reflect.getProperty(FlxG.save.data, data.save));
            break;
        }
    }
    
    if (controls.ACCEPT && !skipThisFrame && canSelect && init) {
        for (data in __data) {
            if (data.name != text) continue;
            skipThisFrame = true;
            break;
        }
        if (!skipThisFrame) return;
        CoolUtil.playMenuSFX(1);
        flicker = FlxFlicker.flicker(alphabets.members[curSelected], 0, Options.flashingMenu ? 0.06 : 0.15, true, false, function(t) {});
        canSelect = false;
    }


    if (!init) init = true;
}