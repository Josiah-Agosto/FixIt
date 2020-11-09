//
//  NewTaskView.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/2/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import SwiftUI
import Firebase

struct NewTaskView: View {
    // MARK: - Properties / References
    private var globalHelper = GlobalHelper.shared
    @State var mapHelper: MapHelperFunctions?
    @State var locationManager = LocationManager.shared
    @State var taskNameField: String = ""
    @State var detailField: String = ""
    @State var emailField: String = ""
    @State var cityField: String = ""
    @State var stateField: String = ""
    @State var errorField: String = ""
    @State var passed: Bool = true
    var newUser = NewTaskFunctions()
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
            .onAppear {
                self.locationManager.startLocating()
                self.mapHelper = MapHelperFunctions(locationManager: self.locationManager.locationManager)
                self.taskData.retrieveUserData()
            }
    } // body End
    
    // MARK: - Methods
    private func addNewTask() {
        if self.taskData.name.isEmpty == false && self.detailField.isEmpty == false && self.taskData.email.isEmpty == false {
            self.passed = true
            if self.taskData.location.isEmpty == true {
                self.newUser.getUserState { (userLocation, userId) in
                    self.addingDataToDatabase(with: self.taskData.location, and: userId)
                } // getUserState End
            }
            self.addingDataToDatabase(with: self.taskData.location, and: Constants.shared.currentUser!)
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
    /// Adding user data to Database.
    /// - Parameters:
    ///   - location: String
    ///   - id: String
    private func addingDataToDatabase(with location: String, and id: String) {
        let currentUserReference = Constants.shared.dbReference.child("Users").child("byId").child(Constants.shared.currentUser ?? "")
        let taskNameString = "\($taskData.name.wrappedValue)"
        let taskEmailString = "\($taskData.email.wrappedValue)"
        let newTask = NewTask(id: id, taskName: taskNameField, description: detailField, email: taskEmailString, location: location, sender: taskNameString, date: newUser.dateAdded())
        let newTaskDictionary = newTask.toAnyObject()
        currentUserReference.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.hasChild("openIssues") {
                self.appendingToTasks(with: currentUserReference.child("openIssues").childByAutoId(), and: newTask)
            } else {
                self.creatingANewTask(with: currentUserReference.child("openIssues").childByAutoId(), with: newTaskDictionary)
            }
        }
    }
    /// Call when there are no open issues.
    /// - Parameters:
    ///   - databaseReference: DatabaseReference
    ///   - data: [String: Any]
    private func creatingANewTask(with databaseReference: DatabaseReference, with data: [String: Any]) {
        databaseReference.updateChildValues(data) { (error, _) in
            if let error = error {
                print(error.localizedDescription)
            }
            globalHelper.addingToIssueCounter()
        }
    }
    /// Call when there is already open issues.
    /// - Parameters:
    ///   - reference: DatabaseReference
    ///   - data: NewTask
    private func appendingToTasks(with reference: DatabaseReference, and data: NewTask) {
        reference.updateChildValues(data.toAnyObject()) { (error, reference) in
            if let error = error {
                print("Updating Issue: \(error.localizedDescription)")
            }
            globalHelper.addingToIssueCounter()
        }
    }
    
}


struct NewTaskView_Previews: PreviewProvider {    
    static var previews: some View {
        NewTaskView()
    }
}
