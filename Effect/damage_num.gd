extends Node2D

var text setget set_text
func set_text(value):
	$Label.text = str(value)

func _process(delta):
	modulate.a -= delta
	position.y -= delta * 32
	if(modulate.a<=0):
		queue_free()
