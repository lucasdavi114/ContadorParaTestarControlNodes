extends VBoxContainer
class_name Contador

signal estado_alterado

var valorCont: int = 0
var nomeInicial: String = ""
var passoInicial: int = 1

@onready var lineEdit: LineEdit = $LineEdit
@onready var lineEditPasso: LineEdit = $HBoxContainerPasso/PassoLineEdit
@onready var label: Label = $HBoxContainer/Label
@onready var menos: TextureButton = $HBoxContainer2/MinusButton
@onready var mais: TextureButton = $HBoxContainer2/PlusButton

# Função para o Main injetar os valores no contador antes dele aparecer
func set_dados(valor: int, nome: String, passo: int = 1) -> void:
	valorCont = valor
	nomeInicial = nome
	passoInicial = max(1, passo)

func _ready() -> void:
	label.text = str(valorCont)
	lineEdit.text = nomeInicial
	lineEditPasso.text = str(passoInicial)

func get_passo() -> int:
	if lineEditPasso:
		var valor: int = lineEditPasso.text.to_int()
		if valor <= 0:
			return 1
		return valor
	return passoInicial

func _on_minus_button_pressed() -> void:
	valorCont -= get_passo()
	if valorCont <= 0:
		valorCont = 0
	
	label.text = str(valorCont)
	estado_alterado.emit()


func _on_plus_button_pressed() -> void:
	valorCont += get_passo()
	label.text = str(valorCont)
	estado_alterado.emit()


func _on_close_button_pressed() -> void:
	queue_free()


func _on_line_edit_text_changed(_new_text: String) -> void:
	estado_alterado.emit()


func _on_passo_line_edit_text_changed(new_text: String) -> void:
	var apenas_digitos: String = ""
	for c in new_text:
		if c >= "0" and c <= "9":
			apenas_digitos += c
	
	if new_text != apenas_digitos:
		lineEditPasso.text = apenas_digitos
		lineEditPasso.caret_column = apenas_digitos.length()
	
	estado_alterado.emit()


func _on_passo_line_edit_focus_exited() -> void:
	if lineEditPasso.text.to_int() <= 0:
		lineEditPasso.text = "1"
		estado_alterado.emit()
	
