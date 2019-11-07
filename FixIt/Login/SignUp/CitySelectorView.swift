//
//  CitySelectorView.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/2/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import SwiftUI

struct CitySelectorView: View {
    @State var enteredCity = ""
    
    var body: some View {
        VStack {
            TextField("City", text: $enteredCity)
            List {
                Text("First")
            }
        }
    }
}

struct CitySelectorView_Previews: PreviewProvider {
    static var previews: some View {
        CitySelectorView()
    }
}
