Cell[][] _cellArray;
int _cellSize = 10;
int _numX, _numY;

void setup() {
  size(500, 300);
  _numX = floor(width / _cellSize );
  _numY = floor(height / _cellSize );
  restart();
}

void restart() {
  _cellArray = new Cell[_numX][_numY];
  for (int i = 0; i < _numX * _numY; i++) {
    int x = i % _numX;
    int y = i / _numX;
    _cellArray[x][y] = new Cell(x, y);
  }

  for (int i = 0; i < _numX * _numY; i++) {
    int x = i % _numX;
    int y = i / _numX;
    int above = (y - 1 + _numY) % _numY;
    int below = (y + 1) % _numY;
    int left  = (x - 1 + _numX) % _numX;
    int right = (x + 1) % _numX;

    _cellArray[x][y].addNeighbour(_cellArray[left][above]);
    _cellArray[x][y].addNeighbour(_cellArray[left][y]);
    _cellArray[x][y].addNeighbour(_cellArray[left][below]);

    _cellArray[x][y].addNeighbour(_cellArray[x][above]);
    _cellArray[x][y].addNeighbour(_cellArray[x][below]);

    _cellArray[x][y].addNeighbour(_cellArray[right][above]);
    _cellArray[x][y].addNeighbour(_cellArray[right][y]);
    _cellArray[x][y].addNeighbour(_cellArray[right][below]);
  }
}

void draw() {
  background(200);

  for (int i = 0; i < _numX * _numY; i++) {
    _cellArray[i % _numX][i / _numX].calcNextState();
  }

  translate(_cellSize / 2, _cellSize / 2);

  for (int i = 0; i < _numX * _numY; i++) {
    _cellArray[i % _numX][i / _numX].drawMe();
  }
}

void mouserPressed() {
  restart();
}

/**--------------------------------------------
 * Cell class
 --------------------------------------------*/
class Cell {
  float x, y;
  int state, nextState;
  Cell[] neighbours;

  Cell(float ex, float why) {
    x = ex * _cellSize;
    y = why * _cellSize;

    nextState = (int) (random(2));
    state = nextState;
    neighbours = new Cell[0];
  }

  void addNeighbour(Cell cell) {
    neighbours = (Cell[])append(neighbours, cell);
  }

  void calcNextState() {
    if (state == 0) {
      int firingCount = 0;
      for (int i = 0; i < neighbours.length; i++) {
        if (neighbours[i].state == 1) {
          firingCount++;
        }
      }

      if (firingCount == 2) {
        nextState =1;
      } else {
        nextState = state;
      }
    } else if (state == 1) {
      nextState =2;
    } else if (state == 2) {
      nextState =0;
    }
  }

  void drawMe() {
    state = nextState;
    stroke(0);

    if (state == 1) {
      fill(0);
    } else     if (state == 2) {
      fill(150);
    } else {
      fill(255);
    }

    ellipse(x, y, _cellSize, _cellSize);
  }
}
