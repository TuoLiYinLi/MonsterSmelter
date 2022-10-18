extends Gene
class_name GeneIgnite


func _ready():
	# 攻速
	attack_speed = 0.1
	#生命恢复
	health_recovery = 0.2

# 当击中敌人时 enemy是击中的敌人
func on_attack(enemy):
	print("击中敌人时使其燃烧3s")
	enemy.burning_cd += 3
