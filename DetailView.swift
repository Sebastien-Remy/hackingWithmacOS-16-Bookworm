//
//  DetailView.swift
//  Bookworm
//
//  Created by Sebastien REMY on 05/11/2022.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var review: Review
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        Form {
            TextField("Title", text: $review.reviewTitle)
            TextField("Author", text: $review.reviewAuthor)
            
            Picker("Rating", selection: $review.rating) {
                ForEach(1..<6) {
                    Text(String($0))
                        .tag(Int32($0))
                }
            }
            .pickerStyle(.segmented)
            
            TextEditor(text: $review.reviewText)
        }
        .onChange(of: review.reviewTitle, perform: dataController.enqueueSave)
        .onChange(of: review.reviewAuthor, perform: dataController.enqueueSave)
        .onChange(of: review.rating, perform: dataController.enqueueSave)
        .onChange(of: review.reviewText, perform: dataController.enqueueSave)
        .disabled(review.managedObjectContext == nil) // nil when review deleted
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let dataController = DataController()
        let review = Review(context: dataController.container.viewContext)
        DetailView(review: review)
            .environmentObject(dataController)
    }
}
