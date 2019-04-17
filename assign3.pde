final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int Move_Stop = 0;
final int Move_Down = 1;
final int Move_Left = 2;
final int Move_Right = 3;
int moveState = Move_Stop;

float ghogX=80*4;
float ghogY=80,ghogWidth = 80;
int point=80;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

float allSoilY = 0;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered,life,
groundhogDown,groundhogLeft,groundhogRight,groundhogldle;
PImage bg, soil8x24, soil0,soil1,soil2,soil3,soil4,soil5,stone1,stone2;
int soil[] = new int[8];
PImage soilImage[] = new PImage[6];

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
	soil8x24 = loadImage("img/soil8x24.png");
  soilImage[0] = loadImage("img/soil0.png");
  soilImage[1] = loadImage("img/soil1.png");
  soilImage[2] = loadImage("img/soil2.png");
  soilImage[3] = loadImage("img/soil3.png");
  soilImage[4] = loadImage("img/soil4.png");
  soilImage[5] = loadImage("img/soil5.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  life = loadImage("img/life.png");
  playerHealth = 2;
  groundhogldle = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

		// Background
		image(bg, 0, 0);

		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);

    pushMatrix();
    translate(0,allSoilY);
		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
    for(int i=0 ; i < soil.length ; i++){
      for(int n=0; n<4 ; n++){
        for(int a=0; a<soilImage.length; a++){
          image(soilImage[a],0+80*i,(160+320*a)+80*n,80,80);
        }
      }
    }
    //stone1-8
    for (int i = 0; i < width; i += 80){
      pushMatrix();
      translate(i, i);
      image(stone1,0,160,80,80);
      popMatrix();
    }
    
    //stone10-15
    for(int r=0; r<160+80*4; r+=160){
      pushMatrix();
      translate(0,r);
      if(r/160%2 == 0){//rows with stones in middle
      //move and copy to left
      for(int i=-width; i<width*2; i+=320){
        pushMatrix();
        translate(i,0);
        //draw stones in square
        for(int col=-1; col<1; col++){
        for(int row=9; row<11; row++){
          int x=80*col;
          int y=160+80*row;
          image(stone1,x,y,80,80);
          }
        }
        popMatrix();
      }
      }else{//rows with stones close to the edge 
        //move and copy to left
        for(int i=-width; i<width*2; i+=320){
        pushMatrix();
        translate(i,0);
        //draw stones in square
        for(int col=1; col<3; col++){
        for(int row=9; row<11; row++){
          int x=80*col;
          int y=160+80*row;
          image(stone1,x,y,80,80);
          }
        }
        popMatrix();
      }
        
      }
      popMatrix();
    }
    //stone9,16
    for(int i=0; i<width; i+=320){
        pushMatrix();
        translate(i,0);
        //draw 2 stones
        for(int col=1; col<3; col++){
          int x=80*col;
          image(stone1,x,160+80*8,80,80);
          }
        popMatrix();
    }
    for(int i=0; i<width; i+=320){
        pushMatrix();
        translate(i,0);
        //draw 2 stones
        for(int col=1; col<3; col++){
          int x=80*col;
          image(stone1,x,160+80*15,80,80);
          }
        popMatrix();
    }
    //stone17-24
      //stone1
    for(int i=0; i<width*2; i+=240){
      pushMatrix();
      translate(i,0);

        for(int n=0; n<width; n+=80){
          pushMatrix();
          translate(n,-n);
          //draw 2 stone
          image(stone1,0-80*6,160+80*23,80,80);
          image(stone1,80-80*6,160+80*23,80,80);
          popMatrix();
        }
      popMatrix();
    }
      //stone2
    for(int i=0; i<width*2; i+=240){
      pushMatrix();
      translate(i,0);

        for(int n=0; n<width; n+=80){
          pushMatrix();
          translate(n,-n);
          //draw 1 stone
          image(stone2,80-80*6,160+80*23,80,80);
          popMatrix();
        }
      popMatrix();
    }
    //groundHog & soil move
    switch(moveState){
      case Move_Stop:
        image(groundhogldle,ghogX,ghogY);
      break;
      case Move_Down:
        //soil move
        if(allSoilY > 80*20*-1){
          allSoilY -= 5;
        }
        //ghog move
        if(ghogY < 160+80*24-ghogWidth){
          image(groundhogDown,ghogX,ghogY);
          ghogY+=5;
          if(ghogY%point == 0){
          moveState = Move_Stop;
          }
        }else{image(groundhogldle,ghogX,160+80*24-ghogWidth);}

        
        
      break;
      case Move_Left:
      if(ghogX>0){
        image(groundhogLeft,ghogX,ghogY);
        ghogX-=5;
        if(ghogX%point == 0){
          moveState = Move_Stop;
        }
      }else{image(groundhogldle,0,ghogY);}
        
      break;
      case Move_Right:
        if(ghogX < 640-ghogWidth){
          image(groundhogRight,ghogX,ghogY);
          ghogX+=5;
          if(ghogX%point == 0){
          moveState = Move_Stop;
          }
        }else{image(groundhogldle,640-ghogWidth,ghogY);}
      break;
    }
    popMatrix();
		// Health UI
    for(int i=10; i<10+70*playerHealth; i+=70){
      image(life,i,10);
    }
    
    
		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// ghog move
  if(key == CODED){
    if(ghogX%point==0 && ghogY%point==0)
    switch(keyCode){
      case LEFT:
      moveState = Move_Left;
      break;
      case RIGHT:
      moveState = Move_Right;
      break;
      case DOWN:
      moveState = Move_Down;
      break;
    }
  }
	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}

void keyReleased(){
}
