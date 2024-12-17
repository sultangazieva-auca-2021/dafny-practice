method Main() 
{
  var board := CreateBoard();
  assert IsSolvable(board);
}

function IsValid(x: int, y: int): bool
  requires x >= 0 && y >= 0;
  ensures IsValid(x, y) ==> 0 <= x < 4 && 0 <= y < 4;
{
  0 <= x < 4 && 0 <= y < 4
}

function IsSolvable(board: array<array<int>>): bool
  requires board.Length == 4 && board[0].Length == 4;
  ensures IsSolvable(board) ==> ExistsPath(board, 0, 0, 3, 3);
{
  ExistsPath(board, 0, 0, 3, 3)
}

function ExistsPath(board: array<array<int>>, curr_x: int, curr_y: int, goal_x: int, goal_y: int): bool
  requires board.Length == 4 && board[0].Length == 4;
  requires 0 <= curr_x < 4 && 0 <= curr_y < 4 && 
           0 <= goal_x < 4 && 0 <= goal_y < 4;
  ensures ExistsPath(board, curr_x, curr_y, goal_x, goal_y) ==> 
          (curr_x == goal_x && curr_y == goal_y) ||
    
    exists dx, dy ::
      (dx, dy) in [(0, 1), (1, 0), (0, -1), (-1, 0)] &&
      IsValid(curr_x + dx * board[curr_x][curr_y], curr_y + dy * board[curr_x][curr_y]) &&
      ExistsPath(board, curr_x + dx * board[curr_x][curr_y], curr_y + dy * board[curr_x][curr_y], goal_x, goal_y);
{
  if curr_x == goal_x && curr_y == goal_y then true
  else var total_steps := board[curr_x][curr_y];

    exists dx, dy ::
      (dx, dy) in [(0, 1), (1, 0), (0, -1), (-1, 0)] &&
      IsValid(curr_x + dx * total_steps, curr_y + dy * total_steps) &&
      ExistsPath(board, curr_x + dx * total_steps, curr_y + dy * total_steps, goal_x, goal_y)
}

method CreateBoard() returns (board: array<array<int>>)
  ensures board.Length == 4 && board[0].Length == 4;
  ensures IsSolvable(board);
{
  board := new int[4][4];

  board[0][0] := 2; board[0][1] := 1; board[0][2] := 2; board[0][3] := 1;
  board[1][0] := 1; board[1][1] := 2; board[1][2] := 1; board[1][3] := 2;
  board[2][0] := 3; board[2][1] := 1; board[2][2] := 3; board[2][3] := 1;
  board[3][0] := 1; board[3][1] := 2; board[3][2] := 1; board[3][3] := 1;
}
