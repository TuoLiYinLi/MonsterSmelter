# test_5.gd


extends Node2D

func _ready():
	var gm = G.grid_manager
	
	gm.init_grids(10,10)
	
	for i in range(3,9):
		G.spawn_manager.spawn_building_dirt_wall(3,i,randi()%3)

	for i in [[0,0,0,8],[0,0,9,0],[9,1,9,9],[0,9,8,9]]:
		for grid in gm.get_grids_range(i[0],i[1],i[2],i[3]):
			G.spawn_manager.spawn_building_dirt_wall(grid.index_x,grid.index_y,randi()%3)	
	for i in range(5,7):
		G.spawn_manager.spawn_building_dirt_wall(i,4,randi()%3)
	for i in range(4,8):
		G.spawn_manager.spawn_building_dirt_wall(7,i,randi()%3)
	for i in range(10):
		for j in range(10):
			G.spawn_manager.spawn_ground_dirt(i,j,randi()%8)	
	var sm=G.spawn_manager
	var m1 = G.spawn_manager.spawn_battle_entity(0,2,5,sm.WEAPON_ID.JAVELIN,[])
	G.spawn_manager.spawn_gene_ignite(m1)
	
	var m2 = G.spawn_manager.spawn_battle_entity(0,8,8,sm.WEAPON_ID.JAVELIN,[])
	G.spawn_manager.spawn_gene_poison(m2)

	m1.attack_target = m2
	m2.attack_target = m1

	
	
	
