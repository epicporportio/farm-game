extends Node

var plant_list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] # 0 = none, 1 = wheat, 2 = carrot
var plant_profiles = {
	1: {"plant_id": 1, "name": "Wheat", "type": "farm", "growtime": 5,"price": 5, "amount": 0, "animation": "wheat_growing", "texture": preload("res://assets/Farm_Tiles-export.png")},
	2: {"plant_id": 2, "name": "Carrot", "type": "farm", "growtime": 10, "price": 20, "amount": 0, "animation": "carrot_growing", "texture": preload("res://assets/carrot.png")},
	3: {"plant_id": 3, "name": "Grape", "type": "vine", "growtime": 15, "price": 10, "amount": 0, "animation": "grape_growing", "texture": preload("res://assets/grape.png")},
	4: {"plant_id": 4, "name": "Apple", "type": "tree", "growtime": 40, "price": 20, "amount": 0, "animation": "apple_growing", "texture": preload("res://assets/apple.png")},
	# 5: {"plant_id": 5, "name": "Rice", "type": "water", "growtime": 25, "amount": 0, "animation": "rice_growing", "texture": preload("res://assets/Carrots-export.png")}
}
var plant_selected = 0
var planting = false
var plant_data = 0
var money = 0
