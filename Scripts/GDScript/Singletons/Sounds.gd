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
}

var soundDict = {}
var sound_loop : AudioStreamPlayer

func _ready():
	
	soundDict[SoundType.MENU] = preload("res://Resources/Soundtracks/Menu/MENU.mp3")
	soundDict[SoundType.GAME] = preload("res://Resources/Soundtracks/Game/GAME.mp3")
	soundDict[SoundType.BUTTON_CLICK] = preload("res://Resources/Soundtracks/Effects/button_click/BUTTON_CLICK.mp3")
	soundDict[SoundType.GAME_OVER] = preload("res://Resources/Soundtracks/Effects/game_over/GAME_OVER.mp3")
	soundDict[SoundType.GET_AMMO] = preload("res://Resources/Soundtracks/Effects/get_ammo/GET_AMMO.mp3")
	soundDict[SoundType.GET_COIN] = preload("res://Resources/Soundtracks/Effects/get_coin/GET_COIN.mp3")
	soundDict[SoundType.GET_DAMAGE] = preload("res://Resources/Soundtracks/Effects/get_damage/GET_DAMAGE.mp3")
	soundDict[SoundType.GET_HP] = preload("res://Resources/Soundtracks/Effects/get_hp/GET_HP.mp3")
	soundDict[SoundType.JUMP] = preload("res://Resources/Soundtracks/Effects/jump/JUMP.mp3")
	soundDict[SoundType.LAND] = preload("res://Resources/Soundtracks/Effects/land/LAND.mp3")
	soundDict[SoundType.PASS_THE_LEVEL] = preload("res://Resources/Soundtracks/Effects/pass_the_level/PASS_THE_LEVEL.mp3")
	soundDict[SoundType.START_GAME] = preload("res://Resources/Soundtracks/Effects/start_game/START_GAME.mp3")


func play_sound(SoundType, volume_percent = Globals.Menu.volume):
	if soundDict.has(SoundType):
		var sound_instance = AudioStreamPlayer.new()
		sound_instance.stream = soundDict[SoundType]
		sound_instance.volume_db = 20 * log(clamp(volume_percent / 100.0, 0.0, 1.0)) / log(10)
		add_child(sound_instance) 
		sound_instance.play()
	else:
		print("Sound not found for ", SoundType)
		
		
func play_loop_sound(SoundType, volume_percent = Globals.Menu.volume):
	if soundDict.has(SoundType):
		sound_loop = AudioStreamPlayer.new()
		sound_loop.volume_db = 20 * log(clamp(volume_percent / 100.0, 0.0, 1.0)) / log(10)
		var looped_sound = soundDict[SoundType]
		looped_sound.loop = true
		sound_loop.stream = looped_sound
		add_child(sound_loop)
		sound_loop.play()
	else:
		print("Sound not found for ", SoundType)
		
func stop_loop_sound():
	if sound_loop:
		sound_loop.stop()
