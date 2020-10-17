import ketai.camera.*;
import ketai.cv.facedetector.*;


KetaiCamera camera;
KetaiSimpleFace[] faces;
boolean findFaces = false;
int MAX_FACES = 20;

void setup()
{
  orientation(LANDSCAPE);
  camera = new KetaiCamera(this, 1280, 768, 30);
  rectMode(CENTER);
  textAlign(CENTER);
  textSize(40);
  stroke(0, 255, 0);
  noFill();
}

void draw()
{
  background(0);
  if (camera != null)
  {
    image(camera, 0, 0);
    if (findFaces)
    {
      faces = KetaiFaceDetector.findFaces(camera, MAX_FACES);
      for (int i=0; i<faces.length; i++)
      {
        rect(faces[i].location.x, faces[i].location.y, faces[i].distance*2, faces[i].distance*2);
      }
      text("Faces found: " + faces.length, width/2, height*8/9);
    }
  }
}

void mousePressed() 
{
  if(!camera.isStarted())
    camera.start();
  if (findFaces)
    findFaces = false;
  else
    findFaces = true;
}

void onCameraPreviewEvent()
{
  camera.read();
}
