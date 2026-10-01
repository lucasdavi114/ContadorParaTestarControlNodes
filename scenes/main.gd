extends Control

const SAVE_PATH = "user://contadores_save.json"

var contadorScene: PackedScene = preload("res://scenes/contador.tscn")
@onready var grid = $ScrollContainer/GridContainer

func _ready() -> void:
	for child in grid.get_children():
		child.queue_free()
	
	carregar_dados()
func _on_button_pressed() -> void:
	adicionar_contador(0, "")
	salvar_dados()

func adicionar_contador(valor: int, nome: String):
	var contador: Contador = contadorScene.instantiate()
	contador.set_dados(valor, nome)
	grid.add_child(contador)
	
	contador.estado_alterado.connect(salvar_dados)
	contador.tree_exited.connect(salvar_dados)

# Sistema de Save / Load

func salvar_dados() -> void:
	var dados_array = []
	for child: Contador in grid.get_children():
		if not child.is_queued_for_deletion():
			dados_array.append({
				"valorCont": child.valorCont,
				"contadorNome": child.lineEdit.text
			})
	
	var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(dados_array))

func carregar_dados() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var json_string = file.get_as_text()
		var dados = JSON.parse_string(json_string)
		
		if typeof(dados) == TYPE_ARRAY:
			for item in dados:
				var valor = item.get("valorCont", 0)
				var nome = item.get("contadorNome", "")
				adicionar_contador(valor, nome)
