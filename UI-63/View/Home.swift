//
//  Home.swift
//  UI-63
//
//  Created by にゃんにゃん丸 on 2020/12/05.
//

import SwiftUI

struct Home: View {
    @StateObject var homedata = HomeViewModel()
    var body: some View {
        VStack{
            
            Spacer(minLength: 0)
            
            if !homedata.allImages.isEmpty && homedata.mainview != nil{
                Image(uiImage: homedata.mainview.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width)
                    
               
                    
                   
                
                Slider(value: $homedata.value)
                    .padding()
                    .opacity(homedata.mainview.isEditable ? 1 : 0)
                    .disabled(homedata.mainview.isEditable ? false : true)
                
                ScrollView(.horizontal, showsIndicators: false, content: {
                    
                    
                    HStack(spacing:25){
                        
                        ForEach(homedata.allImages){filterd in
                            Image(uiImage: filterd.image)
                                .resizable()
                                .frame(width: 150, height: 150)
                                
                                
                            
                                .onTapGesture {
                                    homedata.mainview = filterd
                                    homedata.value = 1.0
                                    
                                }
                            
                            
                            
                        }
                        
                    }
                    .padding()
                    
                })
                
                
            }
            
            else if homedata.imagedata.count == 0{
                
                Text("image")
                    
                    .fontWeight(.heavy)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.red)
                    .background(Color.blue)
                    .cornerRadius(20)
                    
                
            }
            else{
                
                ProgressView()
            }
            
            
        }
        .onChange(of: homedata.value, perform: { (_) in
            homedata.updateEffect()
        })
        .onChange(of: homedata.imagedata, perform: { (_) in
            homedata.allImages.removeAll()
            homedata.mainview = nil
            homedata.loadfilter()
        })
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing){
                
                Button(action: {homedata.imagepicker.toggle()}, label: {
                    Image(systemName: "photo")
                        .font(.title2)
                })
                
            }
       
        
        
        
            ToolbarItem(placement: .navigationBarTrailing){
                
                Button(action: {
                    
                    UIImageWriteToSavedPhotosAlbum(homedata.mainview.image, nil, nil, nil)
                    
                    
                }, label: {
                    Image(systemName: "square.and.arrow.down.fill")
                        .font(.title2)
                })
                .disabled(homedata.mainview == nil ? true : false)
                
            }
        })
        
        .sheet(isPresented: $homedata.imagepicker, content: {
            ImagePicker(picker: $homedata.imagepicker, imagedata: $homedata.imagedata)
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
