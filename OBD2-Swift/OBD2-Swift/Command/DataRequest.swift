//
//  Command.swift
//  OBD2Swift
//
//  Created by Max Vitruk on 25/05/2017.
//  Copyright © 2017 Lemberg. All rights reserved.
//

import Foundation

public class DataRequest {
    
    var description:String
    
    init(from string: String) {
        self.description = string
    }
    
    convenience init(mode : Mode, pid : UInt8, param : String? = nil) {
        var description = ""
        
        if pid >= 0x00 && pid <= 0x4E {
            description = NSString.init(format: "%02lx %02lx", mode.rawValue, pid) as String
            
            //Additional for freeze frame request
            // 020C00 instead of 020C
            if mode == .FreezeFrame02 {
                description += "00"
            }
        }else {
            description = NSString.init(format: "%02lx", mode.rawValue) as String
        }
        
        if let param = param {
            description += (" " + param)
        }
        
        self.init(from: description)
    }
    lazy var data: Data? = {
        self.description.append(kCarriageReturn)
        return self.description.data(using: .ascii)
    }()
    
//    func getData() -> Data? {
//        description.append(kCarriageReturn)
//        return description.data(using: .ascii)
//    }
    
}