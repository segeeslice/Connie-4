extends Node2D

const ColorMode = preload("../Global/ColorMode.gd")
var color = ColorMode.RED setget set_color_mode, get_color_mode

# === API ===

# Set color mode based on ColorMode enum
func set_color_mode(val : int):
  color = val

  $RedSprite.visible = val == ColorMode.RED
  $BlackSprite.visible = val == ColorMode.BLACK

  print($RedSprite.visible)
  print($BlackSprite.visible)
  print('')

func get_color_mode():
  return color

# === Process functions ===

func _ready():
  $BlackSprite.visible = false
  $RedSprite.visible = true

# === Util functions ===

func _get_modal_sprite():
  if (color == ColorMode.RED):
    return $RedSprite
  else:
    return $BlackSprite

