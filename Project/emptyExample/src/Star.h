#pragma once
#include "ofxiOS.h"

class Star{
public:
    void setup(ofVec3f myPoint){
        starPoint=myPoint;
        rotationSpeed = ofRandomf();
        rotationAngle = 20;
    }
//    void update(ofSoundPlayer myMusic){
//        void update(ofVec3f myAccel){
            void update(float starSpeed){

//        rotationAngle+=rotationSpeed;
        rotationAngle+=1*starSpeed;

//        starPoint.x+=myAccel.x;
//        starPoint.y-=myAccel.y;
//        starPoint.z+=myAccel.z;
    }
    void draw(float color, bool isPlaying){
        ofPushMatrix();
        //Animation
        ofTranslate(starPoint);
        ofRotateZDeg(rotationAngle);


        //Static drawing
        float r;
        float a;
        if (isPlaying == true){
            r = ofRandom(0,color);
            a = ofRandom(0,255);
        }else{
            r = color;
            a = 240;
        }
        
//        float b = ofRandom(0,255);

        //        ofSetColor(255,127);
        ofSetColor(r,a);
        
        ofDrawEllipse(0,0,50,3);
        //        ofDrawCircle(0, 0, 20);
        ofDrawEllipse(0,0,3,50);
        ofRotateZDeg(45);
        ofDrawEllipse(0,0,3,50);
        ofRotateZDeg(90);
        ofDrawEllipse(0,0,3,50);
        
        
        //End of matrix
        ofPopMatrix();
    }
    
    ofVec3f starPoint;
    float rotationAngle, rotationSpeed;
};

