# bloodthirsty.gd

extends Gene

func _ready():
	pass


#当击杀敌人时 enemy是击中的敌人
func on_enemy_dead():
	print("击杀敌人时攻击力加1")
	attack+=1
