extends VBoxContainer

var valorCont: int = 0
@onready var contadorNome = $LineEdit.text
@onready var label = $HBoxContainer/Label
@onready var menos = $HBoxContainer2/MinusButton
@onready var mais = $HBoxContainer2/PlusButton

func _ready() -> void:
	label.text = str(valorCont)


func _on_minus_button_pressed() -> void:
	valorCont -= 1
	if valorCont <= 0:
		valorCont = 0
	
	label.text = str(valorCont)


func _on_plus_button_pressed() -> void:
	valorCont += 1
	label.text = str(valorCont)


func _on_close_button_pressed() -> void:
	queue_free()


func _on_line_edit_text_changed(new_text: String) -> void:
	contadorNome = new_text
	
