#pragma once

#include "ofxiOS.h"
#include "Star.h"
#include <cmath>

const float Verts[] = {
    0.000f,  1.000f,  0.000f,
    -0.400f,  0.000f,  0.000f,
    0.000f,  0.000f,  0.400f,
    0.400f,  0.000f,  0.000f,
    0.000f,  0.000f,  -0.400f,
    0.000f,  -1.000f,  0.000f};

const ofIndexType Faces[] = {
    2, 1, 0,
    3, 2, 0,
    4, 3, 0,
    1, 4, 0,
    2, 1, 5,
    3, 2, 5,
    4, 3, 5,
    1, 4, 5};

//#include "ofxAssimpModelLoader.h"

class ofApp : public ofxiOSApp{
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
    
    ofTrueTypeFont myFont;
    
    ofSpherePrimitive sphere;
    
    float radius;
    float delta;
    
    ofMesh planet;
    
    ofEasyCam cam;
    
    float rotationX;
    float rotationY;
    float rotationZ;
    
    ofVec3f v[6];
    ofVec3f n[6];
    ofFloatColor c[6];
    ofVbo vbo;
    
    ofSoundPlayer myMusic;
    
    float diamondColor;
    float musicVolume;
    
    float rotateSpeed = 1;
    float musicSpeed;

    ofVec2f touchPoint;
    bool isDrag;
    float distance;
    float dragDegree;
    
    ofSpherePrimitive miniSphere;
    ofMesh miniPlanet;

    float a,x,y,r;

    vector <Star> myStars;
    
    float leftStarColor, rightStarColor, starSpeed;
    Star s1, s2, s3, s4, s5;

    Star s6, s7, s8, s9, s10;

};


