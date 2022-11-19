extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	NetLobby.connect("player_info_changed", self, "player_info_changed")

var player_scene = load("res://NetworkTest/NetworkTest.Player.tscn")
func player_info_changed(new_info):
	var selfPeerID = get_tree().get_network_unique_id()
	print(str(selfPeerID), "connected")	
	
	var new_player = player_scene.instance()
	new_player.set_name(str(selfPeerID))
	new_player.set_network_master(selfPeerID)
	add_child(new_player)

# TODO: player disconnect
