extends Node

enum SoundType {
	MENU,
	GAME,
	BUTTON_CLICK,
	GAME_OVER,
	GET_AMMO,
	GET_COIN,
	GET_DAMAGE,
	GET_HP,
	JUMP,
	LAND,
	PASS_THE_LEVEL,
	START_GAME,
	ATTACK,
	SINGLE_GUNSHOT,
}

const soundDict = {
	SoundType.MENU : preload("res://Resources/Soundtracks/Menu/MENU.mp3"),
	SoundType.GAME : preload("res://Resources/Soundtracks/Game/GAME.mp3"),
	SoundType.BUTTON_CLICK : preload("res://Resources/Soundtracks/Effects/button_click/BUTTON_CLICK.mp3"),
	SoundType.GAME_OVER : preload("res://Resources/Soundtracks/Effects/game_over/GAME_OVER.mp3"),
	SoundType.GET_AMMO : preload("res://Resources/Soundtracks/Effects/get_ammo/GET_AMMO.mp3"),
	SoundType.GET_COIN : preload("res://Resources/Soundtracks/Effects/get_coin/GET_COIN.mp3"),
	SoundType.GET_DAMAGE : preload("res://Resources/Soundtracks/Effects/get_damage/GET_DAMAGE.mp3"),
	SoundType.GET_HP : preload("res://Resources/Soundtracks/Effects/get_hp/GET_HP.mp3"),
	SoundType.JUMP : preload("res://Resources/Soundtracks/Effects/jump/JUMP.mp3"),
	SoundType.LAND : preload("res://Resources/Soundtracks/Effects/land/LAND.mp3"),
	SoundType.PASS_THE_LEVEL : preload("res://Resources/Soundtracks/Effects/pass_the_level/PASS_THE_LEVEL.mp3"),
	SoundType.START_GAME : preload("res://Resources/Soundtracks/Effects/start_game/START_GAME.mp3"),
	SoundType.ATTACK : preload("res://Resources/Soundtracks/Effects/attack/ATTACK.mp3"),
	SoundType.SINGLE_GUNSHOT : preload("res://Resources/Soundtracks/Effects/single_gunshot/SINGLE_GUNSHOT.mp3")
}

var sound_loop := AudioStreamPlayer.new()
var sound_instance := AudioStreamPlayer.new()

## Called when the node is added to the scene.
func _ready():
	add_child(sound_instance)
	add_child(sound_loop)


## Play a non-looping sound.
## Parameter soundtype: The type of sound to play.
## Parameter volume_percent: Optional. The volume level as a percentage (default is Globals.options.volume).
func play_sound(soundtype, volume_percent = Globals.options.volume):
	if soundDict.has(soundtype):
		sound_instance.stream = soundDict[soundtype]
		sound_instance.volume_db = 20 * log(clamp(volume_percent / 100.0, 0.0, 1.0)) / log(10)
		sound_instance.play()
	else:
		print("Sound not found for ", soundtype)


## Play a looping sound.
## Parameter soundtype: The type of sound to play.
## Parameter volume_percent: Optional. The volume level as a percentage (default is Globals.options.volume).
func play_loop_sound(soundtype, volume_percent = Globals.options.volume):
	if sound_loop && sound_loop.stream == soundDict[soundtype]:
		return

	if soundDict.has(soundtype):
		sound_loop.volume_db = 20 * log(clamp(volume_percent / 100.0, 0.0, 1.0)) / log(10)
		var looped_sound = soundDict[soundtype]
		looped_sound.loop = true
		sound_loop.stream = looped_sound
		sound_loop.play()
	else:
		print("Sound not found for ", soundtype)


## Stop the currently looping sound.
func stop_loop_sound():
	if sound_loop:
		sound_loop.stop()

## Change the volume of the looping sound.
## Parameter volume_percent: Optional. The volume level as a percentage (default is Globals.options.volume).
func change_volume(volume_percent = Globals.options.volume):
	sound_loop.volume_db = 20 * log(clamp(volume_percent / 100.0, 0.0, 1.0)) / log(10)
