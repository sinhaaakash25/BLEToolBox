//
//  BLEManager.swift
//  BLEToolBox
//
//  Created by Aakash Sinha on 09/02/22.
//

import Foundation
import CoreBluetooth

struct Peripheral: Identifiable {
    let id: Int
    let uuid: String
    let name: String
    let rssi: Int
    
}

struct ServiceUUID: Identifiable {
    let id: Int
    let uuid: String
}



struct Characteristics: Identifiable {
    let id: Int
    let uuid : String
    let properties: String
    let value: String
    let notifying : String
}

struct AdvertismentData : Identifiable {
    let id: Int
    let kCBAdvDataLocalName: String
    let kCBAdvDataRxPrimaryPHY: String
    let kCBAdvDataIsConnectable: String
    let kCBAdvDataTxPowerLevel: String
    
    let kCBAdvDataTimestamp: String
    
}

class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    var connectedPeripheral: CBPeripheral!
    var myCentral: CBCentralManager!
    @Published var isSwitchedOn = false
    @Published var peripherals = [Peripheral]()
    @Published var advertismentArray = [AdvertismentData]()
    @Published var serviceUUID = [ServiceUUID]()
    @Published var characteristicArray = [Characteristics]()
    
    
    
    override init() {
        super.init()
        
        myCentral = CBCentralManager(delegate: self, queue: nil)
        myCentral.delegate = self
    }
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        var msg = ""
        switch central.state {
        case .poweredOn:
            isSwitchedOn = true
            startScanning()
        case .poweredOff:
            isSwitchedOn = false
            msg = "Core Bluetooth is powered off"
            // Alert user to turn on Bluetooth
            
        case .unknown:
            msg = "unknown"
        case .resetting:
            msg = "unknown"
        case .unsupported:
            msg = "unknown"
        case .unauthorized:
            msg = "unknown"
            
        @unknown default:
            fatalError()
        }
        
    }
    
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        
        
        var target = "[LG] webOS TV UM7300PTA"
        
        print(peripheral.name)
        
        if peripheral.name == target {
            
            self.connectedPeripheral = peripheral
            
            myCentral.stopScan()
            
            myCentral.connect(peripheral, options: nil)
            
            
            let newPer = Peripheral(id: peripherals.count, uuid: peripheral.identifier.uuidString, name: peripheral.name ?? "Unknown" , rssi: RSSI.intValue)
            
            peripherals.append(newPer)
            advertismentArray = []
            var localName: String = ""
            var primary: String = ""
            var connected: String = ""
            var powerLevel: String = ""
            var timeStamp: String = ""
            
            if let adver = advertisementData["kCBAdvDataLocalName"] {
                localName = adver as! String
            }
            
            if let prima = advertisementData["kCBAdvDataRxPrimaryPHY"] {
                primary = "\(prima)"
            }
            
            if let connectable = advertisementData["kCBAdvDataIsConnectable"] {
                
                connected = "\(Bool(truncating: connectable as! NSNumber))"
            }
            
            if let power = advertisementData["kCBAdvDataTxPowerLevel"] {
                powerLevel = "\(power)"
            }
            
            if let time = advertisementData["kCBAdvDataTimestamp"] {
                timeStamp = "\(time)"
            }
            
            let newAd = AdvertismentData(id: peripherals.count, kCBAdvDataLocalName: localName , kCBAdvDataRxPrimaryPHY: primary , kCBAdvDataIsConnectable: connected, kCBAdvDataTxPowerLevel: powerLevel , kCBAdvDataTimestamp: timeStamp)
            
            advertismentArray.append(newAd)
            
            
        }
        
        
        
        else {
            
            advertismentArray = []
            
            
            let newPer = Peripheral(id: peripherals.count, uuid: peripheral.identifier.uuidString, name: peripheral.name ?? "Unknown" , rssi: RSSI.intValue)
            
            peripherals.append(newPer)
            
            
            var localName: String = ""
            var primary: String = ""
            var connected: String = ""
            var powerLevel: String = ""
            var timeStamp: String = ""
            
            if let adver = advertisementData["kCBAdvDataLocalName"] {
                localName = adver as! String
            }
            
            if let prima = advertisementData["kCBAdvDataRxPrimaryPHY"] {
                primary = "\(prima)"
            }
            
            if let connectable = advertisementData["kCBAdvDataIsConnectable"] {
                
                connected = "\(Bool(truncating: connectable as! NSNumber))"
            }
            
            if let power = advertisementData["kCBAdvDataTxPowerLevel"] {
                powerLevel = "\(power)"
            }
            
            if let time = advertisementData["kCBAdvDataTimestamp"] {
                timeStamp = "\(time)"
            }
            
            let newAd = AdvertismentData(id: peripherals.count, kCBAdvDataLocalName: localName , kCBAdvDataRxPrimaryPHY: primary , kCBAdvDataIsConnectable: connected, kCBAdvDataTxPowerLevel: powerLevel , kCBAdvDataTimestamp: timeStamp)
            
            advertismentArray.append(newAd)
            
            
        }
        
        
        
    }
    
    
    
    func startScanning() {
        myCentral.scanForPeripherals(withServices: nil, options: nil)
        print("startScanning")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.myCentral.stopScan()
            print("Scanning stop")
        }
        
        
    }
    
    func stopScanning() {
        print("stopScanning")
        myCentral.stopScan()
    }
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let servicePeripheral = peripheral.services {
           
            for servicePeripheral in servicePeripheral {
                
                print()
                let newj = ServiceUUID(id: peripheral.services!.count, uuid: "\(servicePeripheral.uuid)")
                serviceUUID.append(newj)
                
                print("peri data \(peripheral.services)")
                print("service \(servicePeripheral.uuid)")
               
                peripheral.discoverCharacteristics(nil, for: servicePeripheral)
            }
        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        if let charArr = service.characteristics {
            print("char are \(charArr)")
            
            
            
            
            for charactericsx in charArr {
               
                peripheral.setNotifyValue(true, for: charactericsx)
                peripheral.readValue(for: charactericsx)
                let newd = Characteristics(id: charArr.count, uuid: "\(charactericsx.uuid)", properties: "\(charactericsx.properties.rawValue)", value: "\(charactericsx.value)", notifying: "\(charactericsx.isNotifying)")
                characteristicArray.append(newd)
            }
            
            print("array \(characteristicArray[0])")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let data: Data = characteristic.value {
            print("data is \(data)")
        }
    }
    
}
