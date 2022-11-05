//
//  RenderView.swift
//  Bookworm
//
//  Created by Sebastien REMY on 05/11/2022.
//

import SwiftUI

struct RenderView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let review: Review
    
    var body: some View {
        VStack(spacing: 10) {
            Text(review.reviewTitle)
                .font(.system(.largeTitle, design: .serif))
            Text("by \(review.reviewAuthor)")
                .font(.system(.title, design: .serif))
                .italic()
            HStack {
                ForEach(1..<6) { number in
                    Image(systemName: "star.fill")
                        .foregroundColor(number > review.rating ? .gray : .yellow)
                }
            }
            ScrollView {
                let markdownText: LocalizedStringKey = LocalizedStringKey(stringLiteral: review.reviewText)
                Text(markdownText)
            }
  
            Spacer()
                .frame(height: 50)
            Button("Done") {
                dismiss()
            }
        }
        .frame(maxWidth: 800)
        .padding(25)
    }
}

struct RenderView_Previews: PreviewProvider {
    static var previews: some View {
        let dataController = DataController()
        let review = Review(context: dataController.container.viewContext)
        RenderView(review: review)
    }
}
