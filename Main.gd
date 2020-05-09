extends Node

# Number in a row it takes to win
const WINNING_COUNT = 4
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

# Returns color of the winner
# If no winner, returns ColorMode.NONE
func check_winner():
  var color_matrix = $Board.get_color_matrix()

  # Get counts of items in a row (detailed more below)
  var horizontal_count = _get_horizontal_count(color_matrix)
  var vertical_count = _get_vertical_count(color_matrix)

  # Find winner if any
  # Assumes previous checks did not find winners, meaning first item found
  # will be the only case of winning
  # Also assumes only one piece can be placed at a time
  for count_dict in [horizontal_count, vertical_count]:
    for color in count_dict:
      if WINNING_COUNT in count_dict[color] and count_dict[color][WINNING_COUNT] > 0:
        return color

  return ColorMode.NONE

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
  var winner = check_winner()

  if winner == ColorMode.NONE: switch_player_color()
  else: _handle_winner(winner)

func _handle_winner(winner):
  var board = $Board

  for i in 3:
    board.hide()
    yield(get_tree().create_timer(.5), 'timeout')
    board.show()
    yield(get_tree().create_timer(.5), 'timeout')

  yield(get_tree().create_timer(2), 'timeout')
  board.clear()

# == Count methods ===
#
# These are for containing the counts of pieces in a row in different contexts
#
# Each returns a dict containing the counts of the color matrix, formatted:
# { ColorMode: { NumInARow: Count } }
#
# E.g. we have 3 red pieces in a row in one area, 2 red in a row in another:
# { (Red enum): { 2: 1, 3: 1 } ... }

# NOTE: *Very* similar to _get_vertical_count. Could centralize somehow?
func _get_horizontal_count (color_matrix):
  var dict = {
      ColorMode.RED: {},
      ColorMode.BLACK: {}
      }

  var col_num = color_matrix.size()
  var row_num = color_matrix[0].size()

  for row_index in row_num:
    var temp_counts = {
        ColorMode.RED: 0,
        ColorMode.BLACK: 0
        }

    for col_index in col_num:
      var color = color_matrix[col_index][row_index]

      for k in temp_counts:
        if k == color:
          temp_counts[k] += 1
        elif temp_counts[k] > 0:
          if not temp_counts[k] in dict[k]:
            dict[k][temp_counts[k]] = 0

          dict[k][temp_counts[k]] += 1
          temp_counts[k] = 0

    # Final check before going to next row
    for k in temp_counts:
      if temp_counts[k] > 0:
        if not temp_counts[k] in dict[k]:
          dict[k][temp_counts[k]] = 0

        dict[k][temp_counts[k]] += 1

  return dict

# NOTE: *Very* similar to _get_horizontal_count. Could centralize somehow?
func _get_vertical_count (color_matrix):
  var dict = {
      ColorMode.RED: {},
      ColorMode.BLACK: {}
      }

  var col_num = color_matrix.size()
  var row_num = color_matrix[0].size()

  for col_index in col_num:
    var temp_counts = {
        ColorMode.RED: 0,
        ColorMode.BLACK: 0
        }

    for row_index in row_num:
      var color = color_matrix[col_index][row_index]

      for k in temp_counts:
        if k == color:
          temp_counts[k] += 1
        elif temp_counts[k] > 0:
          if not temp_counts[k] in dict[k]:
            dict[k][temp_counts[k]] = 0

          dict[k][temp_counts[k]] += 1
          temp_counts[k] = 0

    # Final check before going to next column
    for k in temp_counts:
      if temp_counts[k] > 0:
        if not temp_counts[k] in dict[k]:
          dict[k][temp_counts[k]] = 0

        dict[k][temp_counts[k]] += 1

  return dict

