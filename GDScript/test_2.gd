extends Node2D

#地图的长宽与格子的中间距离Z
var x_screen_size=640
var y_screen_size=640
var meddle=32


func _ready():
	var m1:BattleEntity = G.battle_entity.instance()
	m1.description = "p1"
	self.add_child(m1)
	
	var m2:BattleEntity = G.battle_entity.instance()
	m2.description = "p2"
	self.add_child(m2)
	
	var m3:BattleEntity = G.battle_entity.instance()
	m3.description = "p3"
	self.add_child(m3)
	
	var m4:BattleEntity = G.battle_entity.instance()
	m4.description = "p4"
	self.add_child(m4)
	
	m4.position = Vector2(160,480)
	m4.next_position = Vector2(160,480)
	m4.last_position = Vector2(160,480)
	
	m3.position = Vector2(480,480)
	m3.next_position = Vector2(480,480)
	m3.last_position = Vector2(480,480)
	
	
	m2.position = Vector2(480,160)
	m2.next_position = Vector2(480,160)
	m2.last_position = Vector2(480,160)
	
	m1.position = Vector2(96,160)	
	m1.next_position = Vector2(96,160)
	m1.last_position = Vector2(96,160)
	
	while(true):
		yield(get_tree().create_timer(0.5),"timeout")
		m1.move(G.DIRECTION.DOWN)
		m2.move(G.DIRECTION.LEFT)
		m3.move(G.DIRECTION.UP)
		m4.move(G.DIRECTION.RIGHT)
