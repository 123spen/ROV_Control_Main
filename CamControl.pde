

public class CamControl {

 private float yRight;
 
 private void CamControl(){
   yRight = 0;
 }
 
 public void getYRight(float yRight){
   this.yRight = yRight;
 }
 public int Control(){
   return (int)map(yRight, -1, 1, 0, 180);
 }
 
 
}
