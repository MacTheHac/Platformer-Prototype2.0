@tool
extends EditorScript

# Passe die Liste an deine gewünschten Favoriten an (Godot 4-Knotennamen).
var favorites: Array = ["AnimationPlayer", "Area2D", "CollisionShpe2D", "Node2D", "Marker2D"]

func _run() -> void:
	print("--- set_create_node_favorites_4_5: start ---")
	var base := get_editor_interface().get_base_control()
	if base == null:
		printerr("Editor base control nicht gefunden.")
		return

	var dialog := _find_create_node_dialog(base)
	if dialog == null:
		printerr("Create Node Dialog nicht gefunden. Öffne bitte einmal das 'Create New Node' Fenster und versuche es erneut.")
		return

	if dialog.has_method("set_favorites"):
		dialog.call("set_favorites", favorites)
		print("Favoriten gesetzt:", favorites)
		return

	# Fallback: falls eine Eigenschaft existiert
	if dialog.has_method("get") and dialog.has_method("set"):
		# Suche properties, die 'favorite' im Namen haben
		for prop_info in dialog.get_property_list():
			if typeof(prop_info) == TYPE_DICTIONARY and prop_info.has("name"):
				var pname := str(prop_info.name).to_lower()
				if "favorite" in pname:
					dialog.set(prop_info.name, favorites)
					print("Favoriten via Property", prop_info.name, "gesetzt.")
					return

	printerr("Konnte Favoriten nicht setzen: Dialog bietet keine bekannte API. Godot-Version oder Implementation prüfen.")
	print("--- set_create_node_favorites_4_5: ende ---")

func _find_create_node_dialog(node: Node) -> Node:
	if node == null:
		return null
	# Heuristik: Dialog hat üblicherweise set_favorites oder ähnliche Methoden
	if node.has_method("set_favorites") or node.has_method("get_favorites"):
		return node
	# Klassennamen-Heuristik (sicherheitshalber)
	var cls = node.get_class()
	if cls.to_lower().findn("create") != -1 and cls.to_lower().findn("dialog") != -1:
		return node
	for child in node.get_children():
		if child is Node:
			var found := _find_create_node_dialog(child)
			if found:
				return found
	return null
