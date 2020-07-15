//
//  ViewConstants.swift
//  SetGame
//
//  Created by ariez on 15.07.20.
//  Copyright © 2020 AriezLabs. All rights reserved.
//

import SwiftUI

struct Constants {
    static let outlineWidth: CGFloat = 10
    
    static func outlineWidth(for geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width * 0.025
    }
}
