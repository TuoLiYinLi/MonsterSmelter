# test_3.gd
# 网格管理器测试

extends Node2D

func _ready():
	var gm = G.grid_manager
	
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
			
#	for grid in gm.get_grids_range(3,1,3,4):
#			var b = G.building.instance()
#			add_child(b)
#			grid.building = b
#			b.grid = grid
			
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
	m1.teleport_to(gm.get_grid_at(9,8))
	m1.description = "p1"
	
	var w1 = G.weapon.instance()
	m1.get_node("weapon_pivot").add_child(w1)
	
	var m2 = G.battle_entity.instance()
	add_child(m2)
	m2.teleport_to(gm.get_grid_at(1,6))
	m2.description = "p2"
	
	
#	m2.moving_cd = 0.5
	
	var w2 = G.weapon.instance()
	m2.get_node("weapon_pivot").add_child(w2)
	
	
	m1.attack_target = m2
	m2.attack_target = m1
	
