//
//  ListingView.swift
//  Bookworm
//
//  Created by Sebastien REMY on 05/11/2022.
//

import SwiftUI

struct ListingView: View {

    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var reviews: FetchedResults<Review>
    
    @AppStorage("id") var id = 1
    
    var body: some View {
        List(reviews, selection: $dataController.selectedReview) { review in
            Text(review.reviewTitle)
                .tag(review)
        }
        .toolbar{
            Button(action: addReview) {
                Label("Add review", systemImage: "plus")
            }
        }
    }
    
    func addReview() {
        let review = Review(context: managedObjectContext)
        review.id = Int32(id)
        review.title = "Enter the title"
        review.author = "Enter the author"
        review.rating = 3
        
        id += 1
        
        dataController.save()
        
        dataController.selectedReview = review
    }
}

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        ListingView()
    }
}
