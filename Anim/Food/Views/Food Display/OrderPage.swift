//
//  OrderPage.swift
//  Anim
//
//  Created by Manovski on 4/9/23.
//

import SwiftUI

struct OrderPage: View {
    @State private var quantity = 1
    @State private var selectedOption = "Small"
    @State private var selectedFlavor = "Chocolate"
    @State private var notes = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Order Now")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom)
            
            VStack(alignment: .leading) {
                Text("Quantity")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                
                HStack {
                    Button("-") {
                        if quantity > 1 {
                            quantity -= 1
                        }
                    }
                    .padding()
                    
                    Text("\(quantity)")
                        .font(.title2)
                        .padding(.horizontal, 20)
                    
                    Button("+") {
                        quantity += 1
                    }
                    .padding()
                }
            }
            .padding(.bottom, 20)
            
            VStack(alignment: .leading) {
                Text("Size")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                
                Picker(selection: $selectedOption, label: Text("")) {
                    Text("Small").tag("Small")
                    Text("Medium").tag("Medium")
                    Text("Large").tag("Large")
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding(.bottom, 20)
            
            VStack(alignment: .leading) {
                Text("Flavor")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                
                Picker(selection: $selectedFlavor, label: Text("")) {
                    Text("Chocolate").tag("Chocolate")
                    Text("Vanilla").tag("Vanilla")
                    Text("Strawberry").tag("Strawberry")
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding(.bottom, 20)
            
            VStack(alignment: .leading) {
                Text("Notes")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                
                TextEditor(text: $notes)
                    .frame(height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }
            .padding(.bottom, 20)
            
            Button(action: {}) {
                Text("Add to Cart")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(8)
            }
        }
        .padding()
        .navigationBarTitle("Order", displayMode: .inline)
    }
}
