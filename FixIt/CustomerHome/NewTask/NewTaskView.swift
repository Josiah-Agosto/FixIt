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
    let newUser = userTaskCreationDate()
    // Environment
    @Environment(\.presentationMode) var presentationMode
    
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
                    Text(taskData.location)
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
                    // New Task stuff here
                    if self.taskData.name.isEmpty == false && self.detailField.isEmpty == false && self.taskData.email.isEmpty == false && self.taskData.location.isEmpty == false {
                        self.passed = true
                        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
                        self.newUser.getUserState(id: currentUserId) { (userState) in
                            let openOrders = dbReference.child("CustomerIssues").child("OutgoingIssues").child("byState").child(userState).child(currentUserId)
                            let userOpenOrderValues = ["sender": self.taskData.name, "taskName": self.taskNameField, "location": self.taskData.location, "description": self.detailField, "email": self.taskData.email, "dateAdded": self.newUser.dateAdded()]
                            openOrders.updateChildValues(userOpenOrderValues) { (error, reference) in
                                if error != nil {
                                    self.errorField = error!.localizedDescription
                                }
                                print("New Task Reference: \(reference)")
                                print("Added new Task")
                                
                            }
                            print("Passed constraints: \(self.passed)")
                        }
                    } else {
                        self.passed = false
                        print("Passed constraints: \(self.passed)")
                    } // Elses else
                }, label: {
                    Text("Add Task")
                })) // BarItems End
        } // NavigationView End
            .background(Color(.white))
            .edgesIgnoringSafeArea(.bottom)
    } // body End
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView()
    }
}


struct userTaskCreationDate {
    func dateAdded() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        formatter.string(from: currentDate)
        return formatter.string(from: currentDate)
    }
    
    
    func getUserState(id userId: String?, completion: @escaping (_ state: String) -> Void) -> Void {
        dbReference.child("Customers").child("UsersById").child(userId!).observeSingleEvent(of: .value, with: {
            (snapshot) in
            if let userDictionary = snapshot.value as? [String: Any] {
                let userState = userDictionary["state"] as? String ?? "Add State"
                completion(userState)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
