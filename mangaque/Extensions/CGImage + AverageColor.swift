//
//  CGImage + AverageColor.swift
//  mangaque
//
//  Created by Artem Raykh on 15.09.2022.
//

import UIKit

public extension CGImage {
    func colors(at: [CGPoint]) -> [UIColor]? {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let bitsPerComponent = 8
        let bitmapInfo: UInt32 = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue
        
        guard let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: bitmapInfo
        ),
              let ptr = context.data?.assumingMemoryBound(to: UInt8.self) else {
            return nil
        }
        
        context.draw(
            self,
            in: CGRect(x: 0, y: 0, width: width, height: height)
        )
        
        return at.map { p in
            let i = bytesPerRow * Int(p.y) + bytesPerPixel * Int(p.x)
            
            let a = CGFloat(ptr[i + 3]) / 255.0
            let r = (CGFloat(ptr[i]) / a) / 255.0
            let g = (CGFloat(ptr[i + 1]) / a) / 255.0
            let b = (CGFloat(ptr[i + 2]) / a) / 255.0
            
            return UIColor(red: r, green: g, blue: b, alpha: a)
        }
    }
    
    func averageColorOf(rect: CGRect) -> UIColor {
        
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
        
        guard let colors = colors(at: points) else {
            return .clear
        }
        
        return colors.blend()
    }
}
