//
//  GameScene.swift
//  Plane Lander
//
//  Created by Preston Meade on 11/14/17.
//  Copyright © 2017 com.preston.xc. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    
    
    var plane = Plane(image: "plane.png");
    
    var key_down:[String:Bool] = ["b":false]

    var last_update_time : TimeInterval = 0;
    var dt: TimeInterval = 0;

    var plane_stats = SKLabelNode();
    var background = SKSpriteNode();
    
    var ground = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 1000, height: 200));
    
    
    var runway = SKSpriteNode(imageNamed: "2drunway.png");
    
    var runway_line = SKShapeNode(rectOf: CGSize(width: 1000,height: 4));
    
    
    override func didMove(to view: SKView) {
        
        plane.zPosition = 10;
        self.addChild(plane);
        
        background.texture = SKTexture(imageNamed: "sky.png");
        background.size = self.size;
        background.zPosition = -1;
        background.color = SKColor.red;
        self.addChild(background);
        
  
        plane_stats.position.x = self.frame.minX + plane_stats.frame.width / 2;
        plane_stats.position.y = self.frame.minY;
        plane_stats.fontColor = SKColor.black;
        plane_stats.zPosition = 100;
        plane_stats.fontSize = 20;
        self.addChild(plane_stats);
        
        runway.position = CGPoint(x: 0, y: self.frame.minY );
        runway.size = CGSize(width: 8000, height: 200);
        self.addChild(runway);
        
        ground.fillColor = SKColor.green;
        ground.position.y = self.frame.minY;
        ground.position.x = self.frame.minX;
      //  ground.position = CGPoint(x: 0, y: self.frame.minY + 200);
        self.addChild(ground);
        
        
       // runway_line.positi
        runway_line.position.y -= (plane.frame.size.height / 2);
        self.addChild(runway_line);
        
    }
    
    func update_stats(){
        plane_stats.text = plane.get_stats()
        plane_stats.zPosition = 100;
        plane_stats.position.x = self.frame.minY + (plane_stats.frame.size.width / 2);
        plane_stats.position.y = self.frame.maxY - plane_stats.frame.size.height;


    }
    
    func touchDown(atPoint pos : CGPoint) {
        print(pos.y);
        if(pos.y > 0){
            plane.add_pitch_angle(angle: 0.005);
        }else{
            plane.add_pitch_angle(angle: -0.005);
        }
        update_stats();
    }
    
    func touchMoved(toPoint pos : CGPoint) {
      
    }
    
    func touchUp(atPoint pos : CGPoint) {
      
    }
    
    override func mouseDown(with event: NSEvent) {
        print("TOUCH");
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
    }
    
    override func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case 1:
            plane.speed_brake = !plane.speed_brake;
            break;
        case 11:
            plane.brake = !plane.brake;
            break;
        case 18:
            plane.cruise_speed -= (10);
            break;
        case 19:
            plane.cruise_speed += (1000);
            break;
        case 15:
            plane.spawn();
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    

    
    
    override func update(_ currentTime: TimeInterval) {
        
        if(last_update_time > 0){
            dt = currentTime - last_update_time;
        }else{
            dt = 0;
        }
        
        last_update_time = currentTime;

        
        plane.update();
        update_stats();
        
        
     
        runway.position.x -= (plane.speed_dx * 0.1);
        runway.position.y = -plane.altitude - runway.frame.height / 2 - plane.frame.height / 2 + 10;
        
        ground.position.y = runway.position.y - 100;

        if(runway.position.x + runway.frame.size.width < 0){
            runway.position.x = self.frame.maxX + (runway.size.width / 2);
        }
        print(runway.position.y);
     
        

    }
}
