//
//  UIImage + Crop.swift
//  mangaque
//
//  Created by Artem Raykh on 13.08.2022.
//

import UIKit

extension UIImage {
    func cropImage(cropWidth: CGFloat, cropHeight: CGFloat) -> UIImage {

            let contextImage: UIImage = UIImage(cgImage: self.cgImage!)

            let contextSize: CGSize = contextImage.size
            var cropX: CGFloat = 0.0
            var cropY: CGFloat = 0.0
            var cropRatio: CGFloat = CGFloat(cropWidth/cropHeight)
            var originalRatio: CGFloat = contextSize.width/contextSize.height
            var scaledCropHeight: CGFloat = 0.0
            var scaledCropWidth: CGFloat = 0.0

            // See what size is longer and set crop rect parameters
            if originalRatio > cropRatio {

                scaledCropHeight = contextSize.height
                scaledCropWidth = (contextSize.height/cropHeight) * cropWidth
                cropX = (contextSize.width - scaledCropWidth) / 2
                cropY = 0

            } else {
                scaledCropWidth = contextSize.width
                scaledCropHeight = (contextSize.width/cropWidth) * cropHeight
                cropY = (contextSize.height / scaledCropHeight) / 2
                cropX = 0
            }

            let rect: CGRect = CGRect(x: cropX, y: cropY, width: scaledCropWidth, height: scaledCropHeight)

            // Create bitmap image from context using the rect
            let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!

            // Create a new image based on the imageRef and rotate back to the original orientation

            let croppedImage: UIImage = UIImage(
                cgImage: imageRef,
                scale: self.scale,
                orientation: self.imageOrientation
            )

            return croppedImage
        }
}
