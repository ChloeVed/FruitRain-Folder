/**
 * Fruit Rain game's main file FruitRain.pde
 * 
 * @authors Justin Portillo, Dionys Del Rosario, Chloe Vedrine
 * @version 1.0 Course : STEC 4800, Spring 2023
 * 
 * This file is similar to a Java class that contains the main method. 
 * The Processing game engine ("the main method") starts executing the game by 
 * invoking the method setup() and then will invoke draw() 60 times/sec (the default frame rate).
 * The frame rate can be changed.
 *          
 * The two most important methods in this file:
 *  setup():  Initilize variables when app is started, only one time.
 *  draw():   Update variables. Executed over and over again.
 */
import java.util.ArrayList;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Scanner;
import java.awt.event.KeyEvent;
import javax.swing.*;
import processing.sound.*;
import gifAnimation.*;

final public int BLACK = color(0, 0, 0);
final public int SKY = color(113, 212, 240);
final public int RED = color(255, 0, 0);
final public int RASPBERRY = color(235, 68, 126);
final public int APPLE = color(232, 71, 46);
final public int ORANGE = color(242, 168, 31);
final public int BANANA = color(245, 239, 69);
final public int LIME = color(111, 209, 75);
final public int GRAPE = color(167, 58, 222);

public Enemy[] enemies;

public int guess;
public int quizSize;
public int quizIndex;
public int healthPoints;
public int possiblePoints;
public int correct;
public int scenario;
public boolean oneUp;
public int streak;
public boolean quizChosen;
public String quizName;
public boolean quizLoaded;
PImage backgroundImage;
PImage startup;
Gif myAnimation;

public boolean start; // a boolean variable that represents whetner the game is started.
public int score = 0; // score earned. Potential points earned is based on whether or not they guess wrong. 1000 points for each question, a wrong answer reduces this by 250
public int hitPoints = 5; //player starts with 5 hit points, they lose hit points whenever they get questions wrong. Players can earn back 1 hit point every 6 questions
public ArrayList<Question> questions = new ArrayList<Question>();
public Scanner input = new Scanner(System.in);

//for music
SoundFile file;

/**
 * Method: setup()
 *
 * This method is only invoked once when the game is started.
 * It does a couple of standard things, such as initializes window size, applies background color.
 * Then it initializes variables, such as player location, score, and etc.
 */
 void setup() {
  // Initilize the window size.
  // size() must be called before all other Processing method calls, such as noStroke(). 
  // Both parameters have to be constant: the first is width and the second is height.
  size(900, 900);
  backgroundImage = loadImage("Beachreal2.png");
      myAnimation = new Gif(this, "startup.gif");
    myAnimation.play();
  
  
  //music

  file = new SoundFile(this,"music.wav");
  file.play();
  file.amp(.075);
    
   //FONT
   PFont mono;
   mono = createFont("font.ttf", 128);
   textFont(mono);
   
  // Disable the layer.
  noStroke();
  
  
  quizIndex = 0;
  healthPoints = 5;
  guess = 5;
  possiblePoints = 1000;
  oneUp = false;
  quizChosen = false;
  quizLoaded = false;
  scenario = 1; //1: display question, 2: tell the player their guess was correct, 3: tell the player their guess was incorrect, 4: either game over condition
  
  background(backgroundImage); //this screen color gets overwritten in the draw() method

  start = false;  //Before player click to start the game, it is set to false
  score = 0;      //set score to 0

  enemies = new Enemy[4];
  for (int i =0; i<4; i++) {
    enemies[i] = new Enemy(this, i + 1); //an enemy is declared, we must ensure we get one of each type
    //"Enemies" are fruits, references to fruits as enemies are a relic of the original program that was re-purposed
  }

}


/*  
 * Method: draw
 
 * This method will be invoked in a loop, each iteration drawing a frame as in a movie.
 * The default frame rate (which can be changed) is 60 frames/sec.
 *
 * Any change to the game (variable changes) should happen here. 
 * Note that drawing in Processing uses the rule of stack:
 * - First shape/img will be at the bottom. 
 * - Shape/image drawn later will be on top.
 *
 * When the game hasn't started yet, display instruction.
 * When the game has started, display score and draw player.
 * Increase the score by 1.
 */
void draw() {
  if (!start) {
    backgroundImage = loadImage("Beachreal2.png");
    image(myAnimation, 0, 0);
    quizIndex = 0;
    score = 0;
    healthPoints = 5;
    guess = 5;
    possiblePoints = 1000;
    scenario = 1;
    quizChosen = false;
    quizLoaded = false;
    streak = 0;
    displayInst(); //display instruction if not started yet
  }
  if (start) {
    background(backgroundImage);

    if(!quizChosen) {
      fill(RASPBERRY);
      text("Choose a quiz: ", 375, 100);
      fill(APPLE);
      text("APPLE: Full Quiz", 100, 250);
      fill(ORANGE);
      text("ORANGE: Variables", 100, 400);
      fill(BANANA);
      text("BANANA: Strings", 100, 550);
      fill(LIME);
      text("LIME: Conditionals", 100, 700);
      
      
    } else {
      if(quizChosen && !quizLoaded) {
        questions = loadQuestions();
        quizSize = questions.size();
        quizLoaded = true;
      }
      if(scenario == 2) {
      delay(3000);
    }
    if(scenario == 3) {
      delay(1500);
    }
    if(scenario == 4) {
      start = false;
      delay(5000);
    }
    
    if(scenario != 1) {
      scenario = 1;
      guess = 5;
      delay(500);
    }
    if(scenario == 1) {
      try {
        displayScore();
        if((quizIndex)%6 != 0 || quizIndex == 0) {
          oneUp = false;
        }
        else {
          if(!oneUp) {
            healthPoints++;
            oneUp = true; //ensures the player is only given an additional health point once every 6 questions
          }
        }
        fill(RASPBERRY);
        text("Lives left: " + healthPoints, 5, 50);
        
        correct = questions.get(quizIndex).getCorrect();
        
        fill(RASPBERRY);
        text(questions.get(quizIndex).getText(), 375, 100); //Aim for the top middle of the screen)
        for(int j = 1; (j - 1) < questions.get(quizIndex).getAnswers().size(); j++) {
          enemies[j - 1].drawEnemy();
          fill(GRAPE);
          text(questions.get(quizIndex).getAnswers().get(j-1), (enemies[j-1].getEnemyX() + 50), (enemies[j-1].getEnemyY() + 75));
        }
      
        guess = 5;
      } catch(IndexOutOfBoundsException ex) {//appears to be triggering, seeing as the player returns to the start screen 
        scenario = 4;
        System.out.println("The quiz is over");
        fill(RASPBERRY);
        text("You win! Final Score: " + score, 450, 450);
      }
    }
    }
  }
}

/*  
 * Method: displayInst
 * 
 * Display a text at the upper left corner of the window, starting at coordinates (5, 25).
 */
public void displayInst() {
  
  textSize(40);
  fill(RED);
  text("Click to start game", 200, 450);
}

/*  
 * Method: displayScore
 * 
 * Display the score at the upper left corner of the window, starting at coordinates (5, 25).
 */
 
public void displayScore() {
  textSize(20);
  fill(RED);
  text("Score: " + score, 5, 25);
  text("Streak: " + streak, 5, 75); 
}





/**
 * Method: keyPressed
 *
 * Called when a key is pressed. 
 * 
 * If the key pressed is the ENTER key, start the game.
 */
public void keyPressed() {
  
  if (key == ENTER) {
    start = true;
    return;
  }
  
  if(start) {
  if(keyCode == UP) {
    if(!quizChosen) {
      quizName = "QuizQuestions.csv";
      quizChosen = true;
    } else {
      guess = 1;
    }
  }
  if(keyCode == DOWN) {
    if(!quizChosen) {
      quizName = "Variables.csv";
      quizChosen = true;
    } else {
      guess = 2;
    }
  }
  if(keyCode == LEFT) {
    if(!quizChosen) {
      quizName = "Strings.csv";
      quizChosen = true;
    } else {
      guess = 3;
    }
  }
  if(keyCode == RIGHT) {
    if(!quizChosen) {
      quizName = "Conditionals.csv";
      quizChosen = true;
    } else {
      guess = 4;
    }
  }
  
  //Up: 1, Down: 2, Left: 3, Right: 4
      guess --; //corrects for answers index for the sake of conventionality
  
  if(guess == correct) {
        streak++;
        scenario = 2;
        System.out.println("A correct guess was made");
        fill(RASPBERRY);
        text("That's correct!", 450, 450);
        score += possiblePoints;
        quizIndex++;
        possiblePoints = 1000;
        
      } else if((guess != 4) && (guess != correct)) { //recall that the default value for guess, 5, got reduced by one
        healthPoints--;
        streak = 0;
        
        if(healthPoints == 0) {
        scenario = 4;  
        System.out.println("Game over!");
        fill(RASPBERRY);
        text("Health points: " + healthPoints, 5, 50);
        fill(RASPBERRY);
        text("Game over... Final Score: " + score, 450, 450);
      } else {
          scenario = 3;
          System.out.println("An incorrect guess was made");
          fill(RASPBERRY);
          text("That's incorrect, try again!", 450, 450);
          possiblePoints -= 250;
        }
      }
  }
}

/**
 * Method: mouseClicked
 *
 * Called when mouses is clicked to start the game.
 */
public void mouseClicked(){
  start = true;
}


// loadQuestions, called upon startup 

public ArrayList<Question> loadQuestions() {
  ArrayList<Question> questions = new ArrayList<Question>();
  String fileRoot = "C:\\Users\\jtspo\\Downloads\\CircleDodge\\FruitRain\\FruitRain\\FruitRain-Folder\\FruitRain_Feb27th_BuildB\\FruitRain\\"; //change this line to match YOUR file path. DO NOT include the csv file name
  while(true) {
      try {
        String filePath = fileRoot + quizName;
        Scanner inputFile = new Scanner(new File(filePath)); 
        String regex = "(\\s)*,(\\s)*";
        inputFile.useDelimiter(regex);
        int index = 0;
        while(inputFile.hasNext()) {
          String question = inputFile.next();
          String id = inputFile.next();
          int type = Integer.parseInt(inputFile.next());
          String a1 = inputFile.next();
          String a2 = inputFile.next();
          ArrayList<String> answers = new ArrayList<String>();
          answers.add(a1);
          answers.add(a2);
          if(type == 1) {
            String a3 = inputFile.next();
            String a4 = inputFile.next();
            answers.add(a3);
            answers.add(a4);
          }
          int correct = Integer.parseInt(inputFile.next());
          questions.add(new Question(question, id, type));
          questions.get(index).setAnswers(answers);
          questions.get(index).setCorrect(correct);
          index++;
        }
        inputFile.close();
        break;
      } catch(FileNotFoundException ex) {
        System.out.println("Life is hard");
        break;
      }
    }
    return questions;
}
