import SwiftUI
import SwiftData

struct FlashcardListView: View {
    @Query var flashcards: [Flashcard]
    @State private var searchText: String = ""

    var body: some View {
        let filtered = flashcards.filter {
            searchText.isEmpty || $0.question.localizedCaseInsensitiveContains(searchText)
        }

        List(filtered) { flashcard in
            NavigationLink(destination: FlashcardDetailView(flashcard: flashcard)) {
                Text(flashcard.question)
            }
        }
        .navigationTitle("Alle Karteikarten")
        .searchable(text: $searchText)
    }
}
