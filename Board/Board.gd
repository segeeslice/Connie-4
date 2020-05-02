extends Node2D

const ColorMode = preload("../Global/ColorMode.gd")

const COL_NUM = 7
const ROW_NUM = 6

# Controls if columns should be highlighted on mouse hover
var highlight_enabled = true
var highlighted_col_index = -1
var player_color = ColorMode.RED

# === API ===

# Clear the board, hiding all pieces
func clear():
  for col_index in range(0, COL_NUM):
    for row_index in range(0, ROW_NUM):
      var piece = get_piece(col_index, row_index)
      piece.visible = false

func get_column(x : int):
  var col_name = 'Column' + str(x)
  return get_node(col_name)

# Get piece at the given x, y (col, row) coordinate
func get_piece(x : int, y : int):
  var col_name = 'Column' + str(x)
  var piece_name = col_name + '/Piece' + str(y)
  return get_node(piece_name)

# TODO: instead of highlighting whole column, give "ghost" of placement
func set_column_highlighted(col_index : int, val : bool):
  for row_index in range(0, ROW_NUM):
    var piece = get_piece(col_index, row_index)
    piece.highlighted = val

func switch_player_color():
  player_color = ColorMode.BLACK if player_color == ColorMode.RED else ColorMode.RED

# TODO
# func can_place (col_index : int):
  # if col_index < 0 or col_index > COL_NUM: return false
  # if

# TODO: move to column; add signal to catch in main that returns column clicked
func place_piece(col_index : int):
  if col_index < 0 or col_index > COL_NUM: return

  for row_index in range(0, ROW_NUM):
    var piece = get_piece(col_index, row_index)
    if !piece.visible:
      piece.color = player_color
      piece.visible = true
      return

# === Process functions ===

func _ready():
  for col_index in range(0, COL_NUM):
    var column = get_column(col_index)
    column.connect('mouse_entered', self, '_handle_Column_mouse_entered', [col_index])
    column.connect('mouse_exited', self, '_handle_Column_mouse_exited', [col_index])

func _input(event):
  if highlighted_col_index >= 0 and event.is_pressed() and event.button_index == BUTTON_LEFT:
    place_piece(highlighted_col_index)
    switch_player_color()

# === Event handlers ===

func _handle_Column_mouse_entered(col_index : int):
  if !highlight_enabled: return
  set_column_highlighted(col_index, true)
  highlighted_col_index = col_index

func _handle_Column_mouse_exited(col_index : int):
  set_column_highlighted(col_index, false)
  if highlighted_col_index == col_index:
    highlighted_col_index = -1
