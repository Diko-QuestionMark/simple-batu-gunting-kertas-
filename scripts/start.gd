extends Control



@onready var winLabel = $win
@onready var loseLabel = $lose
@onready var versionLabel = $version
@onready var moneyLabel = $money

var version = 1.2

func _ready() -> void:
	SaveLoad._load()
	var win = Global.win_counter
	var lose = Global.lose_counter
	var money = Global.money
	
	winLabel.text = "win: " + str(win)
	loseLabel.text = "lose: " + str(lose)
	moneyLabel.text = "money: " + str(money)
	versionLabel.text = "version " + str(version) + " beta"
	

func _on_start_pressed() -> void:
	Global.game_mode = "ORIGINAL"
	get_tree().change_scene_to_file("res://scenes/simple.tscn")

func _on_power_up_pressed() -> void:
	Global.game_mode = "POWERUP"
	get_tree().change_scene_to_file("res://scenes/powerup.tscn")

func _on_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/shop.tscn")

func _on_world_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/worldhub.tscn")
	
func _on_exit_pressed() -> void:
	get_tree().quit()
