# 武器
# 决定角色行为和战斗方式的武器

extends Node2D
class_name Weapon

# 获取自己的主人
func get_host():
	if(!get_parent()):
		printerr("[Weapon] 没有找到父级对象")
		return null
	return get_parent().get_parent()

# 获取目标敌人
func get_target():
	var host = get_host()
	if(host and host.attack_target and is_instance_valid(host.attack_target)):
		return host.attack_target
	return null

# 武器开始发挥作用（不同武器的工作效果不一样）
func behavior():
	pass

#------------------------------------------------------
static func is_Weapon(obj)->bool:
	return obj.has_method("is_Weapon")
