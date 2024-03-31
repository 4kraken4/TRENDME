//
//  CartView.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-28.
//

import SwiftUI

struct CartView: View {
    
    @Environment (\.presentationMode) var mode
    @EnvironmentObject var cartVM: CartViewModel
    @State private var items: [Item] = [
        Item(id: "124", itemID: 1, name: "Long sleeved shirt", image: "4995.jpg", unitPrice: 29.99, description: "The best for youth", tags: ["men", "trending"], category: Category.men),
        Item(id: "123", itemID: 2, name: "Long sleeved shirt", image: "4995.jpg", unitPrice: 29.99, description: "The best for youth", tags: ["men", "trending"], category: Category.men),
        Item(id: "12378", itemID: 3, name: "Long sleeved shirt", image: "4995.jpg", unitPrice: 29.99, description: "The best for youth", tags: ["men", "trending"], category: Category.men)
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .center) {
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Delivery Amount")
                                Spacer()
                                Text("Free")
                                    .font(.system(size: 24, weight: .semibold))
                                    .fontDesign(.rounded)
                            }
                            
                            Divider()
                            
                            HStack (alignment: .center) {
                                VStack (alignment: .leading){
                                    Text("Total Amount")
                                        .font(.system(size: 24))
                                    
                                    Text("Rs. \(cartVM.total.formatted())")
                                        .font(.system(size: 36, weight: .semibold))
                                }
                                
                                Spacer()
                                
                                Image(systemName: "cart.fill")
                                    .font(.system(size: 46))
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            
                        }
                        .padding(30)
                        .frame(maxWidth: .infinity)
                        .background(.black.opacity(0.1))
                        .clipShape(.rect(cornerRadius: 30))
                        .padding()
                        
                        
                        VStack {
                            ForEach (items, id: \.id) {item in
                                CartProductView(item: item, onDelete: { item in
                                    cartVM.removeFromCart(item: item)
                                })
                                .environmentObject(cartVM)
                            }
                        }
                        .padding()
                    }
                }
                Button{
                    // Make payment
                } label: {
                    Text("Make Payment")
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .frame(height: 80)
                        .background(.black.opacity(0.8))
                        .font(.system(size: 20, weight: .semibold))
                        .fontDesign(.rounded)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 28))
                        .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    CartView()
        .environmentObject(CartViewModel())
}


struct CartProductView : View {
    var item: Item
    var onDelete: (Item) -> Void
    @EnvironmentObject var cartVM: CartViewModel
    
    var body : some View {
        HStack(alignment: .center, spacing: 20) {
            ImageLoader(url: URL(string: item.image), placeholder: Image("5456_2"))
                .scaledToFit()
                .scaleEffect(1.7)
                .padding()
                .frame(width: 80, height: 80)
                .background(.white.opacity(0.5))
                .clipShape(.circle)
                .blendMode(.darken)
            
            VStack(alignment: .leading, spacing: 0) {
                
                Spacer()
                
                Text(item.name)
                    .font(.system(size: 14))
                    .fontDesign(.rounded)
                
                Spacer()
                
                Text(item.category.rawValue.localizedLowercase)
                    .font(.callout)
                    .foregroundStyle(.blue)
                    .fontDesign(.rounded)
                    .fontWeight(.light)
                
            }
            
            
            HStack(alignment: .center) {
                Text( "Rs.")
                    .font(.system(size: 14))
                    .fontDesign(.rounded)
                    .fontWeight(.none)
                Text( "\(item.unitPrice.formatted())")
                    .font(.system(size: 18))
                    .fontDesign(.rounded)
                    .fontWeight(.semibold)
            }
            
            
            Button {
                onDelete(item)
            } label: {
                Image(systemName: "trash")
                    .font(.system(size: 24))
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background {
            Color.black.opacity(0.1)
                .clipShape(.rect(cornerRadius: 24))
        }
    }
}
