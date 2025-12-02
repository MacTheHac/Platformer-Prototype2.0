@tool extends EditorScript


func _run() -> void:
	ProjectSettings.set("display/window/size/viewport_width", 320)
	ProjectSettings.set("display/window/size/viewport_height", 180)
	ProjectSettings.set("display/window/size/window_width_override", 1280)
	ProjectSettings.set("display/window/size/window_height_override", 720)
	ProjectSettings.set("display/window/stretch/mode", "canvas_items")
	ProjectSettings.set("rendering/textures/canvas_textures/default_texture_filter", "Nearest")
	ProjectSettings.save()
