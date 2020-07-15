//
//  ContentView.swift
//  SetGame
//
//  Created by ariez on 13.07.20.
//  Copyright © 2020 AriezLabs. All rights reserved.
//

import SwiftUI

struct SetView: View {
    @ObservedObject var model: ViewModel
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct SetView_Previews: PreviewProvider {
    static var previews: some View {
        SetView(model: ViewModel())
    }
}
