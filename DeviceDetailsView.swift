//
//  DeviceDetailsView.swift
//  BLEToolBox
//
//  Created by Aakash Sinha on 10/02/22.
//

import SwiftUI

struct DeviceDetailsView: View {
    @ObservedObject var bleManager = BLEManager()
    var peripheral: Peripheral
    //var advertismentData: AdvertismentData
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1))
            VStack {
                
                Text(peripheral.name)
                    .font(.title)
                
                
                HStack {
                    Text("UUID:")
                        .font(.system(size: 15))
                    Text(peripheral.uuid)
                        .font(.system(size: 13))
                }
                
                
                
            }
            .foregroundColor(Color.white)
            .frame(width: UIScreen.main.bounds.width)
            .padding()
            
            
        }
        .frame(height: 100)
        
       // VStack(spacing: 10) {
        ZStack {
            Color(#colorLiteral(red: 0.937254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1))
            Text("Advertisement Data")
                
                .font(.system(size: 20))
                .foregroundColor(.white)
        }
        
        .frame(height: 40)
        
        
        
        VStack {
        
        if (!bleManager.advertismentArray.isEmpty) {
            
            List(bleManager.advertismentArray) { ad in
                VStack(alignment: .leading) {
                    
                    Text("\(ad.kCBAdvDataIsConnectable)")
                        .font(.system(size: 15))
                    Text("Is Device connectable?")
                        .font(.system(size: 13))
                }
                VStack(alignment: .leading) {
                    
                    Text("\(ad.kCBAdvDataLocalName)")
                        .font(.system(size: 15))
                    Text("Local Name")
                        .font(.system(size: 13))
                }
                VStack(alignment: .leading) {
                    
                    Text("\(ad.kCBAdvDataTimestamp)")
                        .font(.system(size: 15))
                    Text("TimeStamp")
                        .font(.system(size: 13))
                }
                VStack(alignment: .leading) {
                    
                    Text("\(ad.kCBAdvDataRxPrimaryPHY)")
                        .font(.system(size: 15))
                    Text("Primary PHY")
                        .font(.system(size: 13))
                }
                VStack(alignment: .leading) {
                    
                    Text("\(ad.kCBAdvDataTxPowerLevel)")
                        .font(.system(size: 15))
                    Text("Power Level")
                        .font(.system(size: 13))
                }
                
            }
            
            .listStyle(PlainListStyle())
            
            
        }
        }
        .frame(height: 250)
  
        
        VStack {
                if !bleManager.serviceUUID.isEmpty {
                    ZStack {
                        Color(#colorLiteral(red: 0.937254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1))
                    Text("Services")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                    }
                    .frame(height: 40)
                    
                    List(bleManager.serviceUUID) { service in
                        HStack {
                            Text("Service UUID:")
                                .font(.system(size: 15))
                            Text("\(service.uuid)")
                                .font(.system(size: 13))
                        }
                        
                    }
                    
                    .listStyle(PlainListStyle())
                    
                    
                }
                
  
        }
        .frame(height: 100)
            
        VStack {

                if !bleManager.characteristicArray.isEmpty {
                    ZStack {
                        Color(#colorLiteral(red: 0.937254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1))
                    Text("Characteristics")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                    }
                    .frame(height: 40)
                    
                    
                    ScrollView(showsIndicators: false) {
                    ForEach(0..<bleManager.characteristicArray.count) { c in
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Characteristic UUID:")
                                    .font(.system(size: 13))
                                Text("\(bleManager.characteristicArray[c].uuid)")
                                    .font(.system(size: 15))
                            }
                           
                            HStack {
                                Text("Properties:")
                                    .font(.system(size: 13))
                                Text("\(bleManager.characteristicArray[c].properties)")
                                    .font(.system(size: 15))
                            }
                            
                            
                            
                            HStack {
                                Text("Value:")
                                    .font(.system(size: 13))
                                Text("\(bleManager.characteristicArray[c].value)")
                                    .font(.system(size: 15))
                            }
                         
                            HStack {
                                Text("Notifying?:")
                                    .font(.system(size: 13))
                                Text("\(bleManager.characteristicArray[c].notifying)")
                                    .font(.system(size: 15))
                            }
                            Divider()
                        }
                        .padding(.leading, 20)
                        
                    }
                   
                    }
                    
                }
                
                
            }
        .frame(height: 250)
        }
        
        
        
        
        
        
        
    
    
    
}
    
    


