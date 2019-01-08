//This class is used to controls the servo for the camra 
public class CamControl {

  private float yRight; //joy stick poition value -1 to 1

  //Constructor initialize the values for the variables in this class 
  private void CamControl() {
    yRight = 0;
  }
  //get joy stick values for class
  public void getYRight(float yRight) {
    this.yRight = yRight;
  }
  //return new value 
  public int Control() {
    return (int)map(yRight, -1, 1, 0, 180);
  }
}
