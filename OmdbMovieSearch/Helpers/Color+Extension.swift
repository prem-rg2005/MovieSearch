//
//  Color+Extension.swift
//  OmdbMovieSearch
//
//  Created by Prem Shankar Rajagopalan Nayar on 7/12/24.
//

import Foundation
import SwiftUI

extension Color {
    static let themeColor = AppColor()
}

struct AppColor {
    let bgColor = Color("Background")
    let primaryText = Color("PrimaryText")
    let secondaryText = Color("SecondaryText")
    let cellBg = Color("ListCell")
}
