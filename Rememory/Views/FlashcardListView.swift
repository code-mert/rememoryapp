import SwiftUI
import SwiftData

struct FlashcardListView: View {
    @Query var flashcards: [Flashcard]

    var body: some View {
        List(flashcards) { flashcard in
            NavigationLink(destination: FlashcardDetailView(flashcard: flashcard)) {
                Text(flashcard.question)
            }
        }
        .navigationTitle("Alle Karteikarten")
    }
}
