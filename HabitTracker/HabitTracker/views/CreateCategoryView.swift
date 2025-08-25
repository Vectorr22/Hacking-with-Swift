//
//  CreateCategoryView.swift
//  HabitTracker
//
//  Created by Victor Manuel Tijerina Garnica on 20/08/25.
//

import SwiftUI

struct CreateCategoryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var categoryTitle = ""
    @State private var imageIndexSelection = 0
    let imagesName = ["journal","meditate","read","water"]
    var categories: Categories
    var body: some View {
        VStack(alignment:.leading){
            
            TextField("Name", text: $categoryTitle)
                .frame(maxHeight: 50)
                .padding()
                .background(.lightGreenMint)
                .clipShape(.buttonBorder)
                .padding(.bottom)
            
            
            
            
            
            Text("Picture of reference")
                .font(.title2)
                .padding(.top)
            
            HStack(alignment: .center) {
                Button {
                    if imageIndexSelection > 0 {
                        imageIndexSelection-=1
                    }
                    
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundStyle(.black)
                }
                
                Spacer()
                
                withAnimation{
                    Image(imagesName[imageIndexSelection])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 200)
                }
                    
                
                Spacer()
                    
                
                Button {
                    if imageIndexSelection < imagesName.count-1 {
                        imageIndexSelection += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .foregroundStyle(.black)
                }
            }.frame(maxWidth: .infinity).padding()
            
            Spacer()
            
            Button {
                let newCategory = Category(name: categoryTitle, image: imagesName[imageIndexSelection])
                categories.categories.append(newCategory)
                dismiss()
                
            } label: {
                Text("Save")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
            }.frame(maxWidth: .infinity, maxHeight: 50)
                .background(.brightGreen)
                .clipShape(.buttonBorder)
            
            
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .leading)
        .padding()
        .navigationTitle("Create a category")
    }
}

#Preview {
    CreateCategoryView(categories: Categories())
}
