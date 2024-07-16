extends Node

signal pause(player : bool)
signal unpause()
signal move_selected(move_resource:move)

var player : Resource = load("res://Resources/units/player.tres")
var opponent : Resource = load("res://Resources/units/opponent.tres")
