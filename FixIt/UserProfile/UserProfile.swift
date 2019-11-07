//
//  UserProfile.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/4/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import SwiftUI
import Firebase

struct UserProfile: View {
    // Sign Out Error
    @State var error = ""
    // Action Sheet Showing
    @State private var showingSheet: Bool = false
    // Profile Data
    @ObservedObject var profileData = ProfileData()
    // Variables
    @State var phoneField = ""
    @State var dobField = ""
    @State var editing: Bool = false

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
                        .disabled(true)
                    TextField("Email", text: $profileData.email)
                        .frame(height: 50)
                        .foregroundColor(Color(.black))
                        .disabled(true)
                    TextField("Phone", text: $phoneField)
                        .frame(height: 50)
                        .foregroundColor(Color(.black))
                    TextField("Date of birth", text: $dobField)
                        .frame(height: 50)
                        .foregroundColor(Color(.black))
                    TextField("Location", text: $profileData.location)
                        .frame(height: 50)
                        .foregroundColor(Color(.black))
                        .disabled(true)
                    Button(action: {
                        self.showingSheet = true
                    }) {
                        Text("Log Out")
                            .foregroundColor(Color.red)
                    }
                        .actionSheet(isPresented: self.$showingSheet) {
                            self.logOutActionSheet
                        }
                } // Form End
                    .background(Color.white)
            } // VStack End
                .navigationBarTitle(Text("Profile"), displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    
                }, label: {
                    Text("Cancel")
                        .foregroundColor(Color(.systemBlue))
                }), trailing: Button(action: {
                    
                }, label: {
                    Text("Save")
                        .hidden()
                        .foregroundColor(Color(.systemBlue))
                }))
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
                        loggedIn = false
                        self.showingSheet = false
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
