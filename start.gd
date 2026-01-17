extends Control



@onready var winLabel = $win
@onready var loseLabel = $lose
@onready var versionLabel = $version

var version = 1.0

func _ready() -> void:
	SaveLoad._load()
	var win = Global.win_counter
	var lose = Global.lose_counter
	
	winLabel.text = "win: " + str(win)
	loseLabel.text = "lose: " + str(lose)
	versionLabel.text = "version " + str(version)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://simple.tscn")
