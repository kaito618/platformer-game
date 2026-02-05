extends Control

func _ready():
	var btn = find_node("musictoogle")
	var selector = find_node("MusicSelector")
	if selector:
		selector.clear() 
		selector.add_item("Sad")      
		selector.add_item("Minecraft") 

	if btn:
		var bus_idx = AudioServer.get_bus_index("Master")
		var is_muted = AudioServer.is_bus_mute(bus_idx)
		btn.pressed = is_muted
		btn.text = "Audio: " + ("OFF" if is_muted else "ON")

func _on_musictoogle_toggled(button_pressed):
	var bus_idx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(bus_idx, button_pressed)
	
	var btn = find_node("musictoogle")
	if btn:
		btn.text = "Audio: " + ("OFF" if button_pressed else "ON")

func _on_back_pressed():
	get_tree().change_scene("res://scenes/main.tscn")

func _on_MusicSelector_item_selected(index):
	var handler = get_node_or_null("/root/MusicHandler")
	if handler:
		if index == 0:
			handler.switch_playlist("Sad")
		elif index == 1:
			handler.switch_playlist("Minecraft")
