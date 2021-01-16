//
//  UIView-extension.swift
//  Instagrid
//
//  Created by Stéphane Rihet on 07/01/2021.
//

import UIKit

class ImageGrid: UIView {
    

    // converts a view into an image
    func createImage(_ view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0) //Creates a bitmap-based graphics context with the specified options
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false) //Renders a snapshot of the complete view hierarchy as visible onscreen into the current context.
        let image = UIGraphicsGetImageFromCurrentImageContext()//Returns an image from the contents of the current bitmap-based graphics context
        UIGraphicsEndImageContext()//Removes the current bitmap-based graphics context from the top of the stack.
        return image!
    }
}

