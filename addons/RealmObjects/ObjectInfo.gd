tool
extends Control

signal pressed

func set_text(text):
	$Button.text = text

func set_description(description):
	$Description.text = description

func _on_button_pressed():
	emit_signal("pressed")
