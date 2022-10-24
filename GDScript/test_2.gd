extends Node2D

#地图的长宽与格子的中间距离Z
var x_screen_size=640
var y_screen_size=640
var meddle=32
class_name Map

#地图抽象化Z
var maze = [[1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	   [1, 0, 0, 0, 0, 1, 0, 0, 0, 1],
	   [1, 0, 0, 0, 0, 1, 0, 0, 0, 1],
	   [1, 0, 0, 0, 0, 1, 1, 1, 1, 1],
	   [1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
	   [1, 0, 0, 0, 0, 1, 0, 0, 0, 1],
	   [1, 0, 0, 0, 0, 1, 0, 0, 0, 1],
	   [1, 0, 0, 0, 0, 1, 0, 0, 1, 1],
	   [1, 0, 0, 0, 0, 1, 0, 1, 1, 1],
	   [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]]

func t0():
	var grid_map:Array = []
	for x in range(10):
		var inner_list:Array = []
		grid_map.append(inner_list)
		for y in range(10):
			inner_list.append(1)
			print("%s %s"%[x,y])
	
	print(grid_map)

	
func _ready():
	var m1:BattleEntity = G.battle_entity.instance()
	m1.description = "p1"
	self.add_child(m1) 
	
	var m2:BattleEntity = G.battle_entity.instance()
	m2.description = "p2"
	self.add_child(m2) 
	
	
	m1.position = Vector2(96,160)	
	m1.next_position = Vector2(96,160)
	m1.last_position = Vector2(96,160)
	m1.target_position = Vector2(480,480)
	
	m2.position = Vector2(480,480)	
	m2.next_position = Vector2(480,480)
	m2.last_position = Vector2(480,480)
	m2.target_position = Vector2(96,160)
	
	var map=maze
	
	while(true):
		yield(get_tree().create_timer(0.5),"timeout")
		m1.move(map)
		m2.move(map)
		#m3.move(map)
