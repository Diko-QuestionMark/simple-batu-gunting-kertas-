extends Node

var playerChoice = ""
var random = 0
var enemyChoice = ""
var result = "SERI"
var playerHealth = 4
var enemyHealth = 4

@onready var resultText = $UI/ResultText
@onready var playerChoiceLabel = $UI/PlayerChoice
@onready var enemyChoiceLabel = $UI/EnemyChoice
@onready var delayGameOver = $DelayGameOver
@onready var tombolAction = $UI/HBoxContainer

@onready var playerSprite = $World/Player
@onready var enemySprite = $World/Enemy

func _ready() -> void:
	randomize()

func _on_batu_pressed() -> void:
	playerChoice = "BATU"
	playerChoiceLabel.text = "✊"
	play_game()
func _on_gunting_pressed() -> void:
	playerChoice = "GUNTING"
	playerChoiceLabel.text = "✌️"
	play_game()
func _on_kertas_pressed() -> void:
	playerChoice = "KERTAS"
	playerChoiceLabel.text = "🖐️"
	play_game()

func play_game() -> void:
	random = randi() % 3
	if random == 2:
		enemyChoice = "BATU"
		enemyChoiceLabel.text = "✊"
	elif random == 1:
		enemyChoice = "GUNTING"
		enemyChoiceLabel.text = "✌️"
	else:
		enemyChoice = "KERTAS"
		enemyChoiceLabel.text = "🖐️"
	
	print()
	print(playerChoice + "+++Player", playerHealth)
	print(enemyChoice + "---Musuh", enemyHealth)
	
	if (playerChoice == "BATU" && enemyChoice == "GUNTING"):
		result = "MENANG"
	elif (playerChoice == "GUNTING" && enemyChoice == "KERTAS"):
		result = "MENANG"
	elif (playerChoice == "KERTAS" && enemyChoice == "BATU"):
		result = "MENANG"
		
	elif (playerChoice == "BATU" && enemyChoice == "BATU"):
		result = "SERI"
	elif (playerChoice == "KERTAS" && enemyChoice == "KERTAS"):
		result = "SERI"
	elif (playerChoice == "GUNTING" && enemyChoice == "GUNTING"):
		result = "SERI"
	else:
		result = "KALAH"
		
		
	if result == "MENANG":
		print("[Player Menang✅]")
		enemyHealth -= 1
		$UI/EnemyHealth.value = enemyHealth
		resultText.text = "MENANG"
		resultText.add_theme_color_override("font_color", Color(0.0, 0.918, 0.014, 1.0))
		if enemyHealth == 0:
			enemySprite.play("death")
			Global.game_win = true
			Global.win_counter += 1
			game_over()
			
	elif result == "SERI":
		print("[SERI 🧐]")
		resultText.text = "SERI"
		resultText.add_theme_color_override("font_color", Color(0.846, 0.918, 0.0, 1.0))
		
	else:
		print("[Player Kalah❌]")
		playerHealth -= 1
		$UI/PlayerHealth.value = playerHealth
		resultText.text = "KALAH"
		resultText.add_theme_color_override("font_color", Color(1.0, 0.0, 0.0, 1.0))
		if playerHealth == 0:
			playerSprite.play("death")
			Global.game_win = false
			Global.lose_counter += 1
			game_over()

func game_over() -> void:
	tombolAction.visible = false
	delayGameOver.start()
	saving()

func _on_delay_game_over_timeout() -> void:
	tombolAction.visible = false
	get_tree().change_scene_to_file("res://scenes/gameover.tscn")

func saving() -> void:
	SaveLoad.contents_to_save.winCount = Global.win_counter
	SaveLoad.contents_to_save.loseCount = Global.lose_counter
	SaveLoad._save()


func _process(_delta: float) -> void:
	pass
	
