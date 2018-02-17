//
//  MoiveError.swift
//  MovieSearchSwift4Skills
//
//  Created by Nick Reichard on 2/16/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import Foundation

enum MovieError: Error {
    case invalidUrl
    case requestFailed
    case jsonConversionFailure
    case imageDataFailure
}

