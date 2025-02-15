import processing.sound.*;
import processing.video.*;
enum GameState {
  HOME, GALLERY, PAINTING1, PAINTING2, PAINTING3, PAINTING4, NEW, CANVAS, REDROOM
}

SoundFile file;
PImage sky, house, galFull, port, frog, duck, eye, still, currentImage, img;
PImage[] positions;

int[] xThresholds;
int count = 0;

Gallery gallery;
SceneManager sceneManager;
Home home;
Frog frogChar;
Spherify stillSphere;
DrawCanvas canvas;
RedRoom redcam;

Capture video;
int videoScale = 13;
int cols, rows;

void setup() {
  size(1200, 900, P3D);
  //hint(DISABLE_OPTIMIZED_STROKE);

  // Load and resize images
  sky = loadImage("sky.png");
  sky.resize(width, height);
  house = loadImage("house.png");
  house.resize(width, height);
  galFull = loadImage("gall.png");
  galFull.resize(2400, 1000);
  port = loadImage("port.png");
  port.resize(width, height);
  frog = loadImage("Frog2.png");
  frog.resize(120, 120);
  duck = loadImage("duck.jpeg");
  duck.resize(width, 1000);
  eye = loadImage("eyes.png");
  eye.resize(width, 1400);
  still = loadImage("still.png");
  still.resize(width, height);
  img = loadImage("still.png");
  img.resize(width, height);

  frogChar = new Frog();
  gallery = new Gallery();
  sceneManager = new SceneManager();
  home = new Home();
  stillSphere = new Spherify();
  canvas = new DrawCanvas();
  redcam = new RedRoom();
  


  positions = new PImage[7];
  for (int i = 0; i < 7; i++) {
    positions[i] = loadImage("pos" + (i+1) + ".png");
    positions[i].resize(width, height);
  }
  xThresholds = new int[]{155, 250, 325, 450, 500, 650, 750};
  currentImage = positions[0];

  file = new SoundFile(this, "music.mp3");
  file.play();
  
  canvas.setupCanvas();
  redcam.setupRed();
}

void draw() {
  sceneManager.handleInput();
  sceneManager.draw();
}


void keyPressed() {
  sceneManager.handleKeyPress(key);
}

void mousePressed() {
  if (sceneManager.currentState == GameState.CANVAS) {
    canvas.mousePressed();
  } 
}

void drawFrog2(float frogX, float frogY) {
  image(frog, frogX, frogY);
}

void drawHome() {
  home.drawHome();
  frogChar.drawFrog();
}

void drawGallery() {
  gallery.update();
  gallery.drawGallery();
  frogChar.drawFrog();
}

void drawPainting(PImage painting) {
  image(painting, 0, 0);
  drawFrog2(mouseX, mouseY);
}

void updateImage() {
  for (int i = 0; i < xThresholds.length; i++) {
    if (mouseX < xThresholds[i]) {
      currentImage = positions[i];
      return;
    }
  }
  currentImage = positions[positions.length - 1];
}

void draw3D() {
  frameRate(24);
  noStroke();
  sphereDetail(4);
  stillSphere.draw3D();
}

void drawCanvas() {
  canvas.drawCanvas();
}

void drawRed() {
  redcam.drawR();
}

void captureEvent(Capture video) {
    video.read();
}
  
float sunPos = 200;
void drawSun() {

  float yArc = 300 + 100 * sin(radians(sunPos));
  for (int i = 1; i < 8; i+=2) {
    fill(255-7*i, 192-7*i, 203-7*i);
    ellipse(sunPos, yArc, 150-15*i, 150-15*i);
  }
  sunPos += 1.5;
}
