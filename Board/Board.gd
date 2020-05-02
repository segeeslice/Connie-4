extends Node2D

const COL_NUM = 7
const ROW_NUM = 6

# Controls if columns should be highlighted on mouse hover
var highlight_enabled = true

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

func set_column_highlighted(col_index : int, val : bool):
  for row_index in range(0, ROW_NUM):
    var piece = get_piece(col_index, row_index)
    piece.highlighted = val

# === Process functions ===

func _ready():
  for col_index in range(0, COL_NUM):
    var column = get_column(col_index)
    column.connect('mouse_entered', self, '_handle_Column_mouse_entered', [col_index])
    column.connect('mouse_exited', self, '_handle_Column_mouse_exited', [col_index])

# === Event handlers ===

func _handle_Column_mouse_entered(col_index : int):
  if !highlight_enabled: return
  set_column_highlighted(col_index, true)

func _handle_Column_mouse_exited(col_index : int):
  set_column_highlighted(col_index, false)
