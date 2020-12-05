//
//  FilterdImage.swift
//  UI-63
//
//  Created by にゃんにゃん丸 on 2020/12/05.
//

import SwiftUI
import CoreImage

struct FilterdImage: Identifiable {
    var id = UUID().uuidString
    var image : UIImage
    var filter : CIFilter
    var isEditable : Bool
    
}


