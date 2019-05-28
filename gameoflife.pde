int mapSize = 100;
int fieldSize = 5;
boolean[][] grid = new boolean[mapSize][mapSize];;
int x, y;

void setup() {
  size(500, 500);
  // frameRate(2);
  randomizeMap();
}

void draw() {
  background(0);
  drawMap();
  if (!keyPressed) {
   updateMap(); 
  }
  // drawCourser();
}

boolean randomBool() {
  return random(1) > .9;
}

void drawMap() {
  // draw the map with 10*10 squeres
  for(int x=0; x<mapSize; x++){
    for(int y=0; y<mapSize; y++){
      fill(0);
      stroke(0);
      if (grid[x][y]) {
        fill(255);
        stroke(255);
      }
      rect(x*fieldSize, y*fieldSize, fieldSize, fieldSize);
    }
  }
}

void randomizeMap() {
  // randomize all cells in the map
  for(int x=0; x<mapSize; x++){
    for(int y=0; y<mapSize; y++){
      grid[x][y] = randomBool();
    }
  }
}

int getNumberOfLivingNeighbours(int x, int y) {
  int numberOfLivingNeighbours = 0;

  // top
  numberOfLivingNeighbours += int(grid[x][(y+mapSize-1)%(mapSize)]);
  // bottom
  numberOfLivingNeighbours += int(grid[x][(y+1)%(mapSize)]);
  // left
  numberOfLivingNeighbours += int(grid[(x+mapSize-1)%mapSize][y]);
  // right
  numberOfLivingNeighbours += int(grid[(x+1)%mapSize][y]);

  // top left
  numberOfLivingNeighbours += int(grid[(x+mapSize-1)%mapSize][(y+mapSize-1)%mapSize]);
  // top right
  numberOfLivingNeighbours += int(grid[(x+mapSize+1)%mapSize][(y+mapSize-1)%mapSize]);
  // bottom left
  numberOfLivingNeighbours += int(grid[(x+mapSize-1)%mapSize][(y+mapSize+1)%mapSize]);
  // bottom right
  numberOfLivingNeighbours += int(grid[(x+mapSize+1)%mapSize][(y+mapSize+1)%mapSize]);

  return numberOfLivingNeighbours;
}

void updateMap() {
  // new updated grid
  boolean[][] updatedGrid = new boolean[mapSize][mapSize];
  int numberOfLivingNeighbours;
  // counting all living eighbours in following code
  for(int x=0; x<mapSize; x++){
    for(int y=0; y<mapSize; y++){
      numberOfLivingNeighbours  = getNumberOfLivingNeighbours(x, y);
      // rules
      // if living cell and less then 2 neighbours
      if(grid[x][y] && (numberOfLivingNeighbours < 2)) {
        updatedGrid[x][y] = boolean(0);
      }
      // if living cell and more then 3 neighbours
      if (grid[x][y] && (numberOfLivingNeighbours > 3)) {
        updatedGrid[x][y] = boolean(0);
      }
      // if living cell and more exactly 2 or 3 neighbours
      if (grid[x][y] && ((numberOfLivingNeighbours == 2) || (numberOfLivingNeighbours == 3))) {
        updatedGrid[x][y] = boolean(1);
      }
      // if dead cell and exactly 3 neighbours
      if (!grid[x][y] && (numberOfLivingNeighbours == 3)) {
        updatedGrid[x][y] = boolean(1);
      }
    }
  }
  // update the grid
  grid = updatedGrid;
}

void drawCourser() {
  int numberOfLivingNeighbours;
  x = mouseX/fieldSize;
  y = mouseY/fieldSize;
  numberOfLivingNeighbours  = getNumberOfLivingNeighbours(x, y);
  fill(0, 255, 0, 50);
  rect((x)*fieldSize, ((y+mapSize-1)%(mapSize))*fieldSize, fieldSize, fieldSize);
  rect((x)*fieldSize, ((y+1)%(mapSize))*fieldSize, fieldSize, fieldSize);
  rect(((x+mapSize-1)%mapSize)*fieldSize, (y)*fieldSize, fieldSize, fieldSize);
  rect(((x+1)%mapSize)*fieldSize, (y)*fieldSize, fieldSize, fieldSize);
  rect(((x+mapSize-1)%mapSize)*fieldSize, ((y+mapSize-1)%mapSize)*fieldSize, fieldSize, fieldSize);
  rect(((x+mapSize+1)%mapSize)*fieldSize, ((y+mapSize-1)%mapSize)*fieldSize, fieldSize, fieldSize);
  rect(((x+mapSize-1)%mapSize)*fieldSize, ((y+mapSize+1)%mapSize)*fieldSize, fieldSize, fieldSize);
  rect(((x+mapSize+1)%mapSize)*fieldSize, ((y+mapSize+1)%mapSize)*fieldSize, fieldSize, fieldSize);
}

void mousePressed() {
  // if mouse releases
  x = mouseX/fieldSize;
  y = mouseY/fieldSize;
  int val = int(grid[x][y]);
  grid[x][y] = boolean(0);
  if(val == 0){
    grid[x][y] = boolean(1);
  }
}