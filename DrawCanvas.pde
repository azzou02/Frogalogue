class DrawCanvas {
  boolean showColorPicker = false;
  boolean isErasing = false;
  int pickerX = 20;
  int pickerY = 20;
  int swatchSize = 30;
  int swatchSpacing = 5;
  float redVal, greenVal, blueVal;
  color curColor = color(255);

  // Store drawing history for undo
  ArrayList<PGraphics> drawingHistory;
  PGraphics currentLayer;
  int maxUndoSteps = 20;

  color[] colorOptions = {
    color(255, 129, 198),   // pink
    color(255, 172, 54),    // orange
    color(255, 231, 0),     // yellow
    color(102, 222, 34),    // green
    color(62, 134, 255),    // blue
    color(126, 227, 240),   // teal
    color(178, 126, 240),   // purple
    color(255),             // white
    color(0)                // black
  };

  float[] sizeOptions = {5, 7, 9, 11, 13, 15, 17, 19, 21};
  float curSize = 10;

  void setupCanvas() {

    // Initialize drawing history
    drawingHistory = new ArrayList<PGraphics>();
    currentLayer = createGraphics(width, height);
    currentLayer.beginDraw();
    currentLayer.endDraw();
    saveToHistory();
  }

  void drawCanvas() {
    background(60, 50, 47);

    // Draw the current layer
    image(currentLayer, 0, 0);

    if (mousePressed) {
      if (!isOverColorPicker() && !isOverSizePicker() && !isOverTools()) {
        currentLayer.beginDraw();
        currentLayer.stroke(isErasing ? color(60, 50, 47) : curColor);
        currentLayer.strokeWeight(curSize);
        currentLayer.line(mouseX, mouseY, pmouseX, pmouseY);
        currentLayer.endDraw();
      }
    }

    drawColorPicker();
    drawSizePicker();
    drawTools();
  }

  void drawColorPicker() {
    fill(225, 215, 200);
    noStroke();
    rect(15, 15,
         (swatchSize + swatchSpacing) * colorOptions.length + 5,
         swatchSize + 10);

    // Draw color swatches
    for (int i = 0; i < colorOptions.length; i++) {
      fill(colorOptions[i]);
      rect(pickerX + i * (swatchSize + swatchSpacing),
           pickerY,
           swatchSize,
           swatchSize);
    }

    fill(curColor);
    circle((swatchSize + swatchSpacing) * (colorOptions.length+1) + 10, 35, 40);

  }

  void drawSizePicker() {
    fill(225, 215, 200);
    noStroke();
    rect(15, 25 + swatchSize,
         (swatchSize + swatchSpacing) * colorOptions.length + 5,
         swatchSize + 10);

    // Draw size
    for (int i = 0; i < sizeOptions.length; i++) {
      fill(0);
      circle(pickerX + i * (swatchSize + swatchSpacing) + 15,
           pickerY * 2 + swatchSize,
           sizeOptions[i]);
      strokeWeight(sizeOptions[i]);
    }
  }

  void drawTools() {
    // Draw tools background
    fill(225, 215, 200);
    noStroke();
    rect(15, 85 + swatchSize,
         (swatchSize + swatchSpacing) * 3 + 5,  // Width for 3 tools
         swatchSize + 10);

    // Draw eraser icon
    stroke(0);
    strokeWeight(1);
    fill(isErasing ? color(200, 200, 200) : color(255));
    rect(pickerX, 90 + swatchSize, swatchSize, swatchSize);
    line(pickerX, 90 + swatchSize, pickerX + swatchSize, 90 + swatchSize + swatchSize);

    // Draw undo icon
    fill(255);
    rect(pickerX + swatchSize + swatchSpacing, 90 + swatchSize, swatchSize, swatchSize);
    // Draw arrow for undo
    stroke(0);
    float centerX = pickerX + swatchSize + swatchSpacing + swatchSize/2;
    float centerY = 90 + swatchSize + swatchSize/2;
    line(centerX + 5, centerY - 5, centerX, centerY);
    line(centerX + 5, centerY + 5, centerX, centerY);
  }
  
  float getRed() {
    loadPixels();
    redVal = red(pixels[mouseX + mouseY * width]);
    return redVal;
  }
  
  float getGreen() {
    loadPixels();
    greenVal = green(pixels[mouseX + mouseY * width]);
    return greenVal;
  }
  
  float getBlue() {
    loadPixels();
    blueVal = blue(pixels[mouseX + mouseY * width]);
    return blueVal;
  }

  boolean isOverTools() {
    return mouseX >= pickerX - 5 &&
           mouseX <= pickerX + (swatchSize + swatchSpacing) * 3 + 5 &&
           mouseY >= 85 + swatchSize &&
           mouseY <= 85 + swatchSize * 2 + 10;
  }

  boolean isOverColorPicker() {
    return mouseX >= pickerX - 5 &&
           mouseX <= pickerX + (swatchSize + swatchSpacing) * colorOptions.length + 5 &&
           mouseY >= pickerY - 5 &&
           mouseY <= pickerY + swatchSize + 35;
  }

  boolean isOverSizePicker() {
    return mouseX >= pickerX - 5 &&
           mouseX <= pickerX + (swatchSize + swatchSpacing) * colorOptions.length + 5 &&
           mouseY >= pickerY + swatchSize + 20 &&
           mouseY <= pickerY + swatchSize * 2 + 35;
  }

  void mousePressed() {
    if (mouseY >= pickerY && mouseY <= pickerY + swatchSize) {
      int swatchIndex = (mouseX - pickerX) / (swatchSize + swatchSpacing);
      if (swatchIndex >= 0 && swatchIndex < colorOptions.length) {
        curColor = colorOptions[swatchIndex];
      }
    }

    if (mouseY >= pickerY * 2 + swatchSize - 10 &&
        mouseY <= pickerY * 2 + swatchSize + 10) {
      int sizeIndex = (mouseX - pickerX) / (swatchSize + swatchSpacing);
      if (sizeIndex >= 0 && sizeIndex < sizeOptions.length) {
        curSize = sizeOptions[sizeIndex];
      }
    }

    // Tools selection
    if (mouseY >= 85 + swatchSize && mouseY <= 85 + swatchSize * 2) {
      int toolIndex = (mouseX - pickerX) / (swatchSize + swatchSpacing);
      if (toolIndex == 0) {  // Eraser
        isErasing = !isErasing;
      } else if (toolIndex == 1) {  // Undo
        undo();
      }
    }

    // Save state when starting new stroke
    if (!isOverColorPicker() && !isOverSizePicker() && !isOverTools()) {
      saveToHistory();
    }
  }

  void saveToHistory() {
    // Create new graphics buffer
    PGraphics newLayer = createGraphics(width, height);
    newLayer.beginDraw();
    newLayer.image(currentLayer, 0, 0);
    newLayer.endDraw();

    // Add to history
    drawingHistory.add(newLayer);

    // Remove oldest if exceeded max steps
    if (drawingHistory.size() > maxUndoSteps) {
      drawingHistory.remove(0);
    }
  }

  void undo() {
    if (drawingHistory.size() > 1) {  // Keep at least one state
      drawingHistory.remove(drawingHistory.size() - 1);  // Remove current state
      // Get previous state
      PGraphics previousState = drawingHistory.get(drawingHistory.size() - 1);
      currentLayer = createGraphics(width, height);
      currentLayer.beginDraw();
      currentLayer.image(previousState, 0, 0);
      currentLayer.endDraw();
    } else if (drawingHistory.size() == 1) {  // Clear if it's the last state
      currentLayer = createGraphics(width, height);
      currentLayer.beginDraw();
      currentLayer.endDraw();
    }
  }

  void keyPressed() {
    if (key == DELETE || key == BACKSPACE) {
      background(60, 50, 47);
      currentLayer = createGraphics(width, height);
      currentLayer.beginDraw();
      currentLayer.endDraw();
      drawingHistory.clear();
      saveToHistory();
    } else if (key == 'z' || key == 'Z') {
      if (keyCode == CONTROL) {
        undo();  // Ctrl+Z or Cmd+Z for undo
      }
    }
  }
}
