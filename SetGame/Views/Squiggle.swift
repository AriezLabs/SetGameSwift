//
//  Squiggle.swift
//  SetGame
//
//  Created by ariez on 15.07.20.
//  Copyright © 2020 AriezLabs. All rights reserved.
//

import SwiftUI

private struct SquiggleShape: Shape {
    // Not sure how to get a hold of geometry (needed to find proper width etc) besides passing it in here
    let geometry: GeometryProxy
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let width: CGFloat = min(self.geometry.size.width, self.geometry.size.height)
            let height = width
            
            // IDK what this does, not needed
            path.move(to: CGPoint(x: 0, y: 0))
            
            path.addLines([
                CGPoint(x: 0, y: 0.5 * height),
                CGPoint(x: width * 0.25, y: 0 * height),
                CGPoint(x: width * 0.5, y: 0.3 * height),
                CGPoint(x: width * 0.75, y: 0 * height),
                CGPoint(x: width, y: 0.5 * height),
            ])
            
            path.addArc(center: CGPoint(x: width * 0.5, y: 0.5 * height), radius: width / 2, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: false)
            

            path.addLine(to: CGPoint(x: width * 0.25, y: 0 * height))
        }
    }
}

struct Squiggle: View {
    let color: Color
    let fillOpacity: Double
    
    @ViewBuilder
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                SquiggleShape(geometry: geometry)
                    .stroke(lineWidth: Constants.outlineWidth(for: geometry))
                    .fill(self.color)
                    .aspectRatio(1, contentMode: .fit)
                
                SquiggleShape(geometry: geometry)
                    .fill(self.color)
                    .opacity(self.fillOpacity)
                    .aspectRatio(1, contentMode: .fit)
            }
        }
    }
}

struct Squiggle_Previews: PreviewProvider {
    static var previews: some View {
        Squiggle(color: .green, fillOpacity: 0.5)
    }
}
