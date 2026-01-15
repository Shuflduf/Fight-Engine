@tool
class_name Bundle
extends Node

@export_tool_button("EXPLODE 💣💣💣💣") var explode_func = explode

func explode():
	for child in get_children():
		child.reparent(get_parent())
	queue_free()
