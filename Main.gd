extends Node

const ColorMode = preload("../Global/ColorMode.gd")
var player_color = ColorMode.RED

func start_new_game():
  var board = $Board
  board.clear()
  board.visible = true

  set_player_color(ColorMode.RED)
  $UI/StartButton.hide()

func set_player_color(color):
  player_color = color
  $UI/PlayerLabel.text = "Player: " + ("Red" if color == ColorMode.RED else "Black")

func switch_player_color():
  var new_color = ColorMode.BLACK if player_color == ColorMode.RED else ColorMode.RED
  set_player_color(new_color)

# TODO
func check_winner():
  var color_matrix = $Board.get_color_matrix()
  print(color_matrix.size())

  for col in color_matrix:
    for color in col:
      print(color)

    print('\n')

# Called when the node enters the scene tree for the first time.
func _ready():
  $Board.visible = false
  $UI/PlayerLabel.text = ''

  # warning-ignore:return_value_discarded
  $UI/StartButton.connect('pressed', self, 'start_new_game')
  # warning-ignore:return_value_discarded
  $Board.connect('column_clicked', self, '_handle_column_clicked')

func _handle_column_clicked(column):
  column.place_piece(player_color)
  check_winner()
  switch_player_color()
