extends Control

@onready var moneyLabel = $money

var money = Global.money


func _ready() -> void:
	moneyLabel.text = "money: " + str(money)


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start.tscn")
