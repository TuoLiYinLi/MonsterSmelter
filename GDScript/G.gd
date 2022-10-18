# G.gd 全局脚本
# 全局符号 G
extends Node2D

# 全局燃烧系数
const BURNING_RATE:float = 0.01

# 预加载的战斗实体场景
var battle_entity:PackedScene = load("res://Scene/BattleEntity.tscn")
# 预加载的基因场景
var gene:PackedScene = load("res://Scene/Gene.tscn")
# 点燃基因
var gene_ignite:PackedScene = load("res://Scene/gene_ignite.tscn")
# 能量消耗Z
#var gene_ignite2:PackedScene = load("res://Scene/gene_ignite2.tscn")
