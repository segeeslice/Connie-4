extends Node2D

const COL_NUM = 7
const ROW_NUM = 6

# === API ===

# Clear the board, hiding all pieces
func clear():
  for colIndex in range(0, COL_NUM):
    for rowIndex in range(0, ROW_NUM):
      var piece = getPiece(colIndex, rowIndex)
      piece.visible = false

# Get piece at the given x, y (col, row) coordinate
func getPiece(x : int, y : int):
  var columnName = 'Column' + str(x)
  var pieceName = columnName + '/Piece' + str(y)
  return get_node(pieceName)

# === Process functions ===

func _ready():
  pass
