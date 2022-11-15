extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	NetLobby.connect("player_info_changed", self, "player_info_changed")

var player_scene = load("res://NetworkTest/NetworkTest.Player.tscn")
func player_info_changed():
	for child in get_children():
		remove_child(child)
	
	for player in NetLobby.player_info:
		add_child(player_scene.instance())
