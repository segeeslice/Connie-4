extends Node2D

const ColorMode = preload("../Global/ColorMode.gd")
var color = ColorMode.RED setget setColorMode, getColorMode

# === API ===

# Set color mode based on ColorMode enum
func setColorMode(val : int):
  color = val
  
  $RedSprite.visible = val == ColorMode.RED
  $BlackSprite.visible = val == ColorMode.BLACK
  
  print($RedSprite.visible)
  print($BlackSprite.visible)
  print('')
  
func getColorMode():
  return color

# === Process functions ===

func _ready():
  $BlackSprite.visible = false
  $RedSprite.visible = true

# === Util functions ===

func _getModalSprite():
  if (color == ColorMode.RED):
    return $RedSprite
  else:
    return $BlackSprite

