//
//  pieview.swift
//  drawing
//
//  Created by  椒徒科技 on 16/3/14.
//  Copyright © 2016年 jiaotukeji. All rights reserved.
//

import UIKit

class pieview: UIView {

    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.setNeedsDisplay()
        
        //不重复加载labelzhan
      boolfox = false
    }
    
    var boolfox :Bool = true
    
    var pointX :CGFloat = 0.0
    var pointY :CGFloat = 0.0
    var datas :[Int] = []
    var pointy:CGFloat = 0.0
    var pointx:CGFloat = 0.0
    var pointtox:CGFloat = 0.0
    
    var  topAngle:CGFloat = 0.0
    
  
    var labelX : CGFloat = 0.0
    var labelY : CGFloat = 0.0
    
    var label1 : UILabel!
    var label12 : UILabel!
    var label123 : UILabel!
    var corol :UIColor!
    
    /**
                画图
     - parameter rect:
     */
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        
        /// 获取数组数量
        datas = [30,10,80,30]
        
        
        let w = self.bounds.size.width
        let h = self.bounds.size.height
        var radius :CGFloat = 80.0
        let center = CGPoint(x: w * 0.5 - 30.0, y: h * 0.5)
        var startA :CGFloat = 0
        var angle:CGFloat  =  0
        var endA :CGFloat =  -CGFloat.init(M_PI_2)
        var percentage:CGFloat = 0.0
        var totall:Int = 0
        
        for i in 0 ..< datas.count {
        totall += datas[i]
        }
        
        for i in 0 ..< datas.count {
            startA = endA
            let value = datas[i]
            percentage = CGFloat.init(value)/CGFloat.init(totall)
            angle = percentage *  CGFloat.init(M_PI) * 2 ;
            endA = startA + angle
            if (i == 0){
            }else if (i == 1) {
            radius = 60.0
            }else if (i == 2){
                radius = 20.0
            }else if (i == 3 ){
                radius = 40.0
            }
            
            if (boolfox){
             label1 = UILabel()
             label12 = UILabel()
             label123 = UILabel()
            }
            //画圆
    let path1 = UIBezierPath(arcCenter: center, radius: radius, startAngle: startA , endAngle: endA, clockwise: true)
      path1.addLine(to: center)
            //画线
             let path = CGMutablePath()
            pointX = center.x + radius *  sin( angle * 0.5 + topAngle )
            pointY = center.y + radius * -cos(angle * 0.5 + topAngle )
//           CGPathMoveToPoint(path, nil，pointX, pointY)
            let point = CGPoint(x:pointX,y:pointY)
              path.move (to: point)
          
            if  CGFloat(-M_PI_2) < endA && endA < 0 {
                pointx = 10
                pointtox = 90
                pointy = -30;
                
                labelX = pointX + pointtox * 0.5
                labelY = pointY + pointy
           
            } else if endA >= 0 && endA < CGFloat(M_PI_2){

                pointx = 10
                pointtox = 100
                   pointy = 30;
                if i == 0{
                    pointy = -30
                }
                
                labelX = pointX + pointtox * 0.5
                labelY = pointY + pointy
          
            } else if endA <= CGFloat(M_PI) && endA > CGFloat(M_PI_2){
                pointx = -10
                pointtox = -90
                
                labelX = pointX + pointtox
                labelY = pointY + pointy
            }else if endA <= CGFloat.init(M_PI) + CGFloat(M_PI_2) && endA > CGFloat(M_PI){
                pointx = -10
                pointy  = -40;
                pointtox = -90
                if i == 2{
                    pointy = 40
                }
                labelX = pointX + pointtox
                labelY = pointY + pointy
                
            }
                label1.frame =  CGRect(x: labelX, y: labelY - 16,width: 0, height: 0)
                label1.text = String(format: "%0.2f%%",percentage * 100)
                
                label1.textColor = UIColor.red
                label1.font = UIFont.systemFont(ofSize: 13)
                label1.sizeToFit()
                self.addSubview(label1)
                
                label12.frame =  CGRect(x: labelX , y: labelY  ,width: 0, height: 0)
                label12.text = "不及格"
                label12.font = UIFont.systemFont(ofSize: 13)
                label12.textColor = UIColor.red
                label12.sizeToFit()
                self.addSubview(label12)
            
                label123.frame = CGRect(x: label12.frame.maxX, y: pointY + pointy ,width: 0, height: 0)
                    label1.text = String(format: "%0.2f%%",percentage * 100)
                label123.text = "(\(datas[i])台)"
                label123.font = UIFont.systemFont(ofSize: 13)
                label123.textColor = UIColor.black
                label123.sizeToFit()
                self.addSubview(label123)
         
            //指定颜色
            if i == 0{
                corol = RGB(219, g: 75, b: 93)
                
            }else if i == 1{
               corol = RGB(246, g: 200, b: 108)
                     label12.text = "及格"
            }else if i == 2{
               corol = RGB(30, g: 174, b: 96)
                 label12.text = "优良"
            }else if i == 3{
              corol = RGB(68, g: 65, b: 99)
                
                label12.text = "未巡检"
            }
         
         //字体的颜色
            label1.textColor = corol
            label12.textColor = corol
            //扇形的颜色
//            corol.set()
            
//            CGPathAddLineToPoint(path, nil, pointX + pointx ,pointY  + pointy )
//            CGPathAddLineToPoint(path, nil, pointX + pointtox, pointY + pointy)
            path.addLine(to: CGPoint(x:pointX + pointx , y:pointY + pointy))
            path.addLine(to: CGPoint(x:pointX + pointtox ,y: pointY + pointy))
            
            topAngle = endA + CGFloat.init(M_PI_2)


            ctx?.addPath(path)
            ctx?.strokePath()
        
            path1.fill()
        self.randomColor().set()
        
      }
       
    }
    /**
     自定义颜色
     
     - parameter r:
     - parameter g:
     - parameter b:
     
     - returns:
     */
    func RGB(_ r:Int, g:Int, b:Int)->UIColor {
        return UIColor(red:(CGFloat(r) / 255.0), green:(CGFloat(g) / 255.0), blue:(CGFloat(b) / 255.0), alpha:1)
    }
    
    
    /**
     随机颜色
     
     - returns: color
     */
    func randomColor() ->UIColor{
        
        let r  = arc4random_uniform(256)
        let g  = arc4random_uniform(256)
        let b = arc4random_uniform(256)
        
    return  UIColor(red:CGFloat.init(r)/255.0, green:CGFloat.init(g)/255.0, blue:CGFloat.init(b)/255.0, alpha:1)
    }

    
    
    
}
