//
//  NewTaskView.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/2/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import SwiftUI
import Firebase
import CoreLocation

struct NewTaskView: View {
    // MARK: - Properties
    private var globalHelper = GlobalHelper.shared
    @State var mapHelper: MapHelperFunctions?
    @State var locationManager = LocationManager.shared
    @State var taskNameField: String = ""
    @State var detailField: String = ""
    @State var emailField: String = ""
    @State var cityField: String = ""
    @State var stateField: String = ""
    @State var errorField: String = ""
    @State private var stateSelection = 0
    @State private var passed: Bool = true
    // For Firebase, then to Table View
    @State private var userIssues = [:]
    // Data Model
    @ObservedObject var taskData = TaskDataModel()
    private var newUser = NewTaskFunctions()
    // Environment
    @Environment(\.presentationMode) var presentationMode
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
                    .foregroundColor(Color(.red))
                    .opacity(passed ? 0 : 1)
                    .background(Color(.secondarySystemBackground))
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
        if self.taskData.name.isEmpty == false && self.detailField.isEmpty == false && self.taskData.email.isEmpty == false && self.taskData.location.isEmpty == false {
            self.passed = true
            self.newUser.getUserState { (userState, userId) in
                self.addingDataToDatabase(with: userState ?? taskData.location, and: userId)
            } // getUserState End
        } else {
            self.passed = false
        } // Elses else
    }
    
    
    private func addingDataToDatabase(with state: String, and id: String) {
        print("State: \(state)")
        print("User Id: \(id)")
        // TODO: Fix this placing where to put issues. Should be, user UID -> Issues -> Issue
        let openIssues = Constants.dbReference.child("Users").child("byId").child(id).child("openIssues")
        let userOpenOrderValues = ["sender": self.$taskData.name, "taskName": self.$taskNameField, "location": self.$locationManager.userLocation , "description": self.$detailField, "email": self.$taskData.email, "dateAdded": self.newUser.dateAdded(), "myId": id, "myLatitude": self.newUser.getUsersLatitude(), "myLongitude": self.newUser.getUsersLongitude()] as [String : Any]
        self.userIssues = userOpenOrderValues
        openIssues.updateChildValues(self.userIssues) { (error, reference) in
            if error != nil {
                self.errorField = UserError.UpdatingValues.errorDescription!
            }
            self.globalHelper.addingToIssueCounter()
        }
    }
}


struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView()
    }
}
