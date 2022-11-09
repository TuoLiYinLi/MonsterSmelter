extends Node2D

var text setget set_text
func set_text(value):
	$Label.text = str(value)

var color setget set_color
func set_color(value:Color):
	$Label.modulate = value

func _process(delta):
	modulate.a -= delta
	position.y -= delta * 32
	if(modulate.a <= 0):
		queue_free()
