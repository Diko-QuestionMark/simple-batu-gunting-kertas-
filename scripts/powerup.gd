extends Node

var playerChoice = ""
var random = 0
var enemyChoice = ""
var result = "SERI"
var playerHealth = 4
var enemyHealth = 4
var multi_damage = 1
var damage = 1
var shield = false
var predict = false

@onready var resultText = $UI/ResultText
@onready var playerChoiceLabel = $UI/PlayerChoice
@onready var enemyChoiceLabel = $UI/EnemyChoice
@onready var delayGameOver = $DelayGameOver
@onready var tombolAction = $UI/choice

@onready var barPlayerHealth = $UI/PlayerHealth
@onready var barEnemyHealth = $UI/EnemyHealth
@onready var labelPlayerHealthNumber = $UI/PlayerHealth/Label
@onready var labelEnemyHealthNumber = $UI/EnemyHealth/Label


@onready var tombolDoubleDamage = $UI/power/DoubleDamage
@onready var tombolShield = $UI/power/Shield
@onready var tombolPredict = $UI/power/Predict

@onready var iconDoubleDamage = $UI/DoubleDamage
@onready var iconShield = $UI/Shield
@onready var iconPredict = $UI/Predict

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
	if not predict:
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
	predict = false
	print()
	print(playerChoice + "+++Player", playerHealth)
	print(enemyChoice + "---Musuh", enemyHealth)
	
	if (playerChoice == "BATU" && enemyChoice == "GUNTING"):
		result = "MENANG"
	elif (playerChoice == "GUNTING" && enemyChoice == "KERTAS"):
		result = "MENANG"
	elif (playerChoice == "KERTAS" && enemyChoice == "BATU"):
		result = "MENANG"
		
	elif (playerChoice == enemyChoice):
		result = "SERI"
	else:
		result = "KALAH"
		
		
	if result == "MENANG":
		print("[Player Menang✅]")
		shield = false
		enemyHealth -= damage * multi_damage
		multi_damage = 1
		iconDoubleDamage.visible = false
		iconShield.visible = false
		iconPredict.visible = false
		barEnemyHealth.value = enemyHealth
		labelEnemyHealthNumber.text = str(enemyHealth)
		
		resultText.text = "MENANG"
		resultText.add_theme_color_override("font_color", Color(0.0, 0.918, 0.014, 1.0))
		if enemyHealth == 0:
			enemySprite.play("death")
			Global.game_win = true
			Global.win_counter += 1
			game_over()
			
	elif result == "SERI":
		print("[SERI 🧐]")
		shield = false
		multi_damage = 1
		iconDoubleDamage.visible = false
		iconShield.visible = false
		iconPredict.visible = false
		resultText.text = "SERI"
		resultText.add_theme_color_override("font_color", Color(0.846, 0.918, 0.0, 1.0))
		
	else:
		print("[Player Kalah❌]")
		if shield:
			multi_damage = 0
			shield = false
		playerHealth -= damage * multi_damage
		multi_damage = 1
		iconDoubleDamage.visible = false
		iconShield.visible = false
		iconPredict.visible = false
		barPlayerHealth.value = playerHealth
		labelPlayerHealthNumber.text = str(playerHealth)
		resultText.text = "KALAH"
		resultText.add_theme_color_override("font_color", Color(1.0, 0.0, 0.0, 1.0))
		if playerHealth == 0:
			playerSprite.play("death")
			Global.game_win = false
			Global.lose_counter += 1
			game_over()

func _on_double_damage_pressed() -> void:
	multi_damage = 2
	tombolDoubleDamage.visible = false
	iconDoubleDamage.visible = true

func _on_shield_pressed() -> void:
	tombolShield.visible = false
	iconShield.visible = true
	shield = true

func _on_predict_pressed() -> void:
	tombolPredict.visible = false
	iconPredict.visible = true
	predict = true
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

func game_over() -> void:
	tombolAction.visible = false
	delayGameOver.start()
	saving()

func saving() -> void:
	SaveLoad.contents_to_save.winCount = Global.win_counter
	SaveLoad.contents_to_save.loseCount = Global.lose_counter
	SaveLoad._save()

func _on_delay_game_over_timeout() -> void:
	tombolAction.visible = false
	get_tree().change_scene_to_file("res://scenes/gameover.tscn")

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start.tscn")

func _process(_delta: float) -> void:
	pass
