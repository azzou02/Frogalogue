import processing.video.*;
class RedRoom {
  
  void setupRed() {
    cols = width/videoScale;
    rows = height/videoScale;
    video = new Capture(Draw.this, cols, rows);
    video.start();
  }
  
  void drawR() {
    video.loadPixels();
    video.updatePixels();
    
    // Begin loop for columns
    for (int i = 0; i < cols; i++) {
      // Begin loop for rows
      for (int j = 0; j < rows; j++) {
        // Where are you, pixel-wise?
        int x = i*videoScale;
        int y = j*videoScale;
        
        color c = video.pixels[i + j*video.width];
        float r = red(c) * 1;
        float g = green(c) * 0.3;
        float b = blue(c) * 0.3;
        color redTint = color(r, g, b);
        
        fill(redTint);
        stroke(0);
        rect(x, y, videoScale, videoScale);
        
      }
    }
    image(video, 0, 0, 0, 0);
  }
}
