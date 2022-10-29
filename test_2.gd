extends Node2D

#地图的长宽与格子的中间距离Z
var x_screen_size=640
var y_screen_size=640
var meddle=32
class_name Map

#地图抽象化Z
#1为障碍物2为怪物
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

#地图中人物抽象化2为有人 Z
var maze_role = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]

#地图地板抽象化Z
var maze_floor = [[1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
				[1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
				[1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
				[1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
				[1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
				[1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
				[1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
				[1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
				[1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
				[1, 1, 1, 1, 1, 1, 1, 1, 1, 1]]

#创建格子类数组Z				
var grid_map:Array = []
class Grid_Z:
	var grid_position:Vector2
	var grid_role
	var grid_building
	var grid_floor
	
	func _init(grid_position, grid_role, grid_building, grid_floor):
		self.grid_position = grid_position
		self.grid_role = grid_role
		self.grid_building = grid_building
		self.grid_floor = grid_floor

	#修改数值函数
	func change_position(x):
		self.grid_position = x
	
	func change_role(x):
		self.grid_role = x
	
	func change_building(x):
		self.grid_building = x
	
	func change_floor(x):
		self.grid_floor = x
		
	func pr():
		print(self.grid_position,' ',self.grid_role, ' ', self.grid_building, ' ',self.grid_floor )
		

	#测试用----------------------------------------------
		
	#---------------------------------------------------	
		
	
#创建grid_map
func creat_grid():
	for x in range(10):
		var inner_list:Array = []
		grid_map.append(inner_list)
		for y in range(10):
			inner_list.append(Grid_Z.new(Vector2(x*64+32,y*64+32),maze_role[x][y],maze[x][y],maze_floor[x][y]))

	
func _ready():
	creat_grid()
	var m1:BattleEntity = G.battle_entity.instance()
	m1.description = "p1"
	self.add_child(m1) 
	
	var m2:BattleEntity = G.battle_entity.instance()
	m2.description = "p2"
	self.add_child(m2) 
	
	var m3:BattleEntity = G.battle_entity.instance()
	m3.description = "p3"
	self.add_child(m3) 
	
	m1.position = Vector2(96,160)	
	m1.next_position = Vector2(96,160)
	m1.last_position = Vector2(96,160)
	m1.target_position = Vector2(480,416)
	#因为坐标系的xy与数组xy是相反的所以要反着输入Z
	grid_map[int(160/64)][int(96/64)].change_role(m1.description)
	
	
	m2.position = Vector2(480,480)	
	m2.next_position = Vector2(480,480)
	m2.last_position = Vector2(480,480)
	m2.target_position = Vector2(96,224)
	grid_map[int(480/64)][int(480/64)].change_role(m2.description)
	
	
	m3.position = Vector2(224,544)	
	m3.next_position = Vector2(224,544)
	m3.last_position = Vector2(224,544)
	m3.target_position = Vector2(544,288)
	grid_map[int(544/64)][int(224/64)].change_role(m2.description)

	
	while(true):
		yield(get_tree().create_timer(0.5),"timeout")
		
		m1.move_Z(grid_map)
		m2.move_Z(grid_map)
		m3.move_Z(grid_map)
