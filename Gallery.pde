class Gallery {
  float offsetX = -1200;
  float targetOffsetX = -1200;
  float lerpFactor = 0.05;
  
  void update() {
    offsetX = lerp(offsetX, targetOffsetX, lerpFactor);
    if (mouseX >= 800) {
      targetOffsetX = -1200;
    } else if (mouseX > 400) {
      targetOffsetX = map(mouseX, 400, 800, 0, -1200);
    } else {
      targetOffsetX = 0;
    }
  }
  
  void drawGallery() {
    background(255);
    image(galFull, offsetX, 0);
  }
}
