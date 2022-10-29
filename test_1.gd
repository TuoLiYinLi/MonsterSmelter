# test_1 测试脚本1
# 用于测试两个战斗实体之间的战斗
extends Node2D

func _ready():
	var m1:BattleEntity = G.battle_entity.instance()
	m1.description="p1"
	self.add_child(m1)
	
	var m2:BattleEntity = G.battle_entity.instance()
	m2.description="p2"
	self.add_child(m2)
	
	#Z
#	var m3:BattleEntity = G.battle_entity.instance()
#	m3.description="p3"
#	self.add_child(m3)
	
	var g1:Gene = G.gene.instance()
	m1.get_node("gene_pivot").add_child(g1)
	
	var g2 = G.gene_ignite.instance()
	m2.get_node("gene_pivot").add_child(g2)
	
	#var g3 = G.GeneIgnite2.instance()
	#m3.get_node("gene_pivot").add_child(g3)
	
	m1.target = m2
	m2.target = m1
	
	m1.attack_cd = 0.5
	
	randomize()
