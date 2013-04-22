/**
  *By Michael Mühlhaus _ www.muehlseife.de
  *have fun!
  *
  *Workflow:
  
  *Settup your sketch:
  *  Create a sketch, drwaing filled shapes (only filled faces are supported for now)
  *  import muehlseife.*; 
  *  create an variable: "octaneRenderer" for example oct;
  *  setup the variable: oct = new octaneRenderer(this);
  *  organize your geometry with "setMaterial()" and "setObject()"
  *  all geometry after a setMaterial()/setObject() will have this Material/ belong to this Group.
  *  OPTIONAL: you can change default settings of the exporter like scaleFactor, invertY, etc. 
  *
  *Export object:
  *  call "oct.exportObj();" in setup().
  *  IMPORTANT: disable all camera() if you want a clean export, because they transform the whole scene!!!!
  *
  *Settup Octane:
  *  Start octane, load your object and make all settinks, like materials, light, camera, etc...
  *  Save the Scene in your sketch_folder as master.ocs (default settings)
  *
  *Start Rendering:
  *  set samples per pixel in setup oct.setCalculationsPerPixel(800);
  *  exchange oct.exportObj(); with oct.startRendering(0,100); (startframe, numberofframes)
  *  go for a walk.......
  **/



import muehlseife.*;
import processing.opengl.*;

                      
public float Gravity=0.2;           
public float Damping=0.9;           
                                    
public int particlecount = 3;        

octaneRenderer oct;

int counter = 0;

  Particle[] P =  { 
  new Particle(300, 100,200, 20), 
  new Particle(280, 400,160, 50), 
  new Particle(400, 340,450, 30)
};

void setup()
{
  size (600,600,OPENGL);                  
  smooth(); 
  frameRate(25);  
  
  oct = new octaneRenderer(this);    
  oct.setCalculationsPerPixel(800);

  
  sphereDetail(20);
  
  //oct.exportObj();
  oct.startRendering(0,100);
}    



void draw()
{
  translate(0,0,-800);
  
  background(255); 
  
  oct.setMaterial("floor",100,100,100,255);
  beginShape();
  texture(new PImage(500,500));
    vertex(-5000,500,-5000,0,500);
    vertex(5000,500,-5000,500,500);
    vertex(5000,500,5000,500,0);
    vertex(-5000,500,5000,0,0);
  endShape();
  
  
                     
  for (int i=0; i<P.length; i++)      
  {
    //if(i < 2){oct.setMaterial("Glow",255,0,0,255);}
    //else{oct.setMaterial("NoGlow",0,255,0,255);}
    P[i].update();
    if(i == 0) oct.setMaterial("Ball0",255,0,0,255);
    if(i == 1) oct.setMaterial("Ball1",0,255,0,255);
    if(i == 2) oct.setMaterial("Ball2",0,0,255,255);
    P[i].display3D();  
    for(int j = i; j<P.length; j++){
      checkSphereCollision(P[i], P[j]);
    }  
  }
}



