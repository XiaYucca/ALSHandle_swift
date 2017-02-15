//
//  processImage.swift
//  processImage
//
//  Created by RainPoll on 2016/11/1.
//  Copyright © 2016年 RainPoll. All rights reserved.
//

import Foundation

import CoreImage

import PhotosUI


//extension UIImage {
//    
//
//    
//    ///对指定图片进行拉伸
//    func resizableImage(name: String) -> UIImage {
//        
//        var normal = UIImage(named: name)!
//        let imageWidth = normal.size.width * 0.5
//        let imageHeight = normal.size.height * 0.5
//        normal = resizableImage(withCapInsets: UIEdgeInsetsMake(imageHeight, imageWidth, imageHeight, imageWidth))
//        
//        return normal
//    }
//    
//    /**
//     *  压缩上传图片到指定字节
//     *
//     *  image     压缩的图片
//     *  maxLength 压缩后最大字节大小
//     *
//     *  return 压缩后图片的二进制
//     */
//    func compressImage(image: UIImage, maxLength: Int) -> NSData? {
//        
//        let newSize = self.scaleImage(image: image, imageLength: 300)
//        let newImage = self.resizeImage(image: image, newSize: newSize)
//        
//        var compress:CGFloat = 0.9
//        var data = UIImageJPEGRepresentation(newImage, compress)
//        
//        while (data?.count)! > maxLength && compress > 0.01 {
//            compress -= 0.02
//            data = UIImageJPEGRepresentation(newImage, compress)
//        }
//        
//        return data as NSData?
//    }
//    
//    /**
//     *  通过指定图片最长边，获得等比例的图片size
//     *
//     *  image       原始图片
//     *  imageLength 图片允许的最长宽度（高度）
//     *
//     *  return 获得等比例的size
//     */
//    func  scaleImage(image: UIImage, imageLength: CGFloat) -> CGSize {
//        
//        var newWidth:CGFloat = 0.0
//        var newHeight:CGFloat = 0.0
//        let width = image.size.width
//        let height = image.size.height
//        
//        if (width > imageLength || height > imageLength){
//            
//            if (width > height) {
//                
//                newWidth = imageLength;
//                newHeight = newWidth * height / width;
//                
//            }else if(height > width){
//                
//                newHeight = imageLength;
//                newWidth = newHeight * width / height;
//                
//            }else{
//                
//                newWidth = imageLength;
//                newHeight = imageLength;
//            }
//            
//        }
//        return CGSize(width: newWidth, height: newHeight)
//    }
//    
    /**
     *  获得指定size的图片
     *
     *  image   原始图片
     *  newSize 指定的size
     *
     *  return 调整后的图片
     */
//    func resizeImage(image: UIImage, newSize: CGSize) -> UIImage {
//        UIGraphicsBeginImageContext(newSize)
//        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
//        
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        return newImage!
//    }
//
//}


extension UIImage {
    /**
     *  重设图片大小
     */
    func reSizeImage(_ reSize:CGSize)->UIImage {
        UIGraphicsBeginImageContext(reSize);
        //UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        //CGRectMake(0, 0, reSize.width, reSize.height)
        
        self.draw(in:CGRect(x:0,y:0,width:reSize.width,height:reSize.height));
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        
        let info = self.cgImage?.bitmapInfo
        
        //      let CGContext
        
        
        
        print("info _------\(info!)");
        
        return reSizeImage;
    }
    
    /**
     *  等比率缩放
     */
    func scaleImage(scaleSize:CGFloat)->UIImage {
        let reSize = CGSize(width:self.size.width * scaleSize, height:self.size.height * scaleSize)
        return reSizeImage(reSize)
    }
    
    func cutImage(rect:CGRect) -> UIImage {
        
        UIGraphicsBeginImageContext(self.size);
        
        return self;
        
    }
    
    /*
     
     //UIImage* ImageA;
     CGImageRef image = [ImageA CGImage];
     
     CGSize image_size = ImageA.size;
     
     CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
     void* data = malloc(image_size.width * image_size.height * 4);
     CGContextRef context =
     CGBitmapContextCreate(data, image_size.width, image_size.height, 8, 4 * image_size.width, colorSpace,
     kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
     CGContextDrawImage(context, CGRectMake(0, 0, leftwidth, image_size.height), image);
     /*
     data中就是你要得原始bmp图了, 没有文件头
     */
     CGContextRelease(context);
     free(data);
     
     
     fun  getImageByCuttingImage:( UIImage *)image Rect:( CGRect )rect{
     
     
     CGRect myImageRect = rect;
     
     UIImage * bigImage= image;
     
     CGImageRef imageRef = bigImage. CGImage ;
     
     CGImageRef subImageRef = CGImageCreateWithImageInRect (imageRef, myImageRect);
     
     CGSize size;
     
     size. width = rect. size . width ;
     
     size. height = rect. size . height ;
     
     UIGraphicsBeginImageContext (size);
     
     CGContextRef context = UIGraphicsGetCurrentContext ();
     
     CGContextDrawImage (context, myImageRect, subImageRef);
     
     UIImage * smallImage = [ UIImage imageWithCGImage :subImageRef];
     
     UIGraphicsEndImageContext ();
     
     return smallImage;*/
}




class processImage: NSObject {
    
    var fileM:FileManager = FileManager.default;
    var filePath:NSString?;
    
    
    init(filePath:String) {
        super.init();
        
        fileM = FileManager.default;
        var list:Array<String>? = nil;
        
        list = self.fileM.subpaths(atPath: filePath)as Array<String>?
        
        print("start filepath")
        
        for var path in list!{
            
            if path.contains(".png") {
                
                let newPath = path
                
                while path.contains("@2x.") {
                    path.replaceSubrange(path.range(of: "@2x.")!, with: ".");
                    while path.contains("@3x.") {
                        path.replaceSubrange(path.range(of: "@3x.")!, with: ".");
                    }
                }
                while path.contains("@3x.") {
                    path.replaceSubrange(path.range(of: "@3x.")!, with: ".");
                    
                    while path.contains("@2x.") {
                        path.replaceSubrange(path.range(of: "@2x.")!, with: ".");
                    }
                    
                }
                
//                if path.contains("3x/"){
//                    path.replaceSubrange(path.range(of: ".png")!, with: "@3x.png");
//                }
                
                if path.contains("2x/") {
                    
                    let testFilePath = filePath.appending("/\(newPath)")
                    
                    let testFileP = URL.init(fileURLWithPath: testFilePath);
                    
                    let dp = try! Data.init(contentsOf: testFileP)
                    var image = UIImage.init(data:dp)
                    print(image)
                    let nimage = image?.scaleImage(scaleSize: 1)
                    print(nimage)
                    let pdata = UIImagePNGRepresentation(nimage!);
                    print(pdata);
                    try! pdata?.write(to: URL.init(fileURLWithPath: filePath.appending("/\(newPath)")))
                    
                    path.replaceSubrange(path.range(of: ".png")!, with: "@2x.png");
                    
                }else {
                    path.replaceSubrange(path.range(of: ".png")!, with: "@3x.png");
                }
                
                print(path)
                try! self.fileM.moveItem(atPath: filePath.appending("/\(newPath)"), toPath: filePath.appending("/\(path)"))
            }
        }
        
        let de = try! self.fileM.contentsOfDirectory(atPath: filePath)
        
        
        
        
        //修改图片吃春 , 保存到文件中
        
        
        print(" directory \(de)");
        print(filePath)
        print(list);
        
    }
    /*  func testCoreImage(image:UIImage) {
     var img = CIImage.init(image: image);
     
     
     }
     */
}
