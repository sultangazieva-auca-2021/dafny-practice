#include <iostream>
#include <vector>
#include <queue>
#include <cstdlib>
#include <ctime>

using namespace std;

const int DIMENTION = 4;
const vector<pair<int, int>> directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

bool isValid(int x, int y) {
    if (x >= 0 && x < DIMENTION && 
        y >= 0 && y < DIMENTION) {
        return true;
    } else {
        return false;
    }
}

// BFS
bool isSolvable(vector<vector<int>> &board) {
    vector<vector<bool>> visited(DIMENTION, vector<bool>(DIMENTION, false));
    queue<pair<int, int>> q;
    q.push({0, 0});
    visited[0][0] = true;

    while (!q.empty()) {
        auto [x, y] = q.front();
        q.pop();

        int total_total_steps = board[x][y];
        for (auto [dx, dy] : directions) {
            int next_x = x + dx * total_total_steps;
            int next_y = y + dy * total_total_steps;

            if (isValid(next_x, next_y) && !visited[next_x][next_y]) {
                visited[next_x][next_y] = true;
                q.push({next_x, next_y});
            }
        }
    }

    return visited[DIMENTION - 1][DIMENTION - 1];
}

vector<vector<int>> createBoard() {
    vector<vector<int>> board(DIMENTION, vector<int>(DIMENTION));
    srand(time(0));

    do {
        for (int i = 0; i < DIMENTION; i++) {
            for (int j = 0; j < DIMENTION; j++) {
                board[i][j] = rand() % (DIMENTION - 1) + 1;
            }
        }
    } while (!isSolvable(board));

    return board;
}

void displayBoard(vector<vector<int>> &board, int curr_x, int curr_y) {
    for (int i = 0; i < DIMENTION; i++) {
        for (int j = 0; j < DIMENTION; j++) {
            if (i == curr_x && j == curr_y) {
                cout << "J" << board[i][j] << " ";
            } else if (i == DIMENTION - 1 && j == DIMENTION - 1) {
                cout << " G ";
            } else {
                cout << " " << board[i][j] << " ";
            }
        }

        cout << "\n";
    }
}

bool isGoalReachable(vector<vector<int>> &board, int x, int y, vector<vector<bool>> &visited) {
    // termination point
    if (x == DIMENTION - 1 && y == DIMENTION - 1) {
        return true;
    }

    visited[x][y] = true;
    int total_steps = board[x][y];

    for (auto [dx, dy] : directions) {
        int next_x = x + dx * total_steps;
        int next_y = y + dy * total_steps;

        if (isValid(next_x, next_y) && !visited[next_x][next_y]) {
            if (isGoalReachable(board, next_x, next_y, visited)) {
                // backtrack
                visited[x][y] = false;
                return true;
            }
        }
    }

    // backtrack
    visited[x][y] = false;
    return false;
}

int main() {
    cout << "Reach the goal 'G' from your current position 'J'\n";
    vector<vector<int>> board = createBoard();
    int curr_x = 0, curr_y = 0;

    vector<vector<bool>> visited(DIMENTION, vector<bool>(DIMENTION, false));
    while (curr_x != DIMENTION - 1 || curr_y != DIMENTION - 1) {
        displayBoard(board, curr_x, curr_y);
        cout << "Move to 'left' or 'right' or 'up' or 'down': ";
        string move;
        cin >> move;

        int total_total_steps = board[curr_x][curr_y];
        int next_x = curr_x, next_y = curr_y;

        if (move == "right") {
            next_y += total_total_steps;
        } else if (move == "left") {
            next_y -= total_total_steps;
        } else if (move == "down") {
            next_x += total_total_steps;
        } else if (move == "up") {
            next_x -= total_total_steps;
        }

        if (isValid(next_x, next_y)) {
            curr_x = next_x;
            curr_y = next_y;

            visited[curr_x][curr_y] = true;
            vector<vector<bool>> tempVisited = visited;
            if (!isGoalReachable(board, curr_x, curr_y, tempVisited)) {
                cout << "Game Over. Unreachable Goal. Start Again.\n";
                curr_x = 0;
                curr_y = 0;
            }
        } else {
            cout << "You cannot go outside of the board.\nTry again.\n";
        }
    }

    cout << "Congratulations! You won!\n";
    
    return 0;
}
