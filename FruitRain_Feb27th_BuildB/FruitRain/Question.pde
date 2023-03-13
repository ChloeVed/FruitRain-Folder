/*
 *  Fruit Rain games's question class, Question.
 * 
 * @authors Justin Portillo, Dionys Del Rosario, Chloe Vedrine
 * @version 1.0 Course : STEC 4800, Spring 2023'
 *
 * Contains all of the attributes of a question and necessary methods; works in tandem with the loadQuestions() method
 * found in FruitRain.pde
*/ 
import java.util.ArrayList;

public class Question {
  
  private String text;
  private String id; //never used, only present for the sake of organization when creating the questions spreadsheet
  private int type; //indicates whether the question has 4 answers (type 1), or 2 answers (type 2)
  private ArrayList<String> answers;
  private int correct;
  
  public Question(String text, String id, int type) {
    this.text = text;
    this.id = id;
    this.type = type;
    answers = new ArrayList<String>();
  }
  
  public String getText() {
    return this.text;
  }
  
  public void setAnswers(ArrayList<String> answers) {
    for(int i = 0; i < answers.size(); i++) {
      this.answers.add(answers.get(i));
    }
  }
  
  public void setCorrect(int index) {
    if(index > this.answers.size()) {
      //throw custom exception
    }
    else {
      correct = index;
    }
    
  }
  
  public ArrayList<String> getAnswers() {
    return this.answers;
  }
  
  public int getType() {
    return this.type;
  }
  
  public int getCorrect() {
    return this.correct;
  }
  
}
