//
//  ProductRowView.swift
//  CoolBlueChallenge
//
//  Created by Jude on 10/08/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductRowView: View {
    
    var product: Product?
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            if let urlString = product?.productImage,
               let url = URL(string: urlString) {
                WebImage(url: url)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 150)
                    .overlay(RoundedRectangle(cornerRadius: 3.0).stroke(Color.gray, lineWidth: 0.3))
                
            }
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text(product?.productName ?? "N/A")
                    .font(.system(size: 14, weight: .semibold))
                    .fontWeight(.bold)
                HStack(spacing: 5) {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.orange)
                        .font(.system(size: 12))
                    Text(product?.reviewInformation?.reviewSummary?.reviewAverage?.formatAverageRating() ?? "0.00")
                        .font(.system(size: 14, weight: .semibold))
                }
                
                ForEach(product?.uSPs ?? [], id: \.self){ tag in
                    Text("\u{2022} \(tag)")
                        .font(.system(size: 11, weight: .light, design: .monospaced))
                }
                
                Text("\u{20ac} \(Product.formatAmount(product?.salesPriceIncVat ?? 0.00) ?? "0.00")")
                    .font(.system(size: 14, weight: .heavy))
                    .padding(.bottom)
            })
            Spacer(minLength: 0)
        }.padding(15)
        
    }
}


struct ProductRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProductRowView()
    }
}
