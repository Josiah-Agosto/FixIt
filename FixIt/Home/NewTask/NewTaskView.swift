//
//  NewTaskView.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/2/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import SwiftUI

struct NewTaskView: View {
    @State var nameField: String = ""
    @State var detailField: String = ""
    @State var emailField: String = ""
    @State var cityField: String = ""
    @State var stateField: String = ""
    @State private var stateSelection = 0
    @State private var passed: Bool = true
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Name", text: $nameField)
                    TextField("Details about your Task", text: $detailField)
                        .lineLimit(nil)
                }
                    .font(.headline)
                Section(header: Text("Email")) {
                    TextField("Email", text: $emailField)
                }
                    .font(.headline)
                Section(header: Text("City")) {
                    TextField("City", text: $cityField)
                }
                    .font(.headline)
                Section(header: Text("State")) {
                    Picker(selection: $stateSelection, label:
                        Text("Tap Selected State")
                    ){
                        ForEach(0 ..< usStates.count, id: \.self) { item in
                            Text(usStates[item]).tag(item)
                        }
                    } // Picker End
                } // Section End
                    .font(.headline)
                Text("Please complete all the Fields")
                    .foregroundColor(Color(.red))
                    .accessibility(hidden: true)
            } // Form End
                .navigationBarTitle(Text("New Task"), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    if self.nameField.count > 5 {
                        if self.detailField.count > 15 {
                            if self.emailField.contains("@") {
                                if self.cityField.count > 3 {
                                    // Save Data
                                    self.presentation.wrappedValue.dismiss()
                                } else {
                                    self.passed = false
                                }// cityField Else
                            } else {
                                self.passed = false
                            }// emailField Else
                        } else {
                            self.passed = false
                        }// detailField Else
                    } else {
                        self.passed = false
                    } // nameField Else
                }, label: {
                    Text("Add Task")
                })) // BarItems End
//                .navigationBarTitle("New Task")
        } // NavigationView End
            .edgesIgnoringSafeArea(.bottom)
            .moveDisabled(true)
    } // body End
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView()
    }
}
