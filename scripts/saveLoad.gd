extends Node

const save_location = "user://SaveFile.json"
var contents_to_save: Dictionary = {
	"winCount": 0,
	"loseCount": 0,
	"money": 0,
}

func _ready() -> void:
	_load()

func _save():
	print(OS.get_user_data_dir())
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	file.store_var(contents_to_save.duplicate())
	file.close()

func _load():
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open(save_location, FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		var save_data = data.duplicate()
		contents_to_save.winCount = save_data.winCount
		contents_to_save.loseCount = save_data.loseCount
		contents_to_save.money = save_data.money
		
		Global.win_counter = contents_to_save.winCount
		Global.lose_counter = contents_to_save.loseCount
		Global.money = contents_to_save.money
