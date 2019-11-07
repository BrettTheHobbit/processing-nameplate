/*
Brett Hobbs
ICS 3U1
Assignment 1
This program is a game that gets you to unlock each letter of my name before seeing the nameplate in its full glory
*/

int xPos = 10;
int yPos = 10;
int SPEED = 5;
int r = 200;
int g = 150;
int b = 100;
boolean toggle = false;
int gameState = 0;
/*
int unlockB = 50;// if you hover your mouse over said letter, it lights up!
int unlockR = 50;
int unlockE = 50;
int unlockT = 50;
int unlockT2 = 50;
*/
int gameScore = 0;
float mineX;//TBD via function
float mineY;
float mineSize;
int mineCounter = 60;

float mineXCalculate() {
  mineX = random(100,500);
  return mineX;// randomizes mineX and returns a value 
}

float mineYCalculate() {
  mineY = random(100,500);
 return mineY;// randomizes mineY and returns a value 
}

float mineSizeCalculate() {
  mineSize = random(10,150);
  return mineSize;// randomizes mineSize and returns a value 
}


void drawName() {//draws bretts name
  strokeWeight(0);
  fill(255,0,10);// B
  arc((width/2)-150, (height/2)-100, 80, 80, -2, 2, CHORD);
  arc((width/2)-150, (height/2)-50, 80, 80, -2, 2, CHORD);
  fill(0,0,0);
  arc((width/2)-150, (height/2)-100, 40, 40, -2, 2, CHORD);
  arc((width/2)-150, (height/2)-50, 40, 40, -2, 2, CHORD);
  fill(0,255,10);//R
  arc((width/2)-70, (height/2)-45, 80,60, -2, 1, PIE);
  rect((width/2)-90, (height/2)-50, 40, 75,5);
  arc((width/2)-70, (height/2)-80, 80, 60, -3.14, 1.55, PIE);
  fill(0,0,0);
  ellipse((width/2)-70, (height/2)-75,40,40);
  fill(10,0,255);//E
  rect((width/2)-15,(height/2)-60,20,90,5);
  rect((width/2)+17,(height/2)-25,70,20,5);
  rect((width/2)+17,(height/2)-60,70,20,5);
  rect((width/2)+17,(height/2)-95,70,20,5);
  fill(10,200,200);//T
  rect((width/2)+90,(height/2) -95, 70,20);
  rect((width/2)+90,(height/2)- 60, 20,80);
  fill(200,10,200);//T2
  rect((width/2)+150,(height/2) -95, 70,20);
  rect((width/2)+150,(height/2)- 60, 20,80);
}

void drawNameCondensed() {//redraws name as a ball for gameplay purposes
    strokeWeight(0);
  fill(255,0,10);// B
  arc(xPos, yPos, 80, 80, -2, 2, CHORD);
  arc(xPos, yPos, 80, 80, -2, 2, CHORD);
  fill(0,0,0);
  arc(xPos, yPos, 40, 40, -2, 2, CHORD);
  arc(xPos, yPos, 40, 40, -2, 2, CHORD);
  fill(0,255,10);//R
  arc(xPos, yPos, 80,60, -2, 1, PIE);
  rect(xPos, yPos, 40, 75,5);
  arc(xPos, yPos, 80, 60, -3.14, 1.55, PIE);
  fill(0,0,0);
  ellipse(xPos, yPos,40,40);
  fill(10,0,255);//E
  rect(xPos, yPos,20,90,5);
  rect(xPos, yPos,70,20,5);
  rect(xPos, yPos,70,20,5);
  rect(xPos, yPos,70,20,5);
  fill(10,200,200);//T
  rect(xPos, yPos, 70,20);
  rect(xPos, yPos, 20,80);
  fill(200,10,200);//T2
  rect(xPos, yPos, 70,20);
  rect(xPos, yPos, 20,80);
}



void changeColour() {// flashes colour back and forth
  r+= 20;
  g-= 10;
  b++;
  if (r > 350) {
   r = 200;
   g = 150;
   b = 100;
  }
  fill(r,g,b);
}

void setup() {//sets up the program
  size(600,600);
  background(0);
  rectMode(CENTER);
  ellipseMode(CENTER);
  
}

void draw() {
    background(255,0,0);
  if (gameState == 0) {// start: has the name plate unlit
  fill(255,50,0);//border
  rect(300,250,550,450);
  fill(255,150,0);
  rect(300,250,500,400);
  fill(0);
  rect(300,250,375,250);
  fill(255);
  textSize(20);// start text and click detetion
  text("Start",(width/2)-25,400);
  text("How To Play",(width/2)-55, 500);
  if (mousePressed) {
    if(mouseY > 300 && mouseY < 400) {
      gameState = 1;
    } else if (mouseY > 400) {
      gameState = 2;
    }
  }
    drawName();
  } else if (gameState == 1) {

  mineCounter--;
    if (millis()%40 == 1) {//if odd seconds, create mine
  mineXCalculate();//returns values of my special bomb
  mineYCalculate();
  mineSizeCalculate();
    }
  
  
  //text("Bertothus Hobbilton",xPos,yPos); // replacce w/ actual name + nameplate
  if (keyCode == 37) {// arrow keys for movement
   xPos -= SPEED; 
  } else if (keyCode == 39) {
   xPos += SPEED; 
  } else if (keyCode == 40) {
   yPos += SPEED;
  } else if (keyCode == 38) {
   yPos -= SPEED; 
  }
  if (keyCode == 84) {//t starts and stops movement
   toggle = true; 
   
  }
  if (keyCode == 89) {//y
  toggle = false;
  }
  if (toggle) {// controls when to stop
   SPEED = 0; 
  } else {
   SPEED = 5; 
  }
  // stops ball from exiting border
  if (xPos > width) {
   xPos = width; 
  } else if (xPos < 0) {
  xPos = 0;
  } else if (yPos > height) {
   yPos = height; 
  } else if (yPos < 0) {
    yPos = 0;
  }
  //collision
  if ((xPos-mineX)*(xPos-mineX) + (mineY-yPos)*(mineY-yPos) <= (mineSize+80)*(mineSize+80)) {//equaision to find if mine is colliding/oerlapping w/ my name
    gameState = 0;//haha you lost all because of RNG.. hehehe
    mineX = -10;
    mineY = height+ 1000;
    mineSize = 1;
    println("gotem haha");
  }
  drawNameCondensed();//Used to condense name and free clutter from draw
  changeColour();
  ellipse(mineX,mineY,mineSize,mineSize);
  
  } else if (gameState == 2) {//how to play screen
    fill(255);
    textSize(50);
    text("Use arrow keys to move\nT/Y to freeze the name\n and unfreeze the name",0,100);
    text("Click mouse \n and E to Continue", 100,400);
    if (mousePressed && keyCode == 69 ) {// continues to game
     gameState = 1; 
    }
}
}
