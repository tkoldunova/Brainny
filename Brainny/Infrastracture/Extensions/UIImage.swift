//
//  UIImage.swift
//  Brainny
//
//  Created by Tanya Koldunova on 27.09.2024.
//

import UIKit
extension UIImage {
    // Function to create a new image by shifting the original image
    func imageWithOffset(x: CGFloat, y: CGFloat) -> UIImage? {
            // Keep the original image size
            let newSize = self.size
            
            // Create a context with the same size as the image
        UIGraphicsBeginImageContextWithOptions(newSize, false, 2)
            
            // Draw the image at the shifted position
            self.draw(at: CGPoint(x: x, y: y))
            
            // Capture the new image
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return newImage
        }
}

