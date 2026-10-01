extends VBoxContainer
class_name Contador

signal estado_alterado

var valorCont: int = 0
var nomeInicial: String = ""
@onready var lineEdit = $LineEdit
@onready var label = $HBoxContainer/Label
@onready var menos = $HBoxContainer2/MinusButton
@onready var mais = $HBoxContainer2/PlusButton

# Função para o Main injetar os valores no contador antes dele aparecer
func set_dados(valor: int, nome: String) -> void:
	valorCont = valor
	nomeInicial = nome

func _ready() -> void:
	label.text = str(valorCont)
	lineEdit.text = nomeInicial

func _on_minus_button_pressed() -> void:
	valorCont -= 1
	if valorCont <= 0:
		valorCont = 0
	
	label.text = str(valorCont)
	estado_alterado.emit()


func _on_plus_button_pressed() -> void:
	valorCont += 1
	label.text = str(valorCont)
	estado_alterado.emit()


func _on_close_button_pressed() -> void:
	queue_free()


func _on_line_edit_text_changed(_new_text: String) -> void:
	estado_alterado.emit()
	
