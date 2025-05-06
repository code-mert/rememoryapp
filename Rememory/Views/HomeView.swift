import SwiftUI
import _SwiftData_SwiftUI

struct HomeView: View {
    @Query var flashcards: [Flashcard]
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                // App-Titel oben
                Text("Rememory")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)
                
                TextField("Suche...", text: $searchText)
                    .padding(8)
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Spacer()

                let filteredFlashcards = flashcards.filter {
                    ($0.nextReviewDate == nil || $0.nextReviewDate! <= Date()) &&
                    (
                        searchText.isEmpty ||
                        $0.question.localizedCaseInsensitiveContains(searchText) ||
                        $0.tags.contains(where: { $0.localizedCaseInsensitiveContains(searchText) })
                    )
                }

                List(filteredFlashcards) { flashcard in
                    NavigationLink(destination: FlashcardReviewView(flashcard: flashcard)) {
                        Text(flashcard.question)
                            .padding(.vertical, 8)
                    }
                }
                .frame(maxHeight: 300)

                Spacer()

                // Buttons unten links und rechts
                HStack {
                    NavigationLink(destination: FlashcardListView()) {
                        Image(systemName: "list.bullet.rectangle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 40)
                            .padding()
                            .background(Color.accentColor.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    NavigationLink(destination: NewFlashcardView()) {
                        Image(systemName: "plus.square")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 40)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding([.horizontal, .bottom])
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemBackground))
        }
    }
}

#Preview {
    HomeView()
}
