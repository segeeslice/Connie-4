extends Node2D

const ColorMode = preload("../Global/ColorMode.gd")
var color = ColorMode.RED setget set_color_mode, get_color_mode
var highlighted = false setget set_highlighted, get_highlighted

# === API ===

# Set color mode based on ColorMode enum
func set_color_mode(val : int):
  color = val

  $RedSprite.visible = val == ColorMode.RED && !highlighted
  $RedSpriteHighlighted.visible = val == ColorMode.RED && highlighted
  $BlackSprite.visible = val == ColorMode.BLACK && !highlighted
  $BlackSpriteHighlighted.visible = val == ColorMode.BLACK && highlighted

func get_color_mode(): return color

func set_highlighted(val : bool):
  highlighted = val

  if color == ColorMode.RED:
    $RedSprite.visible = !highlighted
    $RedSpriteHighlighted.visible = highlighted
  else:
    $BlackSprite.visible = !highlighted
    $BlackSpriteHighlighted.visible = highlighted

func get_highlighted(): return highlighted

# === Process functions ===

func _ready():
  $RedSprite.visible = true

  $RedSpriteHighlighted.visible = false
  $BlackSprite.visible = false
  $BlackSpriteHighlighted.visible = false

# === Util functions ===

# func _get_modal_sprite():
  # if (color == ColorMode.RED):
    # return $RedSprite
  # else:
    # return $BlackSprite

