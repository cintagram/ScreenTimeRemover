//
//  ContentView.swift
//  WDBRemoveThreeAppLimit
//
//  Created by Zhuowei Zhang on 2023-01-31.
//

import SwiftUI



struct ContentView: View {
    @State private var successful = false
    @State private var failedAlert = false
    @State private var successAlert = false
    @State private var applyText = " "
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    @State private var showAlert = false
    @State private var showAlert2 = false
    @State private var showAlert3 = false

    
    @State private var message = ""
    var body: some View {
        VStack {
            Text("PULSErvice Screentime Remover")
                .font(.title)
                .foregroundColor(Color.black)
            Text("Only works on KFD Exploit Compatible OS")
            Text("Original by BluStikOSX")
            Text("")
            Text("In order to delete the app, restart your device a third time (will fix glitch soon (hopefully))")

        }
        Spacer()
                VStack{
                    Button(action: {
                        do {
                            try FileManager.default.removeItem(atPath: "/var/mobile/Library/Preferences/com.apple.ScreenTimeAgent.plist")
                            print("Successfully deleted!")
                            showAlert2 = true
                        } catch {
                            self.errorMessage = error.localizedDescription
                            self.showErrorAlert = true
                            showAlert3 = true
                        }
                    }) {
                        Text("Delete Screentime (Restart Device After)")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 370, height: 35)
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                    .alert(isPresented: $showErrorAlert, content: {
                        Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                    })
                }
                .alert(isPresented: $showAlert2) {
                    Alert(title: Text("Completed"), message: Text("Now Restart Your Device and Screentime Will Be Gone!"), dismissButton: .default(Text("OK")))
                }
                .alert(isPresented: $showAlert3) {
                    Alert(title: Text("Failed"), message: Text("Sorry, I guess it didn't work :("), dismissButton: .default(Text("OK")))
                }
                    Text(message)
                    Button(action: {
                        grant_full_disk_access { error in
                            if let error = error {
                                print(error)
                                DispatchQueue.main.async {
                                    message = "Failed to get full disk access: \(error)"
                                }
                                return
                            }
                            if !patch_installd() {
                                print("Failed")
                                DispatchQueue.main.async {
                                    message = "Failed Exploit"
                                }
                                return
                            }
                            DispatchQueue.main.async {
                                message = "Success."
                            }
                        }
                    }) {
                        Text("Give Access")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 370, height: 35)
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Disclaimer"), message: Text("This app is for educational purposes only. I'm not responsible for any damage caused by this app. (Feel free to look over the code yourself and make fixes and/or additions.)"), dismissButton: .default(Text("OK")))
                    }
                HStack {
                    Button(action: {
                        if let url = URL(string: "https://github.com/cintagram/ScreenTimeRemover") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Text("Source Code!")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 185, height: 35)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                                Button(action: {
                                    if let url = URL(string: "https://github.com/zhuowei/WDBRemoveThreeAppLimit") {
                                        UIApplication.shared.open(url)
                                    }
                                }) {
                                    Text("Based off of!")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(width: 185, height: 35)
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                }
                
                }
                    .onAppear {
                        showAlert = true
                    }
            }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
