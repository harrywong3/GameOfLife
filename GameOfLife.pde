import de.bezier.guido.*;
public final static int NUM_ROWS=35;
public final static int NUM_COLS=35;
private Life[][] buttons;
private boolean[][] buffer;
private boolean running = true;

public void setup () {
  size(700, 700);
  frameRate(6);
  Interactive.make( this );

  buttons = new Life[NUM_ROWS][NUM_COLS];
  for(int r=0; r<NUM_ROWS;r++){
  for(int c=0; c<NUM_COLS;c++){
  buttons[r][c]=new Life(r,c);}
  }
  buffer = new boolean[NUM_ROWS][NUM_COLS];
}

public void draw () {
  background( 0 );
  if (running == false)
    return;
  copyFromButtonsToBuffer();

  for(int r=0; r<NUM_ROWS;r++){
    for(int c=0; c<NUM_COLS;c++){
      if(countNeighbors(r,c)==3){
        buffer[r][c]=true;
        buttons[r][c].setDuration(1);}
      else if(countNeighbors(r,c)==2&&buttons[r][c].getLife()) {
        buffer[r][c]=true;
        buttons[r][c].setDuration(1);}
      else {
        buffer[r][c]=false;
        buttons[r][c].noDuration();}
  buttons[r][c].draw();}
  }
  copyFromBufferToButtons();
}

public void keyPressed() {
  if(running==true)running=false;
  else running = true;
}

public void copyFromBufferToButtons() {
  //your code here
  for(int r=0; r<NUM_ROWS;r++){
  for(int c=0; c<NUM_COLS;c++)
  buttons[r][c].setLife(buffer[r][c]);}
}

public void copyFromButtonsToBuffer() {
  for(int r=0; r<NUM_ROWS;r++){
  for(int c=0; c<NUM_COLS;c++)
  buffer[r][c]=buttons[r][c].getLife();}
}

public boolean isValid(int r, int c) {
  if (r<0||c<0)return false;
  if (r<NUM_ROWS&&c<NUM_COLS)return true;
  return false;
}

public int countNeighbors(int row, int col) {
  int neighbors = 0;
  for(int r=row-1;r<=row+1;r++){
    for(int c=col-1;c<=col+1;c++){
      if(isValid(r,c)==true&&buttons[r][c].getLife()==true)neighbors++;
    }
  }
  if (buttons[row][col].getLife()==true) neighbors--;
  return neighbors;
}

public class Life {
  private int myRow, myCol, duration;
  private float x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
     width = 700/NUM_COLS;
     height = 700/NUM_ROWS;
    myRow = row;
    myCol = col; 
    duration = 0;
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .5;
    Interactive.add( this );
  }
  public void mousePressed () {alive = !alive;}
  public void draw () {    
    if (alive != true){
      fill(0);
      rect(x, y, width, height);
    }
    else {
      fill( 150 );
    rect(x, y, width, height);
    if(duration>=15)
      {fill(250);
      rect(x+4,y+4,4,4);
      rect(x+12,y+4,4,4);
      rect(x+4,y+12,2,2);
      rect(x+14,y+12,2,2);
      rect(x+6,y+14,8,2);
      }
    }
  }
  public boolean getLife() {return alive;}
  public void setLife(boolean living) {alive = living;}
  public void noDuration() {duration=0;}
  
  public int setDuration(int change) {
    duration=duration+change;
    return duration;
  }
}
