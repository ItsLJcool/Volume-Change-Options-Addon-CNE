//a

function new() {
    FlxG.save.data.volumeUpKeys = null;
    FlxG.save.data.volumeDownKeys = null;
    FlxG.save.data.muteKeys = null;
    
    FlxG.save.data.volumeUpKeys ??= FlxG.sound.volumeUpKeys;
    FlxG.save.data.volumeDownKeys ??= FlxG.sound.volumeDownKeys;
    FlxG.save.data.muteKeys ??= FlxG.sound.muteKeys;
    FlxG.save.flush();

    FlxG.sound.volumeUpKeys = FlxG.save.data.volumeUpKeys;
    FlxG.sound.volumeDownKeys = FlxG.save.data.volumeDownKeys;
    FlxG.sound.muteKeys = FlxG.sound.muteKeys;
}