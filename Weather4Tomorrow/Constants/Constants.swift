//
//  Constants.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 07.02.25.
//

import Foundation

struct Constants {
    static let coordinates: [Coordinate] = [
        Coordinate(latitude: 53.619653, longitude: 10.079969),
        Coordinate(latitude: 53.080917, longitude: 8.847533),
        Coordinate(latitude: 52.378385, longitude: 9.794862),
        Coordinate(latitude: 52.496385, longitude: 13.444041),
        Coordinate(latitude: 53.866865, longitude: 10.739542),
        Coordinate(latitude: 54.304540, longitude: 10.152741),
        Coordinate(latitude: 54.797277, longitude: 9.491039),
        Coordinate(latitude: 52.426412, longitude: 10.821392),
        Coordinate(latitude: 53.542788, longitude: 8.613462),
        Coordinate(latitude: 53.141598, longitude: 8.242565)
    ]
    
    static let updateTime: UInt64 = 10_000_000_000
    static let cornerRadius: CGFloat = 20
}
