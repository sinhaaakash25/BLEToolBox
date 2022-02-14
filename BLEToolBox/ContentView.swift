//
//  ContentView.swift
//  BLEToolBox
//
//  Created by Aakash Sinha on 09/02/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var username: String = ""
    
    @ObservedObject var bleManager = BLEManager()
    @State var progressValue: Float = 0.0
    
    var body: some View {
        
        
        
        NavigationView  {
            VStack(spacing: 0) {
                Text("Peripherals")
                    .font(.title)
                    .bold()
                
                ZStack {
                    // Background Color
                    Color(#colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1))
                    // Custom Search Bar (Search Bar + 'Cancel' Button)
                    HStack {
                        // Search Bar
                        HStack {
                            // Magnifying Glass Icon
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(.white))
                            
                            // Search Area TextField
                            TextField("searching", text: $username)
                                .tint(Color.white)
                                .accentColor(.white)
                                .foregroundColor(.white)
                        }
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                        .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)).cornerRadius(8.0))
                        
                        // 'Cancel' Button
                        Button(action: {
                            print("cancelled")
                        }, label: {
                            Text("Cancel")
                        })
                            .accentColor(Color.white)
                            .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 8))
                    }
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                }
                
                .frame(height: 50)
                
                
                List(bleManager.peripherals) { peripheral in
                    
                    HStack {
                        
                        ProgressBarView(progress: peripheral.rssi)
                            .frame(width: 40.0, height: 40.0)
                            .padding(5.0)
                            .padding(.trailing, 10)
                        
                        
                            NavigationLink(destination: DeviceDetailsView(peripheral: peripheral)) {
                                Text(peripheral.name)
                            }
                            .navigationBarHidden(true)
                            .navigationBarTitle("Peripherals", displayMode: .inline)
                            
                        
                        
                        
                        
                        
                        
                        
                    }
                    
                }
                
                .listStyle(PlainListStyle())
                
                
                HStack {
                    
                    Button(action: {
                        self.bleManager.startScanning()
                    }) {
                        Text("Start Scanning")
                            .foregroundColor(.white)
                            .font(.system(size: 15))
                    }
                    .buttonStyle(GrowingButton())
                    
                    Spacer()
                    
                    Button(action: {
                        self.bleManager.stopScanning()
                    }) {
                        Text("Stop Scanning")
                            .foregroundColor(.white)
                            .font(.system(size: 15))
                    }
                    .buttonStyle(GrowingButton())
                    
                    
                }
                
                .padding()
                Spacer()
            }
        }
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(#colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1)))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}



