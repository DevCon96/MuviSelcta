//
//  DesignSystem.swift
//  MuviSelcta
//
//  Created by Connor Jones on 10/02/2023.
//

import Foundation
import UIKit
import SwiftUI

fileprivate let blueHex: String = "#5D6497"
fileprivate let darkBlueHex: String = "#1C2765"
fileprivate let greyHex: String = "#C1AFAB"
fileprivate let yellowHex: String = "#FC944B"
fileprivate let orangeHex: String = "#F14E24"
fileprivate let whiteHex: String = "#F0EFF6"
fileprivate let blackHex: String = "#050831"

///This is used to statically define the apps colour scheme. This particular colour scheme was taken from
///an online resource
extension Color {
    static let brandLightBlue = Color(uiColor: UIColor(hex: blueHex) ?? .white)
    static let brandDarkBlue = Color(uiColor: UIColor(hex: darkBlueHex) ?? .white)
    static let brandGrey = Color(uiColor: UIColor(hex: greyHex) ?? .white)
    static let brandYellow = Color(uiColor: UIColor(hex: yellowHex) ?? .white)
    static let brandOrange = Color(uiColor: UIColor(hex: orangeHex) ?? .white)
    static let brandWhite = Color(uiColor: UIColor(hex: whiteHex) ?? .white)
    static let brandBlack = Color(uiColor: UIColor(hex: blackHex) ?? .white)
}

extension UIColor {
    static let brandLightBlue = UIColor(hex: blueHex) ?? .white
    static let brandDarkBlue = UIColor(hex: darkBlueHex) ?? .white
    static let brandGrey = UIColor(hex: greyHex) ?? .white
    static let brandYellow =  UIColor(hex: yellowHex) ?? .white
    static let brandOrange = UIColor(hex: orangeHex) ?? .white
    static let brandWhite = UIColor(hex: whiteHex) ?? .white
    static let brandBlack = UIColor(hex: blackHex) ?? .white
}
