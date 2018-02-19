//
//  ArrayExtention.swift
//  MovieSearchSwift4Skills
//
//  Created by Nick Reichard on 2/18/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import Foundation

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        
        return result
    }
}
