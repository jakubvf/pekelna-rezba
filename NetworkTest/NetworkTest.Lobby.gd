extends Control

var SERVER_IP = "127.0.0.1"
var SERVER_PORT = 65443
var MAX_PLAYERS = 8

var player_info = {}
var my_info = { name = "Johnson Magenta", favorite_color = Color8(255, 0, 255) }

signal player_connected(new_player_info)
signal player_disconnected(id)

func _player_connected(id):
	# Called on both clients and server when a peer connects. Send my info to it.
	rpc_id(id, "register_player", my_info)
	$Panel.visible = false

remote func register_player(info):
	var id = get_tree().get_rpc_sender_id()
	print("player connected: " + str(id))
	player_info[id] = info
	emit_signal("player_connected", info)


func _player_disconnected(id):
	player_info.erase(id) # Erase player from info.
	rpc_id(id, "deregister_player", id)
	$Panel.visible = true

remote func deregister_player(id):
	print("player disconnected: " + str(id))
	player_info.erase(id)
	emit_signal("player_disconnected", id)


func _connected_ok():
	print("connected: "  + SERVER_IP + ":" + str(SERVER_PORT))
	$Panel.visible = false

func _server_disconnected():
	print("kicked by server")
	$Panel.visible = true

func _connected_fail():
	print("failed to connect: "  + SERVER_IP + ":" + str(SERVER_PORT))
	$Panel.visible = true

var player_scene = preload("res://NetworkTest/NetworkTest.Player.tscn")

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	
	var server_result = start_server()
	if server_result == ERR_CANT_CREATE:
		# TODO: handle start_client fail
		start_client()
	
	$Panel.visible = false

func _on_Server_pressed():
	start_server()

func start_client():
	print("connecting to: " + SERVER_IP + ":" + str(SERVER_PORT))
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(SERVER_IP, SERVER_PORT)
	get_tree().network_peer = peer


func _on_Client_pressed():
	start_client()

func start_server():
	print("starting server: " + SERVER_IP + ":" + str(SERVER_PORT))
	var peer = NetworkedMultiplayerENet.new()
	
	var result = peer.create_server(SERVER_PORT, MAX_PLAYERS)
	if result == OK:
		get_tree().network_peer = peer
		
	return result
