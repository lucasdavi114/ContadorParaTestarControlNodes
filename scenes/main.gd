extends Control


func _on_button_pressed() -> void:
	var contadorScene: PackedScene = preload("res://scenes/contador.tscn")
	var contador = contadorScene.instantiate()
	$ScrollContainer/GridContainer.add_child(contador)
