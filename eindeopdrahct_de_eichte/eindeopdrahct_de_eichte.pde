Player player;
Player player2;
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();

boolean[] keys = new boolean[128];
boolean[] codedKeys = new boolean[526];

boolean player1IsIt = true; // rood begint als tikker

// UI & timer
int gameTime = 45;          
int startTime;              
boolean gameRunning = false;
boolean showInstructions = true; 

// Score
int player1Score =   0;
int player2Score = 0;

void setup() {
  size(500, 500);
  textAlign(CENTER, CENTER);
  textSize(20);
  
  player  = new Player(30, 250, 30, 30);
  player2 = new Player(475, 250, 30, 30);

  // Obstakels
  obstacles.add(new Obstacle(250, 100, 50, 150));
  obstacles.add(new Obstacle(150, 300, 50, 150));
  obstacles.add(new Obstacle(45, 215, 50, 75));
  obstacles.add(new Obstacle(400, 215, 50, 75));
  obstacles.add(new Obstacle(40,40,110,50));
  obstacles.add(new Obstacle(350,420,60,50));

}

void keyPressed() {
  if (showInstructions && key == ENTER) {
    // Start het spel bij ENTER
    showInstructions = false;
    gameRunning = true;
    startTime = millis();
    return;
  }

  if (key == CODED) codedKeys[keyCode] = true;
  else if (key < 128) keys[key] = true;
}

void keyReleased() {
  if (key == CODED) codedKeys[keyCode] = false;
  else if (key < 128) keys[key] = false;
}

void update() {
  // Als het spel niet loopt, geen beweging
  if (!gameRunning) return;

  // 🔹 Snelheden afhankelijk van wie de tikker is
  float player1Speed = player1IsIt ? 2.5 : 2.0;
  float player2Speed = player1IsIt ? 2.0 : 2.5;

  // --- Player 1 (WASD) ---
  player.xVelocity = 0;
  player.yVelocity = 0;
  if (keys['A'] || keys['a']) player.xVelocity = -player1Speed;
  else if (keys['D'] || keys['d']) player.xVelocity = player1Speed;
  else if (keys['W'] || keys['w']) player.yVelocity = -player1Speed;
  else if (keys['S'] || keys['s']) player.yVelocity = player1Speed;

  // --- Player 2 (Arrow keys) ---
  player2.xVelocity = 0;
  player2.yVelocity = 0;
  if (codedKeys[LEFT]) player2.xVelocity = -player2Speed;
  else if (codedKeys[RIGHT]) player2.xVelocity = player2Speed;
  else if (codedKeys[UP]) player2.yVelocity = -player2Speed;
  else if (codedKeys[DOWN]) player2.yVelocity = player2Speed;

  // Beweeg spelers
  player.move();
  player2.move();

  // Check of ze elkaar raken (tikkertje)
  if (player.collides(player2)) {
    if (player1IsIt) {
      player1IsIt = false;
      player1Score++; // rood (player1) scoort
      player2.respawn();
    } else {
      player1IsIt = true;
      player2Score++; // groen (player2) scoort
      player.respawn();
    }
  }

  // Check of timer afgelopen is
  int elapsed = (millis() - startTime) / 1000;
  if (elapsed >= gameTime) {
    gameRunning = false;
  }
}

class Player {
  float x, y, w, h;
  float yVelocity;
  float xVelocity;
  float spawnX, spawnY;

  Player(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    spawnX = x;
    spawnY = y;
  }

  void move() {
    float oldX = x;
    float oldY = y;
    x += xVelocity;
    y += yVelocity;

    // Botsing met obstakels
    for (Obstacle o : obstacles) {
      if (o.collides(this)) {
        x = oldX;
        y = oldY;
      }
    }

    // Binnen speelveld blijven
    if (x - w/2 < 0) x = w/2;
    if (x + w/2 > width) x = width - w/2;
    if (y - h/2 < 0) y = h/2;
    if (y + h/2 > height) y = height - h/2;
  }

  void respawn() {
    x = spawnX;
    y = spawnY;
  }

  void display(color c) {
    fill(c);
    ellipse(this.x, this.y, this.w, this.h);
  }

  boolean collides(Player other) {
    float dx = this.x - other.x;
    float dy = this.y - other.y;
    float distance = sqrt(dx*dx + dy*dy);
    return distance < (this.w/2 + other.w/2);
  }
}

class Obstacle {
  float x, y, w, h;

  Obstacle(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void display() {
    fill(200);
    stroke(0);
    strokeWeight(3);
    rect(x, y, w, h);
  }

  boolean collides(Player p) {
    return (p.x + p.w/2 > x &&
      p.x - p.w/2 < x + w &&
      p.y + p.h/2 > y &&
      p.y - p.h/2 < y + h);
  }
}

void draw() {
  background(#7206C1);

  // --- UITLEG SCHERM ---
  if (showInstructions) {
    fill(255);
    textSize(24);
    text("TIKKERTJE!", width/2, height/2 - 80);
    textSize(16);
    text("Rood = de tikker \nTik de groene speler om kleuren te wisselen!\n\nSpeler 1: WASD\nSpeler 2: pijltjestoetsen\n\nDruk op ENTER om te beginnen.", 
         width/2, height/2);
    return;
  }

  // --- OBSTAKELS ---
  for (Obstacle o : obstacles) {
    o.display();
  }

  // --- SPEL UPDATE ---
  update();

  // --- SPELERS TEKENEN ---
  if (player1IsIt) {
    player.display(color(255, 0, 0));
    player2.display(color(0, 255, 0));
  } else {
    player.display(color(0, 255, 0));
    player2.display(color(255, 0, 0));
  }

  // --- TIMER ---
  if (gameRunning) {
    int timeLeft = max(0, gameTime - (millis() - startTime) / 1000);
    fill(255);
    textSize(20);
    text("Tijd: " + timeLeft, width/2, 20);

    // Scores tonen tijdens het spel
    textAlign(LEFT);
    text("Speler 1 (Rood): " + player1Score, 20, 20);
    textAlign(RIGHT);
    text("Speler 2 (Groen): " + player2Score, width - 20, 20);
    textAlign(CENTER, CENTER);
  } 
  else {
    // --- GAME OVER SCHERM ---
    fill(255);
    textSize(24);
    text("Tijd voorbij!", width/2, height/2 - 60);
    textSize(20);
    text("Eindscore:", width/2, height/2 - 20);
    text("player1: " + player1Score + "   player2: " + player2Score, width/2, height/2 + 10);

    String winner;
    if (player1Score < player2Score) winner = " player1 heeft gewonnen!";
    else if (player2Score > player1Score) winner = " player2 heeft gewonnen!";
    else winner = "Gelijkspel!";
    text(winner, width/2, height/2 + 50);

    textSize(16);
    text("Druk op ENTER om opnieuw te spelen.", width/2, height/2 + 90);

    if (keyPressed && key == ENTER) {
      resetGame();
    }
  }
}

void resetGame() {
  player.respawn();
  player2.respawn();
  player1IsIt = true;
  startTime = millis();
  gameRunning = true;
  player1Score = 0;
  player2Score = 0;
}
