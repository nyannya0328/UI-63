//
//  ImagePicker.swift
//  UI-63
//
//  Created by にゃんにゃん丸 on 2020/12/05.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var picker : Bool
    @Binding var imagedata : Data
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        
        let view = PHPickerViewController(configuration: PHPickerConfiguration())
        view.delegate = context.coordinator
        return view
        
    }
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    class Coordinator : NSObject,PHPickerViewControllerDelegate{
        
        
        var parent : ImagePicker
        init(parent:ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if !results.isEmpty{
                
                
                if results.first!.itemProvider.canLoadObject(ofClass: UIImage.self){
                    
                    results.first?.itemProvider.loadObject(ofClass: UIImage.self) { (image, err) in
                        
                        DispatchQueue.main.async {
                            self.parent.imagedata = (image as! UIImage).pngData()!
                            self.parent.picker.toggle()
                            
                            
                        }
                        
                    }
                    
                    
                }
                
                
                
            }
            else{
                self.parent.picker.toggle()
                
                
            }
        }
        
        
    }
}


