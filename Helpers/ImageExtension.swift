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
        
        let urlString = Query.shared.baseURL + imagePath
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            do {
                if let error = error { throw error }
                guard let data = data else { throw NSError() }
                
                guard let image = UIImage(data: data) else {
                    print("Could't find an image")
                    return
                }
                DispatchQueue.main.async {
                    self.image = image
                }
            } catch let error {
                print("Error fetcing image: \(#file) \(#function) \(error) \(error.localizedDescription)")
                return
            }
        }.resume()
    }
}
