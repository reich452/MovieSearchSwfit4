//
//  MovieError.swift
//  MovieSearchSwift4Skills
//
//  Created by Nick Reichard on 2/16/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import UIKit

enum MovieError: Error {
    case invalidUrl
    case requestFailed
    case jsonConversionFailure
    case imageDataFailure
}

enum Icon {
    
    case defaultPoser
    
    var defaultImage: UIImage {
        switch self {
        case .defaultPoser: return #imageLiteral(resourceName: "redditDefaultImage")
        }
    }
}

