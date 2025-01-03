//a

function new() {
    FlxG.save.data.volumeUpKeys ??= FlxG.sound.volumeUpKeys;
    FlxG.save.data.volumeDownKeys ??= FlxG.sound.volumeDownKeys;
    FlxG.save.flush();

    FlxG.sound.volumeUpKeys = FlxG.save.data.volumeUpKeys;
    FlxG.sound.volumeDownKeys = FlxG.save.data.volumeDownKeys;
}