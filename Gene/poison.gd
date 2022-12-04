# poison.gd

extends Gene

func _ready():
	pass

# 当击中敌人时 enemy是击中的敌人
func on_attack(enemy):
	print("击中敌人时使其中毒4s")
	enemy.poisoning_cd += 4
