int mapSize = 50;
boolean[][] grid = new boolean[50][50];;
int x, y;

void setup() {
  size(500, 500);
  frameRate(3);
}

void draw() {
  background(0);
  randomizeMap();
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
