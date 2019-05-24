int mapSize = 70;
boolean[][] grid = new boolean[mapSize][mapSize];;
int x, y;

void setup() {
  size(700, 700);
  frameRate(7);
  randomizeMap();
}

void draw() {
  background(0);
  updateMap();
  drawMap();
}

boolean randomBool() {
  return random(1) > .5;
}

void drawMap() {
  for(int x=0; x<mapSize; x++){
    for(int y=0; y<mapSize; y++){
      fill(0);
      if (grid[x][y]) {
        fill(255);
      }
      rect(x*10, y*10, 10, 10);
    }
  }
}

void randomizeMap() {
  for(int x=0; x<mapSize; x++){
    for(int y=0; y<mapSize; y++){
      grid[x][y] = randomBool();
    }
  }
}

void updateMap() {
  boolean[][] updatedGrid = new boolean[mapSize][mapSize];;
  boolean somethingChanged;
  somethingChanged = boolean(0);
  int numberOfLivingNeighbours;
  for(int x=0; x<mapSize; x++){
    for(int y=0; y<mapSize; y++){
      numberOfLivingNeighbours = 0;

      // top
      if(y!=0){numberOfLivingNeighbours += int(grid[x][y-1]);}else{
        numberOfLivingNeighbours += int(grid[x][mapSize-1]);
      }
      // bottom
      if(y!=mapSize-1){numberOfLivingNeighbours += int(grid[x][y+1]);}else{
        numberOfLivingNeighbours += int(grid[x][0]);
      }
      // left
      if(x!=0){numberOfLivingNeighbours += int(grid[x-1][y]);}else{
        numberOfLivingNeighbours += int(grid[mapSize-1][y]);
      }
      // right
      if(x!=mapSize-1){numberOfLivingNeighbours += int(grid[x+1][y]);}else{
        numberOfLivingNeighbours += int(grid[0][y]);
      }

      // top left
      if (x==0) {
        if (y==0) {
          numberOfLivingNeighbours += int(grid[mapSize-1][mapSize-1]);
        }else {
          numberOfLivingNeighbours += int(grid[mapSize-1][y-1]);
        }
      }else {
        if (y==0) {
          numberOfLivingNeighbours += int(grid[x-1][mapSize-1]);
        }else {
          numberOfLivingNeighbours += int(grid[x-1][y-1]);
        }
      }
      // top right
      if (x==mapSize-1) {
        if (y==0) {
          numberOfLivingNeighbours += int(grid[0][mapSize-1]);
        }else {
          numberOfLivingNeighbours += int(grid[0][y-1]);
        }
      }else {
        if (y==0) {
          numberOfLivingNeighbours += int(grid[x+1][mapSize-1]);
        }else {
          numberOfLivingNeighbours += int(grid[x+1][y-1]);
        }
      }
      // bottom left
      if (x==0) {
        if (y==mapSize-1) {
          numberOfLivingNeighbours += int(grid[mapSize-1][0]);
        }else {
          numberOfLivingNeighbours += int(grid[mapSize-1][y+1]);
        }
      }else {
        if (y==mapSize-1) {
          numberOfLivingNeighbours += int(grid[x-1][0]);
        }else {
          numberOfLivingNeighbours += int(grid[x-1][y+1]);
        }
      }
      // bottom right
      if (x==mapSize-1) {
        if (y==mapSize-1) {
          numberOfLivingNeighbours += int(grid[0][0]);
        }else {
          numberOfLivingNeighbours += int(grid[0][y+1]);
        }
      }else {
        if (y==mapSize-1) {
          numberOfLivingNeighbours += int(grid[x+1][0]);
        }else {
          numberOfLivingNeighbours += int(grid[x+1][y+1]);
        }
      }

      if(grid[x][y] && (numberOfLivingNeighbours < 2)) {
        updatedGrid[x][y] = boolean(0);
        somethingChanged = boolean(1);
      }else if (grid[x][y] && (numberOfLivingNeighbours > 3)) {
        updatedGrid[x][y] = boolean(0);
        somethingChanged = boolean(1);
      }else if (!grid[x][y] == (numberOfLivingNeighbours == 3)) {
        updatedGrid[x][y] = boolean(1);
        somethingChanged = boolean(1);
      }
    }
  }
  grid = updatedGrid;
  if(!somethingChanged){
    randomizeMap();
  }
}

void mouseReleased() {
  randomizeMap();
}