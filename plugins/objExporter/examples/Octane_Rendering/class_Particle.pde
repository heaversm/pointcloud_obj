//wir erstellen eine Klasse Partikel welcher "physikalisch" korrekt der Gravitation ausgesetzt sein soll
//       erweitern könnte man ihn um kollision und anziehungskraft untereinander wenn man will 
//       beispiele dazu findet man auf http://www.processing.org/learning/topics/ unter "Motion"

class Particle                        //Eröffnen der Klasse namens Particle
{      
  PVector pos, vel, a;                    //erstellen von 3 Vektoren (PVector) für p(position),v(velocity) und a(acceleration)
  float m;
  float r;
  
  Particle(float x, float y, float z, float r)          //Ein Particle kann mit den werten x und y (seine position) initialisiert werden.
  {
    pos = new PVector(x,y,z);             // x und y werden an der Positionsvektor übergeben
    vel = new PVector(0,0,0);             // die Vectoren v und a werden auf 0,0 initialisiert
    a = new PVector(0,0,0);
    
    this.r = r;
    m = r*.1;
  }
  
  void display()                      //Die Methode(funktion einer Klasse) "display" zeichnet den Partikel auf den Bildschirm
  {
    strokeWeight(8);                  
    stroke(0);
    point(pos.x,pos.y);
  }
  
  void display3D()
  {
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    sphere(r);
    popMatrix();
  }
  
  void update()                                              //Die Methode "update" errrechnet die neue Position des Partikels
  {
    PVector g = new PVector(0,Gravity);                      // wir erstellen einen PVector g(gravity) und setzten eine y coordinate auf "Gravity"(haben wir oben definiert);
    vel.add(a);                                                // Nun addieren wir a(acceleration) zum Geschwindigkeitsvektor v
    vel.add(g);                                                // und den Vektor g(für gravity) ebenfalls
    pos.add(vel);                                                // anschließend wird die Position um die Geschwindigkeit erhöht 
    
    
    //if (pos.y>500)                                             // Sollte die y.Position des Partikels größer als 500 sein (unterer Boden)
    //  {
    //    pos.y=500;                                             // Setzte die Position aif 500; -> der Partikel kann nicht unter 500 fallen;
     //   vel.y*=-1*Damping;                                     // Drehe die y-Coordinate des Geschwindikeitsvektors um (damit er wieder nach oben springt) und Multipliziere in mit der Reibung
      //  vel.x*=Damping;                                        // Die Reibung wird auch zur x-Coordinate des Vektors addiert.
     // }
      
    //if (pos.y<0) {pos.y = 0; vel.y*=-1*Damping; vel.x*=Damping;}     //-> Die kommenden 3 Zeilen entsprechen dem if(){} Drüber. Sie behandeln die Anderen 3 "Wände" unserer Kiste
    //if (pos.x<0) {pos.x=0; vel.x*=-1*Damping; vel.y*=Damping;}
    //if (pos.x>600) {pos.x=600; vel.x*=-1*Damping; vel.y*=Damping;}
    checkBoundaryCollision(this);
  }
}

void checkSphereCollision(Particle a, Particle b){
  PVector Vdistance = new PVector();
  float Mdistance;
  float SumRadius;
  Vdistance = PVector.sub(a.pos,b.pos);
  Mdistance = Vdistance.mag();
  SumRadius = a.r + b.r;
  
  
  if(Mdistance<SumRadius){ //if collision
  
    //sphere a
    PVector x_axis = PVector.sub(a.pos,b.pos);
    x_axis.normalize();
    PVector vel1 = a.vel;
    float x1 = x_axis.dot(vel1);
    println(x1);
    PVector v1x = PVector.mult(x_axis,x1);
    PVector v1y = PVector.sub(vel1,v1x);
    float m1 = a.m;
    
    //sphere b
    x_axis.mult(-1);
    PVector vel2 = b.vel;
    float x2 = x_axis.dot(vel2);
    PVector v2x = PVector.mult(x_axis,x2);
    PVector v2y = PVector.sub(vel2,v2x);
    float m2 = b.m;
    
    //vels berechnen
    a.vel = PVector.mult(v1x,((m1-m2)/(m1+m2)));
    a.vel.add(PVector.mult(v2x,((2*m2)/(m1+m2))));
    a.vel.add(v1y);
    
    b.vel = PVector.mult(v1x,((2*m1)/(m1+m2)));
    b.vel.add(PVector.mult(v2x,((m2-m1)/(m1+m2))));
    b.vel.add(v2y);
    
    
  }
}

//float boxWidth = 500;
float boxHeight = 500;
//float boxDepth = 500;

void checkBoundaryCollision(Particle ball) {
  //if (ball.pos.x > boxWidth-ball.r) {
   // ball.pos.x = boxWidth-ball.r;
   // ball.vel.x *= -1;
  //} 
  //else if (ball.pos.x < ball.r) {
  //  ball.pos.x = ball.r;
  //  ball.vel.x *= -1;
  //} 
  if (ball.pos.y > boxHeight-ball.r) {
    ball.pos.y = boxHeight-ball.r;
    ball.vel.y *= -1;
  } 
 // else if (ball.pos.y < ball.r) {
 //   ball.pos.y = ball.r;
  //  ball.vel.y *= -1;
 //}
//  if (ball.pos.z > boxDepth-ball.r) {
  //  ball.pos.z = boxDepth-ball.r;
  //  ball.vel.z *= -1;
 // } 
  //else if (ball.pos.z < ball.r+200) {
  //  ball.pos.z = ball.r;
   // ball.vel.z *= -1;
 // }
  
}
    
