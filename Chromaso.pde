import controlP5.*;

ControlP5 cp5;
String username = System.getProperty("user.name");
int hue_Saturation;
int hue_Brightness;
int countX = 2;
int countY = 5;
float sizeX, sizeY;
PFont font;
PFont fontLabel;

void setup() {
  size(500, 600);
  font = createFont("SF-Compact-Text-Bold.otf", 26, true);
  fontLabel = createFont("SF-Compact-Text-Regular.otf", 10, true);
  ControlFont newFont = new ControlFont(fontLabel, 10);
  background(0);
  colorMode(HSB, 360, 100, 100);
  sizeX = width/countX;
  sizeY = height/countY;

  cp5 = new ControlP5(this);

  cp5.addSlider("hue_Saturation")
    .setPosition(10, 10)
    .setSize(230, 15)
    .setRange(0, 360)
    .setNumberOfTickMarks(91)
    .showTickMarks(false)
    .setValue(280)
    .setColorActive(color(0, 0, 75))
    .setColorForeground(color(0, 0, 75))
    .setColorBackground(color(0, 0, 25))
    ;

  cp5.getController("hue_Saturation")
    .getValueLabel()
    .setFont(newFont)
    .align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE)
    .setPaddingX(0)
    .setColor(color(0, 0, 100))
    ;
  cp5.getController("hue_Saturation")
    .getCaptionLabel()
    .setFont(newFont)
    .align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE)
    .setPaddingX(0)
    .setColor(color(0, 0, 100))
    ;

  cp5.addSlider("hue_Brightness")
    .setPosition(sizeX+10, 10)
    .setSize(230, 15)
    .setRange(0, 360)
    .setNumberOfTickMarks(91)
    .showTickMarks(false)
    .setValue(140)
    .setColorActive(color(0, 0, 75))
    .setColorForeground(color(0, 0, 75))
    .setColorBackground(color(0, 0, 25))
    ;

  cp5.getController("hue_Brightness")
    .getValueLabel()
    .setFont(newFont)
    .align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE)
    .setPaddingX(0)
    .setColor(color(0, 0, 0))
    ;
  cp5.getController("hue_Brightness")
    .getCaptionLabel()
    .setFont(newFont)
    .align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE)
    .setPaddingX(0)
    .setColor(color(0, 0, 0))
    ;
}

void draw() {
  for (int i=0; i<countX; i++) {
    for (int j=0; j<countY; j++) {
      float amt = map(j, 0, countY, 0, 1);
      float val = lerp(0, 126, amt);
      if (i==0) {
        color cS = color(hue_Saturation, val, 100);
        fill(cS);
        noStroke();
        rect(i*sizeX, j*sizeY, sizeX, sizeY);

        fill(0, 0, 25);
        textFont(font);
        textAlign(LEFT);
        text(hue_Saturation, 10, 110);
        textAlign(RIGHT);
        text(int(saturation(cS))+"%", i*sizeX+239, j*sizeY+110);
      } else if (i==1) {
        color cB = color(hue_Brightness, 100, val);
        fill(cB);
        noStroke();
        rect(i*sizeX, j*sizeY, sizeX, sizeY);
        
        fill(0, 0, 75);
        textFont(font);
        textAlign(LEFT);
        text(hue_Brightness, sizeX+10, 110);
        textAlign(RIGHT);
        text(int(brightness(cB))+"%", i*sizeX+239, j*sizeY+110);
      }
    }
  }
}

void keyPressed() {
  if (keyCode == 83) {
    saveFrame("/Users/"+username+"/Desktop/Chromaso/Chromaso-###.png");
  }
  if (key == ESC) {
    key = 0;
  }
}
