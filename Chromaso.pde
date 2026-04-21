import controlP5.*;

ControlP5 cp5;

final float MAX_RAMP_VALUE = 126;

int hue_Saturation;
int hue_Brightness;
int countX = 2;
int countY = 5;
float sizeX, sizeY;
PFont font;
PFont fontLabel;

String copyMessage = "";
int copyMessageTimer = 0;

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
      float val = lerp(0, MAX_RAMP_VALUE, amt);
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

  // On-screen copy confirmation
  if (copyMessageTimer > 0) {
    copyMessageTimer--;
    textFont(fontLabel);
    float msgW = textWidth(copyMessage) + 20;
    fill(0, 0, 0, 180);
    noStroke();
    rectMode(CENTER);
    rect(width/2, height - 30, msgW, 24, 6);
    rectMode(CORNER);
    fill(0, 0, 100);
    textAlign(CENTER, CENTER);
    text(copyMessage, width/2, height - 30);
  }
}

void mousePressed() {
  if (cp5.isMouseOver()) return;
  int i = floor(mouseX / sizeX);
  int j = floor(mouseY / sizeY);
  if (i < 0 || i >= countX || j < 0 || j >= countY) return;

  float amt = map(j, 0, countY, 0, 1);
  float val = lerp(0, MAX_RAMP_VALUE, amt);
  color c;
  if (i == 0) {
    c = color(hue_Saturation, val, 100);
  } else {
    c = color(hue_Brightness, 100, val);
  }

  String hexValue = "#" + hex(c).substring(2);
  java.awt.Toolkit.getDefaultToolkit().getSystemClipboard().setContents(
    new java.awt.datatransfer.StringSelection(hexValue), null
  );
  copyMessage = "Copied " + hexValue;
  copyMessageTimer = 90;
}

void keyPressed() {
  if (keyCode == 83) {
    java.io.File dir = new java.io.File(System.getProperty("user.home"), "Chromaso");
    if (!dir.exists() && !dir.mkdirs()) {
      println("ERROR: could not create save directory: " + dir.getAbsolutePath());
      return;
    }
    saveFrame(dir.getAbsolutePath() + "/Chromaso-###.png");
  }
  if (key == ESC) {
    key = 0;
  }
}