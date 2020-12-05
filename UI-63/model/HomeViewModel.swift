//
//  HomeViewModel.swift
//  UI-63
//
//  Created by にゃんにゃん丸 on 2020/12/05.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

class HomeViewModel: ObservableObject {
    @Published var imagepicker = false
    @Published var imagedata = Data(count: 0)
    
    @Published var allImages : [FilterdImage] = []
    
    @Published var mainview : FilterdImage!
    
    @Published var value : CGFloat = 1.0
    
    let filters : [CIFilter] = [
        
        CIFilter.sepiaTone(),CIFilter.comicEffect(),CIFilter.colorInvert(),
        CIFilter.colorMonochrome(),CIFilter.photoEffectFade(),CIFilter.gaussianBlur(),
        CIFilter.bloom()
        
 
    ]
    
    func loadfilter(){
        
        let context = CIContext()
        filters.forEach { (filter) in
            
        DispatchQueue.global(qos: .userInteractive).async{
            let ciimage = CIImage(data: self.imagedata)
            
            filter.setValue(ciimage!, forKey: kCIInputImageKey)
            guard let newimage = filter.outputImage else {return}
            
            let cgimage = context.createCGImage(newimage, from: newimage.extent)
            
            let iseditable = filter.inputKeys.count > 1
            
            
            let filterdata = FilterdImage(image: UIImage(cgImage: cgimage!), filter: filter, isEditable: iseditable)
            
            
            
            
            
        
            DispatchQueue.main.async {
                self.allImages.append(filterdata)
                
                if self.mainview == nil{
                    
                    self.mainview = self.allImages.first
                }
            }
        
        
        }
          
            
        }
    }
    
        
        
        
        

        
    
    
    
    func updateEffect(){
        
        let context = CIContext()
        
      
            
        DispatchQueue.global(qos: .userInteractive).async{
            let ciimage = CIImage(data: self.imagedata)
            let filter = self.mainview.filter
            
            filter.setValue(ciimage!, forKey: kCIInputImageKey)
            
            
            
            
            if filter.inputKeys.contains("inputradius"){
                filter.setValue(self.value * 10, forKey: kCIInputRadiusKey)
                
            }
            
            if filter.inputKeys.contains("inputIntensitykey"){
                
                
                filter.setValue(self.value, forKey: kCIInputIntensityKey)
            }
            
            
            guard let newimage = filter.outputImage else {return}
            
            let cgimage = context.createCGImage(newimage, from: newimage.extent)
            
            
            
            
            
            
            
        
            DispatchQueue.main.async {
                self.mainview.image = UIImage(cgImage: cgimage!)
               
            }
        
        
    }
    
    
    
}
    
    
    


    }

