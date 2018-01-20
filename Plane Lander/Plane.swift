//
//  Plane.swift
//  Plane Lander
//
//  Created by Preston Meade on 11/14/17.
//  Copyright © 2017 com.preston.xc. All rights reserved.
//

import Foundation
import SpriteKit

class Plane : SKSpriteNode{
    
    var gear_down = true;
    var speed_dx : CGFloat = 0.0;
    var speed_dy : CGFloat = 0.0;
    var flaps = 0.0;
    var heading = 0.0;
    var lift = 1;
    var altitude : CGFloat = 00;
    var pitch_angle : CGFloat = 0.0;
    var speed_brake = false;
    var on_ground = false;
    var brake = true;
    var max_speed = 380;
    var cruise_speed = 280;
    var crashed = false;
    

    
    func add_pitch_angle(angle: CGFloat){
        var to_add = angle;
        if(altitude <= 0){
            
            if(angle < 0 || speed_dx < 30){
                to_add = 0;
            }
          
        }
        
        self.pitch_angle += to_add;
        self.zRotation = self.pitch_angle;
        
    
    }
    
    func spawn(){
        if(crashed){
        crashed = false;
        altitude = 500;
        speed_dx = 190;
        cruise_speed = 190;
        gear_down = false;
        speed_brake = false;
        brake = false;
        pitch_angle = 0;
        on_ground = false;
        }
    }
    
    func update(){
        
        if(!crashed){
        altitude += (pitch_angle * speed_dx);
        if(altitude < 0){
            altitude = 0;
            crashed = true;
            pitch_angle = 0;
            speed_dx = 0;
            speed_dy = 0;
        }
        speed_dx -= ((pitch_angle / 100) * speed_dx);
        
        if(speed_brake){
            speed_dx -= ( (speed_dx / 10) * 0.005);
        }
        
        
        speed_dy = (pitch_angle * speed_dx);
        
      //  altitude -= 9; // gravity
        
            if(speed_dx < 120){
              // altitude += 9;
            }
        
        var speed_up = CGFloat(cruise_speed) - speed_dx;
        
        //print(speed_up);
        
                speed_dx += CGFloat(speed_up) * 0.001 ;
        
        
        if( brake){
            speed_dx -= 1;
            if(speed_dx < 0){
                speed_dx = 0;
            }
        }
        
        }
        
        if(speed_dx > CGFloat(max_speed) ){
            speed_dx = CGFloat(max_speed);
        }
        if(cruise_speed > (max_speed)){
            cruise_speed = max_speed;
        }
        if(cruise_speed < 120){
            altitude -= 10;
        }

    }
    
    func get_stats() -> String{
        var stat_speed = round(speed_dx);
        var stat_altitude = round(altitude);
        var stat_pitch_angle = round(pitch_angle);
        
        return ("Speed: \(stat_speed)  \tAngle: \(stat_pitch_angle) \tAGL:  \(stat_altitude) \tSB: \(speed_brake) \tVS:  \(speed_dy) \tCRUISE:  \(cruise_speed) ");
        
    }
    
    override init(texture: SKTexture!, color: SKColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init(image: String) {
        self.init(imageNamed: image)
        
        var center_of_mass = SKShapeNode(circleOfRadius: 40);
        center_of_mass.fillColor = SKColor.red;
        center_of_mass.zPosition = 100;
        var bounds = SKShapeNode(rectOf: self.size);
        
        bounds.strokeColor = SKColor.red;
        
        
       // self.addChild(bounds);
       // self.addChild(center_of_mass);

        
        self.xScale = -1;
    }
    
    required init?(coder aDecoder: NSCoder) {
        // Decoding length here would be nice...
        super.init(coder: aDecoder)
    }
}
