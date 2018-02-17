//
//  ImageExtension.swift
//  MovieSearchSwift4Skills
//
//  Created by Nick Reichard on 2/16/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadImage(imagePath: String) {
        
        guard let url = URL(string: imagePath) else {
            print("Invalid URL")
            return
        }
    }
    
    
}
