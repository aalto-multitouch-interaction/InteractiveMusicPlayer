#include "ofApp.h"


//--------------------------------------------------------------
void ofApp::setup(){

    myMusic.load("Carol.m4a");

    ofBackground(0);

    radius = 250;

    sphere.setRadius(radius);
    sphere.setResolution(14);
    sphere.setPosition(0, 0, 0);

    planet = sphere.getMesh();
    planet.setMode(OF_PRIMITIVE_TRIANGLE_STRIP);
    
    int i, j = 0;
    for ( i = 0; i < 6; i++ )
    {
        
        c[i].r = ofRandom(1.0);
        c[i].g = ofRandom(1.0);
        c[i].b = ofRandom(1.0);

        v[i][0] = Verts[j] * 100.f;
        j++;
        v[i][1] = Verts[j] * 100.f;
        j++;
        v[i][2] = Verts[j] * 100.f;
        j++;
        
    }
    
    vbo.setVertexData( &v[0], 6, GL_STATIC_DRAW );
    vbo.setColorData( &c[0], 6, GL_STATIC_DRAW );
    vbo.setIndexData( &Faces[0], 24, GL_STATIC_DRAW );
    
    glEnable(GL_DEPTH_TEST);
    

//    miniSphere.setResolution();
    
    ofVec3f pos6(590,1077,0);
    ofVec3f pos7(445,1033,0);
    ofVec3f pos8(271,990,0);
    ofVec3f pos9(69,1068,0);
    ofVec3f pos10(216,1065,0);
    s6.setup(pos6);
    s7.setup(pos7);
    s8.setup(pos8);
    s9.setup(pos9);
    s10.setup(pos10);
 
    
}

//--------------------------------------------------------------
void ofApp::update(){


     if (myMusic.isPlaying() == true){
    rotationY += 1 * rotateSpeed;
    rotationX += 2 * rotateSpeed;
    rotationZ += 4 * rotateSpeed;

     }else{
//         rotationY = rotationY + 0.1 + dragDegree;
//         rotationX = rotationX + 0.1 + dragDegree;
//         rotationZ = rotationZ + 0.1 + dragDegree;
         rotationY = rotationY + 0.1;
         rotationX = rotationX + 0.1;
         rotationZ = rotationZ + 0.1;
     }
    
    if (isDrag == true){
         rotationY = rotationY + dragDegree;
         rotationX = rotationX + dragDegree;
         rotationZ = rotationZ + dragDegree;
    }
    
    starSpeed = ofMap(musicSpeed, 0, 2, 0, 5);

    s6.update(starSpeed);
    s7.update(starSpeed);
    s8.update(starSpeed);
    s9.update(starSpeed);
    s10.update(starSpeed);
    
}

//--------------------------------------------------------------
void ofApp::draw(){

    ofPushMatrix();
    ofTranslate(ofGetWidth()/2, ofGetHeight()/2);
    
    ofRotateXDeg(rotationX);
    ofRotateYDeg(rotationY);
    ofRotateZDeg(rotationZ);

//    vector<ofMeshFace> triangles = planet.getUniqueFaces();
    for(int i = 0; i < planet.getVertices().size(); i++){
        planet.addColor(ofFloatColor( float(i)/planet.getVertices().size(), 0.75, 1.0 - (float(i)/planet.getVertices().size()) ));
    }


    if (myMusic.isPlaying()==true){
        planet.drawVertices();
    }else{
        planet.drawWireframe();
    }

    
//    ofTranslate(ofGetWidth()/2, ofGetHeight()/2, 100);
    ofRotate(ofGetElapsedTimef() * 20.0, 0, 1, 0);
    glPointSize(10.f);
    vbo.drawElements( GL_TRIANGLES, 24);
    ofPopMatrix();
    
    //
    float smallColor = ofMap(myMusic.getPosition(),0,1,0,255);
    ofSetColor(255-smallColor, 255, smallColor);
    
    if (myMusic.isPlaying()==true){
        ofFill();
    }else{
        ofNoFill();
    }
    float a = 35;
    float r = 5;
    float angel=ofMap(myMusic.getPosition(),0,1,0,2*PI);
    float x = (radius + a) * (cos(angel)-1);
    float y = -(radius + a) * sin(angel);
    ofDrawCircle(ofGetWidth()/2-(radius+a)-x, ofGetHeight()/2+y, r);
    
//    ofTranslate(ofGetWidth()/2, ofGetHeight()/2);
//
//    float r=ofMap(myMusic.getPosition(),0,1,10,250);
//
//    miniSphere.setRadius(r);
//    miniSphere.setPosition(ofGetWidth()/2-(radius+a)-x, ofGetHeight()/2+y, 0);
//    miniSphere.draw();
//    miniPlanet = miniSphere.getMesh();
////    miniPlanet.setMode(OF_PRIMITIVE_TRIANGLE_STRIP);
//    miniPlanet.drawWireframe();
    
    //Stars
    
    ofVec3f pos1(584,51,0);
    ofVec3f pos2(435,95,0);
    ofVec3f pos3(345,60,0);
    ofVec3f pos4(199,125,0);
    ofVec3f pos5(65,50,0);
    s1.setup(pos1);
    s2.setup(pos2);
    s3.setup(pos3);
    s4.setup(pos4);
    s5.setup(pos5);
    leftStarColor = ofMap(musicVolume, 0, 1, 0, 255);
    s1.draw(leftStarColor,myMusic.isPlaying());
    s2.draw(leftStarColor,myMusic.isPlaying());
    s3.draw(leftStarColor,myMusic.isPlaying());
    s4.draw(leftStarColor,myMusic.isPlaying());
    s5.draw(leftStarColor,myMusic.isPlaying());


    rightStarColor = ofMap(musicSpeed, 0, 2, 0, 255);

    s6.draw(200,myMusic.isPlaying());
    s7.draw(200,myMusic.isPlaying());
    s8.draw(200,myMusic.isPlaying());
    s9.draw(200,myMusic.isPlaying());
    s10.draw(200,myMusic.isPlaying());

//    myStars.push_back(newStar);
    
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    cout << touch.x << endl;
    cout << touch.y << endl;

    }

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    
    if(touch.y < ofGetHeight()/4){
        
        diamondColor = ofMap(touch.x, 0, ofGetWidth(), 1, 0);
        musicVolume = ofMap(touch.x, 0, ofGetWidth(), 0, 1);
//        cout << musicVolume << endl;
        for ( int i = 0; i < 6; i++ )
        {
            c[i].r = ofRandom(1.0);
            c[i].g = diamondColor;
            c[i].b = ofRandom(1.0);
        }
        vbo.setColorData( &c[0], 6, GL_STATIC_DRAW );
        myMusic.setVolume(musicVolume);
    }
    
    
    if(touch.y > 3 * ofGetHeight()/ 4){
        
        rotateSpeed = ofMap(touch.x, 0, ofGetWidth(), 0, 2);
        musicSpeed = ofMap(touch.x, 0, ofGetWidth(), 0, 2);
//        cout << musicSpeed << endl;
        myMusic.setSpeed(musicSpeed);
    }
    
//    if (pow(touch.x-ofGetWidth()/2, 2) + pow(touch.y-ofGetHeight()/2,2)< pow(radius,2)){
//        isDrag = true;
//        distance = pow(touch.x-touchPoint.x, 2) + pow(touch.y-touchPoint.y, 2);
//        dragDegree = ofMap(distance,0, pow(2 * radius,2), 1, 45);
//
//    }
    
    
    ofVec2f vRef(1,0);
    ofVec2f v1(touch.x - ofGetWidth()/2, touch.y - ofGetHeight()/2);
    float angle = v1.angle(vRef);

    if ((pow(touch.x-ofGetWidth()/2, 2) + pow(touch.y-ofGetHeight()/2,2) < pow(radius+a+a,2))){
        float playhead = ofMap(angle, -180, 180, 1, 0);
        myMusic.setPosition(playhead);
        cout << playhead << endl;
    }
    
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){
    
    if (pow(touch.x-ofGetWidth()/2, 2) + pow(touch.y-ofGetHeight()/2,2) < pow(radius,2) && myMusic.isPlaying() != true){
        myMusic.play();
    }else if(pow(touch.x-ofGetWidth()/2, 2) + pow(touch.y-ofGetHeight()/2,2) < pow(radius,2) && myMusic.isPlaying() == true){
        myMusic.setPaused(true);
    }
}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}

