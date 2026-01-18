extends Control

@onready var description = $Description
@onready var winSound = $winSound
@onready var loseSound = $loseSound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.game_win == true:
		description.text = "Good job, you won!👍"
		description.add_theme_color_override("font_color", Color(0.0, 0.918, 0.014, 1.0))
		winSound.play()
	else:
		description.text = "Nice try, you lose.👎"
		description.add_theme_color_override("font_color", Color(1.0, 0.0, 0.0, 1.0))
		loseSound.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	if Global.game_mode == "ORIGINAL":
		get_tree().change_scene_to_file("res://scenes/simple.tscn")
	if Global.game_mode == "POWERUP":
		get_tree().change_scene_to_file("res://scenes/powerup.tscn")


func _on_back_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start.tscn")
