/**
  *By Michael Mühlhaus _ www.muehlseife.de
  *have fun!
  *
  *This example shows how to give the camera to octane
  *!!!Important!!! Don't use the camer() in your sketch when exporting!! This transform the whole Raw scene!!!!
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
  *  Start octane, load your object and make all settinks, like materials, light, etc...
  *  Save the Scene in your sketch_folder as master.ocs (default settings)
  *
  *Start Rendering:
  *  set samples per pixel in setup oct.setCalculationsPerPixel(800);
  *  set the OctaneCamera in each Frame!
  *  exchange oct.exportObj(); with oct.startRendering(0,100); (startframe, numberofframes)
  *  go for a walk.......
  **/

import processing.opengl.*;


import muehlseife.*;

octaneRenderer oct;

PVector camPosition;
PVector camTarget;

int counter = 0;

void setup(){
  size(500,500,OPENGL);
  

  oct = new octaneRenderer(this);    
  oct.setCalculationsPerPixel(500);
  oct.setOctaneQuietMode(true);
  
  camPosition = new PVector(0,-60,300);
  camTarget = new PVector(0,-30,0);
  
  
  //oct.exportObj();
  oct.startRendering(0,130);  
}

void draw(){
  background(255);
  
  //When rendering disable the camera in your Scene and use the setCamera command instead! 
  oct.setOctaneCam(new PVector(camPosition.x + counter*2, camPosition.y - counter*0.8, camPosition.z), new PVector(camTarget.x + counter*1.2 , camTarget.y + counter*0.5, camTarget.z));
  oct.setOctaneCamFoV(71);
  //camera(camPosition.x + counter*2, camPosition.y - counter*0.8, camPosition.z, camTarget.x + counter*1.2 , camTarget.y + counter*0.5, camTarget.z, 0.0, 1.0, 0.0);
  
  oct.setMaterial("box1",100,100,100,255);
  box(50,50,50);
  translate(100,0,0);
  oct.setMaterial("sphere",100,100,100,255);
  sphere(50);
  translate(100,0,0);
  pushMatrix();
  rotateZ((counter*2)*(PI/180));
  oct.setMaterial("box2",100,100,100,255);
  box(30,60,50);
  popMatrix();
  translate(100,0,0);
  pushMatrix();
  rotateY((counter*4)*(PI/180));
  oct.setMaterial("box1");
  box(30,60,50);
  popMatrix();
  
  oct.setMaterial("floor",100,100,100,255);
  beginShape();
  texture(new PImage(500,500));
    vertex(-1000,25,-1000,0,500);
    vertex(1000,25,-1000,500,500);
    vertex(1000,25,1000,500,0);
    vertex(-1000,25,1000,0,0);
  endShape();
  
  counter ++;
  println(counter);
}
