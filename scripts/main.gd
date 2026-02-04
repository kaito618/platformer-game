extends Control

var score = 0
var high_score = 0
var save_path = "user://highscore.save"

onready var score_label = $score
onready var highscore_label = $highscore
onready var cookie_btn = $TextureButton

func _ready():
	load_high_score() # This must run to get the old score from the disk
	cookie_btn.rect_pivot_offset = cookie_btn.rect_size / 2 # Centers the shake

func _on_TextureButton_pressed():
	score += 1
	score_label.text = str(score)
	$click.play()
	
	# Shake Animation
	var tween = create_tween()
	cookie_btn.rect_rotation = 8
	tween.tween_property(cookie_btn, "rect_rotation", 0, 0.2).set_trans(Tween.TRANS_ELASTIC)
	
	# High Score Logic
	if score > high_score:
		high_score = score
		highscore_label.text = "Best: " + str(high_score)
		save_high_score() # We save every time the record is broken

func _on_settings_pressed():
	get_tree().change_scene("res://scenes/settings.tscn")

func save_high_score():
	var file = File.new()
	var err = file.open(save_path, File.WRITE)
	if err == OK:
		file.store_var(high_score)
		file.close()
		print("High score saved successfully: ", high_score) # Look for this in the Output tab!
	else:
		print("Failed to save file. Error code: ", err)

func load_high_score():
	var file = File.new()
	if file.file_exists(save_path):
		var err = file.open(save_path, File.READ)
		if err == OK:
			high_score = file.get_var()
			file.close()
			highscore_label.text = "Best: " + str(high_score)
			print("High score loaded: ", high_score)
