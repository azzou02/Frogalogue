class SceneManager {
  GameState currentState = GameState.HOME;

  void setState(GameState newState) {
    currentState = newState;
  }

  void draw() {
    switch(currentState) {
    case HOME:
      drawHome();
      break;
    case GALLERY:
      drawGallery();
      break;
    case PAINTING1:
      drawPainting(port);
      break;
    case PAINTING2:
      drawPainting(duck);
      break;
    case PAINTING3:
      drawPainting(eye);
      updateImage();
      image(currentImage, 10, 60);
      drawFrog2(mouseX, mouseY);
      if (mousePressed) {
        println(mouseX, mouseY);
      }
      break;
    case PAINTING4:
      drawPainting(still);
      break;
    case NEW:
      draw3D();
      break;
    case CANVAS:
      drawCanvas();
      break;
    case REDROOM:
      drawRed();
      break;
    }
  }


  void handleInput() {

    if (currentState == GameState.GALLERY) {
      if (mousePressed && mouseX > 1120) {
        setState(GameState.HOME);
      } else if (mousePressed) {
        if (mouseX > 765 && mouseX < 880 && mouseY < 380) {
          setState(GameState.PAINTING1);
        } else if (mouseX > 620 && mouseX < 715) {
          setState(GameState.PAINTING2);
        } else if (mouseX > 505 && mouseX < 550) {
          setState(GameState.PAINTING3);
        } else if (mouseX > 300 && mouseX < 450) {
          setState(GameState.PAINTING4);
        }
      }
    } else if (currentState == GameState.HOME &&
      mouseX >= 820 && mouseX <= 975 &&
      mouseY >= 450 && mouseY <= 650 &&
      mousePressed) {
      setState(GameState.GALLERY);
    } else if (currentState == GameState.PAINTING4 && key == 'p') {
      setState(GameState.NEW);
    } else if (currentState == GameState.PAINTING1 && key == 'd') {
      setState(GameState.CANVAS);
    } else if (currentState == GameState.PAINTING3 &&
               mouseX >= 470 && mouseX <= 605 && 
               mouseY >= 440 && mouseY <= 525 && 
               mousePressed) {
      setState(GameState.REDROOM);
    }
  }

  void handleKeyPress(char k) {
    // Handle key events in a separate method
    if ((k == DELETE || k == BACKSPACE) &&
      currentState != GameState.HOME &&
      currentState != GameState.GALLERY) {
      setState(GameState.GALLERY);
    }
  }

}
