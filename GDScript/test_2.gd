extends Node2D

func _ready():
	var m1:BattleEntity = G.battle_entity.instance()
	m1.description = "p1"
	self.add_child(m1)
	
	m1.position = Vector2(160,160)
	
	m1.next_position = Vector2(160,160)
	
	m1.last_position = Vector2(160,160)
	
	while(true):
		yield(get_tree().create_timer(0.5),"timeout")
		m1.move(G.DIRECTION.RIGHT)
	
