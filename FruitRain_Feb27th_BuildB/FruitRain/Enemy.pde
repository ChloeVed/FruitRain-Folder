/**
 * Fruit Rain games's fruit class, Enemy.
 * 
 * @authors Justin Portillo, Dionys Del Rosario, Chloe Vedrine
 * @version 1.0 Course : STEC 4800, Spring 2023
 * 
 * Enemy class contains the attributes and methods for an enemy.
 */
public class Enemy {
  private int enemyStartingEdge; //enemy's random starting location (either x or y)
  private float enemyX;     //x coordinate of the center of the enemy circle
  private float enemyY;     //y coordinate of the center of the enemy circle
  private int enemySize;    //diameter of the enemy circle
  private float enemySpeed; //enemy's moving speed
  private float enemySpeedAdjustor = 0.5;  /* Use a value between 0.1 and 1.0 
to change the enemy speed. Smaller value will slow down the enemy, making
it easier for testing the game. */
//We probably want the "enemies" to either move very slowly or not move at all
  private FruitRain game;
  private int type;
  PImage img;
  private int pngWidth;
  private int pngHeight;
  //private int timeSinceSpawned;
  
  /**
   * Method: Enemy class constructor
   *
   * Initialize the attributes.
   * 
   */
  public Enemy(FruitRain game, int type) {
    this.type = type;
    this.game = game;
    spawnEnemy();
  }
  
  /**
   * Method: getEnemyX
   */
  public float getEnemyX() {
    return enemyX;
    
  }
  
  /**
   * Method: getEnemyY
   */
  public float getEnemyY() {
    return enemyY;
    
  }

  /**
   * Method: getEnemySize
   */
  public float getEnemySize() {
    return enemySize;
    
  }

  /**
   * Method: spawnEnemy
   *
   * This method will create an enemy circle just outside of the window.
   */
  public void spawnEnemy()
  {
    
    if(type == 1) //Apples, map to the UP input
    {
      pngWidth = 130;
      pngHeight = 169;
      enemySpeed = 4;
      enemySize = 169;
      img = loadImage("apple.png");
    }
    else if (type == 2) //Oranges, map to the DOWN input
    {
      pngWidth = 125;
      pngHeight = 125;
      enemySpeed = 9;
      enemySize = 125;
      img = loadImage("orange.png");
    }
    else if (type == 3) //Bananas, map to the LEFT input
    {
      pngWidth = 100;
      pngHeight = 180;
      enemySpeed = 4;
      enemySize = 180;
      img = loadImage("banana.png");
    }    
    else if (type == 4)    //Limes, map to the RIGHT input
    {
      pngWidth = 100;
      pngHeight = 100;
      enemySpeed = 6;
      enemySize = 100;
      img = loadImage("lime.png");
    }
    
    enemyStartingEdge = 2; //remnants of the original Circle Dodge game
    
    if(enemyStartingEdge == 2) //Spawn from Top Edge of the Window 
    {
      //set x to a random value between 0 and the window's width
      enemyX = 50 + random(0, game.width - 150); 
      //set y to be above the top edge of the window
      enemyY = 0 - enemySize - 5; 
    }

    image(img, enemyX, enemyY, pngWidth, pngHeight);
  }
  
  /**
   * Method: drawEnemy
   *
   * This method will move the enemy to its next location and 
   * then draw the circle representing the enemy.
   */
  public void drawEnemy()
  {
    //timeSinceSpawned ++;
    
    //calculate the shift from current location to the next
    float positionDelta = enemySpeed * enemySpeedAdjustor;
    
    if(outOfSight()) /*Currently meant to determine if an enemy
    leaves the game window and therefore whether or not to de-spawn/re-spawn them
    
    We will alter this method to always de-spawn the fruit (and depending on if it's
    a regular question or a bonus round, possibly penalize the player.
    We may choose to have fruit stationary for the regular questions
    */
    {
      spawnEnemy();
    }
    
    if (enemyStartingEdge == 2)//top spawn, move downward
    {
      //add change to the enemy's y coordinate
      enemyY += positionDelta;
    }
    
    image(img, enemyX, enemyY, pngWidth, pngHeight);
  }
  
  /**
   * Method: outOfSight
   *
   * This method will detect when the enemy moves out of the game window.
   * then draw the circle representing the enemy.
   *
   * @return whether the enemy's location will make the enemy disappear 
   *         from the game window
   */
  public boolean outOfSight()
  {
    //top spawned and disappeared into the bottom edge
    if (enemyStartingEdge == 2 && enemyY >= game.height + enemySize + 5)
    {
      return true;
    } 
    //bottom spawned and disappeared into the top edge
    else if(enemyY <= 0 - enemySize - 5)
    {
      return true;
    }
    
    return false;
  }
}
