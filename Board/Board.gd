extends Node2D

const ColorMode = preload("../Global/ColorMode.gd")

signal column_clicked(col)

const COL_NUM = 7
const ROW_NUM = 6

# Controls if columns should be highlighted on mouse hover
var highlight_enabled = true
var highlighted_col_index = -1

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
  return get_node(col_name).get_piece(y)

# Get 2D array of all the colors currently in place on the board
# If no piece is placed yet, ColorMode.NONE is put instead
func get_color_matrix():
  var matrix = []

  for x in range(0, COL_NUM):
    matrix.append([])
    for y in range(0, ROW_NUM):
      var piece = get_piece(x, y)
      matrix[x].append(piece.color if piece.visible else ColorMode.NONE)

  return matrix

# === Process functions ===

func _ready():
  for col_index in range(0, COL_NUM):
    var column = get_column(col_index)
    column.connect('mouse_entered', self, '_handle_Column_mouse_entered', [col_index])
    column.connect('mouse_exited', self, '_handle_Column_mouse_exited', [col_index])

func _input(event):
  if highlighted_col_index >= 0 and event.is_pressed() and event.button_index == BUTTON_LEFT:
    emit_signal('column_clicked', get_column(highlighted_col_index))

# === Event handlers ===

# TODO: move to main as necessary
func _handle_Column_mouse_entered(col_index : int):
  if !highlight_enabled: return
  get_column(col_index).set_highlighted(true)
  highlighted_col_index = col_index

func _handle_Column_mouse_exited(col_index : int):
  get_column(col_index).set_highlighted(false)
  if highlighted_col_index == col_index:
    highlighted_col_index = -1
