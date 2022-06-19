//
//  Extensions.swift
//  Neflix Clone
//
//  Created by mohamed salah on 08/06/2022.
//

import Foundation


extension String {
    func CapitalizeFirstLetter () ->String{
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
