//
//  ColorManager.swift
//  mangaque
//
//  Created by Artem Raykh on 21.09.2022.
//

import UIKit
import Foundation

class ColorManager: NSObject {
    
    let image: CGImage
    let context: CGContext?
    
    var width: Int {
        get {
            return image.width
        }
    }
    
    var height: Int {
        get {
            return image.height
        }
    }
    
    init(image: CGImage) {
        self.image = image
        self.context = ColorManager.createBitmapContext(img: image)
    }
    
    class func createBitmapContext(img: CGImage) -> CGContext {
        
        // Get image width, height
        let pixelsWide = img.width
        let pixelsHigh = img.height
        
        let bitmapBytesPerRow = pixelsWide * 4
        let bitmapByteCount = bitmapBytesPerRow * Int(pixelsHigh)
        
        // Use the generic RGB color space.
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // Allocate memory for image data. This is the destination in memory
        // where any drawing to the bitmap context will be rendered.
        let bitmapData = malloc(bitmapByteCount)
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
        let size = CGSize(width: CGFloat(pixelsWide), height: CGFloat(pixelsHigh))
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        // create bitmap
        let context = CGContext(
            data: bitmapData,
            width: pixelsWide,
            height: pixelsHigh,
            bitsPerComponent: 8,
            bytesPerRow: bitmapBytesPerRow,
            space: colorSpace,
            bitmapInfo: bitmapInfo.rawValue
        )
        
        // draw the image onto the context
        let rect = CGRect(x: 0, y: 0, width: pixelsWide, height: pixelsHigh)
        
        context?.draw(img, in: rect)
        
        return context!
    }
    
    func colorAt(x: Int, y: Int) -> UIColor {
        
        assert(0<=x && x<width)
        assert(0<=y && y<height)
        
        guard let pixelBuffer = context?.data else { return .white }
        let data = pixelBuffer.bindMemory(to: UInt8.self, capacity: width * height)
        
        let offset = 4 * (y * width + x)
        
        let alpha: UInt8 = data[offset]
        let red: UInt8 = data[offset+1]
        let green: UInt8 = data[offset+2]
        let blue: UInt8 = data[offset+3]
        
        let color = UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha)/255.0)
        
        return color
    }
    
    func averageColor(of rect: CGRect) -> UIColor {
        
        let points = [
            CGPoint(
                x: rect.minX,
                y: rect.minY
            ),
            CGPoint(
                x: rect.maxX,
                y: rect.minY
            ),
            CGPoint(
                x: rect.minX,
                y: rect.maxY
            ),
            CGPoint(
                x: rect.maxX,
                y: rect.maxY
            )
        ]
        
        let colors = points.compactMap { point -> UIColor in
            colorAt(
                x: Int(point.x),
                y: Int(point.y)
            )
        }
        
        return colors.blend()
    }
}
