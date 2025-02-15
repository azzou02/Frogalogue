class Frog {
  float a = 395, b = 495, c = 570;
  float spdA = 0.15, spdB = -0.15, armSpeedX = 0.5;
  
  void drawFrog() {
    
    noStroke();
    
    fill(114, 194, 133);
    ellipse(mouseX, mouseY, 150, 120);
    ellipse(mouseX - 50, mouseY - 50, 50, 50);
    ellipse(mouseX + 50, mouseY - 50, 50, 50);
    rect(mouseX - 25, mouseY + 20, 10, 150);
    rect(mouseX + 15, mouseY + 20, 10, 150);
  
    // Frog blush
    fill(255, 192, 203);
    ellipse(mouseX - 45, mouseY - 20, 25, 15);
    ellipse(mouseX + 45, mouseY - 20, 25, 15);

    // Frog eyes and mouth
    fill(0);
    ellipse(mouseX - 50, mouseY - 50, 25, 25);
    ellipse(mouseX + 50, mouseY - 50, 25, 25);
    ellipse(mouseX, mouseY - 30, 28, 2);
  
    // Shoes
    fill(107, 65, 42);
    rect(mouseX + 12, mouseY + 170, 40, 20, 20);
    rect(mouseX + 12, mouseY + 150, 20, 35, 20);
    rect(mouseX - 50, mouseY + 170, 40, 20, 20);
    rect(mouseX - 30, mouseY + 150, 20, 35, 20);
  
    // Arms
    fill(114, 194, 133);
    quad(mouseX - 115, mouseY + 50, mouseX - 115, mouseY + 35, mouseX - 65, mouseY - 10, mouseX - 65, mouseY + 6);
    quad(mouseX + 100, mouseY + 10, mouseX + 100, mouseY - 4, mouseX + 65, mouseY - 10, mouseX + 65, mouseY + 5);
    quad(mouseX + (c - 450), mouseY - 50, mouseX + (c - 450), mouseY - 35, mouseX + 100, mouseY + 10, mouseX + 100, mouseY - 4);
    //stroke(114, 194, 133);
    //strokeWeight(9);
    //line(mouseX - 115, mouseY + 50, mouseX - 65, mouseY - 10);
    //line(mouseX + 100, mouseY + 10, mouseX + 65, mouseY - 10);
    //line(mouseX + (c - 450), mouseY - 50, mouseX + 100, mouseY + 10);

    // Moving eyes
    fill(255);
    noStroke();
    ellipse(mouseX - 50 + (a - 400), mouseY - 52, 10, 10);
    ellipse(mouseX + 50 + (b - 500), mouseY - 52, 10, 10);
    
    // Movement in arms
    a += spdA;
    b += spdB;
    c += armSpeedX;

    if (a <= 394.95 || a >= 405) spdA *= -1;
    if (b <= 494.95 || b >= 505) spdB *= -1;
    if (c > 580 || c < 560) armSpeedX *= -1;
    
  }
}
