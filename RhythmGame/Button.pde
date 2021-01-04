class Button {
  int rectX, rectY;      // Position of square button
  int rectwidth = 200;     // Diameter of rect
  int rectheight = 80;
  String text;
  boolean Colset = false;

  color rectColor;
  color rectHighlight;
  boolean rectOver;
  boolean clickevent;

  public Button(int x, int y, int w, int h, String z) { // 버튼 생성자.
    rectX = x;
    rectY = y;
    text=z;
    rectwidth = w;
    rectheight = h;
    
    rectColor = color(#ffcc33);
    rectHighlight = color(255,0,0);
    rectOver = false; // 버튼위에 마우스있는지.
    clickevent = false; //버튼이 클릭되었는지.
  }

  void Set() { //버튼 위치 설정.
    update();
    if (rectOver) {
      fill(rectHighlight);
    } else {
      fill(rectColor);
    }

    if (!Colset) {
      stroke(0, 150, 150);
      strokeWeight(8);
      rect(rectX, rectY, rectwidth, rectheight,20,20,20,20);

      textSize(36); //버튼 내 text 설정.
      fill(255); 
      text(text, rectX+92-text.length()*8, rectY+45);

      if (rectOver && mousePressed) { // 클릭시 사건 처리
        clickevent = true;
      }
    } else {
      stroke(0, 150, 150);
      strokeWeight(3);
      rect(rectX, rectY, rectwidth, rectheight,20,20,20,20);

      textSize(18); //버튼 내 text 설정.
      fill(0); 
      text(text, rectX+35, rectY+rectheight/2+5);

      if (rectOver && mousePressed) { // 클릭시 사건 처리
        clickevent = true;
      }
    }
  }

  void update() { //버튼 위에 마우스가 있다 없다.
    if ( mouseX >= rectX && mouseX <= rectX+rectwidth && 
      mouseY >= rectY && mouseY <= rectY+rectheight) {
      rectOver = true;
    } else {
      rectOver = false;
    }
  }
}
