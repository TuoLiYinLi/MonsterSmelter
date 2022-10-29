# test_3.gd
# 网格管理器测试

extends Node2D

func _ready():
	var gm = G.grid_manager.instance()
	
	add_child(gm)
	
	gm.init_grids(10,10)
	
	for grid in gm.get_grids_range(3,3,3,8):
		var b = G.building.instance()
		add_child(b)
		grid.building = b
		b.grid = grid

	for i in [[0,0,0,8],[0,0,9,0],[9,1,9,9],[0,9,8,9]]:
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
	m1.description = "p1"
	
	while(true):
		yield(get_tree().create_timer(0.5),"timeout")
		var mt = gm.to_navigate_matrix(G,"simple_navigate_matrix")
		
		for i in mt:
			print(i)
		
		var ns = PathFinder.next_step(mt,m1.grid.index_x,m1.grid.index_y,8,8)
		if(ns):
			m1.move_to(gm.get_grid_at(ns[0],ns[1]))
