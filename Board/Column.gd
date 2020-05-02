extends Area2D
const ColorMode = preload("../Global/ColorMode.gd")

const ROW_NUM = 6

func get_piece(x : int):
  var piece_name = 'Piece' + str(x)
  return get_node(piece_name)
  
func place_piece(color):
  # TODO: validate color?
  for row_index in range(0, ROW_NUM):
    var piece = get_piece(row_index)
    
    if !piece.visible:
      piece.color = color
      piece.visible = true
      return
      
# TODO: instead of highlighting whole column, give "ghost" of placement
func set_highlighted(val : bool):
  for row_index in range(0, ROW_NUM):
    var piece = get_piece(row_index)
    piece.highlighted = val   
