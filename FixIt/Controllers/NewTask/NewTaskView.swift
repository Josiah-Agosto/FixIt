//
//  NewTaskView.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/2/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import SwiftUI

struct NewTaskView: View {
    // MARK: - Properties / References
    private var globalHelper = GlobalHelper.shared
    @State var mapHelper: LocationHelperClass?
    @State var locationManager = LocationManager.shared
    @State var taskNameField: String = ""
    @State var detailField: String = ""
    @State var emailField: String = ""
    @State var cityField: String = ""
    @State var stateField: String = ""
    @State var errorField: String = ""
    @State var passed: Bool = true
    private let newUser = NewTaskHelper()
    private let firebaseHelper = FirebaseHelperClass()
    // Objects
    @ObservedObject var taskData = TaskDataModel()
    @EnvironmentObject var presentedObject: PresentedObject
    // MARK: - View
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Task name", text: $taskNameField)
                        .foregroundColor(Color(.darkGray))
                    TextField("Details about your Task", text: $detailField)
                        .foregroundColor(Color(.darkGray))
                        .lineLimit(nil)
                }
                    .font(.headline)
                Section(header: Text("Email")) {
                    TextField("Email", text: $taskData.email)
                    .foregroundColor(Color(.darkGray))
                }
                    .font(.headline)
                Section(header: Text("Your Location")) {
                    TextField("Location", text: $taskData.location)
                    .foregroundColor(Color(.darkGray))
                }
                    .font(.headline)
                Text("\(errorField)")
                    .background(Color(.clear))
                    .foregroundColor(Color(.red))
                    .opacity(passed ? 1 : 0)
            } // Form End
                .navigationBarTitle(Text("New Task"), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    self.addNewTask()
                }, label: {
                    Text("Add")
                })) // BarItems End
        } // NavigationView End
            .background(Color(.white))
            .edgesIgnoringSafeArea(.bottom)
    } // body End
    
    // MARK: - Methods
    private func addNewTask() {
        if self.taskData.name.isEmpty == false && self.detailField.isEmpty == false && self.taskData.email.isEmpty == false {
            self.passed = true
            if self.taskData.location.isEmpty == true {
                // If location isn't there get their location.
                print("Empty Location.")
            }
            self.addingDataToDatabase()
            self.presentedObject.navigationController?.dismiss(animated: true, completion: nil)
        } else {
            self.passed = false
            errorCreatingTask()
        } // Elses else
    }
    
    private func errorCreatingTask() {
        if passed == false {
            self.errorField = "Please fill in all details."
        }
    }
    
    
    private func addingDataToDatabase() {
        let newTask = NewTask(id: Constants.shared.currentUser ?? "", taskName: taskNameField, description: detailField, email: String($taskData.name.wrappedValue), location: taskData.location, sender: String($taskData.name.wrappedValue), date: newUser.dateAdded())
        firebaseHelper.creatingANewIssue(task: newTask, location: newTask.location)
    }
    
}


struct NewTaskView_Previews: PreviewProvider {    
    static var previews: some View {
        NewTaskView()
    }
}
