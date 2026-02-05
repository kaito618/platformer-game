extends Control

func _ready():
	# Sync the audio button text
	var bus_idx = AudioServer.get_bus_index("Master")
	var is_muted = AudioServer.is_bus_mute(bus_idx)
	
	# Path updated to include VBoxContainer
	$VBoxContainer/musictoogle.text = "Audio: " + ("OFF" if is_muted else "ON")

func _on_musictoogle_pressed():
	var bus_idx = AudioServer.get_bus_index("Master")
	var is_muted = not AudioServer.is_bus_mute(bus_idx)
	AudioServer.set_bus_mute(bus_idx, is_muted)
	
	# Path updated to include VBoxContainer
	$VBoxContainer/musictoogle.text = "Audio: " + ("OFF" if is_muted else "ON")

func _on_back_pressed():
	get_tree().change_scene("res://scenes/main.tscn")

func _on_MusicSelector_item_selected(index):
	# Path updated to include VBoxContainer
	if index == 0:
		MusicHandler.switch_playlist("Sad")
	elif index == 1:
		MusicHandler.switch_playlist("Minecraft")
