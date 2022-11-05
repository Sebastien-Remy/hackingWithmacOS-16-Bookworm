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
//        .onDeleteCommand(perform: deleteSelected) // isn't called here Known bug that Apple are working to fix
        .contextMenu {
            Button("Delete", role: .destructive, action: deleteSelected)
        }
        .toolbar{
            Button(action: addReview) {
                Label("Add review", systemImage: "plus")
            }
            Button(action: deleteSelected, label: { Label("Delete", systemImage: "trash") })
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
    
    func deleteSelected() {
        guard let selectedReview = dataController.selectedReview else { return }
        guard let selectedIndex = reviews.firstIndex(of: selectedReview) else { return }
        managedObjectContext.delete(selectedReview)
        dataController.save()
        
        if selectedIndex < reviews.count {
            dataController.selectedReview = reviews [selectedIndex]
        } else {
            let previousIndex = selectedIndex - 1
            if previousIndex >= 0 {
                dataController.selectedReview = reviews[previousIndex]
            } else {
                dataController.selectedReview = nil
            }
        }
    }
}

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        ListingView()
    }
}
