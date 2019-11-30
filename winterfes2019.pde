//共通ライブラリ
import processing.video.*;
import ddf.minim.*;

//共通設定
int scene = 0;

//シーン1
int angle;
int pyramidSize = 300;

//シーン2
int w = 0;
int h = 0;
int t = 150;

Movie movie;

//シーン3
ArrayList<Beam> beams;

color mainBlue = color(24, 61, 143);
color mainRed = color(205, 57, 87);

int fwWeight = 5;

//シーン4
float fillAlpha = 0;

//シーン5

//シーン6
Movie sc5movie;

//シーン7
String sc7textList[] = {
    "",
    "Clap Your Hands!!",
    "[BAND TEAM]\nAika Yoshino Sayaka Ayumi Sae\nKaigen Sou Kazune Neji",
    "",
    "[DANCE TEAM]\nChika　Reina　Momoko\nYumika　Natsumi Fukino Shuko",
    "[Genie]\nTakami",
    "[Genie]\nKouki",
    "[Genie]\nMarumo",
    "[Aladdin]　Shoutarou\n[Jasmine]　Mai",
    "[SPECIAL SUPPORT]\n\nMisato　Kirie",
    "",
    "最高の友達",
    "See You Next Stage!"
};
　 
int sc7textFlag = 0;

PFont jpFont;
float fontSize = 50;


//シーン9
float greenValue = 0;

void setup() {

  //setup window size

  fullScreen(P3D);
  
  //size(800, 600, P3D);

  noCursor();

  translate(width/2, height/2, 0);
  stroke(255);
  noFill();

  angle = 0;
  
  //シーン2の設定
  movie = new Movie(this, "india.mp4");
  frameRate(60);
  
  //シーン3の設定
  beams = new ArrayList<Beam>();
  
  //シーン5の設定
  
  sc5movie = new Movie(this, "arabian_castle.mp4");
  frameRate(30);

  
  //シーン6の設定
   w = width;
   h = height;
   
  //シーン7の設定
  jpFont = createFont("HiraKakuPro-W3", fontSize);
  
}

void draw() {
  
  if(scene == 0){
    //真っ黒の背景だけ表示する
    background(0,0,0);
    
  }else if(scene == 1){
   background(0, 0, 0);
   stroke(255,255,255);

    angle += 1;
    if (angle>360) angle = 0;
  
    translate(width/2, height/2);
    rotateY(radians(angle));
    rotateX(radians(angle));
       
    int randX = (int)random(50);
    int randY = (int)random(50);
    int randZ = (int)random(50);
    
    Pyramid pyramid = new Pyramid(
      -1*pyramidSize+randX, -1*pyramidSize+randY, -1*pyramidSize+randZ, 1*pyramidSize+randX, -1*pyramidSize+randY, -1*pyramidSize+randZ, 0+randX, 0+randY, 1*pyramidSize+randZ, 1*pyramidSize+randX, 1*pyramidSize+randY, -1*pyramidSize+randZ
    );
  }else if(scene == 2){
    
    image(movie, 0, 0, width, height);
    
  }else if(scene == 3){
    
    background(0, 0, 0);
    translate(width / 2, height / 2);
    rotateX(frameCount * 0.002);
    rotateY(frameCount * 0.003);
    rotateZ(frameCount * 0.005);
    ArrayList<Beam> nextBeams = new ArrayList<Beam>();
    for(Beam b: beams){
      b.display();
      b.update();
      if(!b.isDead()){
        nextBeams.add(b);
      }
    }
    beams = nextBeams;
  
  }else if(scene == 4){
    //シーン4
    rectMode(CENTER);
    noStroke();
    fill(255,0,0, fillAlpha);
    rect(width/2, height/2, 200, 200);
    
    fillAlpha += 0.005;
    if(fillAlpha >= 3){
      fillAlpha = 0;
      background(0);
    }
     
  
  }else if(scene == 5){
    
    //シーン5: 城
    background(0); 
    //sc5movie.width = width;
    //sc5movie.height = height;

    fill(255,255,255);
    sc5movie.read();
    sc5movie.loadPixels();
    for ( int i = 0; i < height; i=i+10 ) {
      beginShape();
      for ( int j = 0; j < width; j++ ) {
        color c1 = sc5movie.get(j, i);
        stroke(255);
        strokeWeight(1);
        vertex(j, i+(red(c1)+green(c1)+blue(c1))/25);
      }
      endShape();
    }
    
    
    //image(sc5movie, 0, 0, width, height);
  
  
  }else if(scene == 6){
    
    //シーン5: グラデーション
    
    noStroke();

    for(float w = 0; w < width; w += 5){
      for(float h = 0; h < height; h += 5){
        color c = lerpColor(mainBlue, mainRed, (w + h) / (width + height));
        fill(c);
        rect(w, h, 5, 5);
      }
    }
    
    //線を描画して絨毯感を出す
    for(int j = 0;j < 40;j++){
      float seed = (j - frameCount) * 0.02;
      float pre_y = noise(seed) * t - t/2 + h/4 * sin(0) + h / 2;
      int c = color(noise(seed) * 255,noise(seed + 1) * 255,noise(seed + 2) * 255); 
      stroke(c);
      for(int i = 0;i < w;i+=3){
        float y = noise(seed + 0.01 * (i + 1)) * t - t/2 + h/4 * sin(TWO_PI/360*i * 0.8) + h / 2;
        line(i, pre_y, i + 3, y);
        pre_y = y;
      }
    }
    
  }else if(scene == 7){
    //シーン7: エンディング
    
    background(0);
    rectMode(CENTER);
    textSize(100);
    fill(255, 215, 0);
    textFont(jpFont);
    textAlign(CENTER);
    text(sc7textList[sc7textFlag], width/2, height/2);
    
  }else if(scene == 8){
  
  }else if(scene == 9){
    
    background(0,0,0);
    
    noFill();
    noStroke();
    strokeWeight(2);
    stroke(255, greenValue, 255);
    drawSakura(width/2, height/2, 200);
    
    greenValue += 0.5;
    if(greenValue > 250) greenValue = 0;
  
  }
  
}

//シーン3
void explode(){
  float r = map(sqrt(random(1)), 0, 1, 0, 250);
  float a1 = random(PI);
  float a2 = random(TWO_PI);
  float x = r * sin(a1) * cos(a2);
  float y = r * cos(a1);
  float z = r * sin(a1) * sin(a2);
  color c = color(random(360), random(360), random(360));
  int num = int(random(50, 100));
  for(int i = 0; i < num; i++){
    beams.add(new Beam(x, y, z, c));
  }
}

void mousePressed(){
  explode();
}

void movieEvent(Movie m) {
  m.read();
}

//キーボードのpressによって状態を管理する

void keyPressed(){
 
  if(key == '0'){
    scene = 0;
  }else if(key == '1'){
    scene = 1;
  }else if(key == '2'){
    scene = 2;
    movie.loop();
  }else if(key == '3'){
    scene = 3;
  }else if(key == '4'){
    scene = 4;
  }else if(key == '5'){
    scene = 5;
    sc5movie.loop();
  }else if(key == '6'){
    scene = 6;
  }else if(key == '7'){
    scene = 7;
  }else if(key == '8'){
    scene = 8;
  }else if(key == '9'){
    scene = 9;
  }else if(key == 32){
    explode();
  }
  
  if(key == CODED){
    if(keyCode == UP){
      fwWeight += 2;
    }else if(keyCode == DOWN){
      fwWeight -= 2;
    } 
  }
  
  if(key != '2'){
    movie.stop();
  }
  
  if(key != '5'){
    sc5movie.stop();
  }
  
  //sc7 テキストの入れ替え
  if(key == CODED){
    if(keyCode == LEFT){
      if(sc7textFlag > 0){
        sc7textFlag -= 1;
      }
    }else if(keyCode == RIGHT){
      if(sc7textList.length-1 > sc7textFlag){
        sc7textFlag += 1;
      }
    }
    
    if(sc7textFlag == 11){
      fontSize = 80;
      
    }else{
      fontSize = 50 ;
    }
    jpFont = createFont("HiraKakuPro-W3", fontSize);
    
    println(sc7textFlag);
  }

}
  
class Pyramid{

  
  Pyramid(int Ax, int Ay, int Az, int Bx, int By, int Bz, int Cx, int Cy,int  Cz, int Dx,  int Dy,int Dz){
    
    strokeWeight(5);

    beginShape();
    vertex(Ax, Ay, Az);
    vertex(Bx, By, Bz);
    vertex(Cx, Cy, Cz);
  
    vertex(Ax, Ay, Az);
    vertex(Cx, Cy, Cz);
    vertex(Dx, Dy, Dz);
  
    vertex(Ax, Ay, Az);
    vertex(Dx, Dy, Dz);
    vertex(Bx, By, Bz);
    
    vertex(Bx, By, Bz);
    vertex(Cx, Cy, Cz);
    vertex(Dx, Dy, Dz);
    
    endShape();
    
  }
 
}

class Beam{
    
  PVector end1, end2, vel;
  float span;
  int life;
  color col;
  
  Beam(float x, float y, float z, color c){
    end1 = new PVector(x, y, z);
    end2 = new PVector(x, y, z);
    vel = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
    vel.normalize();
    float velSize = random(2, 10);
    vel.mult(velSize);
    span = random(30, 60);
    life = int(random(50, 200));
    col = c; 
  }
  
  void display(){
    stroke(col);
    strokeWeight(fwWeight);
    line(end1.x, end1.y, end1.z,  end2.x, end2.y, end2.z);
  } 
  
  void update(){
    if(life > 0){
      if(PVector.dist(end1, end2) < span){
        end1.add(vel);
      } else {
        end1.add(vel);
        end2.add(vel);
      }
      life--;
    } else {
      end2.add(vel);
    }
  }
  
  boolean isDead(){
    return life == 0 && PVector.dist(end1, end2) <= vel.mag();
  }
  
}
//シーン4 サクラ
void drawSakura(int ox, int oy, int or) {
  int petalNum = 5;  // 花びらの数

  pushMatrix();
  translate(ox, oy);
  rotate(radians(90));
  beginShape();
  for (int theta = 0; theta < 360; theta++) {
    float A = petalNum / PI * radians(theta);
    int md = floor(A) % 2;
    float r = pow(-1, md) * (A - floor(A)) + md;
    float R = r + 2 * calcH(r);

    float x = or * R * cos(radians(theta));
    float y = or * R * sin(radians(theta));

    vertex(x, y);
  }
  endShape(CLOSE);
  popMatrix();
}

float calcH(float x) {
  if (x < 0.8) {
    return 0;
  } else {
    return 0.8 - x;
  }
}