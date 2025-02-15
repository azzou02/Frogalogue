class Spherify { 
  int num = 200;
  int dia = width/num;

  void draw3D()
  {
    background(0);
    directionalLight(200, 200, 200, -1, 1, 0);
    ambientLight(100, 100, 100);
    
    push();
    translate(width/2, height/2);
    rotateY(radians(frameCount));

    for(int i=0; i<num; i++)
    {
      for(int j=0; j<num; j++)
      {
        color col = img.get(i*dia, j*dia);
        float bright = map(brightness(col), 0, 255, 1, 0);
        float z = map(bright, 1, 0, 0, 200);
        push();
        scale(0.8);
        translate(i*dia-width/2, j*dia-height/2, z);
        //ellipse(0, 0, dia*bright, dia*bright);
        //box(dia*bright);
        sphere(dia * bright);
        pop();
      }
    }
    pop();

  }
}
