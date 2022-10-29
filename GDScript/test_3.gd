# test_3.gd
# 网格管理器测试

extends Node2D

func _ready():
	var gm:GridManager = G.grid_manager.instance()
	
	add_child(gm)
	
	gm.init_grids(10,10)
	
	for grid in gm.get_grids_range(3,3,3,8):
		var b = G.building.instance()
		add_child(b)
		grid.building = b
		b.grid = grid
		
	for i in [[0,0,0,9],[0,0,9,0],[9,0,9,9],[0,9,9,9]]:
		for grid in gm.get_grids_range(i[0],i[1],i[2],i[3]):
			var b = G.building.instance()
			add_child(b)
			grid.building = b
			b.grid = grid
			
	for grid in gm.get_grids_range(5,4,6,4):
			var b = G.building.instance()
			add_child(b)
			grid.building = b
			b.grid = grid
		
	for grid in gm.get_grids_range(7,4,7,7):
		var b = G.building.instance()
		add_child(b)
		grid.building = b
		b.grid = grid
	
	var m1 = G.battle_entity.instance()
	add_child(m1)
	m1.teleport_to(gm.get_grid_at(5,1))
	m1.target_position=Vector2(544,544)
	m1.description = "p1"
	
	var m2 = G.battle_entity.instance()
	add_child(m2)
	m2.teleport_to(gm.get_grid_at(7,8))
	m2.target_position=Vector2(96,96)
	m2.description = "p1"
	
	while(true):
		yield(get_tree().create_timer(0.5),"timeout")
		m1.move_Z(gm)
		m2.move_Z(gm)
	#print(gm.to_navigate_matrix(G,"simple_navigate_matrix"))
	
	#slime.move_to(gm.get_grid_at(5,2))
	
#	yield(get_tree().create_timer(2),"timeout")
#	slime.move_to(gm.get_grid_at(5,3))
	
#	print(gm.to_navigate_matrix(G,"simple_navigate_matrix"))
#	yield(get_tree().create_timer(2),"timeout")
#	slime.move_to(gm.get_grid_at(6,3))
#
#
#	
#
#	yield(get_tree().create_timer(2),"timeout")
#	slime.move_to(gm.get_grid_at(6,4))
#
#
#	print(gm.to_navigate_matrix(G,"simple_navigate_matrix"))
#
#	slime.teleport_to(gm.get_grid_at(5,1))
#
#	print(gm.to_navigate_matrix(G,"simple_navigate_matrix"))
#
#	slime.move_to(gm.get_grid_at(5,2))
#
#	yield(get_tree().create_timer(2),"timeout")
#	slime.move_to(gm.get_grid_at(5,3))
#
#
#	yield(get_tree().create_timer(2),"timeout")
#	slime.move_to(gm.get_grid_at(6,3))
#
#
#	print(gm.to_navigate_matrix(G,"simple_navigate_matrix"))
#
#	yield(get_tree().create_timer(2),"timeout")
#	slime.move_to(gm.get_grid_at(9,9))
