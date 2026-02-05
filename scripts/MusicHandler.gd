extends Node

onready var player = AudioStreamPlayer.new()

# Dictionary to hold your songs
var playlists = {
	"Sad": [
		load("res://assets/sad1.mp3"), 
		load("res://assets/sad2.mp3")
	],
	"Minecraft": [
		load("res://assets/mc1.mp3"), 
		load("res://assets/mc2.mp3")
	]
}

var current_playlist = "Sad"
var current_track_index = 0

func _ready():
	add_child(player)
	player.bus = "Master"
	# Connect the signal so it plays the next song automatically
	player.connect("finished", self, "_on_song_finished")

func _on_song_finished():
	current_track_index += 1
	if current_track_index >= playlists[current_playlist].size():
		current_track_index = 0
	play_current_selection()

func play_current_selection():
	var songs = playlists[current_playlist]
	if songs.size() > 0:
		player.stream = songs[current_track_index]
		player.play()

func switch_playlist(playlist_name):
	if playlists.has(playlist_name):
		current_playlist = playlist_name
		current_track_index = 0 
		play_current_selection()
