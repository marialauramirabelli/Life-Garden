import controlP5.*;

PFont font;

String data[];

ControlP5 cp5;
ControlFont cf1;
DropdownList d1;
int country;

ArrayList<Butterfly> bfs = new ArrayList <Butterfly>();
PImage bf1, bf2, bf3, bf4, bf5, bf6, bf7, bf8, bf9;
int widthLimit;
int heightLimit;
int counter;
int index;
int rate;
boolean start;

void setup(){
 size(900, 900);
 font = createFont("BebasNeue Regular.ttf", 30);
 loadImages();
 start = false;
 
 String[] txtFile = loadStrings("birthDeath.txt");
 data = split(txtFile[0], '_');
 
 cp5 = new ControlP5(this);
 d1 = cp5.addDropdownList("Country")
 .setPosition(100, 110)
 .setSize(200, 200); 
 customize(d1);
 
 counter = 0;
 index = -1;
 widthLimit = 250;
 heightLimit = 250;
 for (int i = 0; i < rate; i++){
 Butterfly b = new Butterfly();
 bfs.add(b);
 };
}

int getRate(int country){
 int indexCountry = country*3; //countries from 0 to 225
 int rate = Math.round(float(data[indexCountry + 1])) - Math.round(float(data[indexCountry + 2]));
 if(rate < 0){
 rate = 0;
 };
 return rate;
}

void customize(DropdownList ddl) {
 ddl.setBackgroundColor(color(190));
 ddl.setItemHeight(20);
 ddl.setBarHeight(15);
 ddl.getCaptionLabel().set("Countries");
 for (int i = 0;i < data.length/3; i++) {
 ddl.addItem(data[i*3], i);
 }
 ddl.setColorBackground(color(60));
 ddl.setColorActive(color(255, 128));
}

void controlEvent(ControlEvent theEvent) {
 if (theEvent.isController()) {
 index = int(theEvent.getController().getValue()); 
 rate = getRate(index);
 index = index*3;
 println(rate);
 }
}

void loadImages(){
 bf1 = loadImage("bf1.png");
 bf2 = loadImage("bf2.png");
 bf3 = loadImage("bf3.png");
 bf4 = loadImage("bf4.png");
 bf5 = loadImage("bf5.png");
 bf6 = loadImage("bf6.png");
 bf7 = loadImage("bf7.png");
 bf8 = loadImage("bf8.png");
 bf9 = loadImage("bf9.png");
}

class Butterfly{
 int X;
 int Y;
 int FRAME;
 int DIRECTION;
 int HORIZONTAL;
 int VERTICAL;
 int SPEED;
 int CENTERX;
 int CENTERY;
 int centerCounter;
 int centerCounterLimit;
 float alpha;
 
 Butterfly(){
 FRAME = int(random(1, 10));
 SPEED = int(random(10, 20));
 DIRECTION = int(random(0, 2));
 X = DIRECTION*width;
 Y = int(random(heightLimit, height-heightLimit));
 CENTERX = int(random(widthLimit, width-widthLimit));
 CENTERY = int(random(heightLimit, height-heightLimit));
 HORIZONTAL = (CENTERX - X)/SPEED;
 VERTICAL = (CENTERY - Y)/SPEED;
 alpha = 255;
 centerCounter = 0;
 centerCounterLimit = int(random(100, 300));
 }
 
 float fly(){
 tint(255, alpha);
 pushMatrix();
 scale(0.75);
 scale((float)Math.pow(-1, DIRECTION), 1);
 switch(FRAME){
 case 1: image(bf1, ((float)Math.pow(-1, DIRECTION))*(X + (DIRECTION*bf1.width)), Y);
 break;
 case 2: image(bf2, ((float)Math.pow(-1, DIRECTION))*(X + (DIRECTION*bf2.width)), Y);
 break;
 case 3: image(bf3, ((float)Math.pow(-1, DIRECTION))*(X + (DIRECTION*bf3.width)), Y);
 break;
 case 4: image(bf4, ((float)Math.pow(-1, DIRECTION))*(X + (DIRECTION*bf4.width)), Y);
 break;
 case 5: image(bf5, ((float)Math.pow(-1, DIRECTION))*(X + (DIRECTION*bf5.width)), Y);
 break;
 case 6: image(bf6, ((float)Math.pow(-1, DIRECTION))*(X + (DIRECTION*bf6.width)), Y);
 break;
 case 7: image(bf7, ((float)Math.pow(-1, DIRECTION))*(X + (DIRECTION*bf7.width)), Y);
 break;
 case 8: image(bf8, ((float)Math.pow(-1, DIRECTION))*(X + (DIRECTION*bf8.width)), Y);
 break;
 case 9: image(bf9, ((float)Math.pow(-1, DIRECTION))*(X + (DIRECTION*bf9.width)), Y);
 break;
 };
 popMatrix();
 if((DIRECTION == 0 && X >= CENTERX) || (DIRECTION == 1 && X <= CENTERX)){
 HORIZONTAL = 0;
 VERTICAL = 0;
 centerCounter++;
 };
 if(centerCounter > centerCounterLimit){
 HORIZONTAL = 0;
 VERTICAL = (height - CENTERY)/SPEED;
 alpha -= 1;
 };
 if(counter%7 == 0){
 if(FRAME == 9){
 FRAME = 1;
 }
 else{
 FRAME++;
 };
 };
 if(counter%SPEED == 0){
 X += HORIZONTAL;
 Y += VERTICAL;
 };
 return alpha;
 }
 }

void draw(){
 background(255);
 textFont(font);
 fill(0, 120);
 if(start == false){
 d1.hide();
 textAlign(CENTER);
 text("This is a data visualization of the world's 2016 birth and death rates for each country.", width/2, height/30*14);
 text("The data was taken from the CIA's 'The World Factbook'.", width/2, height/30*15);
 fill(0);
 text("Click to continue.", width/2, height/30*18);
 if(mousePressed){
 start = true;
 }
 }
 else{
 d1.show();
 fill(0, 120);
 textAlign(LEFT);
 if(index == -1){
 text("Choose a country ", 100, 100);
 }
 else{
 text("Country: "+data[index], 100, 100);
 textAlign(RIGHT);
 text("Birth rate: "+data[index+1], width - 100, height - 133);
 text("Death rate: "+data[index+2], width - 100, height - 100);
 textAlign(LEFT);
 };
 
 counter++;
 if(bfs.size() < rate){
 for(int i = 0; i < rate - bfs.size(); i++){
 Butterfly a = new Butterfly();
 bfs.add(a);
 };
 };
 for (int i = 0; i < bfs.size(); i++){
 Butterfly b = bfs.get(i);
 float opacity = b.fly();
 if(opacity < 0){
 bfs.remove(b);
 };
 }; 
 };
}
