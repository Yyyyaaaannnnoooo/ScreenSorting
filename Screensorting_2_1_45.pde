import java.awt.Robot;
import java.awt.Rectangle;
import java.awt.AWTException;
int counter=0, num=2;
float angle, z;
PImage screenshot, fdbck, fdbck2, fdbck3;
boolean k = false;
void setup() {
  //size(1740,1200);
  size(720, 450);
  frameRate(25);
  //fullScreen();
  fdbck=createImage(width, height, RGB);
  fdbck2=createImage(width, height, RGB);
  fdbck3=createImage(width, height, RGB);
  noSmooth();
}

void draw() {
  // num=(int)random(1,5);
  counter++;
  angle+=.03;//controls wavy ondulation
  z=lerp( cos(angle), sin(angle), .1);
  num=(int)map(mouseX,0,width,.1,1);
  sorting1();
}
void screenshot() {
  try {
    Robot robot = new Robot();
    screenshot = new PImage(robot.createScreenCapture(new Rectangle(0, 0, width, height)));
  } 
  catch (AWTException e) {
  }
}
void keyPressed() {
  if (key == 's') {
    String date = new java.text.SimpleDateFormat("yyyy_MM_dd_kkmmss").format(new java.util.Date ());
    saveFrame("screen"+date+".jpg");
  }

  if (key=='k') {
    if (k) {
      k=false;
    } else {
      k = true;
    }
  }
}
void sorting(PImage img) {
  img.loadPixels();
  img.pixels = sort (img.pixels);
  //img.pixels = reverse  (img.pixels);
  img.updatePixels();
}

void sorting1() {

  screenshot();
  noStroke();
  for (int i=0; i<screenshot.width; i+=1) {
    PImage slice=screenshot.get(i, 0, 1, screenshot.height);
    slice.loadPixels();
    slice.pixels = sort(slice.pixels);
    if (i%(int)random(2, 7)==0) {
      slice.pixels = reverse (slice.pixels);
    }

    slice.updatePixels();
    arrayCopy(slice.pixels, 0, fdbck.pixels, slice.pixels.length*i, slice.pixels.length);
    fdbck.updatePixels();
  }
  //image(fdbck,0,0);
  for (int i=0; i<fdbck.width; i+=1) {
    PImage slice=fdbck.get(i, 0, 1, fdbck.height);
    pushMatrix();
    translate(i, 0);
    sorting(slice);
    image(slice, 0, 0);
    popMatrix();
  }
}

void sorting2() {
  screenshot();

  noStroke();

  for (int i=0; i<screenshot.height; i+=num) {
    PImage slice=screenshot.get(0, i, screenshot.width, num );
    //image(slice,i,i);
    pushMatrix();
    translate(0, i);
    sorting(slice);
    image(slice, 0, 0);
    popMatrix();
  }

  fdbck=get(0, 0, width, height);

  for (int i=0; i<fdbck.width; i+=num) {
    PImage slice=fdbck.get(i, 0, num, fdbck.height);
    //image(slice,i,i); 
    pushMatrix();
    translate(i, 0);
    sorting(slice);
    image(slice, 0, 0);
    popMatrix();
  }
}