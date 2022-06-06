//
//  DashBoadView.swift
//  UI-579
//
//  Created by nyannyan0328 on 2022/06/06.
//

import SwiftUI

struct DashBoadView: View {
    var props : Properties
    @Binding var showSlder : Bool
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            let showDetail = props.isIpad && !props.isSprit && props.isLandScape
            VStack{
                
                TopNavBar()
                
               
                
                
                VStack(spacing:15){
                    
                 

                    HStack{
                        
                        
                        Text("My files")
                            .font(.title3.weight(.semibold))
                        
                        
                        Spacer()
                        
                        
                        Button {
                            
                        } label: {
                            
                            Label {
                                
                                Text("Add Now")
                            } icon: {
                                
                                Image(systemName: "plus")
                                    .font(.title3)
                                
                            }

                        }
                        .foregroundColor(.white)
                        .padding(.vertical,9)
                        .padding(.horizontal)
                        .background{
                         
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color("Blue"))
                        }
                    }
                    .padding(.vertical,30)
                    
                    
                    OnlineStrageView()
                    
                    
                    FileView()
                        .padding(.top)
                    
                    
                    if !showDetail{
                        
                        StorageDetailView()
                        
                        
                    }
                    

                    
                    
                }
                .padding(.trailing,showDetail ? (props.size.width / 4) + 15 : 0)
                .overlay(alignment: .topTrailing) {
                    
                    
                    if showDetail{
                        
                        StorageDetailView()
                            .frame(width: props.size.width / 4)
                    }
                }
              
                
            }
            .padding()
        }
          .frame(maxWidth: .infinity,alignment: .center)
          .background{
           
              Color("BG").ignoresSafeArea()
          }
    }
    
    func getIndex(item : StorageDetail)->Int{
        
        return sampleStorageDetails.firstIndex { Ctem in
            
            Ctem.id == item.id
        } ?? 0
        
        
    }
    
    func getAngel(item : StorageDetail)->Angle{
        
        let index = getIndex(item: item)
        
        let prefixItems = sampleStorageDetails.prefix(index)
        
        var angle : Angle = .zero
        
        
        for item in prefixItems{
            
            
            angle += .init(degrees: item.progress * 360)
            
            
        }
        
        return angle
        
        
    }
    
    @ViewBuilder
    func StorageDetailView()->some View{
        
        
        VStack(alignment:.leading,spacing: 18){
            
            
            Text("Storage Details")
                .font(.title2.weight(.semibold))
            
            ZStack{
                
                
                Circle()
                    .stroke(Color("BG"),lineWidth: 25)
                
                ForEach(sampleStorageDetails){storage in
                    
                    
                    let index = CGFloat(getIndex(item: storage))
                    
                    let progress = index / CGFloat(sampleStorageDetails.count)
                    
                    
                    Circle()
                        .trim(from: 0, to: storage.progress)
                        .stroke(storage.progressColor,lineWidth: 35 - (10 * progress))
                        .rotationEffect(.init(degrees: -90))
                        .rotationEffect(getAngel(item: storage))
                    
                }
                
                
                
            }
            .frame(height: 200)
            .padding()
            .padding(.bottom,10)
            
            
            ForEach(sampleStorageDetails){item in
                
                
                HStack(spacing:15){
                    
                    
                    Image(item.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                    
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
                        Text(item.type)
                            .font(.caption.weight(.bold))
                        
                        Text(item.files + "Files")
                            .font(.callout.weight(.semibold))
                            .foregroundColor(.gray)
                        
                    }
                      .frame(maxWidth: .infinity,alignment: .leading)
                    
                    
                    Text(item.size)
                        .font(.callout.weight(.bold))
                        .foregroundColor(.white)
                }
                .padding()
                .background{
                 
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .strokeBorder(.white.opacity(0.3))
                }
            }
            
            
        }
      .frame(maxWidth: .infinity,alignment: .leading)
      .padding()
      .background{
       
          
          RoundedRectangle(cornerRadius: 10, style: .continuous)
              .fill(Color("Overlay"))
      }
        
        
    }
    
    @ViewBuilder
    func FileView()->some View{
        
        VStack(alignment: .leading, spacing: 13) {
            
            
            Text("Recent Files")
                .font(.title3.weight(.semibold))
                .foregroundColor(.white)
            
            
            HStack(spacing:0){
                
                ForEach(["File Name","Date","Size"],id: \.self){type in
                    
                    
                    
                    Text(type)
                        .italic().bold()
                        .frame(maxWidth: .infinity,alignment: type == "File Name" ? .leading : .center)
                        .foregroundColor(.white)
                }
            }
            
            
            
            Rectangle()
                .fill(.white.opacity(0.3))
                .frame(height: 2)
                .padding(.horizontal,-15)
            
            
            ForEach(sampleFiles){file in
                
                HStack(spacing:15){
                    
                    Image(file.fileIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20)
                    
                    
                    Text(file.fileType)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(file.fileDate)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text(file.fileSize)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                .font(.system(size: props.isIpad ? 18 : 13, weight: .semibold))
                
                Rectangle()
                    .fill(.white.opacity(0.3))
                    .frame(height: 2)
                    .padding(.horizontal,-15)
                
                
                
            }
            
         
            
            
        }
        .padding()
        .frame(maxWidth: .infinity,alignment: .leading)
        .background{
         
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color("Overlay"))
        }
        
        
        
    }
    @ViewBuilder
    func DynamicLazyVGrit<Content : View>(count : Int,content : @escaping()->Content)->some View{
        
        
        let columnus1 = Array(repeating: GridItem(.flexible(),spacing: 10), count: 1)
        
        let columnus2 = Array(repeating: GridItem(.flexible(),spacing: 10), count: 2)
        
        
        if count == 1{
            
            LazyHGrid(rows: columnus1, spacing: 15) {
                
                content()
            }
            
        }
        else{
            
            LazyVGrid(columns: columnus2, spacing: 15) {
                
                content()
            }
            
            
            
        }
        
        
        
        
    }
    @ViewBuilder
    func OnlineStrageView()->some View{
        
        
        let count = (props.isIpad && !props.isSprit ? 1 : 2)
        
        
        DynamicLazyVGrit(count: count) {
            
            
            ForEach(sampleStorages){storage in
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    
                    
                    HStack{
                        
                        
                        Image(storage.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                            .padding(10)
                            .background{
                             
                                Circle()
                                    .fill(storage.progressColor.opacity(0.1))
                            }
                        
                        
                        Spacer(minLength: 0)
                        
                        
                        Button {
                            
                        } label: {
                            
                            Image(systemName: "ellipsis")
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundColor(.gray)
                                .rotationEffect(.init(degrees: -90))
                            
                            
                        }

                    }
                    
                    
                    Text(storage.title)
                        .font(.caption2.weight(.black))
                    
                    GeometryReader{proxy in
                        
                         let size = proxy.size
                        ZStack(alignment:.leading){
                            
                            
                            Capsule()
                                .fill(.white.opacity(0.6))
                            
                            Capsule()
                                .fill(storage.progressColor)
                                .frame(width: (storage.progress * size.width))
                        }
                        .frame(height: 5)
                        
                        
                      
                       
                            
                    }
                    
                    HStack{
                        
                        
                        Text("\(storage.fileCount) Files")
                            .font(.caption)
                        
                        Spacer(minLength: 5)
                        
                        
                        Text(storage.maxSize)
                        
                    }
                }
                .padding()
                .background{
                 
                    
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color("Overlay"))
                }
            }
            
        }
        
        
        
    }
    @ViewBuilder
    func TopNavBar()->some View{
        
        
        HStack(spacing:15){
            
            if props.isIpad && props.isLandScape{
                
                Text("Dash Board")
            }
            else{
                
                Button {
                    withAnimation(.easeOut){
                        
                        showSlder = true
                    }
                } label: {
                
                    Image(systemName: "line.3.horizontal")
                        .font(.title2)
                        .foregroundColor(.white)
                }

            }
            
            
            HStack{
                
                TextField("Search", text: .constant(""))
                    .padding(.leading,10)
                
                Button {
                    
                } label: {
                    
                    Image(systemName: "magnifyingglass")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding(10)
                        .background{
                         
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color("Blue"))
                        }
              
                        
                }

                
            }
            .background{
             
                RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .fill(Color("Overlay"))
            }
              .frame(width: 250)
              .frame(maxWidth: .infinity,alignment: .trailing)
            
            
            Button {
                
            } label: {
                Image("p1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            }

            
        }
        
        
    }
}

struct DashBoadView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
