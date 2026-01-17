extends Control

var win = Global.win_counter
var lose = Global.lose_counter

@onready var winLabel = $win
@onready var loseLabel = $lose


func _ready() -> void:
	SaveLoad._load()
	winLabel.text = "win: " + str(win)
	loseLabel.text = "lose: " + str(lose)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://simple.tscn")
