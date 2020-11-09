//
//  UserProfile.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/4/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit
import SwiftUI
import Firebase

struct UserProfile: View {
    // Sign Out Error
    @State var error = ""
    // Action Sheet Showing
    @State private var showingSheet: Bool = false
    // Profile Data
    @ObservedObject var profileData = ProfileDataModel()
    @State private var editing: Bool = false
    @State private var isValid: Bool = false
    @State private var savedSuccessfully: Bool = false
    @State private var saveButtonClicked: Bool = false
    // Environment
    @Environment(\.presentationMode) var presentationMode

    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    ZStack {
                        Image(systemName: "person")
                            .resizable()
                            .aspectRatio(contentMode: ContentMode.fit)
                            .clipShape(Circle())
                            .shadow(radius: 20)
                            .frame(maxWidth: 150, maxHeight: 150)
                        Button(action: {
                            // TODO: - Add UIPickerController Here
                        }) {
                            Image(systemName: "camera.fill")
                                .frame(alignment: Alignment.center)
                                .foregroundColor(Color(.white))
                                .aspectRatio(contentMode: ContentMode.fit)
                        }
                            .frame(width: 40, height: 40)
                            .background(Color.init(red: 77/255, green: 130/255, blue: 199/255))
                            .clipShape(Circle())
                            .offset(x: 50, y: 50)
                    } // ZStack End
                } // VStack End
                    .frame(height: 200)
                Form {
                    TextField("Name", text: $profileData.name)
                        .frame(height: 50)
                        .foregroundColor(Color(.black))
                        .disabled(self.editing ? false : true)
                    TextField("Email", text: $profileData.email)
                        .frame(height: 50)
                        .foregroundColor(Color(.black))
                        .keyboardType(.emailAddress)
                        .disabled(self.editing ? false : true)
                    TextField("Phone Number", text: $profileData.phone)
                        .frame(height: 50)
                        .foregroundColor(Color(.black))
                        .keyboardType(.phonePad)
                        .disabled(self.editing ? false : true)
                    TextField("Date of birth, ex: mm/dd/yyyy", text: $profileData.dob)
                        .frame(height: 50)
                        .foregroundColor(Color(.black))
                        .disabled(self.editing ? false : true)
                    TextField("Location", text: $profileData.location)
                        .frame(height: 50)
                        .foregroundColor(Color(.black))
                        .disabled(self.editing ? false : true)
                    Button(action: {
                        self.showingSheet = true
                    }) {
                        Text("Log Out")
                            .foregroundColor(Color.red)
                    }
                        .actionSheet(isPresented: self.$showingSheet) {
                            self.logOutActionSheet
                        }
                    Text(savedSuccessfully ? "Data was saved Successfully!" : "Data saving was Unsuccessful!")
                        .frame(height: 30)
                        .opacity(savedSuccessfully ? 1 : 0)
                        .foregroundColor(Color(savedSuccessfully ? .green : .red))
                } // Form End
                    .background(Color(.white))
            } // VStack End
                .navigationBarTitle(Text("Profile"), displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    self.editing.toggle()
                }, label: {
                    Text(self.editing ? "Cancel" : "Edit")
                        .foregroundColor(Color(.systemBlue))
                }), trailing: Button(action: {
                    if self.profileData.phone.isEmpty == false || self.profileData.dob.isEmpty == false {
                        self.saveButtonClicked = true
                        self.isValid = true
                        self.profileData.addUserData(to: .phoneNumber, with: self.profileData.phoneNumberText)
                        self.profileData.addUserData(to: .dateOfBirth, with: self.profileData.dob)
                        self.savedSuccessfully = true
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        self.saveButtonClicked = true
                        self.isValid = false
                        self.savedSuccessfully = false
                    }
                }, label: {
                    Text("Save")
                        .foregroundColor(Color(.systemBlue))
                        .opacity(self.editing ? 1.0 : 0.5)
                })
                    .disabled(self.editing ? false : true)
            )
        } // Navigation End
            .accentColor(Color(.clear))
            .edgesIgnoringSafeArea(.bottom)
        
    } // body End
    
    var logOutActionSheet: ActionSheet {
        ActionSheet(
            title: Text("Log Out").bold(),
            message: Text("Are you sure you want to Log Out?"),
            buttons: [
                ActionSheet.Button.cancel(Text("Close"), action: {
                    self.showingSheet = false
                }),
                ActionSheet.Button.destructive(Text("Log Out"), action: {
                    do {
                        try Auth.auth().signOut()
                        Constants.shared.loggedIn = false
                        DataRetriever().saveSetting(for: Constants.shared.loggedIn, forKey: "logInKey")
                        self.showingSheet = false
                        print("Logged Out!")
                    } catch let error {
                        self.error = error.localizedDescription
                    }
                })
        ])
    } // Log Out Sheet
} // View


struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
