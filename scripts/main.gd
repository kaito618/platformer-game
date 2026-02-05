extends Control

var save_path = "user://highscore.save"

func _ready():
	load_high_score()
	# Apply current skin to all states
	var tex = load(Global.current_skin_path)
	if tex:
		$TextureButton.texture_normal = tex
		$TextureButton.texture_pressed = tex
		$TextureButton.texture_hover = tex
	
	# Initial text setup
	$score.text = str(Global.total_cookies)
	$highscore.text = "Best: " + str(Global.high_score)
	
	$TextureButton.rect_pivot_offset = $TextureButton.rect_size / 2

func _on_TextureButton_pressed():
	Global.total_cookies += 1
	$score.text = str(Global.total_cookies)
	
	$click.stop()
	$click.play()
	
	$TextureButton.rect_pivot_offset = $TextureButton.rect_size / 2
	$TextureButton.rect_scale = Vector2(1, 1)

	if has_node("Tween"):
		$Tween.interpolate_property($TextureButton, "rect_scale",
			Vector2(0.9, 0.9), Vector2(1, 1), 0.1,
			Tween.TRANS_QUAD, Tween.EASE_OUT)
		$Tween.start()
	
	if Global.total_cookies > Global.high_score:
		Global.high_score = Global.total_cookies
		$highscore.text = "Best: " + str(Global.high_score)
		save_high_score()
	
	_check_milestones()

func _check_milestones():
	var new_skin = "res://assets/250.webp" 
	
	if Global.total_cookies >= 100000:
		new_skin = Global.skin_100000
	elif Global.total_cookies >= 1000:
		new_skin = Global.skin_1000
	elif Global.total_cookies >= 100:
		new_skin = Global.skin_100
		
	if Global.current_skin_path != new_skin:
		Global.current_skin_path = new_skin
		var tex = load(new_skin)
		if tex:
			$TextureButton.texture_normal = tex
			$TextureButton.texture_pressed = tex
			$TextureButton.texture_hover = tex

func save_high_score():
	var file = File.new()
	if file.open(save_path, File.WRITE) == OK:
		file.store_var(Global.high_score)
		file.close()

func load_high_score():
	var file = File.new()
	if file.file_exists(save_path):
		file.open(save_path, File.READ)
		Global.high_score = file.get_var()
		file.close()

func _on_settings_pressed():
	get_tree().change_scene("res://scenes/settings.tscn")
